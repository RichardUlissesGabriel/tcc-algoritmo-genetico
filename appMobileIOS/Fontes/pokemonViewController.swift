//
//  pokemonViewController.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 03/05/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class pokemonViewController: UIViewController {

    var idPokemon = 0
    var poke = pokemon()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sliderLv: UISlider!
    
    //Outlets da tela
    @IBOutlet weak var ndex: UILabel!
    @IBOutlet weak var regiao: UILabel!
    @IBOutlet weak var geracao: UILabel!
    @IBOutlet weak var tipoLabel: UILabel!
    //constraint do tipo
    @IBOutlet weak var tipoConstraint: NSLayoutConstraint!
    @IBOutlet weak var tipo1: UIImageView!
    @IBOutlet weak var tipo2: UIImageView!
    @IBOutlet weak var imgPoke: UIImageView!
    //stats
    @IBOutlet weak var hp: UILabel!
    @IBOutlet weak var attack: UILabel!
    @IBOutlet weak var defense: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var sAttack: UILabel!
    @IBOutlet weak var sDefense: UILabel!
    //range stats lv50
    @IBOutlet weak var hpRange50: UILabel!
    @IBOutlet weak var attackRange50: UILabel!
    @IBOutlet weak var defenseRange50: UILabel!
    @IBOutlet weak var sAttackRange50: UILabel!
    @IBOutlet weak var sDefenseRange50: UILabel!
    @IBOutlet weak var speedRange50: UILabel!
    //Abilitys
    @IBOutlet weak var firstAbility: UILabel!
    @IBOutlet weak var labelSecond: UILabel!
    @IBOutlet weak var secondAbility: UILabel!
    @IBOutlet weak var hiddenAbility: UILabel!
    @IBOutlet weak var labelHidden: UILabel!
    //eggGroup
    @IBOutlet weak var eggGroup: UILabel!
    @IBOutlet weak var labelEggGroup2: UILabel!
    @IBOutlet weak var eggGroup2: UILabel!
    //damage Taken
    @IBOutlet weak var dmgNormal: UILabel!
    @IBOutlet weak var dmgFire: UILabel!
    @IBOutlet weak var dmgWater: UILabel!
    @IBOutlet weak var dmgElec: UILabel!
    @IBOutlet weak var dmgGrass: UILabel!
    @IBOutlet weak var dmgIce: UILabel!
    @IBOutlet weak var dmgFight: UILabel!
    @IBOutlet weak var dmgPoison: UILabel!
    @IBOutlet weak var dmgGround: UILabel!
    @IBOutlet weak var dmgFlying: UILabel!
    @IBOutlet weak var dmgPsychic: UILabel!
    @IBOutlet weak var dmgBug: UILabel!
    @IBOutlet weak var dmgRock: UILabel!
    @IBOutlet weak var dmgGhost: UILabel!
    @IBOutlet weak var dmgDragon: UILabel!
    @IBOutlet weak var dmgDark: UILabel!
    @IBOutlet weak var dmgSteel: UILabel!
    @IBOutlet weak var dmgFairy: UILabel!
    
    @IBOutlet weak var labelLV: UILabel!
    
    //auxiliares
    var viewReferenciaConstraints:UIView = UIView()
    //Definindo a minha barra
    let barraBranca = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        poke = dataManager.instance.listaPokemons[idPokemon]
        
        ndex.text = poke.nDex
        regiao.text = dataManager.instance.listaGen[poke.idGeracao-1].nome
        geracao.text = dataManager.instance.listaGen[poke.idGeracao-1].numeroRomano
        tipoLabel.text = poke.idTipo2 == 0 ? "Type" : "Types"
        tipo1.image = UIImage(named: dataManager.instance.listaTipo[poke.idTipo1-1].nomeImg)
        
        //arrumando a posicao do tipo, quando o pokemon tem somente um tipo
        if poke.idTipo2 == 0{
            UIView.animate(withDuration: 0, animations: {
                self.tipoConstraint.constant = 0
            })
            tipo2.isHidden = true
        }else{
            tipo2.image = UIImage(named: dataManager.instance.listaTipo[poke.idTipo2-1].nomeImg)
        }
        
        imgPoke.image = UIImage(named: poke.nomeImg)

        hp.text = "\(poke.hp)"
        attack.text = "\(poke.ataque)"
        defense.text = "\(poke.defesa)"
        speed.text = "\(poke.ataqueEspecial)"
        sAttack.text = "\(poke.defesaEspecial)"
        sDefense.text = "\(poke.velocidade)"
        
        //preenchendo o dano tomado
        criaDamage()
        
        //preenchendo as habilidades
        firstAbility.text = dataManager.instance.listaHabilidade[poke.idHabilidade1-1].nome
        
        if poke.idHabilidade2 != 0{
            secondAbility.text = dataManager.instance.listaHabilidade[poke.idHabilidade2-1].nome
        }else{
            labelSecond.isHidden = true
            secondAbility.isHidden = true
        }
        
        if poke.idHabilidadeHidden != 0{
            hiddenAbility.text = dataManager.instance.listaHabilidade[poke.idHabilidadeHidden-1].nome
        }else{
            hiddenAbility.isHidden = true
            labelHidden.isHidden = true
        }
        
        
        if poke.listaIdsEggGroups.count != 0{
            //Preenchendo os eggsGroups
            eggGroup.text = dataManager.instance.listaEggGroup[poke.listaIdsEggGroups[0]-1].nome
            
            if poke.listaIdsEggGroups.count == 1 {
                labelEggGroup2.isHidden = true
                eggGroup2.isHidden = true
            }else{
                eggGroup.text = dataManager.instance.listaEggGroup[poke.listaIdsEggGroups[0]-1].nome
                eggGroup2.text = dataManager.instance.listaEggGroup[poke.listaIdsEggGroups[1]-1].nome
            }
        }else{
            
            //Estou em um mega
            var pokeAnt = dataManager.instance.listaPokemons[poke.idPokemon - 2]
            //estou em um mega X
            if pokeAnt.listaIdsEggGroups.count == 0{
                pokeAnt = dataManager.instance.listaPokemons[poke.idPokemon - 3]
            }
            
            //Preenchendo os eggsGroups
            eggGroup.text = dataManager.instance.listaEggGroup[pokeAnt.listaIdsEggGroups[0]-1].nome
            
            if pokeAnt.listaIdsEggGroups.count == 1 {
                labelEggGroup2.isHidden = true
                eggGroup2.isHidden = true
            }else{
                eggGroup.text = dataManager.instance.listaEggGroup[pokeAnt.listaIdsEggGroups[0]-1].nome
                eggGroup2.text = dataManager.instance.listaEggGroup[pokeAnt.listaIdsEggGroups[1]-1].nome
            }
        }
        
        
        //calculando os status iniciando em 50
        calculaStatus(level: 50)
        
        //print(dataManager.instance.listaTipo[poke.idTipo1-1].damageTipoTaken[12]["dano"]!)
        
        //let danofromNormal = poke.idTipo2 != 0 ? dataManager.instance.listaTipo[poke.idTipo1-1].damageTipoTaken[13]["dano"] * dataManager.instance.listaTipo[poke.idTipo1-1].damageTipoTaken[13]["dano"] : dataManager.instance.listaTipo[poke.idTipo1-1].damageTipoTaken[13]["dano"]
        
        //print(danofromNormal)
        
        /*
        //colocando os danos tomados
        dmgNormal.text = "\(dataManager.instance.listaTipo[poke.idTipo1-1].damageTipoTaken[13])"
        dmgFire.text = "\()"
        dmgWater.text = "\()"
        dmgElec.text = "\()"
        dmgGrass.text = "\()"
        dmgIce.text = "\()"
        dmgFight.text = "\()"
        dmgPoison.text = "\()"
        dmgGround.text = "\()"
        dmgFlying.text = "\()"
        dmgPsychic.text = "\()"
        dmgBug.text = "\()"
        dmgRock.text = "\()"
        dmgGhost.text = "\()"
        dmgDragon.text = "\()"
        dmgDark.text = "\()"
        dmgSteel.text = "\()"
        dmgFairy.text = "\()"*/
        
        //constraint do tipo
        /*tipoConstraint: NSLayoutConstraint!
        tipo1: UIImageView!
        tipo2: UIImageView!
        imgPoke: UIImageView!
        //stats
        hp: UILabel!
        attack: UILabel!
        defense: UILabel!
        speed: UILabel!
        sAttack: UILabel!
        sDefense: UILabel!
        //range stats lv50
        hpRange50: UILabel!
        attackRange50: UILabel!
        defenseRange50: UILabel!
        sAttackRange50: UILabel!
        sDefenseRange50: UILabel!
        speedRange50: UILabel!
        //range stats lv100
        hpRange100: UILabel!
        attackRange100: UILabel!
        defenseRange100: UILabel!
        sAttackRange100: UILabel!
        sDefenseRange100: UILabel!
        speedRange100: UILabel!
        //Abilitys
        firstAbility: UILabel!
        labelSecond: UILabel!
        secondAbility: UILabel!
        hiddenAbility: UILabel!
        labelHidden: UILabel!
        //eggGroup
        eggGroup: UILabel!
        //damage Taken
        dmgNormal: UILabel!
        dmgFire: UILabel!
        dmgWater: UILabel!
        dmgElec: UILabel!
        dmgGrass: UILabel!
        dmgIce: UILabel!
        dmgFight: UILabel!
        dmgPoison: UILabel!
        dmgGround: UILabel!
        dmgFlying: UILabel!
        dmgPsychic: UILabel!
        dmgBug: UILabel!
        dmgRock: UILabel!
        dmgGhost: UILabel!
        dmgDragon: UILabel!
        dmgDark: UILabel!
        dmgSteel: UILabel!
        dmgFairy: UILabel!*/

        
    }
    
    
    
    
    func criaDamage(){
        
        let type1 = dataManager.instance.listaTipo[poke.idTipo1-1]
        var type2 = tipo()
        
        //Se meu pokemon tem mais de um tipo
        if poke.idTipo2 != 0{
            type2 = dataManager.instance.listaTipo[poke.idTipo2-1]
            
            dmgNormal.text = "\(type1.damageTipoTaken[12] * type2.damageTipoTaken[12])"
            dmgFire.text = "\(type1.damageTipoTaken[6] * type2.damageTipoTaken[6])"
            dmgWater.text = "\(type1.damageTipoTaken[17] * type2.damageTipoTaken[17])"
            dmgElec.text = "\(type1.damageTipoTaken[3] * type2.damageTipoTaken[3])"
            dmgGrass.text = "\(type1.damageTipoTaken[9] * type2.damageTipoTaken[9])"
            dmgIce.text = "\(type1.damageTipoTaken[11] * type2.damageTipoTaken[11])"
            dmgFight.text = "\(type1.damageTipoTaken[5] * type2.damageTipoTaken[5])"
            dmgPoison.text = "\(type1.damageTipoTaken[13] * type2.damageTipoTaken[13])"
            dmgGround.text = "\(type1.damageTipoTaken[10] * type2.damageTipoTaken[10])"
            dmgFlying.text = "\(type1.damageTipoTaken[7] * type2.damageTipoTaken[7])"
            dmgPsychic.text = "\(type1.damageTipoTaken[14] * type2.damageTipoTaken[14])"
            dmgBug.text = "\(type1.damageTipoTaken[0] * type2.damageTipoTaken[0])"
            dmgRock.text = "\(type1.damageTipoTaken[15] * type2.damageTipoTaken[15])"
            dmgGhost.text = "\(type1.damageTipoTaken[8] * type2.damageTipoTaken[8])"
            dmgDragon.text = "\(type1.damageTipoTaken[2] * type2.damageTipoTaken[2])"
            dmgDark.text = "\(type1.damageTipoTaken[1] * type2.damageTipoTaken[1])"
            dmgSteel.text = "\(type1.damageTipoTaken[16] * type2.damageTipoTaken[16])"
            dmgFairy.text = "\(type1.damageTipoTaken[4] * type2.damageTipoTaken[4])"
        }else{
            //Possui somente um tipo
            dmgNormal.text = "\(type1.damageTipoTaken[12])"
            dmgFire.text =   "\(type1.damageTipoTaken[6])"
            dmgWater.text =  "\(type1.damageTipoTaken[17])"
            dmgElec.text =   "\(type1.damageTipoTaken[3])"
            dmgGrass.text =  "\(type1.damageTipoTaken[9])"
            dmgIce.text =    "\(type1.damageTipoTaken[11])"
            dmgFight.text =  "\(type1.damageTipoTaken[5])"
            dmgPoison.text = "\(type1.damageTipoTaken[13])"
            dmgGround.text = "\(type1.damageTipoTaken[10])"
            dmgFlying.text = "\(type1.damageTipoTaken[7])"
            dmgPsychic.text = "\(type1.damageTipoTaken[14])"
            dmgBug.text =    "\(type1.damageTipoTaken[0])"
            dmgRock.text =   "\(type1.damageTipoTaken[15])"
            dmgGhost.text =  "\(type1.damageTipoTaken[8])"
            dmgDragon.text = "\(type1.damageTipoTaken[2])"
            dmgDark.text =   "\(type1.damageTipoTaken[1])"
            dmgSteel.text =  "\(type1.damageTipoTaken[16])"
            dmgFairy.text =  "\(type1.damageTipoTaken[4])"
        }
        
        //verificando o levitate
        let firstHabilidade = poke.idHabilidade1
        let secondHabilidade = poke.idHabilidade2
        let hiddenHabilidade = poke.idHabilidadeHidden
        
        //habilidade levitate
        if firstHabilidade == 96 || secondHabilidade == 96 || hiddenHabilidade == 96{
            dmgGround.text = "0.0"
        }
    }

    
    
    
    /*
    func preparaTela(){
        //coloco o nome do move no topo da tela
        self.navigationItem.title = pokemon.nome
        
        //Alterar o tamanho do scroll view
        //scrollView.contentSize.height = UIScreen.mainScreen().bounds.size.height * 3
        
        //coloco as informacoes do pokemons
        //padronizo os 3 caracteres com um # antes do num da pokedex
        let numPokedex = pokemon.nDex
        if let nDex = Int(numPokedex){
            
            if nDex < 10 {
                ndex.text = "#00\(numPokedex)"
            }else if nDex < 100 {
                ndex.text = "#0\(numPokedex)"
            }else{
                ndex.text = "#\(numPokedex)"
            }
            
            //Pokemons especiais que utilizei letras no numero da dex
        }else{
            //retiro a letra especial
            let nDex = Int(numPokedex.substring(to: numPokedex.characters.index(before: numPokedex.endIndex)))!
            
            if nDex < 10 {
                ndex.text = "#00\(nDex)"
            }else if nDex < 100 {
                ndex.text = "#0\(nDex)"
            }else{
                ndex.text = "#\(nDex)"
            }
        }
        
        //padronizo o regional tambem
        let numRegional = pokemon.rDex
        if let rDex = Int(numRegional){
            
            if rDex < 10 {
                rdex.text = "#00\(numRegional)"
            }else if rDex < 100 {
                rdex.text = "#0\(numRegional)"
            }else{
                rdex.text = "#\(numRegional)"
            }
            
            //Pokemons especiais que utilizei letras no numero da dex
        }else{
            rdex.text = "#\(pokemon.rDex)"
        }
        
        //regiao e geracao
        regiao.text = pokemon.regiao
        geracao.text = "#00\(pokemon.geracao)"
        
        //tipos e imagem
        tipo1.image = UIImage(named: "\(pokemon.type1.lowercased()).png")
        
        if pokemon.type2 == ""{
            tipoLabel.text = "Type"
            UIView.animate(withDuration: 0, animations: {
                self.tipoConstraint.constant = 0
            })
            tipo2.isHidden = true
        }else{
            tipo2.image = UIImage(named: "\(pokemon.type2.lowercased()).png")
        }
        
        imgPoke.image = UIImage(named: pokemon.image)
        
        //Colocando o stats base
        hp.text = "\(pokemon.hp)"
        attack.text = "\(pokemon.attack)"
        defense.text = "\(pokemon.defense)"
        sAttack.text = "\(pokemon.sAttack)"
        sDefense.text = "\(pokemon.sDefense)"
        speed.text = "\(pokemon.speed)"
        
        //calculando os ranges
        //hp lv 50
        //HP Formula = (Base * 2 + IV + (EV/4)) * Level / 100 + 10 + Level
        var lv = 50
        let hp50Min = (pokemon.hp * 2 + 0 + (0/4)) * lv / 100 + 10 + lv
        let hp50Max = (pokemon.hp * 2 + 31 + (252/4)) * lv / 100 + 10 + lv
        hpRange50.text = "\(hp50Min) - \(hp50Max)"
        
        //outros stats lv 50
        //Stats Formula = ((Base * 2 + IV + (EV/4)) * Level / 100 + 5) * Nmod
        //attack
        var attack50Min = Double(((pokemon.attack * 2 + 0 + (0/4)) * lv / 100 + 5))
        attack50Min *= 0.9
        var attack50Max = Double(((pokemon.attack * 2 + 31 + (252/4)) * lv / 100 + 5))
        attack50Max *= 1.1
        attackRange50.text = "\(Int(attack50Min)) - \(Int(attack50Max))"
        
        //defense
        var defense50Min = Double(((pokemon.defense * 2 + 0 + (0/4)) * lv / 100 + 5))
        defense50Min *= 0.9
        var defense50Max = Double(((pokemon.defense * 2 + 31 + (252/4)) * lv / 100 + 5))
        defense50Max *= 1.1
        defenseRange50.text = "\(Int(defense50Min)) - \(Int(defense50Max))"
        
        //sAttack
        var sAttack50Min = Double(((pokemon.sAttack * 2 + 0 + (0/4)) * lv / 100 + 5))
        sAttack50Min *= 0.9
        var sAttack50Max = Double(((pokemon.sAttack * 2 + 31 + (252/4)) * lv / 100 + 5))
        sAttack50Max *= 1.1
        sAttackRange50.text = "\(Int(sAttack50Min)) - \(Int(sAttack50Max))"
        
        //sdefense
        var sDefense50Min = Double(((pokemon.sDefense * 2 + 0 + (0/4)) * lv / 100 + 5))
        sDefense50Min *= 0.9
        var sDefense50Max = Double(((pokemon.sDefense * 2 + 31 + (252/4)) * lv / 100 + 5))
        sDefense50Max *= 1.1
        sDefenseRange50.text = "\(Int(sDefense50Min)) - \(Int(sDefense50Max))"
        
        //speed
        var speed50Min = Double(((pokemon.speed * 2 + 0 + (0/4)) * lv / 100 + 5))
        speed50Min *= 0.9
        var speed50Max = Double(((pokemon.speed * 2 + 31 + (252/4)) * lv / 100 + 5))
        speed50Max *= 1.1
        speedRange50.text = "\(Int(speed50Min)) - \(Int(speed50Max))"
        
        //agora para o level 100
        lv = 100
        //HP Formula = (Base * 2 + IV + (EV/4)) * Level / 100 + 10 + Level
        let hp100Min = (pokemon.hp * 2 + 0 + (0/4)) * lv / 100 + 10 + lv
        let hp100Max = (pokemon.hp * 2 + 31 + (252/4)) * lv / 100 + 10 + lv
        hpRange100.text = "\(hp100Min) - \(hp100Max)"
        
        //outros stats lv 50
        //Stats Formula = ((Base * 2 + IV + (EV/4)) * Level / 100 + 5) * Nmod
        //attack
        var attack100Min = Double(((pokemon.attack * 2 + 0 + (0/4)) * lv / 100 + 5))
        attack100Min *= 0.9
        var attack100Max = Double(((pokemon.attack * 2 + 31 + (252/4)) * lv / 100 + 5))
        attack100Max *= 1.1
        attackRange100.text = "\(Int(attack100Min)) - \(Int(attack100Max))"
        
        //defense
        var defense100Min = Double(((pokemon.defense * 2 + 0 + (0/4)) * lv / 100 + 5))
        defense100Min *= 0.9
        var defense100Max = Double(((pokemon.defense * 2 + 31 + (252/4)) * lv / 100 + 5))
        defense100Max *= 1.1
        defenseRange100.text = "\(Int(defense100Min)) - \(Int(defense100Max))"
        
        //sAttack
        var sAttack100Min = Double(((pokemon.sAttack * 2 + 0 + (0/4)) * lv / 100 + 5))
        sAttack100Min *= 0.9
        var sAttack100Max = Double(((pokemon.sAttack * 2 + 31 + (252/4)) * lv / 100 + 5))
        sAttack100Max *= 1.1
        sAttackRange100.text = "\(Int(sAttack100Min)) - \(Int(sAttack100Max))"
        
        //sdefense
        var sDefense100Min = Double(((pokemon.sDefense * 2 + 0 + (0/4)) * lv / 100 + 5))
        sDefense100Min *= 0.9
        var sDefense100Max = Double(((pokemon.sDefense * 2 + 31 + (252/4)) * lv / 100 + 5))
        sDefense100Max *= 1.1
        sDefenseRange100.text = "\(Int(sDefense100Min)) - \(Int(sDefense100Max))"
        
        //speed
        var speed100Min = Double(((pokemon.speed * 2 + 0 + (0/4)) * lv / 100 + 5))
        speed100Min *= 0.9
        var speed100Max = Double(((pokemon.speed * 2 + 31 + (252/4)) * lv / 100 + 5))
        speed100Max *= 1.1
        speedRange100.text = "\(Int(speed100Min)) - \(Int(speed100Max))"
        
        //Abilitys
        //Colocando as outras habilidades
        let firstHabilidade = DataBaseManager.instance.getHabilidadePokemon(pokemon.nDex, first: true, second: false, hidden:  false)
        let secondHabilidade = DataBaseManager.instance.getHabilidadePokemon(pokemon.nDex, first: false, second: true, hidden:  false)
        let hiddenHabilidade = DataBaseManager.instance.getHabilidadePokemon(pokemon.nDex, first: false, second: false, hidden:  true)
        firstAbility.text = firstHabilidade.nome
        viewReferenciaConstraints = firstAbility
        
        //crio o mecanismo de chamar a outra tela
        let tap = UITapGestureRecognizer(target: self, action: #selector(PokemonViewController.tapHabilidade(_:)))
        firstAbility.addGestureRecognizer(tap)
        firstAbility.isUserInteractionEnabled = true
        
        if hiddenHabilidade.nome == ""{
            
            labelHidden.isHidden = true
            hiddenAbility.isHidden = true
            
        }else{
            hiddenAbility.text = hiddenHabilidade.nome
            let tap = UITapGestureRecognizer(target: self, action: #selector(PokemonViewController.tapHabilidade(_:)))
            hiddenAbility.addGestureRecognizer(tap)
            hiddenAbility.isUserInteractionEnabled = true
        }
        
        if secondHabilidade.nome == ""{
            
            secondAbility.isHidden = true
            labelSecond.isHidden = true
            
        }else{
            secondAbility.text = secondHabilidade.nome
            let tap = UITapGestureRecognizer(target: self, action: #selector(PokemonViewController.tapHabilidade(_:)))
            secondAbility.addGestureRecognizer(tap)
            secondAbility.isUserInteractionEnabled = true
        }
        
        //colocando os damagesTakens
        criaDamage()
        
        //criando a linha evolutiva
        criaEvolucoes()
        
        //colocando o nome do eggGroup
        eggGroup.text = DataBaseManager.instance.getNomeEggGroup(pokemon.nDex)
        
        
        
        //criando os moves do pokemon
        criaMoves()
        
    }
    
    func criaDamage(){
        
        let type1 = DataBaseManager.instance.getTipo(pokemon.type1)
        var type2 = Tipo()
        
        //Se meu pokemon tem mais de um tipo
        if pokemon.type2 != ""{
            type2 = DataBaseManager.instance.getTipo(pokemon.type2)
            
            dmgNormal.text = "\(type1.damageTaken["normal"]! * type2.damageTaken["normal"]!)"
            dmgFire.text = "\(type1.damageTaken["fire"]! * type2.damageTaken["fire"]!)"
            dmgWater.text = "\(type1.damageTaken["water"]! * type2.damageTaken["water"]!)"
            dmgElec.text = "\(type1.damageTaken["electric"]! * type2.damageTaken["electric"]!)"
            dmgGrass.text = "\(type1.damageTaken["grass"]! * type2.damageTaken["grass"]!)"
            dmgIce.text = "\(type1.damageTaken["ice"]! * type2.damageTaken["ice"]!)"
            dmgFight.text = "\(type1.damageTaken["fighting"]! * type2.damageTaken["fighting"]!)"
            dmgPoison.text = "\(type1.damageTaken["poison"]! * type2.damageTaken["poison"]!)"
            
            //verificando o levitate
            let firstHabilidade = DataBaseManager.instance.getHabilidadePokemon(pokemon.nDex, first: true, second: false, hidden:  false)
            let secondHabilidade = DataBaseManager.instance.getHabilidadePokemon(pokemon.nDex, first: false, second: true, hidden:  false)
            let hiddenHabilidade = DataBaseManager.instance.getHabilidadePokemon(pokemon.nDex, first: false, second: false, hidden:  true)
            
            if firstHabilidade.nome == "Levitate" || secondHabilidade.nome == "Levitate" || hiddenHabilidade.nome == "Levitate"{
                dmgGround.text = "0.0"
            }else{
                dmgGround.text = "\(type1.damageTaken["ground"]! * type2.damageTaken["ground"]!)"
            }
            dmgFlying.text = "\(type1.damageTaken["flying"]! * type2.damageTaken["flying"]!)"
            dmgPsychic.text = "\(type1.damageTaken["psychic"]! * type2.damageTaken["psychic"]!)"
            dmgBug.text = "\(type1.damageTaken["bug"]! * type2.damageTaken["bug"]!)"
            dmgRock.text = "\(type1.damageTaken["rock"]! * type2.damageTaken["rock"]!)"
            dmgGhost.text = "\(type1.damageTaken["ghost"]! * type2.damageTaken["ghost"]!)"
            dmgDragon.text = "\(type1.damageTaken["dragon"]! * type2.damageTaken["dragon"]!)"
            dmgDark.text = "\(type1.damageTaken["dark"]! * type2.damageTaken["dark"]!)"
            dmgSteel.text = "\(type1.damageTaken["steel"]! * type2.damageTaken["steel"]!)"
            dmgFairy.text = "\(type1.damageTaken["fairy"]! * type2.damageTaken["fairy"]!)"
        }else{
            //Possui somente um tipo
            dmgNormal.text = "\(type1.damageTaken["normal"]!)"
            dmgFire.text = "\(type1.damageTaken["fire"]!)"
            dmgWater.text = "\(type1.damageTaken["water"]!)"
            dmgElec.text = "\(type1.damageTaken["electric"]!)"
            dmgGrass.text = "\(type1.damageTaken["grass"]!)"
            dmgIce.text = "\(type1.damageTaken["ice"]!)"
            dmgFight.text = "\(type1.damageTaken["fighting"]!)"
            dmgPoison.text = "\(type1.damageTaken["poison"]!)"
            
            
            //verificando o levitate
            let firstHabilidade = DataBaseManager.instance.getHabilidadePokemon(pokemon.nDex, first: true, second: false, hidden:  false)
            let secondHabilidade = DataBaseManager.instance.getHabilidadePokemon(pokemon.nDex, first: false, second: true, hidden:  false)
            let hiddenHabilidade = DataBaseManager.instance.getHabilidadePokemon(pokemon.nDex, first: false, second: false, hidden:  true)
            
            if firstHabilidade.nome == "Levitate" || secondHabilidade.nome == "Levitate" || hiddenHabilidade.nome == "Levitate"{
                dmgGround.text = "0.0"
            }else{
                dmgGround.text = "\(type1.damageTaken["ground"]!)"
            }
            
            dmgFlying.text = "\(type1.damageTaken["flying"]!)"
            dmgPsychic.text = "\(type1.damageTaken["psychic"]!)"
            dmgBug.text = "\(type1.damageTaken["bug"]!)"
            dmgRock.text = "\(type1.damageTaken["rock"]!)"
            dmgGhost.text = "\(type1.damageTaken["ghost"]!)"
            dmgDragon.text = "\(type1.damageTaken["dragon"]!)"
            dmgDark.text = "\(type1.damageTaken["dark"]!)"
            dmgSteel.text = "\(type1.damageTaken["steel"]!)"
            dmgFairy.text = "\(type1.damageTaken["fairy"]!)"
        }
    }
    
    func criaEvolucoes(){
        
        
        //variavel que recebe as evolucoes
        var evolucao = Array<Evolucao>()
        //declaro o meu label
        let labelEvolutions = UILabel()
        
        //Pokemon primario
        if pokemon.stageEvolution == 0{
            
            //evolucao
            evolucao = DataBaseManager.instance.getPokemonEvolution(pokemon.nDex)
            //preciso do pokemon primario da linha evolutiva
        }else{
            
            evolucao = DataBaseManager.instance.getPrePokemonEvolution(pokemon.nDex)
            evolucao = DataBaseManager.instance.getPokemonEvolution(evolucao[0].nDexOrigem)
        }
        
        if evolucao.count > 0{
            viewReferenciaConstraints = scrollView
            //configuro meu label
            labelEvolutions.text = "Evolution"
            labelEvolutions.font = UIFont.boldSystemFont(ofSize: 15.0)
            labelEvolutions.textColor = UIColor.white
            //adiciono ao meu scroll view
            scrollView.addSubview(labelEvolutions)
            
            //Defino as contraints
            //margem esquerda
            criaConstraints(labelEvolutions, destino: scrollView, height: 17, leading: 10)
            criaConstraints(labelEvolutions, destino: eggGroup, verticalSpacing: 20)
            
            //configurando a minha barraBranca
            barraBranca.backgroundColor = UIColor.white
            scrollView.addSubview(barraBranca)
            
            //definindo as constraints
            criaConstraints(barraBranca, destino: scrollView, height: 5, leading: 10, trailing: -10)
            criaConstraints(barraBranca, destino: labelEvolutions, verticalSpacing: 16)
            
            //var viewReferenciaVerticalSpacing:UIView = barraBranca
            
            if evolucao[0].nDexOrigem == "133" {//Eevee
                montaEevee(evolucao)
            }else if evolucao[0].nDexOrigem == "236"{//tyrogue
                montaTyrogue(evolucao)
            }else{
                
                //Definindo a minha imagem
                let primeiroPoke = UIButton()
                primeiroPoke.setImage(UIImage(named: "\(evolucao[0].nDexOrigem)MS.png"), for: UIControlState())
                primeiroPoke.addTarget(self, action: #selector(PokemonViewController.tapPoke(_:)), for: UIControlEvents.touchUpInside)
                primeiroPoke.isUserInteractionEnabled = true
                primeiroPoke.accessibilityIdentifier = evolucao[0].nDexOrigem
                
                scrollView.addSubview(primeiroPoke)
                
                var topSpace:CGFloat = 0
                //tenho dois caminhos no meio da linha evolutiva
                if evolucao.count == 2{
                    //altero o espacamento do pokemon
                    topSpace = 20
                    
                    //se ele esta no meio da linha evolutiva
                    if DataBaseManager.instance.getpokemon(evolucao[0].nDexOrigem).stageEvolution > 0{
                        //Preciso alterar a distancia do pokemon 1
                        for i in 0 ..< scrollView.constraints.count{
                            
                            if scrollView.constraints[i].identifier == "TopSpace" &&
                                scrollView.constraints[i].constant == 0{
                                
                                scrollView.constraints[i].constant = 20
                            }
                        }
                    }
                }
                
                //definindo as constraints
                if viewReferenciaConstraints == scrollView{
                    criaConstraints(primeiroPoke, destino: viewReferenciaConstraints, height: 40, width: 40, leading: 10)
                }else{
                    criaConstraints(primeiroPoke, destino: viewReferenciaConstraints, height: 40, width: 40, leading: 30)
                }
                criaConstraints(primeiroPoke, destino: barraBranca,verticalSpacing: topSpace)
                
                topSpace = -20
                for i in 0 ..< evolucao.count{
                    viewReferenciaConstraints = primeiroPoke
                    var evolucaoNova = evolucao
                    
                    if i == 1{
                        topSpace = 20
                    }
                    
                    var j = i
                    
                    
                    while evolucaoNova.count > 0 {
                        if evolucaoNova.count == 1{
                            j = 0
                        }else if evolucaoNova.count == 2{
                            montaPoke(evolucaoNova[1], topSpace: 20, updateConstraint: false)
                            
                            if evolucaoNova[1].nDexDestino == "475"{//gallade
                                
                                var outraEvolucao = evolucaoNova
                                
                                outraEvolucao = DataBaseManager.instance.getPokemonEvolution(outraEvolucao[1].nDexDestino)
                                montaPoke(outraEvolucao[0], topSpace: 20, updateConstraint: false)
                            }
                        }
                        montaPoke(evolucaoNova[j], topSpace: topSpace)
                        evolucaoNova = DataBaseManager.instance.getPokemonEvolution(evolucaoNova[j].nDexDestino)
                    }
                }
            }
        }
    }
    
    func montaPoke(_ evolucao:Evolucao, topSpace:CGFloat, updateConstraint:Bool = true, spaceHorizontal:CGFloat = 0){
        
        let leading = spaceHorizontal + 40
        
        //Definindo a forma de evolucao
        let evolucaoImg = UIImageView()
        
        if let level = Int(evolucao.formaEvolucao){
            
            //Coloca a imgPadrao do level
            evolucaoImg.image = UIImage(named: "evLv.png")
            scrollView.addSubview(evolucaoImg)
            
            criaConstraints(evolucaoImg, destino: viewReferenciaConstraints, height: 80, width: 30, leading: leading)
            criaConstraints(evolucaoImg, destino: barraBranca, verticalSpacing: topSpace)
            
            //crio o label que vai levar o level
            let labelLv = UILabel()
            //configuro meu label
            labelLv.text = "\(level)"
            labelLv.font = UIFont.boldSystemFont(ofSize: 9.0)
            labelLv.textColor = UIColor.red
            scrollView.addSubview(labelLv)
            
            criaConstraints(labelLv, destino: evolucaoImg, centerX: true, centerY: true)
            
        }else{
            
            //Coloca a imgPadrao do level
            evolucaoImg.image = UIImage(named: "\(evolucao.formaEvolucao).png")
            scrollView.addSubview(evolucaoImg)
            
            if evolucao.formaEvolucao.range(of: "mega") != nil || evolucao.formaEvolucao.range(of: "primal") != nil ||
                evolucao.formaEvolucao.range(of: "OtherForme") != nil{
                
                if evolucao.nDexOrigem.range(of: "479") != nil{//Rotom
                    
                    criaConstraints(evolucaoImg, destino: viewReferenciaConstraints, height: 50, width: 25, leading: 35)
                    criaConstraints(evolucaoImg, destino: barraBranca, verticalSpacing: -5)
                    
                }else if evolucao.nDexOrigem.range(of: "475") != nil{//Gallade
                    
                    criaConstraints(evolucaoImg, destino: viewReferenciaConstraints, height: 80, width: 40, leading: 110)
                    criaConstraints(evolucaoImg, destino: barraBranca, verticalSpacing: topSpace)
                    
                }else{
                    
                    criaConstraints(evolucaoImg, destino: viewReferenciaConstraints, height: 80, width: 40, leading: leading)
                    criaConstraints(evolucaoImg, destino: barraBranca, verticalSpacing: topSpace)
                    
                }
            }else{
                criaConstraints(evolucaoImg, destino: viewReferenciaConstraints, height: 80, width: 30, leading: leading)
                criaConstraints(evolucaoImg, destino: barraBranca, verticalSpacing: topSpace)
            }
            
        }
        
        //Definindo o meu segundo pokemon
        let segundoPoke = UIButton()
        segundoPoke.setImage(UIImage(named: "\(evolucao.nDexDestino)MS.png"), for: UIControlState())
        segundoPoke.addTarget(self, action: #selector(PokemonViewController.tapPoke(_:)), for: UIControlEvents.touchUpInside)
        segundoPoke.isUserInteractionEnabled = true
        segundoPoke.accessibilityIdentifier = evolucao.nDexDestino
        scrollView.addSubview(segundoPoke)
        
        //definindo as constraints
        if evolucao.formaEvolucao.range(of: "mega") != nil ||
            evolucao.formaEvolucao.range(of: "primal") != nil ||
            evolucao.formaEvolucao.range(of: "OtherForme") != nil{
            
            
            if evolucao.nDexOrigem.range(of: "479") != nil{//Rotom
                criaConstraints(segundoPoke, destino: evolucaoImg, height: 40, width: 40, leading: 20, centerY: true)
            }else{
                criaConstraints(segundoPoke, destino: evolucaoImg, height: 40, width: 40, leading: leading, centerY: true)
            }
            
        }else{
            criaConstraints(segundoPoke, destino: evolucaoImg, height: 40, width: 40, leading: 30 + spaceHorizontal, centerY: true)
        }
        
        if updateConstraint == true{
            viewReferenciaConstraints = segundoPoke
        }
        
    }
    
    
    func montaEevee(_ evolucao: Array<Evolucao>){
        //Definindo a minha imagem
        let primeiroPoke = UIButton()
        primeiroPoke.setImage(UIImage(named: "\(evolucao[0].nDexOrigem)MS.png"), for: UIControlState())
        primeiroPoke.addTarget(self, action: #selector(PokemonViewController.tapPoke(_:)), for: UIControlEvents.touchUpInside)
        primeiroPoke.isUserInteractionEnabled = true
        primeiroPoke.accessibilityIdentifier = evolucao[0].nDexOrigem
        scrollView.addSubview(primeiroPoke)
        
        //definindo as constraints
        criaConstraints(primeiroPoke, destino: viewReferenciaConstraints, height: 40, width: 40, centerX: true)
        criaConstraints(primeiroPoke, destino: barraBranca,verticalSpacing: 0)
        
        
        for evo in evolucao{
            //Definindo a forma de evolucao
            let evolucaoImg = UIImageView()
            //Coloca a imgPadrao do level
            evolucaoImg.image = UIImage(named: "\(evo.formaEvolucao).png")
            scrollView.addSubview(evolucaoImg)
            
            criaConstraints(evolucaoImg, destino: primeiroPoke, height: 19, width: 50, verticalSpacing: 30)
            if viewReferenciaConstraints == scrollView{
                criaConstraints(evolucaoImg, destino: viewReferenciaConstraints, leading: 0)
            }else{
                criaConstraints(evolucaoImg, destino: viewReferenciaConstraints, leading: 40)
            }
            
            viewReferenciaConstraints = evolucaoImg
            
            //Definindo a minha imagem
            let segundoPoke = UIButton()
            segundoPoke.setImage(UIImage(named: "\(evo.nDexDestino)MS.png"), for: UIControlState())
            segundoPoke.addTarget(self, action: #selector(PokemonViewController.tapPoke(_:)), for: UIControlEvents.touchUpInside)
            segundoPoke.isUserInteractionEnabled = true
            segundoPoke.accessibilityIdentifier = evo.nDexDestino
            scrollView.addSubview(segundoPoke)
            
            //definindo as constraints
            criaConstraints(segundoPoke, destino: viewReferenciaConstraints, height: 40, width: 40, verticalSpacing: 15, centerX: true)
        }
        
    }
    
    func montaTyrogue(_ evolucao: Array<Evolucao>){
        //Definindo a minha imagem
        let primeiroPoke = UIButton()
        primeiroPoke.setImage(UIImage(named: "\(evolucao[0].nDexOrigem)MS.png"), for: UIControlState())
        primeiroPoke.addTarget(self, action: #selector(PokemonViewController.tapPoke(_:)), for: UIControlEvents.touchUpInside)
        primeiroPoke.isUserInteractionEnabled = true
        primeiroPoke.accessibilityIdentifier = evolucao[0].nDexOrigem
        scrollView.addSubview(primeiroPoke)
        
        //definindo as constraints
        criaConstraints(primeiroPoke, destino: viewReferenciaConstraints, height: 40, width: 40, centerX: true)
        criaConstraints(primeiroPoke, destino: barraBranca,verticalSpacing: 0)
        
        
        for evo in evolucao{
            //Definindo a forma de evolucao
            let evolucaoImg = UIImageView()
            //Coloca a imgPadrao do level
            evolucaoImg.image = UIImage(named: "\(evo.formaEvolucao).png")
            scrollView.addSubview(evolucaoImg)
            
            criaConstraints(evolucaoImg, destino: primeiroPoke, height: 30, width: 80, verticalSpacing: 35)
            if viewReferenciaConstraints == scrollView{
                criaConstraints(evolucaoImg, destino: viewReferenciaConstraints, leading: 60)
            }else{
                criaConstraints(evolucaoImg, destino: viewReferenciaConstraints, leading: 70)
            }
            
            viewReferenciaConstraints = evolucaoImg
            
            //Definindo a minha imagem
            let segundoPoke = UIButton()
            segundoPoke.setImage(UIImage(named: "\(evo.nDexDestino)MS.png"), for: UIControlState())
            segundoPoke.addTarget(self, action: #selector(PokemonViewController.tapPoke(_:)), for: UIControlEvents.touchUpInside)
            segundoPoke.isUserInteractionEnabled = true
            segundoPoke.accessibilityIdentifier = evo.nDexDestino
            scrollView.addSubview(segundoPoke)
            
            //definindo as constraints
            criaConstraints(segundoPoke, destino: viewReferenciaConstraints, height: 40, width: 40, verticalSpacing: 25, centerX: true)
        }
    }
    
    func criaMoves(){
        //viewReferenciaConstraints
        
        let labelMoves = UILabel()
        
        //configuro meu label
        labelMoves.text = "Moves"
        labelMoves.font = UIFont.boldSystemFont(ofSize: 15.0)
        labelMoves.textColor = UIColor.white
        //adiciono ao meu scroll view
        scrollView.addSubview(labelMoves)
        
        //Defino as contraints
        //margem esquerda
        criaConstraints(labelMoves, destino: scrollView, height: 17, centerX: true)
        criaConstraints(labelMoves, destino: viewReferenciaConstraints, verticalSpacing: 70)
        
        //configurando a minha barraBranca
        let barraBranca = UIView()
        barraBranca.backgroundColor = UIColor.white
        scrollView.addSubview(barraBranca)
        
        //definindo as constraints
        criaConstraints(barraBranca, destino: scrollView, height: 5, leading: 10, trailing: -10)
        criaConstraints(barraBranca, destino: labelMoves, verticalSpacing: 16)
        
        viewReferenciaConstraints = barraBranca
        
        //crio a separacao level - tm/hm - movetutor
        
        var levelUp = Array<move>()
        var tm_Hm = Array<move>()
        var moveTutor = Array<move>()
        var breed = Array<move>()
        var event = Array<move>()
        
        for golpe in pokemon.golpes {
            
            
            //            if golpe.nome == "Giga Drain"{
            //                    print("\(golpe.nome) - \(golpe.breed) - \(golpe.levelUp) - \(golpe.tm) - \(golpe.moveTutor)")
            //            }
            
            if golpe.id == 68 || golpe.id == 231 || golpe.id == 251 || golpe.id == 252{
                event.append(golpe)
            }else if golpe.levelUp != ""{
                levelUp.append(golpe)
            }else if golpe.moveTutor == 1 && golpe.breed == 0{
                moveTutor.append(golpe)
            }else if golpe.breed == 1{
                breed.append(golpe)
            }else{
                tm_Hm.append(golpe)
            }
        }
        
        
        var golpesDaVez = Array<move>()
        var tituloDaVez = String()
        //Ordenando os moves por levelUp
        levelUp.sort { (moveA, moveB) -> Bool in
            
            var numLvMoveA = ""
            var numLvMoveB = ""
            let numeros = ["0","1","2","3","4","5","6","7","8","9"]
            var lvMoveA = moveA.levelUp
            var lvMoveB = moveB.levelUp
            
            while lvMoveA.characters.count > 0{
                //verifico se o ultimo caracter é um numero
                if numeros.contains(String(lvMoveA.characters.last!)){
                    numLvMoveA += String(lvMoveA.characters.last!)
                    lvMoveA = lvMoveA.substring(to: lvMoveA.characters.index(before: lvMoveA.endIndex))
                }else{
                    break
                }
            }
            
            while lvMoveB.characters.count > 0{
                //verifico se o ultimo caracter é um numero
                if numeros.contains(String(lvMoveB.characters.last!)){
                    numLvMoveB += String(lvMoveB.characters.last!)
                    lvMoveB = lvMoveB.substring(to: lvMoveB.characters.index(before: lvMoveB.endIndex))
                }else{
                    break
                }
            }
            
            return Int(String(numLvMoveA.characters.reversed())) < Int(String(numLvMoveB.characters.reversed()))
        }
        
        
        for i in 0 ..< 5{
            
            if i == 0{
                golpesDaVez = levelUp
                tituloDaVez = "Level UP"
            }else if i == 1{
                golpesDaVez = tm_Hm
                tituloDaVez = "TM/HM"
            }else if i == 2{
                golpesDaVez = breed
                tituloDaVez = "Breed"
            }else if i == 3{
                golpesDaVez = moveTutor
                tituloDaVez = "Move Tutor"
            }else{
                golpesDaVez = event
                tituloDaVez = "Especial Event"
            }
            
            if golpesDaVez.count > 0{
                
                //Crio o meu label
                let labelTitle = UILabel()
                
                //Altero a font
                labelTitle.font = UIFont.boldSystemFont(ofSize: 15.0)
                
                //altero o texte
                labelTitle.text = tituloDaVez
                
                //altero a cor
                labelTitle.textColor = UIColor.white
                
                scrollView.addSubview(labelTitle)
                
                criaConstraints(labelTitle, destino: scrollView, height: 17, leading: 10, centerX: true)
                criaConstraints(labelTitle, destino: viewReferenciaConstraints, verticalSpacing: 20)
                
                //configurando a minha barraBranca
                let barraBranca = UIView()
                barraBranca.backgroundColor = UIColor.white
                scrollView.addSubview(barraBranca)
                
                //definindo as constraints
                criaConstraints(barraBranca, destino: scrollView, height: 5, leading: 10, trailing: -10)
                criaConstraints(barraBranca, destino: labelTitle, verticalSpacing: 16)
                
                viewReferenciaConstraints = barraBranca
                
                //para todos os golpes da minha lista
                for golpe in golpesDaVez{
                    //Crio o meu label
                    let labelNome = UILabel()
                    
                    //Altero a font
                    labelNome.font = UIFont.boldSystemFont(ofSize: 11.0)
                    
                    //altero o texte
                    labelNome.text = golpe.nome
                    
                    //altero a cor
                    labelNome.textColor = UIColor.white
                    //crio o mecanismo de chamar a outra tela
                    let tap = UITapGestureRecognizer(target: self, action: #selector(PokemonViewController.tapMove(_:)))
                    labelNome.addGestureRecognizer(tap)
                    labelNome.isUserInteractionEnabled = true
                    
                    scrollView.addSubview(labelNome)
                    
                    criaConstraints(labelNome, destino: scrollView, height: 17, leading: 10, centerX: true)
                    criaConstraints(labelNome, destino: viewReferenciaConstraints, verticalSpacing: 15)
                    
                    
                    //Crio o meu label
                    let labelNum = UILabel()
                    
                    //Altero a font
                    labelNum.font = UIFont.boldSystemFont(ofSize: 11.0)
                    
                    
                    if i == 0{
                        //altero o texto
                        labelNum.text = golpe.levelUp
                    }else if i == 1{
                        
                        
                        switch golpe.nome{
                        case "Cut":
                            labelNum.text = "HM01"
                            break
                        case "Fly":
                            labelNum.text = "HM02"
                            break
                        case "Surf":
                            labelNum.text = "HM03"
                            break
                        case "Strength":
                            labelNum.text = "HM04"
                            break
                        case "Waterfall":
                            labelNum.text = "HM05"
                            break
                        case "Rock Smash":
                            labelNum.text = "HM06"
                            break
                        case "Dive":
                            labelNum.text = "HM07"
                            break
                        default:
                            labelNum.text = "TM\(golpe.tm)"
                            break
                        }
                    }
                    
                    
                    
                    //altero a cor
                    labelNum.textColor = UIColor.white
                    
                    scrollView.addSubview(labelNum)
                    
                    criaConstraints(labelNum, destino: scrollView, height: 17, trailing: -10)
                    criaConstraints(labelNum, destino: viewReferenciaConstraints, verticalSpacing: 15)
                    
                    //configurando a minha barraBranca
                    let barraBranca = UIView()
                    barraBranca.backgroundColor = UIColor.white
                    scrollView.addSubview(barraBranca)
                    
                    //definindo as constraints
                    criaConstraints(barraBranca, destino: scrollView, height: 1, leading: 10, trailing: -10)
                    criaConstraints(barraBranca, destino: labelNome, verticalSpacing: 16)
                    
                    
                    viewReferenciaConstraints = barraBranca
                    
                }
            }
        }
        
        criaConstraints(viewReferenciaConstraints, destino: scrollView, bottomSpacing: -10)
        //criaConstraints(viewReferenciaConstraints, destino: scrollView, verticalSpacing: 10)
        
        
    }
    
    /*
    func tapPoke(_ sender:AnyObject){
        
        if sender.accessibilityIdentifier! != pokemon.nDex{
            //chamando a tela propria da aventura
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "pokemon") as! pokemonViewController
            
            //altero a forma de apresentacao da tela
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            //vc.pokemon = dataBaseManager.instance.getpokemon(sender.accessibilityIdentifier!!)
            //apresento a tela
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }*/
    
    
    func criaConstraints(_ origem:UIView, destino:UIView, height:CGFloat = -1, width:CGFloat = -1, leading:CGFloat = -1, trailing:CGFloat = -1, verticalSpacing:CGFloat = -1, centerX:Bool = false, centerY:Bool = false, bottomSpacing:CGFloat = -1){
        
        origem.translatesAutoresizingMaskIntoConstraints = false
        
        //definindo as constraints
        if height != -1{
            //altura
            let heightObj = NSLayoutConstraint(item: origem, attribute:
                .height, relatedBy: .equal, toItem: nil,
                         attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
                         constant: height)
            //ativando a constraint
            NSLayoutConstraint.activate([heightObj])
        }
        
        if width != -1{
            //largura
            let widthObj = NSLayoutConstraint(item: origem, attribute:
                .width, relatedBy: .equal, toItem: nil,
                        attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1.0,
                        constant: width)
            //ativando a constraint
            NSLayoutConstraint.activate([widthObj])
        }
        
        if leading != -1{
            //margem esquerda
            let leaddingObj = NSLayoutConstraint(item: origem, attribute:
                .leadingMargin, relatedBy: .equal, toItem: destino,
                                attribute: .leadingMargin, multiplier: 1.0,
                                constant: leading)
            //ativando a constraint
            NSLayoutConstraint.activate([leaddingObj])
            
        }
        
        if trailing != -1{
            //margem direita
            let trailingObj = NSLayoutConstraint(item: origem, attribute:
                .trailingMargin, relatedBy: .equal, toItem: destino,
                                 attribute: .trailingMargin, multiplier: 1.0,
                                 constant: trailing)
            //ativando a constraint
            NSLayoutConstraint.activate([trailingObj])
        }
        
        if verticalSpacing != -1{
            //espaco do label de cima
            let verticalSpacingObj = NSLayoutConstraint(item: origem, attribute: .top, relatedBy: .equal,
                                                        toItem: destino, attribute: .top, multiplier: 1.0, constant: verticalSpacing)
            verticalSpacingObj.identifier = "TopSpace"
            //ativo as constraints
            scrollView.addConstraint(verticalSpacingObj)
            NSLayoutConstraint.activate([verticalSpacingObj])
        }
        
        if centerX == true{
            //Centralizacao em X
            let centerXObj = NSLayoutConstraint(item: origem, attribute: .centerX, relatedBy: .equal,
                                                toItem: destino, attribute: .centerX, multiplier: 1.0, constant: 0)
            //ativo as constraints
            NSLayoutConstraint.activate([centerXObj])
        }
        
        if centerY == true{
            //centralizacao em Y
            let centerYObj = NSLayoutConstraint(item: origem, attribute: .centerY, relatedBy: .equal,
                                                toItem: destino, attribute: .centerY, multiplier: 1.0, constant: 0)
            //ativo as constraints
            NSLayoutConstraint.activate([centerYObj])
        }
        
        if bottomSpacing != -1{
            //centralizacao em Y
            let bottomSpacingObj = NSLayoutConstraint(item: origem, attribute: NSLayoutAttribute.bottomMargin, relatedBy: .equal,
                                                      toItem: destino, attribute: .bottomMargin, multiplier: 1.0, constant: bottomSpacing)
            //ativo as constraints
            NSLayoutConstraint.activate([bottomSpacingObj])
        }
        
    }
    
    
    /*
    func tapHabilidade(_ sender:UITapGestureRecognizer){
        
        //Consigo o label que eu dei tap
        let label = sender.view as! UILabel
        //consigo a minha habilidade
        let habi = DataBaseManager.instance.getHabilidadePorNome(label.text!)
        //chamo a nova tela
        chamarOutraTela(habi)
        
    }*/
    
    
    /*
    func tapMove(_ sender:UITapGestureRecognizer){
        
        //Consigo o label que eu dei tap
        let label = sender.view as! UILabel
        //consigo a minha habilidade
        let move = DataBaseManager.instance.getMovePorNome(label.text!)
        
        //chamando a tela propria da aventura
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "move") as! MoveViewController
        
        //altero a forma de apresentacao da tela
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.move = move
        
        //apresento a tela
        self.navigationController?.pushViewController(vc, animated: true)
        
    }*/
    
    
    
    /*func chamarOutraTela(_ habi:Habilidade){
        //chamando a tela propria da aventura
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "habilidade") as! HabilidadeViewController
        
        //altero a forma de apresentacao da tela
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.habilidade = habi
        
        //apresento a tela
        self.navigationController?.pushViewController(vc, animated: true)
    }*/*/
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func calculaStatus(level:Int){
        
        labelLV.text = "LV. \(level)"
        //calculando os ranges
        
        //HP Formula = (Base * 2 + IV + (EV/4)) * Level / 100 + 10 + Level
        let lv = level
        let hp50Min = (poke.hp * 2 + 0 + (0/4)) * lv / 100 + 10 + lv
        let hp50Max = (poke.hp * 2 + 31 + (252/4)) * lv / 100 + 10 + lv
        hpRange50.text = "\(hp50Min) - \(hp50Max)"
        
        //outros stats lv 50
        //Stats Formula = ((Base * 2 + IV + (EV/4)) * Level / 100 + 5) * Nmod
        //attack
        var attack50Min = Double(((poke.ataque * 2 + 0 + (0/4)) * lv / 100 + 5))
        attack50Min *= 0.9
        var attack50Max = Double(((poke.ataque * 2 + 31 + (252/4)) * lv / 100 + 5))
        attack50Max *= 1.1
        attackRange50.text = "\(Int(attack50Min)) - \(Int(attack50Max))"
        
        //defense
        var defense50Min = Double(((poke.defesa * 2 + 0 + (0/4)) * lv / 100 + 5))
        defense50Min *= 0.9
        var defense50Max = Double(((poke.defesa * 2 + 31 + (252/4)) * lv / 100 + 5))
        defense50Max *= 1.1
        defenseRange50.text = "\(Int(defense50Min)) - \(Int(defense50Max))"
        
        //sAttack
        var sAttack50Min = Double(((poke.ataqueEspecial * 2 + 0 + (0/4)) * lv / 100 + 5))
        sAttack50Min *= 0.9
        var sAttack50Max = Double(((poke.ataqueEspecial * 2 + 31 + (252/4)) * lv / 100 + 5))
        sAttack50Max *= 1.1
        sAttackRange50.text = "\(Int(sAttack50Min)) - \(Int(sAttack50Max))"
        
        //sdefense
        var sDefense50Min = Double(((poke.defesaEspecial * 2 + 0 + (0/4)) * lv / 100 + 5))
        sDefense50Min *= 0.9
        var sDefense50Max = Double(((poke.defesaEspecial * 2 + 31 + (252/4)) * lv / 100 + 5))
        sDefense50Max *= 1.1
        sDefenseRange50.text = "\(Int(sDefense50Min)) - \(Int(sDefense50Max))"
        
        //speed
        var speed50Min = Double(((poke.velocidade * 2 + 0 + (0/4)) * lv / 100 + 5))
        speed50Min *= 0.9
        var speed50Max = Double(((poke.velocidade * 2 + 31 + (252/4)) * lv / 100 + 5))
        speed50Max *= 1.1
        speedRange50.text = "\(Int(speed50Min)) - \(Int(speed50Max))"

    }
    
    
    
    
    
    @IBAction func sliderLvModifier(_ sender: UISlider) {
        //print(Int(sender.value))
        calculaStatus(level: Int(sender.value))
    }

}
