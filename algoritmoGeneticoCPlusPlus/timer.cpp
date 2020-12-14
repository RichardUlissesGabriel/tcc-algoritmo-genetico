#include "timer.h"

timer::timer(string _nomeSetor) {
	this->nomeSetor = _nomeSetor;
} 
timer::~timer() {}

void timer::iniciarTimer() {
	this->inicio = clock();
}
string timer::pararTimer() {
	
	stringstream retorno;

	retorno << "O setor ";
	retorno << this->nomeSetor;
	retorno << " levou ";
	retorno << (double)(clock() - inicio) / CLOCKS_PER_SEC;
	retorno << "s para executar";

	return retorno.str();
}

double timer::getTime() {

	stringstream retorno;

	return (double)(clock() - inicio) / CLOCKS_PER_SEC;

	//return retorno.str();
}
