//
//  carregamentoViewController.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 25/04/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class carregamentoViewController: UIViewController {

    @IBOutlet weak var gifPikaCarregamento: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Adicionando as imagens do gif do pokémon
        gifPikaCarregamento.animationImages = [
            UIImage(named: "pikaLoading2.png")!,
            UIImage(named: "pikaLoading3.png")!,
            UIImage(named: "pikaLoading4.png")!,
            UIImage(named: "pikaLoading1.png")!
        ]
        
        //Definindo o tempo da animacao
        gifPikaCarregamento.animationDuration = 0.5

        //Iniciando a animacao
        gifPikaCarregamento.startAnimating()
        
        //colocando thread
        OperationQueue().addOperation{
        
            //Conseguindo todos os json para a cricao dos objetos
            let pokeJson = self.getJsonFromPHP(nameJson: "pokemon")
            let geracaoJson = self.getJsonFromPHP(nameJson: "geracao")
            let tipoJson = self.getJsonFromPHP(nameJson: "tipo")
            let moveJson = self.getJsonFromPHP(nameJson: "move")
            let habilidadeJson = self.getJsonFromPHP(nameJson: "habilidade")
            let eggGroupJson = self.getJsonFromPHP(nameJson: "eggGroup")

            
            
            //Convertendo a geracao
            for i in 0 ..< geracaoJson.count{
                let novaGen = geracao()
                novaGen.idGeracao = geracaoJson[i]["idGeracao"] as! Int
                novaGen.numeroRomano = geracaoJson[i]["numeroRomano"] as! String
                novaGen.nome = geracaoJson[i]["nome"] as! String
                dataManager.instance.listaGen.append(novaGen)
            }
            
            //Convertendo o Tipo
            for i in 0 ..< tipoJson.count{
                let novoTipo = tipo()
                novoTipo.idTipo = tipoJson[i]["idTipo"] as! Int
                novoTipo.nome = tipoJson[i]["nome"] as! String
                novoTipo.nomeImg = tipoJson[i]["nomeImg"] as! String
                novoTipo.nomeImgDamage = tipoJson[i]["nomeImgDamage"] as! String
                novoTipo.damageTipoTaken = tipoJson[i]["damageTipoTaken"] as! [Float]
                
                
                /*
                for i in 0 ..< damageTaken.count{
                
                    let dano = damageTaken[i]["dano"] as! Float
                    
                    novoTipo.damageTipoTaken.append(["dano":dano])
                    
                }
                */
                dataManager.instance.listaTipo.append(novoTipo)
            }
            
            //Convertendo o move
            for i in 0 ..< moveJson.count{
                
                let novoMove = move();
                
                novoMove.idMove = moveJson[i]["idMove"] as! Int
                novoMove.nome = moveJson[i]["nome"] as! String
                novoMove.prioridade = moveJson[i]["prioridade"] as! Int
                novoMove.pp = moveJson[i]["pp"] as! Int
                novoMove.ppMax = moveJson[i]["ppMax"] as! Int
                novoMove.power = moveJson[i]["power"] as! Int
                novoMove.accuracy = moveJson[i]["accuracy"] as! Float
                novoMove.descricao = moveJson[i]["descricao"] as! String
                novoMove.categoriaMove = moveJson[i]["categoriaMove"] as! String
                novoMove.nomeImgCategoriaMove = moveJson[i]["nomeImgCategoriaMove"] as! String
                
                if let cM = moveJson[i]["contestMove"] as? String {
                
                    novoMove.contestMove = cM
                    novoMove.nomeImgContestMove = moveJson[i]["nomeImgContestMove"] as! String
                
                }else{
                    
                    novoMove.contestMove = ""
                    novoMove.nomeImgContestMove = ""
                    
                }
                    
                novoMove.idTipo = moveJson[i]["idTipo"] as! Int
                novoMove.efeito = moveJson[i]["efeito"] as! String
                novoMove.chanceEfeito = moveJson[i]["chanceEfeito"] as! Float
                novoMove.target = moveJson[i]["target"] as! String
                novoMove.numeroTM = moveJson[i]["numeroTM"] as! Int
                
                novoMove.listaIdsPokesLevelUp = moveJson[i]["listaIdsPokesLevelUp"] as! [Int]
                novoMove.listaIdsPokesBreed = moveJson[i]["listaIdsPokesBreed"] as! [Int]
                novoMove.listaIdsPokesTm = moveJson[i]["listaIdsPokesTm"] as! [Int]
                novoMove.listaIdsPokesMoveTutor = moveJson[i]["listaIdsPokesMoveTutor"] as! [Int]
                //pode ser nulo
                if let lmt = moveJson[i]["locMoveTutor"] as? String {
                    novoMove.locMoveTutor = lmt
                    novoMove.valorMoveTutor = moveJson[i]["valorMoveTutor"] as! String
                }else{
                    novoMove.locMoveTutor = ""
                    novoMove.valorMoveTutor = ""
                }
                
                if let zC = moveJson[i]["zCrystal"] as? String{
                
                    novoMove.zCrystal = zC
                    novoMove.nomeImgzCrystal = moveJson[i]["nomeImgzCrystal"] as! String
                    novoMove.idMoveRequerido = moveJson[i]["idMoveRequerido"] as! Int
                    
                }else{
                    
                    novoMove.zCrystal = ""
                    novoMove.nomeImgzCrystal = ""
                    novoMove.idMoveRequerido = 0
                    
                }
                
                if let eA = moveJson[i]["efeitoAdicional"] as? String{
                    novoMove.efeitoAdicional = eA
                }else{
                    novoMove.efeitoAdicional = ""
                }
                    
                dataManager.instance.listaMove.append(novoMove)
            }
            
            //Convertendo a habilidade
            for i in 0 ..< habilidadeJson.count{
                let novaHabi = habilidade()
                
                novaHabi.idHabilidade = habilidadeJson[i]["idHabilidade"] as! Int
                novaHabi.nome = habilidadeJson[i]["nome"] as! String
                novaHabi.descEfeito = habilidadeJson[i]["descEfeito"] as! String
                novaHabi.descEfeitoOutside = habilidadeJson[i]["descEfeitoOutside"] as! String
                novaHabi.listaIdsPokesFirst = habilidadeJson[i]["listaIdsPokesFirst"] as! [Int]
                novaHabi.listaIdsPokesSecond = habilidadeJson[i]["listaIdsPokesSecond"] as! [Int]
                novaHabi.listaIdsPokesHidden = habilidadeJson[i]["listaIdsPokesHidden"] as! [Int]
                    
                    
                dataManager.instance.listaHabilidade.append(novaHabi)
            }
            
            //Convertendo os eggGroups
            for i in 0 ..< eggGroupJson.count{
                let novoEgg = eggGroup()
                
                novoEgg.idEggGroup = eggGroupJson[i]["idEggGroup"] as! Int
                novoEgg.nome = eggGroupJson[i]["nome"] as! String
                novoEgg.nomeImg = eggGroupJson[i]["nomeImg"] as! String
                novoEgg.listaPokemon = eggGroupJson[i]["listaPokemon"] as! [Int]
                
                dataManager.instance.listaEggGroup.append(novoEgg)
            }
            
            //Convertendo os pokemons
            for i in 0 ..< pokeJson.count{
                let novoPoke = pokemon()

                novoPoke.idPokemon = pokeJson[i]["idPokemon"] as! Int
                novoPoke.nDex = pokeJson[i]["nDex"] as! String
                novoPoke.nome = pokeJson[i]["nome"] as! String
                novoPoke.nomeImgMS = pokeJson[i]["nomeImgMS"] as! String
                novoPoke.nomeImg = pokeJson[i]["nomeImg"] as! String
                novoPoke.hp = pokeJson[i]["hp"] as! Int
                novoPoke.ataque = pokeJson[i]["ataque"] as! Int
                novoPoke.defesa = pokeJson[i]["defesa"] as! Int
                novoPoke.ataqueEspecial = pokeJson[i]["ataqueEspecial"] as! Int
                novoPoke.defesaEspecial = pokeJson[i]["defesaEspecial"] as! Int
                novoPoke.velocidade = pokeJson[i]["velocidade"] as! Int
                novoPoke.idTipo1 = pokeJson[i]["idTipo1"] as! Int
                novoPoke.idTipo2 = pokeJson[i]["idTipo2"] as! Int
                novoPoke.idGeracao = pokeJson[i]["idGeracao"] as! Int
                novoPoke.idHabilidade1 = pokeJson[i]["idHabilidade1"] as! Int
                novoPoke.idHabilidade2 = pokeJson[i]["idHabilidade2"] as! Int
                novoPoke.idHabilidadeHidden = pokeJson[i]["idHabilidadeHidden"] as! Int
                novoPoke.idPokemonEvolucao = pokeJson[i]["idPokemonEvolucao"] as! Int
                
                if let lE = pokeJson[i]["levelEvo"] as? String{
                    novoPoke.levelEvo = lE
                }else{
                    novoPoke.levelEvo = ""
                }
                
                novoPoke.nomeImgEvo = pokeJson[i]["nomeImgEvo"] as! String
                novoPoke.idPreEvolucao = pokeJson[i]["idPreEvolucao"] as! Int
                novoPoke.listaIdsEggGroups = pokeJson[i]["listaIdsEggGroups"] as! [Int]
                novoPoke.listaIdsMovesLevelUp = pokeJson[i]["listaIdsMovesLevelUp"] as! [String:String]
                novoPoke.listaIdsMovesTm = pokeJson[i]["listaIdsMovesTm"] as! [Int]
                novoPoke.listaIdsMovesMoveTutor = pokeJson[i]["listaIdsMovesMoveTutor"] as! [Int]
                novoPoke.listaIdsMovesBreed = pokeJson[i]["listaIdsMovesBreed"] as! [Int]

                dataManager.instance.listaPokemons.append(novoPoke)

            }
            
           
            /*//Prints de teste
            for i in 0 ..< dataManager.instance.listaGen.count{
                print("\(dataManager.instance.listaGen[i].idGeracao) - \(dataManager.instance.listaGen[i].numeroRomano) - \(dataManager.instance.listaGen[i].nome)")
            }
            
            for i in 0 ..< dataManager.instance.listaMove.count{
                print("\(dataManager.instance.listaMove[i].nome)")
            }
            
            for i in 0 ..< dataManager.instance.listaTipo.count{
                print("\(dataManager.instance.listaTipo[i].idTipo) - \(dataManager.instance.listaTipo[i].nome) - \(dataManager.instance.listaTipo[i].nomeImg) - \(dataManager.instance.listaTipo[i].nomeImgDamage) - \(dataManager.instance.listaTipo[i].damageTipoTaken)")
            }
            
            for i in 0 ..< dataManager.instance.listaHabilidade.count{
                print("\(dataManager.instance.listaHabilidade[i].nome)")
            }
            
            for i in 0 ..< dataManager.instance.listaEggGroup.count{
                print("\(dataManager.instance.listaEggGroup[i].nome)")
            }
            
            for i in 0 ..< dataManager.instance.listaPokemons.count{
                print("\(dataManager.instance.listaPokemons[i].nome)")
            }
            //=========================*/
            
            
            //chamando a tela com a tab bar
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "listaPokemon") as! UINavigationController
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(vc, animated: true, completion: nil)
            
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getJsonFromPHP(nameJson:String) -> [[String:Any]]{
        
        var numEscolha = 0
        var retorno:Any?
        
        switch nameJson {
        case "pokemon":
            numEscolha = 1
            break
        case "geracao":
            numEscolha = 2
            break
        case "tipo":
            numEscolha = 3
            break
        case "move":
            numEscolha = 4
            break
        case "habilidade":
            numEscolha = 5
            break
        case "eggGroup":
            numEscolha = 6
            break
        default:
            numEscolha = 0
        }
        
        if (numEscolha != 0){
        
        
            //Defino minha requisicao
            var request = URLRequest(url: URL(string: "http://192.168.0.3/DatabasePokemon/fontes/getDataManager.php?getData=\(numEscolha)")!)
            request.httpMethod = "GET"
            
            let semaphore = DispatchSemaphore(value: 0)
            
            //lanço minha requisicao
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    // erro de conexao com a internet
                    print("error=\(String(describing: error))")
                    
                    
                    // Crio o alerta de erro
                    let alert = UIAlertController(title: "Ops...", message: "Aconteceu um erro de conexao", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // Adiciono a acao de encerrar o aplicativo por erro de conexao
                    let btExit = UIAlertAction(title: "Sair", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                        exit(0)
                    })
                    
                    //adiciono o botao va mensagem
                    alert.addAction(btExit)
                    
                    //Apresento a mensagem para o usuario
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }
                
                //verifico quando a minha requisicao retornou
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    //resultado diferente de 200 é erro
                    print("statusCode tem que ser 200, mas é \(httpStatus.statusCode)")
                    print("Resposta = \(String(describing: response))")
                    
                    // Crio o alerta de erro
                    let alert = UIAlertController(title: "Ops...", message: "Aconteceu um erro de conexao", preferredStyle: UIAlertControllerStyle.alert)
                    
                    // Adiciono a acao de encerrar o aplicativo por erro de conexao
                    let btExit = UIAlertAction(title: "Sair", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                        exit(0)
                    })
                    
                    //adiciono o botao va mensagem
                    alert.addAction(btExit)
                    
                    //Apresento a mensagem para o usuario
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                //testando a execessao com throw e catch
                do {
                    
                    //serializo o JSON em um array de dicionario de chave e valor
                    guard let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String:Any]]
                        else {
                            //se nao conseguir serializar a data Json mostro o erro e retorno da funcao
                            //print("problemas ao serializar o JSON")
                            return
                    }
                    
                    //print(json[0]["nome"]!)
                    retorno = json
                    semaphore.signal()
                    
                }
                    //Lancou uma excecao, printo o erro no console
                catch {
                    print("erro ao conseguir o valor JSON: \(error)")
                    
                }
                
            }
            
            //Comando para lancar a requisição
            task.resume()
            semaphore.wait()
        }
        
        return retorno as! [[String : Any]]
    }
    
    

}
