#pragma once
#include <string>
#include <vector>
#include <map>
#include "cromossomo.h"
#include "timer.h"
#include "dataManager.h"
#include <tuple>
#include <random>
#include "resultadoExecucao.h"


//Defines para facilitar a escolha dos metodos utilizados
#define CALIBRACAO 0

#define ROLETA 1
#define TORNEIO 2

#define CRUZAMENTO_UM_PONTO 1
#define CRUZAMENTO_MULTI_PONTO 2
#define CRUZAMENTO_UNIFORME 3

#define SELECIONAR_FILHOS 1
#define SUBSTITUIR_PIORES_FILHOS 2
#define ELITISMO 3

#define TIPOS 1
#define ATRIBUTOS 2
#define ATRIBUTOS_TIPOS 3

#define POPULACAO 0
#define FILHOS 1


using namespace std;

class algoritmoGenetico{
private:

	//Parametros do algoritmo
	int qtdPopulacaoInicial;
	int modoCrossover;
	int tipoSelecao;
	int tipoProxGeracao;
	int qtdEpocas;
	int congelamento;
	int tamTorneio;
	float taxaMutacao;
	float taxaElitismo;
	float taxaFilhosATrocar;
	int formaAvaliacao;

	vector<tipo>& tipos = dataManager::getInstance().getListaTipos();

	//time inimigo
	vector<pokemon> timeInimigo;
	

	//Estruturas de dados
	vector<cromossomo> populacao;
	vector<cromossomo> pais;
	vector<cromossomo> filhos;

	//Metodos auxiliares
	int getNumberRandom(int, int);
	float calculaSomaDoDano(pokemon &, pokemon &);

	//Metodos
	void geracaoPopulacaoInicial();

	void avaliacao(int);
	void avaliacaoTipos(int);
	void avaliacaoCalibracao(int);
	void avaliacaoAtributos(int);

	void selecaoPais();

	int getQtdInvalidos();

	void criacaoFilhos();
	void crossover(cromossomo, cromossomo);
	void mutacao(cromossomo&);
	
	void selecaoProxGeracao();
	
public:
	algoritmoGenetico(map<string,int>,vector<pokemon>);
	~algoritmoGenetico();
	string comecar();
	vector<resultadoExecucao> comecarTeste();
	resultadoExecucao comecarTesteDesempenho();
};

