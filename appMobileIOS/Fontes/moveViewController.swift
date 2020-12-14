//
//  moveViewController.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 04/05/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class moveViewController: UIViewController {
    
    var idGolpe = 0
    var golpe = move()
    
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var power: UILabel!
    @IBOutlet weak var accuracy: UILabel!
    @IBOutlet weak var pp: UILabel!
    
    @IBOutlet weak var tipo: UIImageView!
    @IBOutlet weak var categoria: UIImageView!
    @IBOutlet weak var contest: UIImageView!
    
    @IBOutlet weak var prioridade: UILabel!
    @IBOutlet weak var alvo: UILabel!
    @IBOutlet weak var tm: UILabel!
    @IBOutlet weak var tmNum: UILabel!
    
    @IBOutlet weak var scrolView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preparaTela()
    }
    
    func preparaTela(){
        
        golpe = dataManager.instance.listaMove[idGolpe]
        
        //coloco o nome do move no topo da tela
        self.navigationItem.title = golpe.nome
        
        descricao.text = golpe.descricao
        power.text = "\(golpe.power)"
        accuracy.text = "\(golpe.accuracy)"
        pp.text = "\(golpe.pp)"
        
        tipo.image = UIImage(named: dataManager.instance.listaTipo[golpe.idTipo-1].nomeImg)
        categoria.image = UIImage(named: golpe.nomeImgCategoriaMove)
        contest.image = UIImage(named: golpe.nomeImgContestMove)
        
        prioridade.text = "\(golpe.prioridade)"
        alvo.text = golpe.target
        
        if golpe.numeroTM == 0{
            
            tm.isHidden = true
            tmNum.isHidden = true
            
        }else{
            tmNum.text = "\(golpe.numeroTM)"
        }
        
        //        //Alterar o tamanho do scroll view
        //        scrolView.contentSize.height = self.view.bounds.height * 1
        //
        criaListaPokemons()
        
        //Adiciono o efeito swipe
        //let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MoveViewController.swipeRecognizer(_:)))
        //let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(MoveViewController.swipeRecognizer(_:)))
        
        //leftSwipe.direction = .left
        //rightSwipe.direction = .right
        
        //self.view.addGestureRecognizer(leftSwipe)
        //self.view.addGestureRecognizer(rightSwipe)
    }
    
    /*func swipeRecognizer(_ sender:UISwipeGestureRecognizer){
        
        if sender.direction == .right{
            //Pegando a habilidade anterior
            move = DataBaseManager.instance.getMove(move.id - 1)
            
            //Cheguei ao zero preciso colocar o maximo id
            if move.nome == ""{
                move = DataBaseManager.instance.getMove(DataBaseManager.instance.getMaxIdMove())
            }
            
        }else{
            //Pegando a proxima habilidade
            move = DataBaseManager.instance.getMove(move.id + 1)
            
            //Cheguei no fim preciso voltar para o primeiro
            if move.nome == ""{
                move = DataBaseManager.instance.getMove(1)
            }
        }
        
        //recrio a tela novamente
        preparaTela()
    }*/
    
    func criaListaPokemons(){
        
        //Alterar o tamanho do scroll view
        //scrolView.contentSize.height = 50
        
        //removo todos os pokemons existentes
        for view in self.scrolView.subviews {
            view.removeFromSuperview()
        }
        
        var listaIdsPokemons = Array<Int>()
        var viewReferencia:UIView = scrolView
        
        
        for i in 0 ..< 4 {
            
            //label com o tipo de aprendizado
            var labelMove = UILabel()
            
            //altero o titulo de acordo com o tipo de aprendizado requirido
            if i == 0{
                labelMove = UILabel()
                listaIdsPokemons = golpe.listaIdsPokesLevelUp
                labelMove.text = "Level UP"
            }
            
            if i == 1{
                labelMove = UILabel()
                listaIdsPokemons = golpe.listaIdsPokesTm
                labelMove.text = "TM"
            }
            
            if i == 2{
                labelMove = UILabel()
                listaIdsPokemons = golpe.listaIdsPokesBreed
                labelMove.text = "Breed"
            }
            
            if i == 3{
                labelMove = UILabel()
                listaIdsPokemons = golpe.listaIdsPokesMoveTutor
                labelMove.text = "Move Tutor"
            }
            
            if listaIdsPokemons.count != 0{
                
                //Alterar o tamanho do scroll view
                //scrolView.contentSize.height += self.view.bounds.height * (CGFloat(listaPokemons.count)/21)
                
                
                
                //Definindo as configuracoes do label
                labelMove.textColor = UIColor.white
                labelMove.font = UIFont.boldSystemFont(ofSize: 15.0)
                scrolView.addSubview(labelMove)
                
                if viewReferencia == scrolView{
                    criaConstraints(labelMove, destino: viewReferencia, verticalSpacing:10)
                }else{
                    criaConstraints(labelMove, destino: viewReferencia, verticalSpacing:40)
                }
                criaConstraints(labelMove, destino: scrolView, leading:10)
                
                //barra branca que acompanha o titulo
                let barraBranca = UIView()
                barraBranca.backgroundColor = UIColor.white
                scrolView.addSubview(barraBranca)
                //definindo as constraints
                criaConstraints(barraBranca, destino: self.view, height: 5, leading: 16, trailing: -16)
                criaConstraints(barraBranca, destino: labelMove, verticalSpacing:16)
                
                
                viewReferencia = barraBranca
                
                for idPoke in listaIdsPokemons{
                    
                    let poke = dataManager.instance.listaPokemons[idPoke-1]
                    
                    let imgPoke = UIImageView()
                    imgPoke.image = UIImage(named: poke.nomeImgMS)
                    scrolView.addSubview(imgPoke)
                    
                    if viewReferencia == barraBranca{
                        criaConstraints(imgPoke, destino: viewReferencia, height: 40, width: 40, verticalSpacing: 10)
                    }else{
                        criaConstraints(imgPoke, destino: viewReferencia, height: 40, width: 40, verticalSpacing: 30)
                    }
                    criaConstraints(imgPoke, destino: scrolView, leading:10)
                    
                    let pokeName = UILabel()
                    pokeName.textColor = UIColor.white
                    pokeName.font = UIFont.boldSystemFont(ofSize: 13.0)
                    pokeName.text = poke.nome
                    
                    
                    //crio o mecanismo de chamar a outra tela
                    let tap = UITapGestureRecognizer(target: self, action: #selector(moveViewController.tapPoke(_:)))
                    pokeName.addGestureRecognizer(tap)
                    pokeName.isUserInteractionEnabled = true
                    
                    
                    scrolView.addSubview(pokeName)
                    criaConstraints(pokeName, destino: imgPoke, leading:40, centerY:true)
                    
                    let pokelv = UILabel()
                    pokelv.textColor = UIColor.white
                    pokelv.font = UIFont.boldSystemFont(ofSize: 13.0)
                    if i == 0{
                        pokelv.text = poke.listaIdsMovesLevelUp["\(golpe.idMove)"]
                    }
                    scrolView.addSubview(pokelv)
                    criaConstraints(pokelv, destino: pokeName, centerY:true)
                    criaConstraints(pokelv, destino: self.view, trailing:-26)
                    
                    viewReferencia = imgPoke
                }
            }
        }
        
        criaConstraints(viewReferencia, destino: scrolView, bottomSpacing: -10)
        
        
    }
    
    
    
    func tapPoke(_ sender:UITapGestureRecognizer){
        
        //Consigo o label que eu dei tap
        let label = sender.view as! UILabel
        
        //print(label.text!)
        
        //consigo meu poke
        var poke = pokemon()
        
        for pokeEscolhido in dataManager.instance.listaPokemons{
            //print(pokeEscolhido.nome)
            if pokeEscolhido.nome == label.text{
                poke = pokeEscolhido
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
