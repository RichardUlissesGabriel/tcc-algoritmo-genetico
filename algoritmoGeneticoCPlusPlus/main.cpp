#pragma once
#include <iostream>
#include "algoritmoGenetico.h"

#include <iterator>
#include "testeManager.h"

using namespace std;

//--Metodos auxiliares para dividir a string--
template<typename Out>
void split(const string &s, char delim, Out result) {
	stringstream ss;
	ss.str(s);
	string item;
	while (getline(ss, item, delim)) {
		*(result++) = stoi(item);
	}
}

vector<int> split(const string &s, char delim) {
	vector<int> elems;
	split(s, delim, back_inserter(elems));
	return elems;
}

//essa funcao gera 100 times para testes, ele printa um json no console
void gerarTimesInimigos() {
	stringstream ss;

	ss << "[";

	for (int i = 0; i < 100; ++i) {
		ss << "[";
		for (int j = 0; j < 6; ++j) {

			random_device rd; // conseguindo um numero randomico do hardware
			mt19937 eng(rd()); // semente geradora
			uniform_int_distribution<> distr(1, 920); // define o range

			ss << distr(eng);
			
			ss << (j + 1 == 6 ? "" : ",");
		}
		ss << (i+1 == 100?"]":"],");
	}

	ss << "]";


	cout << ss.str();
}
//----------------------------------------------

int main(int argc, char *argv[]) {
	
	//gerarTimesInimigos();

	stringstream ss;
	ss << argv[1];

	//Significa que estou realizando testes
	if (ss.str() == "teste") {
		
		ss.str(string());
		ss.clear();
		ss << argv[3];

		if (ss.str() == "tempo") {
			testeManager::getInstance().iniciar(argv[2], 1, TEMPO);
		} else {
			testeManager::getInstance().iniciar(argv[2], 20, DESEMPENHO);
		}

	}else {

		vector<int> idsPoke = split(argv[1], '-');

		vector<pokemon> timeInimigo;

		for (unsigned i = 0; i < idsPoke.size(); ++i)
			timeInimigo.push_back(dataManager::getInstance().getListaPokemons()[idsPoke[i]-1]);

		map<string, int> params;

		params["qtdPopulacaoInicial"]  = 50;
		params["modoCrossover"] = CRUZAMENTO_UM_PONTO;
		params["tipoSelecao"] = ROLETA;
		params["tipoProxGeracao"] = SELECIONAR_FILHOS;
		params["qtdEpocas"] = 100;
		params["congelamento"] = 20;
		params["tamTorneio"] = 0;
		params["taxaMutacao"] = 1;
		params["taxaElitismo"] = 0;
		params["taxaFilhosATrocar"] = 0;
		params["formaAvaliacao"] = ATRIBUTOS;


		algoritmoGenetico ag(params,timeInimigo);
		cout << ag.comecar() << endl;
	}

	return 0;
}