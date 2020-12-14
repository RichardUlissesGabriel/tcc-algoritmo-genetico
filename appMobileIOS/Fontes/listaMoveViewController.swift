//
//  listaMoveViewController.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 02/05/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class listaMoveViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    var listaMoveFiltrados = Array<move>()
    var filtro = false
    
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
        
        /*for i in 0 ..< dataManager.instance.listaMove.count{
            print("\(dataManager.instance.listaMove[i].idMove) -  \(dataManager.instance.listaMove[i].nome)")
        }*/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//=====================================================================================================
    
    //TABLE VIEW DELEGATE
    
//=====================================================================================================
    
    //Quantidade de linhas da tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(filtro){return listaMoveFiltrados.count}
        return dataManager.instance.listaMove.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Montagem das celulas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell") as! moveTableViewCell
        
        var golpe = move()
        
        //imagem do tipo
        var idTipo = 0
        var nomeTipo = ""
        
        if(filtro){
            golpe = listaMoveFiltrados[indexPath.row]
            //imagem do tipo
            idTipo = listaMoveFiltrados[indexPath.row].idTipo
            nomeTipo = dataManager.instance.listaTipo[idTipo-1].nomeImg
        }else{
            golpe = dataManager.instance.listaMove[indexPath.row]
            //imagem do tipo
            idTipo = dataManager.instance.listaMove[indexPath.row].idTipo
            nomeTipo = dataManager.instance.listaTipo[idTipo-1].nomeImg
        }
        
        //Colocando o nome
        cell.nome.text = golpe.nome
        //Colocando o nome
        cell.descricao.text = golpe.descricao
        //Colocando a imagem miniatura
        cell.tipo.image = UIImage(named: nomeTipo)
        //Colocando o nDex do pokemon
        cell.categoria.image = UIImage(named: golpe.nomeImgCategoriaMove)
        
        return cell
    }
    
    //Metodo que devolve a view do Header
    //func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //}
    
    //Adicionando os index laterais
    //func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    //}
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        //chamando a tela propria da aventura
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "move") as! moveViewController
        
        //altero a forma de apresentacao da tela
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        if filtro{
            //print(listaMoveFiltrados[indexPath.row].idMove)
            vc.idGolpe = listaMoveFiltrados[indexPath.row].idMove - 1
        }else{
            //print(dataManager.instance.listaMove[indexPath.row].idMove)
            vc.idGolpe = dataManager.instance.listaMove[indexPath.row].idMove - 1
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
        listaMoveFiltrados = Array<move>()
        
        //crio uma variavel auxiliar para receber os pokemons filtrados
        listaMoveFiltrados = dataManager.instance.listaMove.filter({ ( golpe:move ) -> Bool in
            let tmp: NSString = golpe.nome as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        //se eu tiver apresento a variavel filtrada
        if listaMoveFiltrados.count > 0{
            filtro = true
        }else{
            filtro = false
        }
        
        
        //recarrego a tabela
        self.table.reloadData()
        
    }

}
