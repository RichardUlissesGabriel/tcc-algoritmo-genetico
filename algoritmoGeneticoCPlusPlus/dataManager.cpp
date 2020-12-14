#include "dataManager.h"

//no construtor padrao do singleton, vou realizar a leitura de todos os arquivos json
//e organizar nas listas dessa classe
dataManager::dataManager()
{
	
	//Lendo todos os arquivos jSON
	//json pokes = json::parse(fileManager::getInstance().readFromFile("C:/wamp/www/TCC/pokemon.json").c_str());
	//json types = json::parse(fileManager::getInstance().readFromFile("C:/wamp/www/TCC/tipo.json").c_str());
	//json move = json::parse(fileManager::getInstance().readFromFile("C:/wamp/www/TCC/move.json").c_str());
	
	json pokes = json::parse(fileManager::getInstance().readFromFile("C:/wamp64/www/DatabasePokemon/fontes/pokemon.json").c_str());
	json types = json::parse(fileManager::getInstance().readFromFile("C:/wamp64/www/DatabasePokemon/fontes/tipo.json").c_str());
	//json move = json::parse(fileManager::getInstance().readFromFile("C:/wamp64/www/DatabasePokemon/fontes/move.json").c_str());
	
	//Vou comecar a decodificar
	//decodificando os tipos
	for (unsigned i = 0; i < types.size(); ++i) {
		map<int, float> danos;

		for (unsigned j = 0; j < types[i]["damageTipoTaken"].size(); ++j) {
			danos[j+1] = types[i]["damageTipoTaken"][j];
			//cout << types[i]["damageTipoTaken"] << endl;
		}
		
		this->listaTipo.push_back(tipo(types[i]["idTipo"], types[i]["nome"], danos));
	}

	//decodificando os golpes
	/*for (unsigned i = 0; i < move.size(); ++i) {
		this->listaGolpes.push_back(golpe(
			move[i]["idMove"],         
			move[i]["nome"],			
			move[i]["prioridade"],		
			move[i]["pp"],				
			move[i]["power"],			
			move[i]["accuracy"],		 
			move[i]["descricao"],		
			move[i]["idTipo"],         
			(!move[i]["efeitoAdicional"].is_null() ? move[i]["efeitoAdicional"] : ""),
			move[i]["chanceEfeito"],	 
			(!move[i]["zCrystal"].is_null() ? true : false),					
			move[i]["categoriaMove"]	
		));								   
	}*/

	//decodificando os pokemons
	for (unsigned i = 0; i < pokes.size(); ++i) {
		
		/*//Conseguindo a lista de golpes
		vector<int> golpes; 
		//Golpes eh um map de string por string
		auto golpesLv = pokes[i]["listaIdsMovesLevelUp"];

		//passo por todos os elementos do map e consigo as chaves para meu array
		for (auto it = golpesLv.begin(); it != golpesLv.end(); ++it) {
			golpes.push_back(stoi(it.key()));
		}

		golpes.insert(golpes.end(), pokes[i]["listaIdsMovesTm"].begin(), pokes[i]["listaIdsMovesTm"].end());
		golpes.insert(golpes.end(), pokes[i]["listaIdsMovesMoveTutor"].begin(), pokes[i]["listaIdsMovesMoveTutor"].end());
		golpes.insert(golpes.end(), pokes[i]["listaIdsMovesBreed"].begin(), pokes[i]["listaIdsMovesBreed"].end());

		//Removendo as duplicatas
		unordered_set<int> s;
		for (int i : golpes)
			s.insert(i);
		golpes.assign(s.begin(), s.end());

		//ignorando os golpes de status
		for (unsigned j = 0; j < golpes.size(); ++j) {
			if (getGolpe(golpes[j]).getCategoriaMove() == "Status") {
				golpes.erase(golpes.begin() + j);
				j--;
			}
		}
		*/
		this->listaPokemons.push_back(pokemon(
			pokes[i]["idPokemon"],           
			pokes[i]["nome"],				
			pokes[i]["hp"],					 
			pokes[i]["ataque"],				 
			pokes[i]["defesa"],				 
			pokes[i]["ataqueEspecial"],		 
			pokes[i]["defesaEspecial"],		 
			pokes[i]["velocidade"],			 
			pokes[i]["idTipo1"],			
			pokes[i]["idTipo2"]//,			
			//golpes
		));
	}

	/*for (unsigned i = 0; i < listaPokemons.size(); ++i) {
		cout << listaPokemons[i].getNome() <<endl;
	}*/
}

//singleton
dataManager& dataManager::getInstance() {
	static dataManager instance; //Iniciando somente no primeiro acesso
	return instance;
}

dataManager::~dataManager(){}

vector<pokemon>& dataManager::getListaPokemons() { return this->listaPokemons; }
//vector<golpe>& dataManager::getListaGolpes() { return this->listaGolpes; }
vector<tipo>& dataManager::getListaTipos() { return this->listaTipo; }
pokemon& dataManager::getPokemon(int idPokemon) { return this->listaPokemons[idPokemon-1]; }
tipo& dataManager::getTipo(int idTipo) { return this->listaTipo[idTipo - 1]; }
//golpe& dataManager::getGolpe(int idMove) { return this->listaGolpes[idMove - 1]; }