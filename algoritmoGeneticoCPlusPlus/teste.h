#pragma once
#include <string>
#include <vector>
#include <map>

using namespace std;

class teste{
private:
	string nomeTeste;
	string nomeFileSaida;

	//vetor de parametros, cada elemento é um conjunto de parametros
	map<string, int> conjuntoParams;

public:
	teste();
	~teste();

	string getNomeTeste();
	string getNomeFileSaida();
	map<string, int>& getConjuntoParams();

	void setNomeTeste(string);
	void setNomeFileSaida(string);
	void setConjuntoParams(map<string, int>);

};

class conjuntoTestes {
private:
	int id;
	string nomeConjuntoTeste;
	string nomeFileSaida;

	vector<teste> conjuntoTeste;

public:
	conjuntoTestes();
	~conjuntoTestes();

	int getId();
	string getNomeConjuntoTeste();
	string getNomeFileSaida();

	vector<teste>& getConjuntoTeste();

	void setId(int);
	void setNomeConjuntoTeste(string);
	void setconjuntoTeste(vector<teste>);
	void addTeste(teste);
	void setNomeFileSaida(string);

};

