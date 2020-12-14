#include "algoritmoGenetico.h"
#include <iostream>


//--Auxiliares--
int algoritmoGenetico::getNumberRandom(int ini, int fim) {
	if (fim < ini)
		fim = ini + 1;
	random_device rd; // conseguindo um numero randomico do hardware
	mt19937 eng(rd()); // semente geradora
	uniform_int_distribution<> distr(ini, fim); // define o range
	return distr(eng); // gera o numero randomico
}

//funcao para ordenacao
bool compara(cromossomo &c1, cromossomo &c2) {
	return c1.getFitness() > c2.getFitness();
}

//Me devolve um numero float aleatorio
float RandomFloat(float a, float b) {
	float random = ((float)rand()) / (float)RAND_MAX;
	float diff = b - a;
	float r = random * diff;
	return a + r;
}
//----------------------------------

//Dano que o primeiro pokemon causa no segundo
float algoritmoGenetico::calculaSomaDoDano(pokemon &p1, pokemon &p2) {

	float resultado = 0.0f;

	
	//vector<tipo> &listaTipos = dataManager::getInstance().getListaTipos();
	// dataManager::getInstance().getTipo(p2.getIdTipo1());

	//cout <<"Poke 1: " << p1.getNome() << " - " << listaTipos[p1.getIdTipo1() - 1].getNome() << " - " << (p1.getIdTipo2() == 0?"": listaTipos[p1.getIdTipo2() - 1].getNome()) << endl;
	//cout <<"Poke 2: "<< p2.getNome() << " - " << listaTipos[p2.getIdTipo1() - 1].getNome() << " - " << (p2.getIdTipo2() == 0 ? "" : listaTipos[p2.getIdTipo2() - 1].getNome()) << endl;;

	//cout << "Poke 1: " << p1.getNome() << " - " << listaTipos[p1.getIdTipo1() - 1].getNome() << " - " << (p1.getIdTipo2() == 0 ? "" : listaTipos[p1.getIdTipo2() - 1].getNome()) << endl;
	//cout << "Poke 2: " << p2.getNome() << " - " << listaTipos[p2.getIdTipo1() - 1].getNome() << " - " << (p2.getIdTipo2() == 0 ? "" : listaTipos[p2.getIdTipo2() - 1].getNome()) << endl;
	//float meuTipo1RecebidoDoTipo1 = listaTipos[p2.getIdTipo1() - 1].getDanoRecebidoDosOutrosTipo()[p1.getIdTipo1()];
	//float meuTipo1RecebidoDoTipo2 = (p2.getIdTipo2() == 0 ? 1.0f : listaTipos[p2.getIdTipo2() - 1].getDanoRecebidoDosOutrosTipo()[p1.getIdTipo1()]);

	float meuTipo1RecebidoDoTipo1 = tipos[p2.getIdTipo1()-1].getDanoRecebidoDosOutrosTipo()[p1.getIdTipo1()];
	float meuTipo1RecebidoDoTipo2 = (p2.getIdTipo2() == 0 ? 1.0f : tipos[p2.getIdTipo2()-1].getDanoRecebidoDosOutrosTipo()[p1.getIdTipo1()]);

	resultado = meuTipo1RecebidoDoTipo1 * meuTipo1RecebidoDoTipo2;

	//cout << meuTipo1RecebidoDoTipo1 << " - " << meuTipo1RecebidoDoTipo2 << " - " << resultado << endl;
	//se o pokemon atacante tem o segundo tipo
	if (p1.getIdTipo2() != 0) {

		//float meuTipo2RecebidoDoTipo1 = listaTipos[p2.getIdTipo1() - 1].getDanoRecebidoDosOutrosTipo()[p1.getIdTipo2()];
		//float meuTipo2RecebidoDoTipo2 = (p2.getIdTipo2() == 0 ? 1.0f : listaTipos[p2.getIdTipo2() - 1].getDanoRecebidoDosOutrosTipo()[p1.getIdTipo2()]);

		float meuTipo2RecebidoDoTipo1 = tipos[p2.getIdTipo1()-1].getDanoRecebidoDosOutrosTipo()[p1.getIdTipo2()];
		float meuTipo2RecebidoDoTipo2 = (p2.getIdTipo2() == 0 ? 1.0f : tipos[p2.getIdTipo2()-1].getDanoRecebidoDosOutrosTipo()[p1.getIdTipo2()]);

		resultado += meuTipo2RecebidoDoTipo1 * meuTipo2RecebidoDoTipo2;
		//cout << meuTipo2RecebidoDoTipo1 << " - " << meuTipo2RecebidoDoTipo2 << " - " << resultado << endl;
	}

	return resultado;
}

