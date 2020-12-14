#include "golpe.h"


golpe::golpe(
			int _id, 
			string _nome, 
			int _prioridade, 
			int _pp, 
			int _power, 
			float _accuracy,
			string _descricao, 
			int _tipo, 
			string _efeito, 
			float _chanceEfeito, 
			bool _zMove,
			string _catMove)
{
	this->idMove = _id;
	this->nome = _nome;
	this->prioridade = _prioridade;
	this->pp = _pp;
	this->power = _power;
	this->accuracy = _accuracy;
	this->descricao = _descricao;
	this->idTipo = _tipo;
	this->efeito = _efeito;
	this->chanceEfeito = _chanceEfeito;
	this->zMove = _zMove;
	this->categoriaMove = _catMove;
}


golpe::~golpe(){}
//Getters
int golpe::getIdMove() { return this->idMove; }
string golpe::getNome() { return this->nome; }
int golpe::getPrioridade() { return this->prioridade; }
int golpe::getPp() { return this->pp; }
int golpe::getPower() { return this->power; }
float golpe::getAccuracy() { return this->accuracy; }
string golpe::getDescricao() { return this->descricao; }
int golpe::getIdTipo() { return this->idTipo; }
string golpe::getEfeito() { return this->efeito; }
float golpe::getChanceEfeito() { return this->chanceEfeito; }
bool golpe::getZMove() { return this->zMove; }
string golpe::getCategoriaMove() { return this->categoriaMove; }
//Setters
void golpe::setIdMove(int _id) { this->idMove = _id; }
void golpe::setNome(string _nome) { this->nome = _nome; }
void golpe::setPrioridade(int _prioridade) { this->prioridade = _prioridade; }
void golpe::setPp(int _pp) { this->pp = _pp; }
void golpe::setPower(int _power) { this->power = _power; }
void golpe::setAccuracy(float _accuracy) { this->accuracy = _accuracy; }
void golpe::setDescricao(string _descricao) { this->descricao = _descricao; }
void golpe::setIdTipo(int _tipo) { this->idTipo = _tipo; }
void golpe::setEfeito(string _efeito) { this->efeito = _efeito; }
void golpe::setChanceEfeito(float _chanceEfeito) { this->chanceEfeito = _chanceEfeito; }
void golpe::setZMove(bool _zMove) { this->zMove = _zMove; }
void golpe::setCategoriaMove(string _catMove) { this->categoriaMove = _catMove; }