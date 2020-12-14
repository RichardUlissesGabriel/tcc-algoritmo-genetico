//
//  move.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 26/04/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class move: NSObject {

    var idMove = Int()
    var nome = String()
    var prioridade = Int()
    var pp = Int()
    var ppMax = Int()
    var power = Int()
    var accuracy = Float()
    var descricao = String()
    var categoriaMove = String()
    var nomeImgCategoriaMove = String()
    var contestMove = String()
    var nomeImgContestMove = String()
    var idTipo = Int()
    var efeito = String()
    var chanceEfeito = Float()
    var target = String()
    var numeroTM = Int()
    var locMoveTutor = String()
    var valorMoveTutor = String()
    var zCrystal = String()
    var nomeImgzCrystal = String()
    var idMoveRequerido = Int()
    var efeitoAdicional = String()
    //var listaIdsPokesLevelUp = [[String:Int]]()
    var listaIdsPokesLevelUp = [Int]()
    var listaIdsPokesTm = [Int]()
    var listaIdsPokesMoveTutor = [Int]()
    var listaIdsPokesBreed = [Int]()


}
