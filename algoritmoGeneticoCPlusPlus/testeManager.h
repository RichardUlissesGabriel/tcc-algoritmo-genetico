#pragma once
#include "teste.h"
#include "algoritmoGenetico.h"
#include "jsonParser.h"


#define AVALIACAO 0
#define SELECAO 1
#define CROSSOVER 2
#define CROSSOVER_INVALIDOS 3
#define PROX_GERACAO 4

#define DESEMPENHO 5
#define TEMPO 6


using namespace std;
using json = nlohmann::json;

class testeManager{
private:
	testeManager();
	//string nomeFileSaida;
	//stringstream resultado;
	vector<vector<pokemon>> listaTimes;
	vector<conjuntoTestes> listaTestes;

	void decodeTestes(string);
	void executarTeste(int);
	void executarTesteDesempenho(int);

public:
	static testeManager& getInstance();
	void iniciar(string,int,int);
	string getNomeFileSaida(int);

	~testeManager();
};

