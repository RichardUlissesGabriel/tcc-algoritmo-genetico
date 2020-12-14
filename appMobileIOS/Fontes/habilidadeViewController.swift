//
//  habilidadeViewController.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 04/05/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class habilidadeViewController: UIViewController {

    var idHabilidade = 0
    var habi = habilidade()
    
    @IBOutlet weak var efeitoInBattle: UILabel!
    @IBOutlet weak var efeitoFora: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    //auxiliares
    var viewReferenciaConstraints:UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //alterando a cor da viewcontroller
        self.view.backgroundColor = UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1)
        
        preparaTela()
        
        //Adiciono o efeito swipe
        //let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeRecognizer:"))
        //let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("swipeRecognizer:"))
        
        //leftSwipe.direction = .left
        //rightSwipe.direction = .right
        
        //self.view.addGestureRecognizer(leftSwipe)
        //self.view.addGestureRecognizer(rightSwipe)
    }
    
    func preparaTela(){
        habi = dataManager.instance.listaHabilidade[idHabilidade]
        
        //coloco o nome da habilidade no topo da tela
        self.navigationItem.title = habi.nome
        
        //colocando os efeitos na tela
        efeitoInBattle.text = habi.descEfeito
        efeitoFora.text = habi.descEfeitoOutside
        

        
        //monto a lista de pokemons
        criaListaPokemons()
    }
    
    
    /*func swipeRecognizer(_ sender:UISwipeGestureRecognizer){
        
        if sender.direction == .right{
            //Pegando a habilidade anterior
            habilidade = DataBaseManager.instance.getHabilidade(habilidade.id - 1)
            
            //Cheguei ao zero preciso colocar o maximo id
            if habilidade.nome == ""{
                habilidade = DataBaseManager.instance.getHabilidade(DataBaseManager.instance.getMaxIdHabilidade())
            }
            
        }else{
            //Pegando a proxima habilidade
            habilidade = DataBaseManager.instance.getHabilidade(habilidade.id + 1)
            
            //Cheguei no fim preciso voltar para o primeiro
            if habilidade.nome == ""{
                habilidade = DataBaseManager.instance.getHabilidade(1)
            }
        }
        
        //recrio a tela novamente
        preparaTela()
    }*/
    
    
    func criaListaPokemons(){
        
        viewReferenciaConstraints = scrollView
        
        //removo todos os pokemons existentes
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        
        var listaIdsPokemons = Array<Int>()
        
        for i in 0 ..< 3 {
            
            //Crio o meu label
            let labelAbility = UILabel()
            
            //Altero a font
            labelAbility.font = UIFont.boldSystemFont(ofSize: 25.0)
            
            if i == 0 {
                
                //seto o texto
                labelAbility.text = "First Ability"
                
                //consigo a lista dos meus pokemons
                listaIdsPokemons = habi.listaIdsPokesFirst
            }
            
            if i == 1 {
                
                //seto o texto
                labelAbility.text = "Second Ability"
                
                //consigo a lista dos meus pokemons
                listaIdsPokemons = habi.listaIdsPokesSecond
            }
            
            if i == 2 {
                
                //seto o texto
                labelAbility.text = "Hidden Ability"
                
                //consigo a lista dos meus pokemons
                listaIdsPokemons = habi.listaIdsPokesHidden
            }
            
            //altero a cor
            labelAbility.textColor = UIColor.white
            
            //Crio a minha faixa branca
            let viewBranca = UIView()
            viewBranca.backgroundColor = UIColor.white
            let labelHiddenAbility = UILabel()
            let labelSecondAbility = UILabel()
            let labelFirstAbility = UILabel()
            
            if listaIdsPokemons.count != 0{
                
                //Adiciono na minha scrollView
                scrollView.addSubview(labelAbility)
                
                //definindo as constraints
                if viewReferenciaConstraints == scrollView{
                    criaConstraints(labelAbility, destino: viewReferenciaConstraints, height: 24, width: UIScreen.main.bounds.size.width, verticalSpacing: 0)
                }else{
                    criaConstraints(labelAbility, destino: viewReferenciaConstraints, height: 24, width: UIScreen.main.bounds.size.width, verticalSpacing: 40)
                }
                criaConstraints(labelAbility, destino: scrollView, leading: 10)
                
                scrollView.addSubview(viewBranca)
                criaConstraints(viewBranca, destino: self.view, height: 5,leading: 16, trailing: -16)
                criaConstraints(viewBranca, destino: labelAbility, verticalSpacing: 26)
                
                
                labelHiddenAbility.text = "Hidden"
                labelHiddenAbility.textColor = UIColor.white
                
                labelHiddenAbility.font = UIFont.boldSystemFont(ofSize: 10.0)
                labelHiddenAbility.textAlignment = .right
                
                //adicionando o cabechalho
                scrollView.addSubview(labelHiddenAbility)
                criaConstraints(labelHiddenAbility, destino: self.view, height: 24, width: 50, trailing: -16)
                criaConstraints(labelHiddenAbility, destino: viewBranca, verticalSpacing: 5)
                
                
                labelSecondAbility.text = "Second"
                labelSecondAbility.textColor = UIColor.white
                
                labelSecondAbility.font = UIFont.boldSystemFont(ofSize: 10.0)
                labelSecondAbility.textAlignment = .center
                //adicionando o cabechalho
                scrollView.addSubview(labelSecondAbility)
                criaConstraints(labelSecondAbility, destino: scrollView, height: 24, width: 50)
                criaConstraints(labelSecondAbility, destino: labelHiddenAbility, trailing: -60, centerY: true)
                
                
                labelFirstAbility.text = "First"
                labelFirstAbility.textColor = UIColor.white
                
                labelFirstAbility.font = UIFont.boldSystemFont(ofSize: 10.0)
                labelFirstAbility.textAlignment = .left
                
                //adicionando o cabechalho
                scrollView.addSubview(labelFirstAbility)
                criaConstraints(labelFirstAbility, destino: scrollView, height: 24, width: 50)
                criaConstraints(labelFirstAbility, destino: labelSecondAbility, trailing: -60, centerY: true)
                
                
                viewReferenciaConstraints = labelHiddenAbility
            }
            
            //para cada pokemon eu monto a minha linha de pokemons
            for idPoke in listaIdsPokemons{
                
                let poke = dataManager.instance.listaPokemons[idPoke-1]
                
                //imagem
                let imgPoke = UIImageView()
                imgPoke.image = UIImage(named: poke.nomeImgMS)
                scrollView.addSubview(imgPoke)
                criaConstraints(imgPoke, destino: scrollView, height: 40, width: 40, leading: 10)
                
                if viewReferenciaConstraints == labelHiddenAbility{
                    criaConstraints(imgPoke, destino: viewReferenciaConstraints, verticalSpacing:10)
                }else{
                    criaConstraints(imgPoke, destino: viewReferenciaConstraints, verticalSpacing:30)
                }
                
                viewReferenciaConstraints = imgPoke
                
                //Nome
                let nomePoke = UILabel()
                nomePoke.text = poke.nome
                
                //crio o mecanismo de chamar a outra tela
                let tap = UITapGestureRecognizer(target: self, action: #selector(habilidadeViewController.tapPoke(_:)))
                nomePoke.addGestureRecognizer(tap)
                nomePoke.isUserInteractionEnabled = true
                
                nomePoke.textColor = UIColor.white
                nomePoke.numberOfLines = 2
                
                if poke.nome.characters.count <= 14{
                    nomePoke.font = UIFont.boldSystemFont(ofSize: 13.0)
                }else{
                    nomePoke.font = UIFont.boldSystemFont(ofSize: 10.0)
                }
                //Altero a font
                labelAbility.font = UIFont.boldSystemFont(ofSize: 20.0)
                
                scrollView.addSubview(nomePoke)
                criaConstraints(nomePoke, destino: scrollView, height: 30, width: 100)
                criaConstraints(nomePoke, destino: imgPoke, leading: 40, centerY: true)
                
                //Colocando as outras habilidades
                let firstHabilidade = dataManager.instance.listaHabilidade[poke.idHabilidade1-1]
                let secondHabilidade = (poke.idHabilidade2 != 0 ? dataManager.instance.listaHabilidade[poke.idHabilidade2-1] : habilidade())
                let hiddenHabilidade = (poke.idHabilidade2 != 0 ? dataManager.instance.listaHabilidade[poke.idHabilidadeHidden-1] : habilidade())
                
                let labelFirst = UILabel()
                
                //altero o nome
                labelFirst.text = (firstHabilidade.nome == "") ? "None" : firstHabilidade.nome
                labelFirst.numberOfLines = 2
                
                //altero a cor
                labelFirst.textColor = UIColor.white
                labelFirst.textAlignment = .left
                
                //Altero a font, se for a mesma coloco em italico
                if firstHabilidade.nome == habi.nome{
                    labelFirst.font = UIFont.italicSystemFont(ofSize: 8.0)
                }else{
                    //se nao coloco como negrito
                    labelFirst.font = UIFont.boldSystemFont(ofSize: 7.0)
                    
                    //crio o mecanismo de chamar a outra tela
                    let tap = UITapGestureRecognizer(target: self, action: #selector(habilidadeViewController.tapHabilidade(_:)))
                    labelFirst.addGestureRecognizer(tap)
                    labelFirst.isUserInteractionEnabled = true
                }
                
                //adiciono na tela
                scrollView.addSubview(labelFirst)
                criaConstraints(labelFirst, destino: scrollView, height: 30, width: 50)
                criaConstraints(labelFirst, destino: nomePoke, centerY: true)
                criaConstraints(labelFirst, destino: labelFirstAbility, centerX: true)
                
                let labelSecond = UILabel()
                
                labelSecond.text = (secondHabilidade.nome == "") ? "None" : secondHabilidade.nome
                labelSecond.numberOfLines = 2
                labelSecond.textAlignment = .center
                
                labelSecond.textColor = UIColor.white
                //Altero a font
                if secondHabilidade.nome == habi.nome{
                    labelSecond.font = UIFont.italicSystemFont(ofSize: 8.0)
                }else{
                    labelSecond.font = UIFont.boldSystemFont(ofSize: 7.0)
                    
                    if labelSecond.text != "None"{
                        
                        //crio o mecanismo de chamar a outra tela
                        let tap = UITapGestureRecognizer(target: self, action: #selector(habilidadeViewController.tapHabilidade(_:)))
                        labelSecond.addGestureRecognizer(tap)
                        labelSecond.isUserInteractionEnabled = true
                    }
                }
                
                scrollView.addSubview(labelSecond)
                criaConstraints(labelSecond, destino: scrollView, height: 30, width: 50)
                criaConstraints(labelSecond, destino: nomePoke, centerY: true)
                criaConstraints(labelSecond, destino: labelSecondAbility, centerX: true)
                
                let labelHidden = UILabel()
                
                labelHidden.text = (hiddenHabilidade.nome == "") ? "None" : hiddenHabilidade.nome
                labelHidden.numberOfLines = 2
                labelHidden.textAlignment = .right
                
                labelHidden.textColor = UIColor.white
                //Altero a font
                if hiddenHabilidade.nome == habi.nome{
                    labelHidden.font = UIFont.italicSystemFont(ofSize: 8.0)
                }else{
                    labelHidden.font = UIFont.boldSystemFont(ofSize: 7.0)
                    
                    if labelHidden.text != "None"{
                        //crio o mecanismo de chamar a outra tela
                        let tap = UITapGestureRecognizer(target: self, action: #selector(habilidadeViewController.tapHabilidade(_:)))
                        labelHidden.addGestureRecognizer(tap)
                        labelHidden.isUserInteractionEnabled = true
                    }
                }
                
                scrollView.addSubview(labelHidden)
                criaConstraints(labelHidden, destino: scrollView, height: 30, width: 50)
                criaConstraints(labelHidden, destino: nomePoke, centerY: true)
                criaConstraints(labelHidden, destino: labelHiddenAbility, centerX: true)
            }
        }
        
        criaConstraints(viewReferenciaConstraints, destino: scrollView, bottomSpacing: -10)
        
    }
    
    func tapPoke(_ sender:UITapGestureRecognizer){
        
        //Consigo o label que eu dei tap
        let label = sender.view as! UILabel
        //consigo meu poke
        
        var poke = pokemon()
        
        for pokemon in dataManager.instance.listaPokemons{
            if pokemon.nome == label.text{
                poke = pokemon
                break
            }
        }
        
        //chamando a tela propria da aventura
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "pokemon") as! pokemonViewController
        
        //altero a forma de apresentacao da tela
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.idPokemon = poke.idPokemon - 1
        
        //apresento a tela
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tapHabilidade(_ sender:UITapGestureRecognizer){
        
        //Consigo o label que eu dei tap
        let label = sender.view as! UILabel
        
        var habi = habilidade()
        
        for habiEscolhida in dataManager.instance.listaHabilidade{
            if habiEscolhida.nome == label.text{
                habi = habiEscolhida
                break
            }
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "habilidade") as! habilidadeViewController
        
        //altero a forma de apresentacao da tela
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.idHabilidade = habi.idHabilidade - 1
        
        //apresento a tela
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func criaConstraints(_ origem:UIView, destino:UIView, height:CGFloat = -1, width:CGFloat = -1, leading:CGFloat = -1, trailing:CGFloat = -1, verticalSpacing:CGFloat = -1, bottomSpacing:CGFloat = -1,centerX:Bool = false, centerY:Bool = false){
        
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
            //ativo as constraints
            NSLayoutConstraint.activate([verticalSpacingObj])
        }
        
        if bottomSpacing != -1{
            //espaco do label de cima
            let bottomObj = NSLayoutConstraint(item: origem, attribute: .bottomMargin, relatedBy: .equal,
                                               toItem: destino, attribute: .bottomMargin, multiplier: 1.0, constant: bottomSpacing)
            //ativo as constraints
            NSLayoutConstraint.activate([bottomObj])
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
    }

}