algoritmoGenetico::algoritmoGenetico(map<string,int> params,vector<pokemon> _timeInimigo){

	//setandos os parametros na inicializacao
	this->qtdPopulacaoInicial = params["qtdPopulacaoInicial"];
	this->modoCrossover = params["modoCrossover"];
	this->tipoSelecao = params["tipoSelecao"];
	this->tipoProxGeracao = params["tipoProxGeracao"];
	this->qtdEpocas = params["qtdEpocas"];
	this->congelamento = params["congelamento"];
	this->tamTorneio = params["tamTorneio"];
	this->taxaMutacao = static_cast<float>(params["taxaMutacao"]);
	this->taxaElitismo = params["taxaElitismo"] / 100.0f;
	this->taxaFilhosATrocar = params["taxaFilhosATrocar"] / 100.0f;
	this->formaAvaliacao = params["formaAvaliacao"];
	this->timeInimigo = _timeInimigo;

	//cout << this->timeInimigo[0].getNome() << endl;

}

algoritmoGenetico::~algoritmoGenetico() {}


//--geracao população inicial--
void algoritmoGenetico::geracaoPopulacaoInicial() {

	int tamanho = dataManager::getInstance().getListaPokemons().size();

	for (int i = 0; i < this->qtdPopulacaoInicial; ++i) {
		vector<int> idsPokemons;
		//Conseguindo o id de 6 pokemons aleatorios
		//for (int j = 0; j < 6; ++j) {
		while (idsPokemons.size() != 6) {
			
			//verificando se ja existe o pokemon
			bool existe = true;

			//parte do pre suposto que o pokemon nao existe
			while (existe) {

				existe = false;

				int idNovoPoke = getNumberRandom(1, tamanho - 1);
				for (unsigned j = 0; j < idsPokemons.size(); ++j) {
					if (idsPokemons[j] == idNovoPoke){
						existe = true;
						break;
					}
				}

				if (existe == false)
					idsPokemons.push_back(idNovoPoke);
			}



			//cout << idNovoPoke << endl;
		}
		//inicializando o meu cromossomo e 
		//adicionando a minha populacao
		this->populacao.push_back(cromossomo(idsPokemons));
		//cout << populacao[i].getFenotipo() << endl;
	}
}
//--------------------------------

//--Avaliacao--
void algoritmoGenetico::avaliacao(int populacao) {


	switch (this->formaAvaliacao){
	/*case COMBATE:

		break;
		*/
	case TIPOS:
		avaliacaoTipos(populacao);
		break;

	case ATRIBUTOS:
		avaliacaoAtributos(populacao);
		break;

	case ATRIBUTOS_TIPOS:
		avaliacaoTipos(populacao);
		avaliacaoAtributos(populacao);
		break;

	case CALIBRACAO:
		avaliacaoCalibracao(populacao);
		break;

	}
}

void algoritmoGenetico::avaliacaoTipos(int popu) {

	//Definindo qual populacao estou avaliando
	vector<cromossomo> &popuAvaliada = (popu == FILHOS ? this->filhos : this->populacao);

	for (unsigned i = 0; i < popuAvaliada.size(); ++i) {

		if (popuAvaliada[i].getFitness() != -999) {
			vector<pokemon> &meuTime = popuAvaliada[i].getTimePokemon();
			int fitness = 0;
			for (unsigned j = 0; j < meuTime.size(); ++j) {
				for (unsigned k = 0; k < this->timeInimigo.size(); ++k) {


					//cout << "poke atacante : " << meuTime[j].getNome() << " - Poke defensor: " << this->timeInimigo[k].getNome() << endl;
					//Dano causado pelo meu pokemon
					fitness += static_cast<int>(calculaSomaDoDano(meuTime[j], this->timeInimigo[k]));

					//cout << "fitness: " << popuAvaliada[i].getFitness() << endl;

					//cout << "poke atacante : " << this->timeInimigo[k].getNome() << " - Poke defensor: " << meuTime[j].getNome() << endl;
					
					//dano sofrido pelo meu pokemon, subtraio da minha aptidao
					fitness -= static_cast<int>(calculaSomaDoDano(this->timeInimigo[k], meuTime[j]));
					
					//cout << "fitness: " << popuAvaliada[i].getFitness() << endl;
				}
			}

			popuAvaliada[i].setFitness(fitness);

			if (this->formaAvaliacao != ATRIBUTOS_TIPOS) {
				//Se eu tiver um fitness negativo jogo ele para zero
				if (popuAvaliada[i].getFitness() < 0)
					popuAvaliada[i].setFitness(0);
			}
		}

		//cout << t.pararTimer() << endl;
		//cout << "fitness: " << popuAvaliada[i].getFitness() << endl;
	}
}


