#pragma once
#include "FileManager.h"
#include "jsonParser.h"
#include "pokemon.h"
#include <unordered_set>


using json = nlohmann::json;

class dataManager{
private:
	vector<pokemon> listaPokemons;
	//vector<golpe> listaGolpes;
	vector<tipo> listaTipo;
	dataManager();
public:
	//singleton
	static dataManager& getInstance();
	//vector<golpe>& getListaGolpes();
	vector<tipo>& getListaTipos();
	vector<pokemon>& getListaPokemons();
	pokemon& getPokemon(int);
	tipo& getTipo(int);
	//golpe& getGolpe(int);
	

	~dataManager();
};