//
//  listaPokemonViewController.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 01/05/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class listaPokemonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    
    var listaPokemonsFiltrados = Array<pokemon>()
    var filtro = false
    var selecaoTeam = false
    var indexTimeInimigo = -1
    
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//=====================================================================================================
    
    //TABLE VIEW DELEGATE
    
//=====================================================================================================
    
    //Quantidade de linhas da tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(filtro){return listaPokemonsFiltrados.count}
        return dataManager.instance.listaPokemons.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Montagem das celulas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! listaPokemonTableViewCell
        
        var poke = pokemon()
        
        if(filtro){
            poke = listaPokemonsFiltrados[indexPath.row]
        }else{
            poke = dataManager.instance.listaPokemons[indexPath.row]
        }
        
        //Colocando o nome
        cell.nomePokemon.text = poke.nome
        //Colocando a imagem miniatura
        cell.imgPokemon.image = UIImage(named: poke.nomeImgMS)
        //Colocando o nDex do pokemon
        cell.numDex.text = poke.nDex
        
        //imagem dos tipos
        let idTipo1 = poke.idTipo1
        let nomeTipo1 = dataManager.instance.listaTipo[idTipo1-1].nomeImg
        let idTipo2 = poke.idTipo2
        
        cell.tipo1.image = UIImage(named: nomeTipo1)
        if (idTipo2 != 0){
            let nomeTipo2 = dataManager.instance.listaTipo[idTipo2-1].nomeImg
            cell.tipo2.image = UIImage(named: nomeTipo2)
        }else{
            cell.tipo2.image = UIImage(named: "")
        }
        
        return cell
    }
    
    //Metodo que devolve a view do Header
    //func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //}
    
    //Adicionando os index laterais
    //func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    //}
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        //Apresento essa mesma lista quando estou selecionando os pokemons do time adversario
        if selecaoTeam{
            
            var jaExisteoId = false
            var idPokeEscolhido = 0
            
            if self.filtro {
                idPokeEscolhido = self.listaPokemonsFiltrados[indexPath.row].idPokemon
            }else{
                idPokeEscolhido = dataManager.instance.listaPokemons[indexPath.row].idPokemon
            }
            
            
            //verificando se o pokemon ja existe no time
            for i in 0 ..< dataManager.instance.idsPokemonsSelecionados.count{
                if dataManager.instance.idsPokemonsSelecionados[i] == idPokeEscolhido{
                    jaExisteoId = true
                    break
                }
            }
            
            //Esse pokemon nao foi escolhido ainda
            if jaExisteoId == false{
                
                
                // Crio o alerta Perguntando se quero adicionar
                let alert = UIAlertController(title: "Escolha", message: "Deseja escolher esse pokemon?", preferredStyle: UIAlertControllerStyle.alert)
                
                // Adiciono a acao de encerrar o aplicativo por erro de conexao
                let btSim = UIAlertAction(title: "Sim", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                    
                    dataManager.instance.idsPokemonsSelecionados[self.indexTimeInimigo] = idPokeEscolhido
                    
                    //Fecho essa tela
                    self.navigationController?.popToRootViewController(animated: true)
                    
                })
                
                let btNao = UIAlertAction(title: "Não", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                    
                })
                
                //adiciono o botao va mensagem
                alert.addAction(btSim)
                alert.addAction(btNao)
                
                //Apresento a mensagem para o usuario
                self.present(alert, animated: true, completion: nil)

            }else{
            
            
                // Crio o alerta Perguntando se quero adicionar
                let alertEscolha = UIAlertController(title: "Ops!!!", message: "Pokemon ja escolhido", preferredStyle: UIAlertControllerStyle.alert)
                
                let btOk = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                    
                })
                
                //adiciono o botao va mensagem
                alertEscolha.addAction(btOk)
                
                
                //Apresento a mensagem para o usuario
                self.present(alertEscolha, animated: true, completion: nil)
            
            }
            
            
        }else{
            
            //chamando a tela propria da aventura
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "pokemon") as! pokemonViewController
            
            //altero a forma de apresentacao da tela
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            if filtro{
                vc.idPokemon = listaPokemonsFiltrados[indexPath.row].idPokemon - 1
            }else{
                vc.idPokemon = dataManager.instance.listaPokemons[indexPath.row].idPokemon - 1
            }
            //apresento a tela
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    
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
        listaPokemonsFiltrados = Array<pokemon>()
        
        //crio uma variavel auxiliar para receber os pokemons filtrados
        listaPokemonsFiltrados = dataManager.instance.listaPokemons.filter({ ( poke:pokemon ) -> Bool in
            let tmp: NSString = poke.nome as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        //se eu tiver apresento a variavel filtrada
        if listaPokemonsFiltrados.count > 0{
            filtro = true
        }else{
            filtro = false
        }
    

        //recarrego a tabela
        self.table.reloadData()

    }
}
