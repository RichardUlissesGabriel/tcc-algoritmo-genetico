//
//  eggGroupsViewController.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 02/05/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class eggGroupsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    var filtro = false
    var listaEggsFiltrados = Array<eggGroup>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //alterando a cor da tab bar
        self.tabBarController?.tabBar.barTintColor = UIColor.black
        self.tabBarController?.tabBar.barStyle = UIBarStyle.black
        UITabBar.appearance().tintColor = UIColor.red
        
        //alterando a cor da navigation bar
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        //alretando a cor da viewController
        self.view.backgroundColor = UIColor.black
        
        self.table.delegate = self
        self.table.dataSource = self
        self.search.delegate = self
        
        self.table.estimatedSectionHeaderHeight = 33
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//=====================================================================================================
    
    //TABLE VIEW DELEGATE
    
//=====================================================================================================
    
    //Quantidade de linhas da tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(filtro){return listaEggsFiltrados[section].listaPokemon.count}
        return dataManager.instance.listaEggGroup[section].listaPokemon.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(filtro){return listaEggsFiltrados.count}
        return dataManager.instance.listaEggGroup.count
    }
    
    //Montagem das celulas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! listaPokemonTableViewCell
        
        var poke = pokemon()
        var idpokemon = 0
        
        if(filtro){
            idpokemon = listaEggsFiltrados[indexPath.section].listaPokemon[indexPath.row]
            poke = dataManager.instance.listaPokemons[idpokemon-1]
        }else{
            idpokemon = dataManager.instance.listaEggGroup[indexPath.section].listaPokemon[indexPath.row]
            poke = dataManager.instance.listaPokemons[idpokemon-1]
        }
        
        //Colocando o nome
        cell.nomePokemon.text = poke.nome
        //Colocando a imagem miniatura
        cell.imgPokemon.image = UIImage(named: poke.nomeImgMS)
        //Colocando o nDex do pokemon
        cell.numDex.text = poke.nDex
        
        //imagem dos tipos
        let idTipo1 = dataManager.instance.listaPokemons[idpokemon-1].idTipo1
        let nomeTipo1 = dataManager.instance.listaTipo[idTipo1-1].nomeImg
        let idTipo2 = dataManager.instance.listaPokemons[idpokemon-1].idTipo2
        
        cell.tipo1.image = UIImage(named: nomeTipo1)
        if (idTipo2 != 0){
            let nomeTipo2 = dataManager.instance.listaTipo[idTipo2-1].nomeImg
            cell.tipo2.image = UIImage(named: nomeTipo2)
        }else{
            cell.tipo2.image = UIImage(named: "")
        }
        
        if filtro {
            cell.backgroundColor = getCorTipo(listaEggsFiltrados[indexPath.section].nome)
        }else{
            cell.backgroundColor = getCorTipo(dataManager.instance.listaEggGroup[indexPath.section].nome)
        }
        
        return cell
    }
    
    
    
    //Metodo que devolve a view do Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 33))
        view.backgroundColor = UIColor.black
        
        let imgSection = UIImageView(frame: CGRect(x: 0, y: 0, width: 124, height: 33))
        
        if filtro{
            imgSection.image = UIImage(named:listaEggsFiltrados[section].nomeImg)
        }else{
            imgSection.image = UIImage(named:dataManager.instance.listaEggGroup[section].nomeImg)
        }
        
        view.addSubview(imgSection)
        
        return view
    }
    
    //Adicionando os index laterais
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        var nomeSection = Array<String>()
        
        if filtro{
            
            for tipo in listaEggsFiltrados{
                var nome = tipo.nome
                nome = "\(nome)\n"
                nomeSection.append(nome)
            }
            
        }else{
            
            for tipo in dataManager.instance.listaEggGroup{
                var nome = tipo.nome
                
                if nome == "Gender-unknown"{
                    nome = "G - unknown"
                }
                
                if nome == "Undiscovered"{
                    nome = "Undiscover"
                }
                
                nomeSection.append(nome)
            }
        }
        
        return nomeSection

    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        //chamando a tela propria da aventura
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pokemon") as! pokemonViewController
        
        //altero a forma de apresentacao da tela
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        if filtro{
            let idPoke = listaEggsFiltrados[indexPath.section].listaPokemon[indexPath.row]
            vc.idPokemon = idPoke-1
        }else{
            //vc.idPokemon = dataManager.instance.listaEggGroup[indexPath.section].listaPokemon[indexPath.row]
            let idPoke = dataManager.instance.listaEggGroup[indexPath.section].listaPokemon[indexPath.row]
            vc.idPokemon = idPoke-1
        }
        
        //apresento a tela
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
//=====================================================================================================
    
    //SEARCH BAR
    
