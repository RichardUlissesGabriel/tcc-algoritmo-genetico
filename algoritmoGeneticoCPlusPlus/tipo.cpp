#include "tipo.h"

//Construtor
tipo::tipo(int _id, string _nome, map<int, float> _danos){
	this->idTipo = _id;
	this->nome = _nome;
	this->danoRecebidoDosOutrosTipo = _danos;
}

tipo::~tipo(){}

//Getters
int tipo::getIdTipo() { return this->idTipo; }
string tipo::getNome() { return this->nome; }
map<int, float>& tipo::getDanoRecebidoDosOutrosTipo() { return this->danoRecebidoDosOutrosTipo; }
//Setters
void tipo::setIdTipo(int _id) { this->idTipo = _id; }
void tipo::setNome(string _nome) { this->nome = _nome; }
void tipo::setDanoRecebidoDosOutrosTipo(map<int, float> _danos) { this->danoRecebidoDosOutrosTipo = _danos; }
