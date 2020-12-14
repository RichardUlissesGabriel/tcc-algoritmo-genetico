//
//  teamViewController.swift
//  PokemonTeam
//
//  Created by Richard Gabriel on 06/05/17.
//  Copyright © 2017 Richard Gabriel. All rights reserved.
//

import UIKit

class teamViewController: UIViewController {

    //YOUR TEAM
    //Imagens
    @IBOutlet weak var poke1: UIImageView!
    @IBOutlet weak var poke2: UIImageView!
    @IBOutlet weak var poke3: UIImageView!
    @IBOutlet weak var poke4: UIImageView!
    @IBOutlet weak var poke5: UIImageView!
    @IBOutlet weak var poke6: UIImageView!
    
    //Nomes
    @IBOutlet weak var pokeNome1: UILabel!
    @IBOutlet weak var pokeNome2: UILabel!
    @IBOutlet weak var pokeNome3: UILabel!
    @IBOutlet weak var pokeNome4: UILabel!
    @IBOutlet weak var pokeNome5: UILabel!
    @IBOutlet weak var pokeNome6: UILabel!
    
    //Ndexs
    @IBOutlet weak var pokeDex1: UILabel!
    @IBOutlet weak var pokeDex2: UILabel!
    @IBOutlet weak var pokeDex3: UILabel!
    @IBOutlet weak var pokeDex4: UILabel!
    @IBOutlet weak var pokeDex5: UILabel!
    @IBOutlet weak var pokeDex6: UILabel!
    
    //ENEMY TEAM
    //Imagens
    @IBOutlet weak var enemyPoke1: UIImageView!
    @IBOutlet weak var enemyPoke2: UIImageView!
    @IBOutlet weak var enemyPoke3: UIImageView!
    @IBOutlet weak var enemyPoke4: UIImageView!
    @IBOutlet weak var enemyPoke5: UIImageView!
    @IBOutlet weak var enemyPoke6: UIImageView!
    
    //Nomes
    @IBOutlet weak var enemyPokeNome1: UILabel!
    @IBOutlet weak var enemyPokeNome2: UILabel!
    @IBOutlet weak var enemyPokeNome3: UILabel!
    @IBOutlet weak var enemyPokeNome4: UILabel!
    @IBOutlet weak var enemyPokeNome5: UILabel!
    @IBOutlet weak var enemyPokeNome6: UILabel!
    
    //Ndexs
    @IBOutlet weak var enemyPokeDex1: UILabel!
    @IBOutlet weak var enemyPokeDex2: UILabel!
    @IBOutlet weak var enemyPokeDex3: UILabel!
    @IBOutlet weak var enemyPokeDex4: UILabel!
    @IBOutlet weak var enemyPokeDex5: UILabel!
    @IBOutlet weak var enemyPokeDex6: UILabel!
    
