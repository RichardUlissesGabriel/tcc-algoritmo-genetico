#pragma once
#include <vector>
#include <stdio.h>
#include "tipo.h"
#include "golpe.h"


using namespace std;

class pokemon{
private:

	int idPokemon;
	string nome;
	int hp;
	int attack;
	int defense;
	int sAttack;
	int sDefense;
	int speed;
	int idTipo1;
	int idTipo2;
	//vector<int> listaIdsMove;

public:
	pokemon(int, string, int, int, int, int, int, int, int, int);// , vector<int>);
	~pokemon();
	
	int getIdPokemon();
	string getNome();
	int getHp();
	int getAttack();
	int getDefense();
	int getSAttack();
	int getSDefense();
	int getSpeed();
	int getIdTipo1();
	int getIdTipo2();
	//vector<int> getIdsListaMove();

	void setIdPokemon(int);
	void setNome(string);
	void setHp(int);
	void setAttack(int);
	void setDefense(int);
	void setSAttack(int);
	void setSDefense(int);
	void setSpeed(int);
	void setIdTipo1(int);
	void setIdTipo2(int);
	//void setListaMove(vector<int>);
	void calculaTodosStatus(int);
};

