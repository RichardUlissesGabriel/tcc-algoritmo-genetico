#pragma once
#include <map>

using namespace std;

class resultadoExecucao{
private:
	map<string, double> conjuntoResultados;
	map<string, string> conjuntoResultadosDesempenho;
public:
	resultadoExecucao();
	~resultadoExecucao();

	map<string, double>& getResultados();
	double getUmRes(string);
	string getRes(string);
	void addResultado(string, double);
	void addResultado(string, string);

};

