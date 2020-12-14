#include "pokemon.h"

//Construtor
pokemon::pokemon(
				int _id, 
				string _nome, 
				int _hp, 
				int _attack, 
				int _defense, 
				int _sAttack, 
				int _sDefense, 
				int _speed, 
				int _t1, 
				int _t2)//, 
				//vector<int> _moves)
{
	this->idPokemon = _id;
	this->nome = _nome;
	this->hp = _hp; 
	this->attack = _attack; 
	this->defense = _defense;
	this->sAttack = _sAttack;
	this->sDefense = _sDefense;
	this->speed = _speed;
	this->idTipo1 = _t1;
	this->idTipo2 = _t2;
	//this->listaIdsMove = _moves;
	calculaTodosStatus(50);
}

pokemon::~pokemon(){}

//Getters
int pokemon::getIdPokemon() { return this->idPokemon; }
string pokemon::getNome() { return this->nome; }
int pokemon::getHp() { return this->hp; }
int pokemon::getAttack() { return this->attack; }
int pokemon::getDefense() { return this->defense; }
int pokemon::getSAttack() { return this->sAttack; }
int pokemon::getSDefense() { return this->sDefense; }
int pokemon::getSpeed() { return this->speed; }
int pokemon::getIdTipo1() { return this->idTipo1; }
int pokemon::getIdTipo2() { return this->idTipo2; }
//vector<int> pokemon::getIdsListaMove() { return this->listaIdsMove; }

//Setters
void pokemon::setIdPokemon(int _id) { this->idPokemon = _id; }
void pokemon::setNome(string _nome) { this->nome = _nome; }
void pokemon::setHp(int _hp) { this->hp = _hp; }
void pokemon::setAttack(int _attack) { this->attack = _attack; }
void pokemon::setDefense(int _defense) { this->defense = _defense; }
void pokemon::setSAttack(int _sAttack) { this->sAttack = _sAttack; }
void pokemon::setSDefense(int _sDefense) { this->sDefense = _sDefense; }
void pokemon::setSpeed(int _speed) { this->speed = _speed; }
void pokemon::setIdTipo1(int _t1) { this->idTipo1 = _t1; }
void pokemon::setIdTipo2(int _t2) { this->idTipo2 = _t2; }
//void pokemon::setListaMove(vector<int> _moves) { this->listaIdsMove = _moves; }

//calculando os status de batalha
void pokemon::calculaTodosStatus(int lv) {

	this->hp = (this->hp * 2 + 31 + (252 / 4)) * lv / 100 + 10 + lv;

	//outros stats lv 50
	//Stats Formula = ((Base * 2 + IV + (EV/4)) * Level / 100 + 5) * Nmod
	//attack
	this->attack = ((this->attack * 2 + 31 + (252 / 4)) * lv / 100 + 5);

	//defense
	this->defense = ((this->defense * 2 + 31 + (252 / 4)) * lv / 100 + 5);

	//sAttack
	this->sAttack = ((this->sAttack * 2 + 31 + (252 / 4)) * lv / 100 + 5);

	//sdefense
	this->sDefense = ((this->sDefense * 2 + 31 + (252 / 4)) * lv / 100 + 5);

	//speed
	this->speed = ((this->speed * 2 + 31 + (252 / 4)) * lv / 100 + 5);
}