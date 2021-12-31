#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model;
vector<int> modelStack;
uint indexOfNextLitToPropagate;
uint decisionLevel;

//added pure literal treatment
vector<int > posVars;
vector<int > negVars;

//propagate optimization
vector<int> conflicts;
vector<vector<vector<int>* > > negClauses;
vector<vector<vector<int>* > > posClauses;

void readClauses( ){
  // Skip comments
  char c = cin.get();
  while (c == 'c') {
    while (c != '\n') c = cin.get();
    c = cin.get();
  }
  // Read "cnf numVars numClauses"
  string aux;
  cin >> aux >> numVars >> numClauses;

  clauses.resize(numClauses);
  //pure literals
  posVars.resize(numVars+1,0);
  negVars.resize(numVars+1,0);
  //heuristics
  conflicts.resize(numVars+1,0);
  posClauses.resize(numVars+1);
  negClauses.resize(numVars+1);
  // Read clauses
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    while (cin >> lit and lit != 0) {
      int var = abs(lit);
      conflicts[var]++;

      if (lit > 0) {
        posVars[lit]++;
        posClauses[var].push_back(&clauses[i]);
      }
      else {
        negClauses[var].push_back(&clauses[i]);
        negVars[-lit]++;
      }
      clauses[i].push_back(lit);
    }
  }
}

int currentValueInModel(int lit){
  if (lit >= 0) return model[lit];
  else {
    if (model[-lit] == UNDEF) return UNDEF;
    else return 1 - model[-lit];
  }
}


inline void setLiteralToTrue(int lit){
  modelStack.push_back(lit);
  if (lit > 0) model[lit] = TRUE;
  else model[-lit] = FALSE;
}


bool propagate() {
  int lit2Propagate = modelStack[indexOfNextLitToPropagate];
  ++indexOfNextLitToPropagate;
  uint var2Propagate = abs(lit2Propagate);
  vector<vector<int>* >& clausesNegated = lit2Propagate > 0 ?
    negClauses[var2Propagate] : posClauses[var2Propagate];
  //propagate conflict detector
  for (uint i = 0; i < clausesNegated.size(); ++i) {
      vector<int>& clause = *clausesNegated[i];
      bool someLitTrue = false;
      uint numUndefs = 0;
      int lastLitUndef = 0;
      for (uint j = 0; not someLitTrue and j < clause.size(); ++j) {
          int val = currentValueInModel(clause[j]);
          if (val == TRUE) someLitTrue = true;
          else if (val == UNDEF){ ++numUndefs; lastLitUndef =  clause[j]; }
      }
      if (not someLitTrue and numUndefs == 0){
        conflicts[var2Propagate]++;
        return true;
      }
      else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);
  }
  return false;
}

bool propagateGivesConflict ( ) {
  while ( indexOfNextLitToPropagate < modelStack.size() ) {
    if(propagate()) return true;
  }
  return false;
}



void backtrack(){
  uint i = modelStack.size() -1;
  int lit = 0;
  while (modelStack[i] != 0){ // 0 is the DL mark
    lit = modelStack[i];
    model[abs(lit)] = UNDEF;
    modelStack.pop_back();
    --i;
  }
  // at this point, lit is the last decision
  modelStack.pop_back(); // remove the DL mark
  --decisionLevel;
  indexOfNextLitToPropagate = modelStack.size();
  setLiteralToTrue(-lit);  // reverse last decision
}



// Heuristic for finding the next decision literal:
int getNextDecisionLiteral(){
  int maxUndefPos=0;
  int max=0;
  for (uint i = 1; i <= numVars; ++i)
    if (model[i] == UNDEF and conflicts[i]>= max){
      max=conflicts[i];
      maxUndefPos= i;
    }
  if (max == 0)return 0;
  return maxUndefPos;
}

void checkmodel(){
  for (uint i = 0; i < numClauses; ++i){
    bool someTrue = false;
    for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
      someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
    if (not someTrue) {
      cout << "Error in model, clause is not satisfied:";
      for (uint j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
      cout << endl;
      exit(1);
    }
  }
}

int main(){
  readClauses();
  model.resize(numVars+1,UNDEF);
  indexOfNextLitToPropagate = 0;
  decisionLevel = 0;

  //Take care of pure literals
  for (uint i = 0; i < posVars.size();i++){
    if(posVars[i]==0){//pure negative literal
      setLiteralToTrue(-i);
    }else if(negVars[i]==0){
      setLiteralToTrue(i);//pure positive
    }
  }




  // Take care of initial unit clauses, if any
  for (uint i = 0; i < numClauses; ++i)
    if (clauses[i].size() == 1) {
      int lit = clauses[i][0];
      int val = currentValueInModel(lit);
      if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
      else if (val == UNDEF) setLiteralToTrue(lit);

    }



    // DPLL algorithm
    while (true) {
      while ( propagateGivesConflict() ) {
        if ( decisionLevel == 0) { cout << "UNSATISFIABLE" << endl; return 10; }
        backtrack();
      }
      int decisionLit = getNextDecisionLiteral();
      if (decisionLit == 0) { checkmodel(); cout << "SATISFIABLE" << endl; return 20; }
      // start new decision level:
      modelStack.push_back(0);  // push mark indicating new DL
      ++indexOfNextLitToPropagate;
      ++decisionLevel;
      setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
    }
}