void algoritmoGenetico::avaliacaoAtributos(int popu) {

	vector<cromossomo> &popuAvaliada = (popu == FILHOS ? this->filhos : this->populacao);

	for (unsigned i = 0; i < popuAvaliada.size(); ++i) {
		//cout << popuAvaliada[i].getFitness() << endl;
		if (popuAvaliada[i].getFitness() >= 0) {
			vector<pokemon> &meuTime = popuAvaliada[i].getTimePokemon();
			int fitness = 0;
			for (unsigned i = 0; i < meuTime.size(); ++i) {
				for (unsigned j = 0; j < timeInimigo.size(); ++j) {

					fitness += (meuTime[i].getHp() - timeInimigo[j].getHp() > 0 ? 1 : 0);
					fitness += (meuTime[i].getAttack() - timeInimigo[j].getAttack() > 0 ? 1 : 0);
					fitness += (meuTime[i].getDefense() - timeInimigo[j].getDefense() > 0 ? 1 : 0);
					fitness += (meuTime[i].getSAttack() - timeInimigo[j].getSAttack() > 0 ? 1 : 0);
					fitness += (meuTime[i].getSDefense() - timeInimigo[j].getSDefense() > 0 ? 1 : 0);
					fitness += (meuTime[i].getSpeed() - timeInimigo[j].getSpeed() > 0 ? 1 : 0);
					/*
					cout << meuTime[i].getNome() << " VS " << timeInimigo[j].getNome() << endl;
					cout << meuTime[i].getHp() << " VS " << timeInimigo[j].getHp() << endl;
					cout << meuTime[i].getAttack() << " VS " << timeInimigo[j].getAttack() << endl;
					cout << meuTime[i].getDefense() << " VS " << timeInimigo[j].getDefense() << endl;
					cout << meuTime[i].getSAttack() << " VS " << timeInimigo[j].getSAttack() << endl;
					cout << meuTime[i].getSDefense() << " VS " << timeInimigo[j].getSDefense() << endl;
					cout << meuTime[i].getSpeed() << " VS " << timeInimigo[j].getSpeed() << endl;
					*/
				}
			}

			//Se a minha avaliacao leva em consideracao atributos e tipos o fitness é a soma
			if (this->formaAvaliacao == ATRIBUTOS_TIPOS) {
				//cout << "Ava Tipo" << popuAvaliada[i].getFitness() << endl;
				//cout << "Ava Atributos" << fitness << endl;
				popuAvaliada[i].setFitness(fitness*(popuAvaliada[i].getFitness() == 0? 1: popuAvaliada[i].getFitness()));
				
			}else {
				popuAvaliada[i].setFitness(fitness);
			}
		}
		else {
			//Se eu tiver um fitness negativo jogo ele para zero
			if (popuAvaliada[i].getFitness() < 0)
				popuAvaliada[i].setFitness(0);
		}
	}
}

void algoritmoGenetico::avaliacaoCalibracao(int popu) {
	
	vector<cromossomo> &popuAvaliada = (popu == FILHOS ? this->filhos : this->populacao);
	//A funcao de calibracao coloca o fitness como o atributo de ataque do primeiro pokemon do time
	for (unsigned i = 0; i < popuAvaliada.size(); ++i) {
		if (popuAvaliada[i].getTimePokemon().size() == 6)
			popuAvaliada[i].setFitness(popuAvaliada[i].getTimePokemon()[0].getAttack());
	}
}

