#pragma once
#include <time.h>
#include <string>
#include <sstream>
#include <math.h>

using namespace std;

class timer{
private:
	clock_t inicio; //= clock();
	//clock_t fim;
	string nomeSetor;
public:
	timer(string);
	~timer();
	void iniciarTimer();
	string pararTimer();
	double getTime();

};

