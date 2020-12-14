#include "fileManager.h"
#include <iostream>

//singleton
fileManager& fileManager::getInstance() {
	static fileManager instance; //Iniciando somente no primeiro acesso
								 
	return instance;
}

string fileManager::getFileNomeWrite() {
	return this->fileNameWrite;
}

string fileManager::getFileNomeRead() {
	return this->fileNameRead;
}

//-------Setters para o nome dos arquivos
void fileManager::setFileNomeWrite(string _name) {
	this->fileNameWrite = _name;
}

void fileManager::setFileNomeRead(string _name) {
	this->fileNameRead = _name;
}

//--------Funcoes para abertura e fechamento dos arquivos
bool fileManager::openFileWrite() {
	fileWrite.open(fileNameWrite, ios::app | ios::out);

	if (fileWrite.is_open())
		return true;
	return false;
}

bool fileManager::openFileRead() {
	fileRead.open(fileNameRead, ios::app | ios::out);

	if (fileRead.is_open())
		return true;
	return false;
}

bool fileManager::closeFileWrite() {
	fileWrite.close();

	if (!fileWrite.is_open())
		return true;
	return false;
}

bool fileManager::closeFileRead() {
	fileRead.close();

	if (!fileRead.is_open())
		return true;
	return false;
}

//funcao para escrever nos arquivos de logs
void fileManager::writeInFile(string conteudo, string nameFile, bool close) {
	//Recebo o nome do arquivo que eu quero abrir
	setFileNomeWrite(nameFile);

	//Abro o arquivo
	if (!fileWrite.is_open()) {
		openFileWrite();
	}

	//Escrevo o conteuno no arquivo dele
	fileWrite << conteudo;

	//fecho o arquivo
	if (close)
		closeFileWrite();
}

//funcao para ler dos arquivos que guardam o json do banco
string fileManager::readFromFile(string nameFile) {

	//variavel que guarda o resultado de getline()
	string line;
	//Variavel para concatenar os resultados do arquivo
	stringstream ss;

	//defino o nome do arquivo de leitura
	setFileNomeRead(nameFile);

	//abro o arquivo
	if (!fileRead.is_open()){
		openFileRead();
	}

	//passo por todas as linhas e salvo dentro da stringstream
	while (getline(fileRead, line)){
		ss << line;
	}

	//fecho o arquivo
	closeFileRead();

	//retorno o valor do stringstream convertido para string
	return ss.str();
}