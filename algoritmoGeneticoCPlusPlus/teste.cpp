#include "teste.h"

teste::teste(){}

teste::~teste(){}

string teste::getNomeTeste() { return this->nomeTeste; }
string teste::getNomeFileSaida() { return this->nomeFileSaida; }
map<string, int>& teste::getConjuntoParams() { return this->conjuntoParams; }

void teste::setNomeTeste(string _nome) { this->nomeTeste = _nome; }
void teste::setNomeFileSaida(string _nome) { this->nomeFileSaida = _nome; }
void teste::setConjuntoParams(map<string, int> _params) { this->conjuntoParams = _params; }


//Conjunto de testes
conjuntoTestes::conjuntoTestes() {}
conjuntoTestes::~conjuntoTestes() {}

int conjuntoTestes::getId() { return this->id; }
string conjuntoTestes::getNomeConjuntoTeste() { return this->nomeConjuntoTeste; }
string conjuntoTestes::getNomeFileSaida() { return this->nomeFileSaida; }

vector<teste>& conjuntoTestes::getConjuntoTeste() { return conjuntoTeste; }

void conjuntoTestes::setId(int _id) { this->id = _id; }
void conjuntoTestes::setNomeConjuntoTeste(string _nome) { this->nomeConjuntoTeste = _nome; }
void conjuntoTestes::setconjuntoTeste(vector<teste> _testes) { this->conjuntoTeste = _testes; }
void conjuntoTestes::addTeste(teste _teste) { this->conjuntoTeste.push_back(_teste); }
void conjuntoTestes::setNomeFileSaida(string _nome) { this->nomeFileSaida = _nome; }