    @IBOutlet weak var chanceVitoria: UILabel!
    var stringResposta = String()
    
    
    var viewLoading = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chanceVitoria.isHidden = true
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(teamViewController.tapImgPoke(_:)))
        enemyPoke1.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(teamViewController.tapImgPoke(_:)))
        enemyPoke2.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(teamViewController.tapImgPoke(_:)))
        enemyPoke3.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(teamViewController.tapImgPoke(_:)))
        enemyPoke4.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(teamViewController.tapImgPoke(_:)))
        enemyPoke5.addGestureRecognizer(tap)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(teamViewController.tapImgPoke(_:)))
        enemyPoke6.addGestureRecognizer(tap)
        
        
        viewLoading = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewLoading.isHidden = true
        viewLoading.backgroundColor = UIColor(red: 72.0/255, green: 72.0/255, blue: 72.0/255, alpha: 1)
        viewLoading.alpha = 1.0
        
        let labelCriando = UILabel(frame: CGRect(x: UIScreen.main.bounds.midX - UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.minY + 150, width: UIScreen.main.bounds.width, height: 150))
        labelCriando.text = "Criando"
        labelCriando.textColor = UIColor.white
        labelCriando.textAlignment = NSTextAlignment.center
        labelCriando.font = UIFont(name: "PokemonHollowNormal", size: 50.0)
        viewLoading.addSubview(labelCriando)
        
        let labelTime = UILabel(frame: CGRect(x: UIScreen.main.bounds.midX - UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.maxX, width: UIScreen.main.bounds.width, height: 150))
        labelTime.text = "Time"
        labelTime.textColor = UIColor.white
        labelTime.textAlignment = NSTextAlignment.center
        labelTime.font = UIFont(name: "PokemonHollowNormal", size: 50.0)
        viewLoading.addSubview(labelTime)
        
        
        let loading = UIImageView(frame: CGRect(x: UIScreen.main.bounds.midX - 100, y: UIScreen.main.bounds.midY - 71.5, width: 200, height: 143))
        loading.image = UIImage(named: "pikaLoading1.png")
        //UIActivityIndicatorView(frame: CGRect(x: UIScreen.mainScreen().bounds.midX, y: UIScreen.mainScreen().bounds.midY, width: 100, height: 100))
        loading.animationImages = [
            UIImage(named: "pikaLoading2.png")!,
            UIImage(named: "pikaLoading3.png")!,
            UIImage(named: "pikaLoading4.png")!,
            UIImage(named: "pikaLoading1.png")!
        ]
        
        loading.animationDuration = 0.5
        loading.startAnimating()
        viewLoading.addSubview(loading)
        self.view.addSubview(viewLoading)
        
        
        //timer para verificacao do retorno da requisicao
        _ = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(arrumaTimeNaTela), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        printaTimeInimigo()
    }
    
    
    //Essa funcao pega as informacoes dos pokemons do data manager e printa na tela
    func printaTimeInimigo(){
        
        if dataManager.instance.idsPokemonsSelecionados[0] != 0 {
            let idPokeEnemy1 = dataManager.instance.idsPokemonsSelecionados[0]
            enemyPoke1.image = UIImage(named: dataManager.instance.listaPokemons[idPokeEnemy1-1].nomeImgMS)
            enemyPokeNome1.text = dataManager.instance.listaPokemons[idPokeEnemy1-1].nome
            enemyPokeDex1.text = dataManager.instance.listaPokemons[idPokeEnemy1-1].nDex
        }
        
        if dataManager.instance.idsPokemonsSelecionados[1] != 0 {
            let idPokeEnemy2 = dataManager.instance.idsPokemonsSelecionados[1]
            enemyPoke2.image = UIImage(named: dataManager.instance.listaPokemons[idPokeEnemy2-1].nomeImgMS)
            enemyPokeNome2.text = dataManager.instance.listaPokemons[idPokeEnemy2-1].nome
            enemyPokeDex2.text = dataManager.instance.listaPokemons[idPokeEnemy2-1].nDex
        }
        
        if dataManager.instance.idsPokemonsSelecionados[2] != 0 {
            let idPokeEnemy3 = dataManager.instance.idsPokemonsSelecionados[2]
            enemyPoke3.image = UIImage(named: dataManager.instance.listaPokemons[idPokeEnemy3-1].nomeImgMS)
            enemyPokeNome3.text = dataManager.instance.listaPokemons[idPokeEnemy3-1].nome
            enemyPokeDex3.text = dataManager.instance.listaPokemons[idPokeEnemy3-1].nDex
        }
        
        if dataManager.instance.idsPokemonsSelecionados[3] != 0 {
            let idPokeEnemy4 = dataManager.instance.idsPokemonsSelecionados[3]
            enemyPoke4.image = UIImage(named: dataManager.instance.listaPokemons[idPokeEnemy4-1].nomeImgMS)
            enemyPokeNome4.text = dataManager.instance.listaPokemons[idPokeEnemy4-1].nome
            enemyPokeDex4.text = dataManager.instance.listaPokemons[idPokeEnemy4-1].nDex
        }
        
        if dataManager.instance.idsPokemonsSelecionados[4] != 0 {
            let idPokeEnemy5 = dataManager.instance.idsPokemonsSelecionados[4]
            enemyPoke5.image = UIImage(named: dataManager.instance.listaPokemons[idPokeEnemy5-1].nomeImgMS)
            enemyPokeNome5.text = dataManager.instance.listaPokemons[idPokeEnemy5-1].nome
            enemyPokeDex5.text = dataManager.instance.listaPokemons[idPokeEnemy5-1].nDex
        }
        
        if dataManager.instance.idsPokemonsSelecionados[5] != 0 {
            let idPokeEnemy6 = dataManager.instance.idsPokemonsSelecionados[5]
            enemyPoke6.image = UIImage(named: dataManager.instance.listaPokemons[idPokeEnemy6-1].nomeImgMS)
            enemyPokeNome6.text = dataManager.instance.listaPokemons[idPokeEnemy6-1].nome
            enemyPokeDex6.text = dataManager.instance.listaPokemons[idPokeEnemy6-1].nDex
        }
    }

    //Essa funcao abre a lista depokemons para o cara adicionar o pokemon inimigo
    func tapImgPoke(_ sender:UITapGestureRecognizer){
        
        let ImgTaped = sender.view as! UIImageView
        
        //chamando a tela propria da aventura
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "listaPoke") as! listaPokemonViewController
        
        //altero a forma de apresentacao da tela
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.selecaoTeam = true
        vc.indexTimeInimigo = Int(ImgTaped.accessibilityIdentifier!)!

        //apresento a tela
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gerarTime(_ sender: AnyObject) {

        if dataManager.instance.idsPokemonsSelecionados[0] == 0 ||
            dataManager.instance.idsPokemonsSelecionados[1] == 0 ||
            dataManager.instance.idsPokemonsSelecionados[2] == 0 ||
            dataManager.instance.idsPokemonsSelecionados[3] == 0 ||
            dataManager.instance.idsPokemonsSelecionados[4] == 0 ||
            dataManager.instance.idsPokemonsSelecionados[5] == 0 {
            
            let alert = UIAlertController(title: "Ops", message: "Existem Pokemons não selecionados!!!", preferredStyle: UIAlertControllerStyle.alert)
            
            let btOk = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
            
            alert.addAction(btOk)
            self.present(alert, animated: true, completion: nil)
            
        }else{
            //print("Algoritmo Genetico")
            viewLoading.isHidden = false
            //self.readResposta()
            
            //adiciono o botao de cancelamento
            //self.navigationController?.navigationBar.topItem!.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(teamViewController.cancel(_:)))
            
            //colocando thread
            OperationQueue().addOperation{
            
                //Defino minha requisicao
                var request = URLRequest(url: URL(string: "http://192.168.0.3/DatabasePokemon/fontes/AG.php?time=\(dataManager.instance.idsPokemonsSelecionados[0])-\(dataManager.instance.idsPokemonsSelecionados[1])-\(dataManager.instance.idsPokemonsSelecionados[2])-\(dataManager.instance.idsPokemonsSelecionados[3])-\(dataManager.instance.idsPokemonsSelecionados[4])-\(dataManager.instance.idsPokemonsSelecionados[5])")!)
                
                
                request.httpMethod = "GET"
                
                let semaphore = DispatchSemaphore(value: 0)
                
                //lanço minha requisicao
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {
                        self.createErrorMenssage()
                        return
                    }
                    
                    //verifico quando a minha requisicao retornou
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                        self.createErrorMenssage()
                        return
                    }
                    
                    //testando a execessao com throw e catch
                    do {
                        
                        //serializo o JSON em um array de dicionario de chave e valor
                        guard let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [Int]
                            else {
                                //se nao conseguir serializar a data Json mostro o erro e retorno da funcao
                                //print("problemas ao serializar o JSON")
                                return
                        }
                        

                        dataManager.instance.timeRetorno = json
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
        }
    }
    
    func createErrorMenssage(){
        
        // Crio o alerta de erro
        let alert = UIAlertController(title: "Ops...", message: "Aconteceu um erro de conexao", preferredStyle: UIAlertControllerStyle.alert)
        
        // Adiciono a acao de encerrar o aplicativo por erro de conexao
        let btExit = UIAlertAction(title: "Sair", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            self.viewLoading.isHidden = true
            self.navigationController?.navigationBar.topItem!.rightBarButtonItem = nil
        })
        
        //adiciono o botao va mensagem
        alert.addAction(btExit)
        
        //Apresento a mensagem para o usuario
        self.present(alert, animated: true, completion: nil)

    }
    
    
    func cancel(_ sender:UIBarButtonItem){
        //task.cancel()
        viewLoading.isHidden = true
        self.navigationController?.navigationBar.topItem!.rightBarButtonItem = nil
    }
    
    func arrumaTimeNaTela(){
        
        if dataManager.instance.timeRetorno.count > 0 {
            
            let time = dataManager.instance.timeRetorno
            
            //imagens
            poke1.image = UIImage(named: (dataManager.instance.listaPokemons[time[0]-1].nomeImgMS))
            poke2.image = UIImage(named: (dataManager.instance.listaPokemons[time[1]-1].nomeImgMS))
            poke3.image = UIImage(named: (dataManager.instance.listaPokemons[time[2]-1].nomeImgMS))
            poke4.image = UIImage(named: (dataManager.instance.listaPokemons[time[3]-1].nomeImgMS))
            poke5.image = UIImage(named: (dataManager.instance.listaPokemons[time[4]-1].nomeImgMS))
            poke6.image = UIImage(named: (dataManager.instance.listaPokemons[time[5]-1].nomeImgMS))
            
            //Nomes
            pokeNome1.text = dataManager.instance.listaPokemons[time[0]-1].nome
            pokeNome2.text = dataManager.instance.listaPokemons[time[1]-1].nome
            pokeNome3.text = dataManager.instance.listaPokemons[time[2]-1].nome
            pokeNome4.text = dataManager.instance.listaPokemons[time[3]-1].nome
            pokeNome5.text = dataManager.instance.listaPokemons[time[4]-1].nome
            pokeNome6.text = dataManager.instance.listaPokemons[time[5]-1].nome
            
            //ndex
            pokeDex1.text = dataManager.instance.listaPokemons[time[0]-1].nDex
            pokeDex2.text = dataManager.instance.listaPokemons[time[1]-1].nDex
            pokeDex3.text = dataManager.instance.listaPokemons[time[2]-1].nDex
            pokeDex4.text = dataManager.instance.listaPokemons[time[3]-1].nDex
            pokeDex5.text = dataManager.instance.listaPokemons[time[4]-1].nDex
            pokeDex6.text = dataManager.instance.listaPokemons[time[5]-1].nDex
            
            viewLoading.isHidden = true
            
            //Zero o meu retorno
            dataManager.instance.timeRetorno = [Int]()
        }
    }
    
    
    @IBAction func limparPokes(_ sender: AnyObject) {
        
        //Imagens
        enemyPoke1.image = UIImage(named: "desconhecidoIcon.png")
        enemyPoke2.image = UIImage(named: "desconhecidoIcon.png")
        enemyPoke3.image = UIImage(named: "desconhecidoIcon.png")
        enemyPoke4.image = UIImage(named: "desconhecidoIcon.png")
        enemyPoke5.image = UIImage(named: "desconhecidoIcon.png")
        enemyPoke6.image = UIImage(named: "desconhecidoIcon.png")
        
        //Nomes
        enemyPokeNome1.text = "--"
        enemyPokeNome2.text = "--"
        enemyPokeNome3.text = "--"
        enemyPokeNome4.text = "--"
        enemyPokeNome5.text = "--"
        enemyPokeNome6.text = "--"
        
        //Ndexs
        enemyPokeDex1.text = "--"
        enemyPokeDex2.text = "--"
        enemyPokeDex3.text = "--"
        enemyPokeDex4.text = "--"
        enemyPokeDex5.text = "--"
        enemyPokeDex6.text = "--"
        
        
        //Imagens
        poke1.image = UIImage(named: "desconhecidoIcon.png")
        poke1.restorationIdentifier = "img1"
        poke2.image = UIImage(named: "desconhecidoIcon.png")
        poke2.restorationIdentifier = "img2"
        poke3.image = UIImage(named: "desconhecidoIcon.png")
        poke3.restorationIdentifier = "img3"
        poke4.image = UIImage(named: "desconhecidoIcon.png")
        poke4.restorationIdentifier = "img4"
        poke5.image = UIImage(named: "desconhecidoIcon.png")
        poke5.restorationIdentifier = "img5"
        poke6.image = UIImage(named: "desconhecidoIcon.png")
        poke6.restorationIdentifier = "img6"
        
        //Nomes
        pokeNome1.text = "--"
        pokeNome2.text = "--"
        pokeNome3.text = "--"
        pokeNome4.text = "--"
        pokeNome5.text = "--"
        pokeNome6.text = "--"
        
        dataManager.instance.idsPokemonsSelecionados = [0,0,0,0,0,0]
        
        //Ndexs
        pokeDex1.text = "--"
        pokeDex2.text = "--"
        pokeDex3.text = "--"
        pokeDex4.text = "--"
        pokeDex5.text = "--"
        pokeDex6.text = "--"
    
    }
    

    //chama o web service e espera a resposta
    func readResposta(){
    }
}
