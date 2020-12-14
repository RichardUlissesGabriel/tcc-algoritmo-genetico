//
//  dataManager.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 27/04/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class dataManager: NSObject {

    //singleton da classe de acesso a base de dado
    static let instance = dataManager()
    
    var listaPokemons = [pokemon]()
    var listaMove = [move]()
    var listaHabilidade = [habilidade]()
    var listaEggGroup = [eggGroup]()
    var listaTipo = [tipo]()
    var listaGen = [geracao]()
    
    var idsPokemonsSelecionados = [0,0,0,0,0,0]
    var timeRetorno = [Int]()
    
}
