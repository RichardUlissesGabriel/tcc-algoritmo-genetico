#include "resultadoExecucao.h"

resultadoExecucao::resultadoExecucao(){}
resultadoExecucao::~resultadoExecucao(){}

map<string, double>& resultadoExecucao::getResultados() { return this->conjuntoResultados; }
double resultadoExecucao::getUmRes(string _chave) { return this->conjuntoResultados[_chave]; }
string resultadoExecucao::getRes(string _chave) { return this->conjuntoResultadosDesempenho[_chave]; }

void resultadoExecucao::addResultado(string _nomeRes, double _tempo) {
	this->conjuntoResultados[_nomeRes] = _tempo;
}

void resultadoExecucao::addResultado(string _nomeRes, string _res) {
	this->conjuntoResultadosDesempenho[_nomeRes] = _res;
}