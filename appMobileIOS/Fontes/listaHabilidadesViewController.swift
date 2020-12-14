//
//  listaHabilidadesViewController.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 02/05/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class listaHabilidadesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var search: UISearchBar!
    
    var filtro = false
    var listaHabiFiltradas = [habilidade]()
    
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
        
    }
    
//=====================================================================================================
    
    //TABLE VIEW DELEGATE
    
//=====================================================================================================
    
    //Quantidade de linhas da tabela
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(filtro){return listaHabiFiltradas.count}
        return dataManager.instance.listaHabilidade.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Montagem das celulas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        var habi = habilidade()
        
        if(filtro){
            habi = listaHabiFiltradas[indexPath.row]
        }else{
            habi = dataManager.instance.listaHabilidade[indexPath.row]
        }
        
        cell.textLabel?.text = habi.nome
        cell.detailTextLabel?.text = habi.descEfeito
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        //chamando a tela propria da aventura
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "habilidade") as! habilidadeViewController
        
        //altero a forma de apresentacao da tela
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        if(filtro){
            vc.idHabilidade = listaHabiFiltradas[indexPath.row].idHabilidade - 1
        }else{
            vc.idHabilidade = dataManager.instance.listaHabilidade[indexPath.row].idHabilidade - 1
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
        listaHabiFiltradas = Array<habilidade>()
        
        //crio uma variavel auxiliar para receber os pokemons filtrados
        listaHabiFiltradas = dataManager.instance.listaHabilidade.filter({ ( habi:habilidade ) -> Bool in
            let tmp: NSString = habi.nome as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        
        //se eu tiver apresento a variavel filtrada
        if listaHabiFiltradas.count > 0{
            filtro = true
        }else{
            filtro = false
        }
        
        
        //recarrego a tabela
        self.table.reloadData()
        
    }
    
}
