#pragma once
#include "tipo.h"

using namespace std;

class golpe{
private:

	int idMove;
	string nome;
	int prioridade;
	int pp;
	int power;
	float accuracy;
	string descricao;
	int idTipo;
	string efeito = "";
	float chanceEfeito = 0.0;
	bool zMove;
	string categoriaMove;

public:
	golpe(int,string,int,int,int,float,string,int,string,float,bool,string);
	~golpe();
	
	int getIdMove();
	string getNome();
	int getPrioridade();
	int getPp();
	int getPower();
	float getAccuracy();
	string getDescricao();
	int getIdTipo();
	string getEfeito();
	float getChanceEfeito();
	bool getZMove();
	string getCategoriaMove();

	void setIdMove(int);
	void setNome(string);
	void setPrioridade(int);
	void setPp(int);
	void setPower(int);
	void setAccuracy(float);
	void setDescricao(string);
	void setIdTipo(int);
	void setEfeito(string);
	void setChanceEfeito(float);
	void setZMove(bool);
	void setCategoriaMove(string);
	 


};