//--------------------------------
//--Criacao dos Filhos--
void algoritmoGenetico::criacaoFilhos() {

	//sort(begin(pais), end(pais), compara);

	

	//realizo a recombinacao 
	for (unsigned i = 0; i < pais.size(); i += 2) {
		crossover(pais[i],pais[i+1]);
	}
	//cout << "fim crossover" << endl;
	

	//realizo a mutacao
	for (unsigned i = 0; i < filhos.size(); i++) {
		mutacao(filhos[i]);
	}

	//sort(begin(filhos), end(filhos), compara);

}
//--Recombinacao--
void algoritmoGenetico::crossover(cromossomo pai1, cromossomo pai2) {

	string fenoPai1 = pai1.getFenotipo();
	string fenoPai2 = pai2.getFenotipo();
	string fenotipoFilho1;
	string fenotipoFilho2;

	if (this->modoCrossover == CRUZAMENTO_UM_PONTO) {

		//Defino o corte
		int corte = getNumberRandom(1, fenoPai1.size() - 1);

		//troco os materiais geneticos de acordo com o corte
		fenotipoFilho1 = fenoPai1.substr(0, corte) + fenoPai2.substr(corte, fenoPai2.size() - corte);
		fenotipoFilho2 = fenoPai2.substr(0, corte) + fenoPai1.substr(corte, fenoPai1.size() - corte);

		//Print para validacao
		/*cout << "Corte " << corte << endl;
		cout << "Pai1 " << pai1.getFenotipo() << endl;
		cout << "Pai2 " << pai2.getFenotipo() << endl;
		cout << "Fil1 " << fenotipoFilho1 << endl;
		cout << "Fil2 " << fenotipoFilho2 << endl << endl;*/

		//return tuple<cromossomo, cromossomo>(cromossomo(fenotipoFilho1), cromossomo(fenotipoFilho2));

	}else if (this->modoCrossover == CRUZAMENTO_MULTI_PONTO) {
		
		//Defino o corte inicial do comeco ate um numero aleatorio
		int corteInicial = getNumberRandom(1, fenoPai1.size() - 3);
		//Defino o corte final apartir do corte inicial
		int corteFinal = getNumberRandom(corteInicial + 1, fenoPai1.size() - 1);

		//Troca os materiais  entre pai1 e pai2 de acordo com os cortes
		fenotipoFilho1 = fenoPai1.substr(0, corteInicial); 
		fenotipoFilho1 += fenoPai2.substr(corteInicial, corteFinal - corteInicial);
		fenotipoFilho1 += fenoPai1.substr(corteFinal, fenoPai1.size() - corteFinal);

		fenotipoFilho2 = fenoPai2.substr(0, corteInicial);
		fenotipoFilho2 += fenoPai1.substr(corteInicial, corteFinal - corteInicial);
		fenotipoFilho2 += fenoPai2.substr(corteFinal, fenoPai2.size() - corteFinal);
		
		//Print para validacao
		/*cout << "CorteIni " << corteInicial << endl;
		cout << "CorteFim " << corteFinal << endl;
		cout << "Pai1 " << pai1.getFenotipo() << endl;
		cout << "Pai2 " << pai2.getFenotipo() << endl;
		cout << "Fil1 " << fenotipoFilho1 << endl;
		cout << "Fil2 " << fenotipoFilho2 << endl << endl;*/

		//return tuple<cromossomo, cromossomo>(cromossomo(fenotipoFilho1), cromossomo(fenotipoFilho2));

	}else if (this->modoCrossover == CRUZAMENTO_UNIFORME) {

		string mascara = "000110000110010100000110110010011001011000110011011000001111";

		auto itPai1 = fenoPai1.begin();
		auto itPai2 = fenoPai2.begin();
		auto itMascara = mascara.begin();

		//Percorro a mascara e quando o bit for 0 o filho 1 recebe o
		//material genetico do pai 1
		while (itMascara != mascara.end()) {

			if (*itMascara == '0') {
				fenotipoFilho1 += *itPai1;
				fenotipoFilho2 += *itPai2;
			}else {
				fenotipoFilho1 += *itPai2;
				fenotipoFilho2 += *itPai1;
			}

			++itMascara;
			++itPai2;
			++itPai1;
		}

		//Print para validacao
		/*cout << "Mascara " << mascara<< endl;
		cout << "Pai1 " << pai1.getFenotipo() << endl;
		cout << "Pai2 " << pai2.getFenotipo() << endl;
		cout << "Fil1 " << fenotipoFilho1 << endl;
		cout << "Fil2 " << fenotipoFilho2 << endl << endl;
		*/
		//return tuple<cromossomo, cromossomo>(cromossomo(fenotipoFilho1), cromossomo(fenotipoFilho2));
	}else if (this->modoCrossover == CALIBRACAO) {
		fenotipoFilho1 = fenoPai1;
		fenotipoFilho2 = fenoPai2;
	}
	
	//Adiciono os filhos ao meu vetro que cuida deles
	filhos.push_back(cromossomo(fenotipoFilho1));
	filhos.push_back(cromossomo(fenotipoFilho2));
	
	

}