//=====================================================================================================
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search.resignFirstResponder()
    }
    
    //Filtrando os pokemons
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if (searchText.characters.count == 0){
            searchBar.perform(#selector(UIResponder.resignFirstResponder), with: nil, afterDelay: 0)
        }
        
        //Reinicializo a minha variavel de pokemons filtrados
        listaEggsFiltrados = Array<eggGroup>()
        
        //Para cada sessao na lista dos meus tipos
        for i in 0 ..< dataManager.instance.listaEggGroup.count{
            
            var pokemonsSemFiltro = [pokemon]()
            
            for j in 0 ..< dataManager.instance.listaEggGroup[i].listaPokemon.count{
                let idPoke = dataManager.instance.listaEggGroup[i].listaPokemon[j]
                pokemonsSemFiltro.append(dataManager.instance.listaPokemons[idPoke-1])
            }
            
            //crio uma variavel auxiliar para receber os pokemons filtrados
            let listaPokemons = pokemonsSemFiltro.filter({ ( poke:pokemon ) -> Bool in
                let tmp: NSString = poke.nome as NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            
            //se essa minha lista esta possui algo
            if listaPokemons.count > 0{
                
                //Adiciono esse tipo na minha lista de tipos filtrados
                let eggG = eggGroup()
                eggG.idEggGroup = dataManager.instance.listaEggGroup[i].idEggGroup
                eggG.nome = dataManager.instance.listaEggGroup[i].nome
                eggG.nomeImg = dataManager.instance.listaEggGroup[i].nomeImg
                
                var idsPokemons = [Int]()
                
                for k in 0 ..< listaPokemons.count {
                    idsPokemons.append(listaPokemons[k].idPokemon)
                }
                
                eggG.listaPokemon = idsPokemons
                
                listaEggsFiltrados.append(eggG)
            }
        }
        
        //Verifico se eu tenho alguma informacao
        var algumPokemon = false
        
        //passo por todas as sessoes verificando se eu tenho pokemons
        for section in listaEggsFiltrados{
            if section.listaPokemon.count > 0{
                algumPokemon = true
                break
            }
        }
        
        //se eu tiver apresento a variavel filtrada
        if algumPokemon{
            filtro = true
        }else{
            filtro = false
        }
        
        //recarrego a tabela
        self.table.reloadData()
        
    }
    
    
    
    
    //essa funcao devolve a cor inicial e final da celula
    func getCorTipo(_ tipo:String) -> UIColor{
        
        //Para cada tipo eu defino uma cor especifica
        switch tipo{
        case "Monster":
            return UIColor(red: 197/255, green: 56/255, blue: 82/255, alpha: 1)
            
        case "Water 1":
            return UIColor(red: 133/255, green: 163/255, blue: 252/255, alpha: 1)
            
        case "Bug":
            return UIColor(red: 154/255, green: 184/255, blue: 32/255, alpha: 1)
            
        case "Flying":
            return UIColor(red: 162/255, green: 130/255, blue: 248/255, alpha: 1)
            
        case "Field":
            return UIColor(red: 216/255, green: 180/255, blue: 86/255, alpha: 1)
            
        case "Fairy":
            return UIColor(red: 254/255, green: 185/255, blue: 236/255, alpha: 1)
            
        case "Grass":
            return UIColor(red: 114/255, green: 204/255, blue: 73/255, alpha: 1)
            
        case "Undiscovered":
            return UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
            
        case "Mineral":
            return UIColor(red: 102/255, green: 79/255, blue: 65/255, alpha: 1)
            
        case "Water 2":
            return UIColor(red: 96/255, green: 131/255, blue: 248/255, alpha: 1)
            
        case "Amorphous":
            return UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1)
            
        case "Ditto":
            return UIColor(red: 184/255, green: 74/255, blue: 177/255, alpha: 1)
            
        case "Dragon":
            return UIColor(red: 101/255, green: 29/255, blue: 255/255, alpha: 1)
            
        case "Human-Like":
            return UIColor(red: 199/255, green: 131/255, blue: 111/255, alpha: 1)
            
        case "Water 3":
            return UIColor(red: 70/255, green: 96/255, blue: 176/255, alpha: 1)
            
        case "Gender-unknown":
            return UIColor(red: 14/255, green: 107/255, blue: 179/255, alpha: 1)
            
        default:
            return UIColor(red: 208/255, green: 220/255, blue: 37/255, alpha: 1)
        }
        
    }

    

}
