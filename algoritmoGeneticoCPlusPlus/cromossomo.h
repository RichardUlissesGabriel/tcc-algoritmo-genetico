#pragma once
#include <string>
#include <iostream>
#include "pokemon.h"
#include "dataManager.h"

using namespace std;

class cromossomo{
private:
	string fenotipo;
	int fitness = 0;
	float probabilidade = 0.0f;
	vector<pokemon> timePokemon;

	void decodificaCromossomo();

public:
	cromossomo(vector<int>);
	cromossomo(string);
	~cromossomo();

	string& getFenotipo();
	int getFitness();
	float getProbabilidade();
	vector<pokemon>& getTimePokemon();

	void setFenotipo(string);
	void setFitness(int);
	void incrementaFitness(int);
	void setProbabilidade(float);

	string DecToBin(int);
	string padBinario(string,int);
	string toString();
	

};