void algoritmoGenetico::mutacao(cromossomo &c) {
	int mutacao = getNumberRandom(1, 100);

	//cout <<"mutacao : "<< mutacao << " - taxa: " << this->taxaMutacao<<  endl;
	
	if (mutacao <= this->taxaMutacao) {
		//a quantidade de bit alterado e o dobro da chance de mutacao, se a chance for 1 eu altero para 2
		//e se a chance for muito baixa 0.2 o dobro seria 0.4 mas eu jogo para 1
		for (unsigned i = 0; i < (2 * this->taxaMutacao < 1 ? 1 : 2 * this->taxaMutacao); ++i) {
			string feno = c.getFenotipo();
			unsigned index = getNumberRandom(0, feno.size() - 1);
			//se o meu bit no index aleatorio for zero mudo para um e vice-versa
			//cout << feno << " - " << index << endl;
			feno.at(index) = (feno.at(index) == '0' ? '1' : '0');
			//cout << feno << " - " << index << endl;
			c.setFenotipo(feno);
		}
	}
}

//--------------------------------

//--------------------------------
void algoritmoGenetico::selecaoPais() {

	if (tipoSelecao == ROLETA) {

		// cout << populacao.size() << endl;

		//ordeno minha populacao de acordo com a maior aptidao
		sort(begin(populacao), end(populacao), compara);

		//faco o somatorio dos fitness
		int somatorioAptidao = 0;

		for (unsigned i = 0; i < populacao.size(); ++i) {
			if (populacao[i].getFitness() != -999)
				somatorioAptidao += populacao[i].getFitness();
		}

		float somatorioAcumulado = 0;

		//somatorioAptidao equivale a 100% das aptidoes
		for (unsigned i = 0; i < populacao.size(); ++i) {

			if (populacao[i].getFitness() != -999) {
				float proba = ((float)(populacao[i].getFitness() * 100) / somatorioAptidao);

				somatorioAcumulado += proba;

				populacao[i].setProbabilidade(somatorioAcumulado);
			}
			else {
				populacao[i].setProbabilidade(-1);
			}
		}

		//cout << populacao.size() << endl;

		//for (unsigned i = 0; i < populacao.size(); ++i) {
		while (pais.size() != populacao.size()) {
			float roleta = RandomFloat(0.0f, 100.0f);//seleciono um numero da roleta
			//cout << "Roleta: " << roleta << endl;
			float inicio = 0;
			for (unsigned j = 0; j < populacao.size(); ++j) {
				if (populacao[j].getProbabilidade() > roleta && roleta >= inicio) {
					pais.push_back(populacao[j]);
					//cout << populacao[j].getProbabilidade() << endl;
					break;
				}
				inicio = populacao[j].getProbabilidade();
			}
		}

		//cout << "tamanho pais: " <<pais.size() << endl;

		/*
		for (int i = 0; i < populacao.size(); ++i) {
		    cout<<populacao[i].getProbabilidade()<<endl;
		}
		cout<<"=================="<<endl;
		cout << "criacao pais"<<pais.size()<<endl;
		*/

	}else if (this->tipoSelecao == TORNEIO) {

		//cout << "Tamanho do torneio: " <<this->tamTorneio << endl;

		for (unsigned i = 0; i < populacao.size(); ++i) {

			vector<cromossomo> torneio;

			for (int j = 0; j < this->tamTorneio; ++j) {//escolho os integrantes do torneio
				int escolha = getNumberRandom(0,qtdPopulacaoInicial-1);
				torneio.push_back(populacao[escolha]);
			}

			//ordeno
			sort(begin(torneio), end(torneio), compara);
			//escolho o mais apto
			pais.push_back(torneio[0]);
		}
	}else if (this->tipoSelecao == CALIBRACAO) {
		this->pais = this->populacao;
	}
}
//--------------------------------
void algoritmoGenetico::selecaoProxGeracao() {

	populacao.clear();

	if (this->tipoProxGeracao == SELECIONAR_FILHOS) {
		//ordeno os filhos caso tenha um invalido na primeira posicao
		sort(begin(filhos), end(filhos), compara);

		populacao = filhos;

	}else if (this->tipoProxGeracao == ELITISMO) {

		//somo os pais e filhos
		pais.insert(pais.end(), filhos.begin(), filhos.end());

		//ordeno pais e filhos de acordo com a apitdao
		sort(begin(pais), end(pais), compara);

		//consigo a quantidade de membros por elitismo
		int elitismo = static_cast<int>(qtdPopulacaoInicial * taxaElitismo);

		//cout<<elitismo<<endl;
		//cout<<pais.size()<<endl;

		for (int i = 0; i < elitismo; ++i) {
			populacao.push_back(pais[i]);
		}

		//removo os filhos invalidos
		while (pais[pais.size() - 1].getFitness() == -999) {
			pais.pop_back();
		}

		//preciso remover os individuos
		reverse(pais.begin(), pais.end());

		//Removo esses membros do pai
		for (int i = 0; i < elitismo; ++i) {
			pais.pop_back();
		}

		//o restante eu pego aleatoriamente
		int resto = static_cast<int>(qtdPopulacaoInicial - populacao.size());

		for (int i = 0; i < resto; ++i) {
			int aleatorio = getNumberRandom(0, pais.size()-1);
			populacao.push_back(pais[aleatorio]);
		}

	}else if (this->tipoProxGeracao == SUBSTITUIR_PIORES_FILHOS) {

		//ordeno pais e filhos de acordo com a apitdao
		sort(begin(pais), end(pais), compara);
		sort(begin(filhos), end(filhos), compara);

		int quantidadePaisSelecionados = static_cast<int>(filhos.size() * taxaFilhosATrocar);
		int qtdFilhosInvalidos = 0;

		//removo os filhos invalidos
		while (filhos[filhos.size() - 1].getFitness() == -999) {
			filhos.pop_back();
			qtdFilhosInvalidos++;
		}

		//tenho mais filhos invalidos do que a taxa de troca, troco todos
		if (quantidadePaisSelecionados < qtdFilhosInvalidos) {

			populacao = filhos;
			int i = 0;

			while (static_cast<int>(populacao.size()) < qtdPopulacaoInicial){
				populacao.push_back(pais[i]);
				++i;
			}

		}else {

			for (int i = 0; i < qtdPopulacaoInicial - quantidadePaisSelecionados; ++i) {
				populacao.push_back(filhos[i]);
			}

			for (int i = 0; i < quantidadePaisSelecionados; ++i) {
				populacao.push_back(pais[i]);
			}

		}

	}else if (this->tipoProxGeracao == CALIBRACAO) {
		this->geracaoPopulacaoInicial();

		//sort(begin(populacao), end(populacao), compara);
	}

}

