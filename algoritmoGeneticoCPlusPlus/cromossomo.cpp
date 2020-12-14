#include "cromossomo.h"



cromossomo::cromossomo(vector<int> idsPoke){
	//converto o numero inteiro passado para uma string binaria
	this->fenotipo = "";
	
	for (unsigned i = 0; i < idsPoke.size(); ++i) {
		this->fenotipo += padBinario(DecToBin(idsPoke[i]), 10);

		//adiciono os pokemons ao meu time
		this->timePokemon.push_back(dataManager::getInstance().getListaPokemons()[idsPoke[i] - 1]);
	}
}

cromossomo::cromossomo(string _fenotipo) {
	//consegui o fenotipo pronto, usado no metodo de crossover do AG
	this->fenotipo = _fenotipo;

	this->decodificaCromossomo();

}

cromossomo::~cromossomo(){}

//getters
string& cromossomo::getFenotipo() { return this->fenotipo; }
int cromossomo::getFitness() { return this->fitness; }
float cromossomo::getProbabilidade() { return this->probabilidade; }
vector<pokemon>& cromossomo::getTimePokemon() { return this->timePokemon; }

//setters
void cromossomo::setFenotipo(string _feno) { 
	this->fenotipo = _feno;
	//Preparando o time novamente
	this->decodificaCromossomo();
}
void cromossomo::setFitness(int _fitness) { this->fitness = _fitness; }
void cromossomo::incrementaFitness(int _valor) { this->fitness += _valor; }
void cromossomo::setProbabilidade(float _probabilidade) { this->probabilidade = _probabilidade; }

//Metodos auxiliares
//Essa funcao converte o numero decimal para uma string binaria
string cromossomo::DecToBin(int numero) {
	if (numero == 0) return "0";
	if (numero == 1) return "1";

	if (numero % 2 == 0)
		return cromossomo::DecToBin(numero / 2) + "0";
	else
		return cromossomo::DecToBin(numero / 2) + "1";
}

//essa funcao deixa padrão o numero de casas binarias
string cromossomo::padBinario(string bin, int tamanho) {
	string retorno = bin;
	for (unsigned i = 0; i < tamanho - bin.size(); ++i) {
		retorno = "0" + retorno;
	}
	return retorno;
}

void cromossomo::decodificaCromossomo() {

	/*cout << "poke1 : " << fenotipo.substr(0, 10)  << " idPoke " << stoi(fenotipo.substr(0, 10) , nullptr, 2) << endl;
	cout << "poke2 : " << fenotipo.substr(10, 10) << " idPoke " << stoi(fenotipo.substr(10, 10), nullptr, 2) << endl;
	cout << "poke3 : " << fenotipo.substr(20, 10) << " idPoke " << stoi(fenotipo.substr(20, 10), nullptr, 2) << endl;
	cout << "poke4 : " << fenotipo.substr(30, 10) << " idPoke " << stoi(fenotipo.substr(30, 10), nullptr, 2) << endl;
	cout << "poke5 : " << fenotipo.substr(40, 10) << " idPoke " << stoi(fenotipo.substr(40, 10), nullptr, 2) << endl;
	cout << "poke6 : " << fenotipo.substr(50, 10) << " idPoke " << stoi(fenotipo.substr(50, 10), nullptr, 2)<<endl;*/
	this->timePokemon.clear();
	for (int i = 0, subStrTam = 0; i < 6; ++i, subStrTam += 10) {
		//converto o numero do fenotipo para inteiro
		unsigned idPoke = stoi(fenotipo.substr(subStrTam, 10), nullptr, 2); 
	
		//verifico se o meu numero inteiro eh um id de pokemon valido
		if (idPoke < dataManager::getInstance().getListaPokemons().size() && idPoke != 0) {

			bool existePoke = false;

			//verificando pokemons repetidos
			for (unsigned i = 0; i < this->timePokemon.size(); ++i) {
				if (this->timePokemon[i].getIdPokemon() == idPoke) {
						this->fitness = -999;//cromossomo invalido
						this->probabilidade = 0.0f;
						this->timePokemon = vector<pokemon>();
						existePoke = true;
						break;
				}
			}

			if (existePoke == false)
				//adiciono o pokemon valido ao meu time
				this->timePokemon.push_back(dataManager::getInstance().getListaPokemons()[idPoke - 1]);


		}else {
			this->fitness = -999;//cromossomo invalido
			this->probabilidade = 0.0f;
			this->timePokemon = vector<pokemon>();
			break;
		}
	}

}

string cromossomo::toString() {
	stringstream ss;

	for (unsigned i = 0; i < this->timePokemon.size(); ++i) {
		ss << this->timePokemon[i].getIdPokemon();
		if (i + 1 != this->timePokemon.size())
			ss << "-";
	}

	return ss.str();
}