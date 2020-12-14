#include "testeManager.h"



testeManager::testeManager(){
	//será carregado a lista de pokemons para teste

	//Lendo todos os arquivos jSON
	json timesParaTeste = json::parse(fileManager::getInstance().readFromFile("timesParaTeste.json").c_str());

	for (unsigned i = 0; i < timesParaTeste.size(); ++i) {

		vector<pokemon> time;

		for (unsigned j = 0; j < timesParaTeste[i].size(); ++j) {
			int id = timesParaTeste[i][j];
			pokemon poke = dataManager::getInstance().getListaPokemons()[--id];
			time.push_back(poke);
		}

		listaTimes.push_back(time);
	}

}


testeManager::~testeManager(){}

//singleton
testeManager& testeManager::getInstance() {
	static testeManager instance; //Iniciando somente no primeiro acesso
	return instance;
}

void testeManager::iniciar(string _nomeFileTestes, int _qtdTeste, int _modo) {
	
	this->decodeTestes(_nomeFileTestes);

	if (_modo == TEMPO) {
		this->executarTeste(_qtdTeste);
	}
	else if (_modo == DESEMPENHO) {
		this->executarTesteDesempenho(_qtdTeste);
	}
}



void testeManager::decodeTestes(string _nomeFileTestes) {
	//Lendo todos os arquivos jSON
	json testes = json::parse(fileManager::getInstance().readFromFile(_nomeFileTestes).c_str());

	//this->nomeFileSaida = getNomeFileSaida(testes[1]["id"]);
	for (unsigned i = 0; i < testes.size(); ++i) {
		conjuntoTestes ct;
		ct.setId(testes[i]["id"]);
		ct.setNomeConjuntoTeste(testes[i]["teste"]);
		ct.setNomeFileSaida(getNomeFileSaida(testes[i]["id"]));

		for (unsigned j = 0; j < testes[i]["conjuntoTeste"].size(); ++j) {
			teste testeDaVez;
			map<string, int> params;
			testeDaVez.setNomeTeste(testes[i]["conjuntoTeste"][j]["nomeTeste"]);
			testeDaVez.setNomeFileSaida(getNomeFileSaida(testes[i]["id"]));

			params["qtdPopulacaoInicial"] = testes[i]["conjuntoTeste"][j]["qtdPopulacaoInicial"];
			params["qtdEpocas"] = testes[i]["conjuntoTeste"][j]["qtdEpocas"];
			params["congelamento"] = testes[i]["conjuntoTeste"][j]["congelamento"];
			params["formaAvaliacao"] = testes[i]["conjuntoTeste"][j]["formaAvaliacao"];
			params["tipoSelecao"] = testes[i]["conjuntoTeste"][j]["tipoSelecao"];
			params["tamTorneio"] = testes[i]["conjuntoTeste"][j]["tamTorneio"];
			params["modoCrossover"] = testes[i]["conjuntoTeste"][j]["modoCrossover"];
			params["taxaMutacao"] = testes[i]["conjuntoTeste"][j]["taxaMutacao"];
			params["tipoProxGeracao"] = testes[i]["conjuntoTeste"][j]["tipoProxGeracao"];
			params["taxaFilhosATrocar"] = testes[i]["conjuntoTeste"][j]["taxaFilhosATrocar"];
			params["taxaElitismo"] = testes[i]["conjuntoTeste"][j]["taxaElitismo"];

			testeDaVez.setConjuntoParams(params);

			ct.addTeste(testeDaVez);
		}

		//testeDaVez.setNomeFileSaida(getNomeFileSaida(testes[i]["id"]))
		this->listaTestes.push_back(ct);
	}
}

void testeManager::executarTeste(int _qtdTeste) {
	//passo por todos os conjuntos de testes
	//for (unsigned i = 0; i < this->listaTestes.size(); ++i) {

	for (conjuntoTestes ct : this->listaTestes) {
		//cout << ct.getNomeConjuntoTeste() << endl;

		for (teste t : ct.getConjuntoTeste()) {
			//cout << t.getNomeTeste() << endl;

			for (int i = 0; i < _qtdTeste; ++i) {

				algoritmoGenetico ag(t.getConjuntoParams(), this->listaTimes[i]);
				stringstream ss;

				vector<resultadoExecucao> res = ag.comecarTeste();

				cout << t.getNomeTeste();

				for (resultadoExecucao resultado : res) {
					//cout << t.getNomeTeste() << endl;

					//coloco o nome do teste A1, A2, A3  ...

					//Seleciono qual informacao eu necessito
					switch (ct.getId()) {
					case AVALIACAO:
						ss << t.getNomeTeste() << ";" << resultado.getUmRes("avaliacaoPais") << "\n";
						ss << t.getNomeTeste() << ";" << resultado.getUmRes("avaliacaoFilhos") << "\n";
						break;
					case SELECAO:
						ss << t.getNomeTeste() << ";" << resultado.getUmRes("selecaoPais") << "\n";
						break;
					case CROSSOVER:
						ss << t.getNomeTeste() << ";" << resultado.getUmRes("criacaoFilhos") << "\n";
						break;
					case CROSSOVER_INVALIDOS:
						ss << t.getNomeTeste() << ";" << resultado.getUmRes("criacaoFilhosInvalidos") << "\n";
						break;
					case PROX_GERACAO:
						ss << t.getNomeTeste() << ";" << resultado.getUmRes("proxGeracao") << "\n";
						break;
					default:
						break;
					}

					//salvando o resultado no arquivo
					fileManager::getInstance().writeInFile(ss.str(), ct.getNomeFileSaida(), true);

				}

				cout << " - FIM!!!" << endl;
			}
		}

		fileManager::getInstance().closeFileWrite();

	}


	//}

}


void testeManager::executarTesteDesempenho(int _qtdTeste) {
	//passo por todos os conjuntos de testes
	//for (unsigned i = 0; i < this->listaTestes.size(); ++i) {
	stringstream ss;

	ss << "nomeTeste;tempoExecucao;fitness;timeEscolhido;timeInimigo;\n";

	for (conjuntoTestes ct : this->listaTestes) {
		//cout << ct.getNomeConjuntoTeste() << endl;

		for (teste t : ct.getConjuntoTeste()) {
			//cout << t.getNomeTeste() << endl;

			for (int i = 0; i < _qtdTeste; ++i) {

				algoritmoGenetico ag(t.getConjuntoParams(), this->listaTimes[i]);
				
				resultadoExecucao res = ag.comecarTesteDesempenho();

				cout << t.getNomeTeste();

				ss << t.getNomeTeste() << ";" << res.getRes("execucao") << ";" << res.getRes("fitness");
				ss << ";" << res.getRes("timeEscolhido") << ";" << res.getRes("timeInimigo") << "\n";

				//salvando o resultado no arquivo
				fileManager::getInstance().writeInFile(ss.str(), ct.getNomeFileSaida(), true);

				//limpando o stringstream
				ss.clear();
				ss.str(string());

				cout << " - FIM!!!" << endl;
			}
		}

		fileManager::getInstance().closeFileWrite();

	}
}

string testeManager::getNomeFileSaida(int _idTeste) {
	switch (_idTeste){
	case AVALIACAO:
		return "resAvaliacao.csv";
	case SELECAO:
		return "resSelecao.csv";
	case CROSSOVER:
		return "resCrossover.csv";
	case CROSSOVER_INVALIDOS:
		return "resCrossoverInvalidos.csv";
	case PROX_GERACAO:
		return "resProxGeracao.csv";
	case DESEMPENHO:
		return "resDesempenho.csv";
	default:
		return "Erro!!!";
	}
}