#include <iostream>
#include <vector>
#include <stdlib.h>  
using namespace std;

bool nonaz(char mander){
	if('Z' >= mander && mander >= 'A' || 'z' >= mander && mander >= 'a' )return false;
	return true;
}

bool bespam(string s){
	if(s.size() > 21) return true; 
	for (int i =0; i<s.size(); i++){
		if(nonaz(s[i]))return true;
	}
	return false;
}

int main(int argc, char* argv[]){
	int i=1;
	//cout << argv[1] << endl << argv[2] << endl << argv[3] << endl ;
	string freq, word;
	while(cin >> freq >> word){
		if (not bespam(word) && stoi(freq) < 9000) cout << freq << endl << i++ << endl;
	}   
}
