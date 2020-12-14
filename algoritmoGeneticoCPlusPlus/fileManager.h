#pragma once
#include <fstream>
#include <string>
#include <sstream>

using namespace std;

class fileManager {
private:
	ofstream fileWrite;
	ifstream fileRead;
	string fileNameWrite;
	string fileNameRead;
	fileManager() {};

	void setFileNomeWrite(string);
	void setFileNomeRead(string);
	bool openFileWrite();
	bool openFileRead();
	
	bool closeFileRead();

public:
	//singleton
	static fileManager& getInstance();
	string getFileNomeWrite();
	string getFileNomeRead();
	void writeInFile(string, string, bool);
	string readFromFile(string);
	bool closeFileWrite();
};