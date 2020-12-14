#pragma once
#include <map>

using namespace std;
class tipo{
private:
	int idTipo = 0;
	string nome;
	map<int, float> danoRecebidoDosOutrosTipo;

public:
	tipo(int,string, map<int, float>);
	~tipo();

	int getIdTipo();
	string getNome();
	map<int, float>& getDanoRecebidoDosOutrosTipo();

	void setIdTipo(int);
	void setNome(string);
	void setDanoRecebidoDosOutrosTipo(map<int, float>);

};