string algoritmoGenetico::comecar() {

	//inicio a geração
	geracaoPopulacaoInicial();

	int stop = 0;
	int incremento = 0;

	string lastBest = populacao[0].getFenotipo();

	while (incremento++ < this->qtdEpocas && stop <= congelamento) {
		
		//inicializo os pais e filhos em cada iteracao
		pais = vector<cromossomo>();
		filhos = vector<cromossomo>();

		//Faco  a avaliacao da populacao
		avaliacao(POPULACAO);

		//faco a selecao dos pais
		selecaoPais();

		//Crio os filhos
		criacaoFilhos();

		//avalicao os filhos
		avaliacao(FILHOS);

		//seleciono a proxima geracao
		selecaoProxGeracao();

		//Verificando o congelamento
		if (lastBest == populacao[0].getFenotipo()) {
			stop++;
		}else {
			lastBest = populacao[0].getFenotipo();
			stop = 0;
		}
	}

	return  populacao[0].toString();
}



vector<resultadoExecucao> algoritmoGenetico::comecarTeste() {

	vector<resultadoExecucao> res;

	//inicio a geração
	geracaoPopulacaoInicial();

	int stop = 0;
	int incremento = 0;

	string lastBest = populacao[0].getFenotipo();

	while (incremento++ < this->qtdEpocas && stop <= congelamento) {

		resultadoExecucao execucaoDaVez;

		timer genTimer("Geracao");
		genTimer.iniciarTimer();

		//inicializo os pais e filhos em cada iteracao
		pais = vector<cromossomo>();
		filhos = vector<cromossomo>();

		timer avaPais("AvaliacaoPais");
		avaPais.iniciarTimer();

		//Faco  a avaliacao da populacao
		avaliacao(POPULACAO);

		execucaoDaVez.addResultado("avaliacaoPais", avaPais.getTime());

		timer selPais("SelecaoPais");
		selPais.iniciarTimer();

		//faco a selecao dos pais
		selecaoPais();

		execucaoDaVez.addResultado("selecaoPais", selPais.getTime());

		//fileManager::getInstance().writeInFile("selPais;" + selPais.getTime() + "\n", "teste.csv", false);

		timer criFilhos("CriacaoFilhos");
		criFilhos.iniciarTimer();

		//Crio os filhos
		criacaoFilhos();

		execucaoDaVez.addResultado("criacaoFilhos", criFilhos.getTime());

		execucaoDaVez.addResultado("criacaoFilhosInvalidos", static_cast<double>(getQtdInvalidos()));

		timer avaFilhos("AvaliacaoFilhos");
		avaFilhos.iniciarTimer();

		//avalicao os filhos
		avaliacao(FILHOS);

		execucaoDaVez.addResultado("avaliacaoFilhos", avaFilhos.getTime());

		timer selProx("ProxGeracao");
		selProx.iniciarTimer();

		//seleciono a proxima geracao
		selecaoProxGeracao();

		execucaoDaVez.addResultado("proxGeracao", selProx.getTime());
		
		execucaoDaVez.addResultado("geracao", genTimer.getTime());

		//Verificando o congelamento
		if (lastBest == populacao[0].getFenotipo()) {
			stop++;
		}
		else {
			lastBest = populacao[0].getFenotipo();
			stop = 0;
		}

		res.push_back(execucaoDaVez);

	}

	//execucaoDaVez.addResultado("geracao", genTimer.getTime());

	return  res;
}

resultadoExecucao algoritmoGenetico::comecarTesteDesempenho() {

	resultadoExecucao execucao;

	timer exeTimer("Execucao");
	exeTimer.iniciarTimer();

	//inicio a geração
	geracaoPopulacaoInicial();

	int stop = 0;
	int incremento = 0;

	string lastBest = populacao[0].getFenotipo();

	while (incremento++ < this->qtdEpocas && stop <= congelamento) {

		//inicializo os pais e filhos em cada iteracao
		pais = vector<cromossomo>();
		filhos = vector<cromossomo>();

		//Faco  a avaliacao da populacao
		avaliacao(POPULACAO);

		//faco a selecao dos pais
		selecaoPais();

		//Crio os filhos
		criacaoFilhos();

		//avalicao os filhos
		avaliacao(FILHOS);

		//seleciono a proxima geracao
		selecaoProxGeracao();

		//Verificando o congelamento
		if (lastBest == populacao[0].getFenotipo()) {
			stop++;
		}
		else {
			lastBest = populacao[0].getFenotipo();
			stop = 0;
		}
	}

	stringstream ss;

	//time inimigo
	for (pokemon poke : timeInimigo) {
		ss << poke.getIdPokemon() << "-";
	}

	string idsInimigos = ss.str();
	idsInimigos.pop_back();

	//tempo
	ss.clear();
	ss.str(string());
	ss << exeTimer.getTime();
	string tempo = ss.str();


	//fitness
	ss.clear();
	ss.str(string());
	ss << populacao[0].getFitness();
	string fitness = ss.str();


	execucao.addResultado("execucao", tempo);
	execucao.addResultado("fitness", fitness);
	execucao.addResultado("timeEscolhido", populacao[0].toString());
	execucao.addResultado("timeInimigo", idsInimigos);

	//execucaoDaVez.addResultado("geracao", genTimer.getTime());

	return  execucao;
}


int algoritmoGenetico::getQtdInvalidos() {

	int retorno = 0;

	for (unsigned i = 0; i < this->filhos.size(); ++i) {
		if (this->filhos[i].getFitness() == -999)
			retorno++;
	}

	return retorno;
}