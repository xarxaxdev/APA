#header
<<
#include <string>
#include <iostream>

using namespace std;

// struct to store information about tokens
typedef struct {
  string kind;
  string text;
} Attrib;

// function to fill token information (predeclaration)
void zzcr_attr(Attrib *attr, int type, char *text);

// fields for AST nodes
#define AST_FIELDS string kind; string text;
#include "ast.h"

// macro to create a new AST node (and function predeclaration)
#define zzcr_ast(as,attr,ttype,textt) as=createASTnode(attr,ttype,textt)
AST* createASTnode(Attrib* attr, int ttype, char *textt);
>>

<<




// function to fill token information
void zzcr_attr(Attrib *attr, int type, char *text) {
    attr->kind = text;
    attr->text = "";
}

// function to create a new AST node
AST* createASTnode(Attrib* attr, int type, char* text) {
  AST* as = new AST;
  as->kind = attr->kind; 
  as->text = attr->text;
  as->right = NULL; 
  as->down = NULL;
  return as;
}

/// create a new "list" AST node with one element
AST* createASTlist(AST *child) {
 AST *as=new AST;
 as->kind="list";
 as->right=NULL;
 as->down=child;
 return as;
}

/// get nth child of a tree. Count starts at 0.
/// if no such child, returns NULL
AST* child(AST *a,int n) {
 AST *c=a->down;
 for (int i=0; c!=NULL && i<n; i++) c=c->right;
 return c;
} 

/// print AST, recursively, with indentation
void ASTPrintIndent(AST *a,string s)
{
  if (a==NULL) return;

  cout<<a->kind;
  if (a->text!="") cout<<"("<<a->text<<")";
  cout<<endl;

  AST *i = a->down;
  while (i!=NULL && i->right!=NULL) {
    cout<<s+"  \\__";
    ASTPrintIndent(i,s+"  |"+string(i->kind.size()+i->text.size(),' '));
    i=i->right;
  }
  
  if (i!=NULL) {
      cout<<s+"  \\__";
      ASTPrintIndent(i,s+"   "+string(i->kind.size()+i->text.size(),' '));
      i=i->right;
  }
}

/// print AST 
void ASTPrint(AST *a)
{
  while (a!=NULL) {
    cout<<" ";
    ASTPrintIndent(a,"");
    a=a->right;
  }
}
////MY FOOOOS

#include <stdlib.h> 
#include <ctype.h>
#include <cmath>
#include <map>
#include <set>
#include <stack>

struct tube{ int length,diameter;};
struct tubestack{
    int maxsize;
    stack<tube> tubes;
};

map<string, tube > tubes;
map<string,int> connectors;
map<string, tubestack > tubevectors;
int myatoi(string a){
    return atoi(&a[0]);
}



tube merge(AST * a, set<string> & delt , set<string> & delc ){
    tube left, right ;
    int con;
    ///trobem el valor de la branca esq
    if(a->down->kind == "MERGE"){
        left=merge(a->down,delt,delc);
    }
    else{
        if(tubes.find(a->down->kind)!=tubes.end() && delt.find(a->down->kind)==delt.end()){
            //hem de mirar que no s'hagi consumit dos cops el mateix tube en un merge
            //a part de que la variable existeixi
            left=tubes.find(a->down->kind)->second;
            delt.insert(a->down->kind);//afegim el tub als gastats
        }
        else{//si no existeix el left el merge ha de fallar
            left.length=-1;left.diameter=-1;return left;
        }
    }
    ///trobem el valor de la branca dreta
    if(a->down->right->right->kind== "MERGE"){
        right=merge(a->down->right->right,delt,delc);
    }
    else{
        if(tubes.find(a->down->right->right->kind)!=tubes.end() && delt.find(a->down->right->right->kind)==delt.end()){
            //hem de mirar que no s'hagi consumit dos cops el mateix tube en un merge
            //a part de que la variable existeixi
            right=tubes.find(a->down->right->right->kind)->second;
            delt.insert(a->down->right->right->kind);
        }
        else{
            right.length=-1;right.diameter=-1;return right;
        }
    }
    ///mirem si el conector existeix i si no l'hem gastat al mateix merge
    if(connectors.find(a->down->right->kind)!=connectors.end()  && delc.find(a->down->right->kind)==delc.end()){
        delc.insert(a->down->right->kind);
        con=connectors.find(a->down->right->kind)->second;
    }
    else{
        right.length=-1;right.diameter=-1;return right;
    }
    if(con==left.diameter and con==right.diameter ){//hem fet funcionar el merge
        delc.insert(a->down->right->kind);
        tube last;
        last.diameter=con;
        last.length=right.length + left.length;
        //cout << "successful merge  left:" << left.length << " right:" << right.length << endl;
        return last;
    }
    else{
        right.length=-1;right.diameter=-1;return right;
    }
}

int evaluate(AST * a){
        //cout << a->kind << endl;
        if(isdigit((a->kind)[0])){
                return myatoi(a->kind);
        } else if(a->kind=="LENGTH"){
            //cout <<" its length" << endl;
            //cout << a->down->kind << endl
            if(tubes.find(a->down->kind)!= tubes.end() ){
                return tubes.find(a->down->kind)->second.length;
            }
            else return -1;
        } else if(a->kind=="DIAMETER"){
                if(tubes.find(a->down->kind) != tubes.end())return tubes.find(a->down->kind)->second.diameter;
                else if(connectors.find(a->down->kind) != connectors.end()) return connectors.find(a->down->kind)->second;
                else return -1;
        }
        else if(a->kind == "+"){
            //cout << "+" << endl;
            return evaluate(a->down) + evaluate(a->down->right);
        }
        else if (a->kind == "-"){
            //cout << "-" << endl;
            return evaluate(a->down) - evaluate(a->down->right);
        }
        else if (a->kind == "/"){
            //cout << "/" << endl;
            return evaluate(a->down) / evaluate(a->down->right);
        }
        else if (a->kind == "*"){
            //cout << "*" << endl;
            return evaluate(a->down) * evaluate(a->down->right);
        }else return -1;
}


int evaluateb(AST * a){
    if(a->kind=="AND"){
        //cout << "and returns"  <<  (evaluateb(a->down) && evaluateb(a->down->right)) << endl ;
        return evaluateb(a->down) && evaluateb(a->down->right);
    }else if(a->kind=="OR"){
        //cout << "or returns"  << ( evaluateb(a->down) || evaluateb(a->down->right)) << endl ;
        return evaluateb(a->down) || evaluateb(a->down->right);
    }else if(a->kind=="NOT"){
        //cout << "not returns" << not ( evaluateb(a->down)) << endl;
        return not ( evaluateb(a->down));
    }else if(a->kind==">"){
        //cout << '\>' <<  " returns"  <<  (evaluate(a->down) > evaluate(a->down->right)) << endl ;
        return evaluate(a->down) > evaluate(a->down->right);
    }else if(a->kind=="<"){
        //cout << '\<' <<" returns"  <<  (evaluate(a->down) < evaluate(a->down->right)) << endl ;
        //cout <<  "tell ,me whyy " <<  evaluate(a-> down) << ' ' <<  evaluate(a->down->right) << endl;
        return (evaluate(a->down) < evaluate(a->down->right));
    }else if(a->kind=="=="){
        //cout << '\=' <<  '\=' <<" returns"  <<  (evaluate(a->down) == evaluate(a->down->right)) << endl ;
        return evaluate(a->down) == evaluate(a->down->right);
    }else if(a->kind=="FULL"){
        if(tubevectors.find(a->down->kind)!= tubevectors.end()) {
            //si troba el tubevector
            //cout << "trobo " << a->down->kind << endl;
            return (tubevectors.find(a->down->kind)->second.maxsize == tubevectors.find(a->down->kind)->second.tubes.size()) ;
        }else return -1;
    }else if(a->kind=="EMPTY"){
        if(tubevectors.find(a->down->kind)!= tubevectors.end()){
        //troba el tubevec
            //cout << "emtpy returns" << tubevectors.find(a->down->kind)->second.tubes.empty() ;
            return tubevectors.find(a->down->kind)->second.tubes.empty();
        }
        else return -1;
    }else {
        //cout << "evaluation: " <<evaluate(a) << endl;
        return evaluate(a);//es un numero o expressio numerica
    }
}


void purget (set<string> & a){
    for (set<string>::iterator it = a.begin(); it != a.end(); it++) {
        tubes.erase(tubes.find(*it));
        //cout << *it  << "deleted" << endl;
      }
}
void purgec (set<string> & a){
    for (set<string>::iterator it = a.begin(); it != a.end(); it++) {
        connectors.erase(connectors.find(*it));
        //cout << *it  << " deleted" << endl;
      }
}
void print(tube t){
    cout << "diameter: "<< t.diameter << " length: " << t.length << endl;
}
void print(string s){
    tube t = tubes.find(s)->second;
    cout << s  << endl;
    print(t) ;
}
bool existv(string s){
    if(tubevectors.find(s)!= tubevectors.end())return true;
    else return false;
}
bool existt(string s){
    if(tubes.find(s)!= tubes.end())return true;
    else return false;
}
int maxsize(string s){
    //cout << s << endl;
    return tubevectors.find(s)->second.maxsize;
}

void printt(){
    //printa tots els tubes
    map<string, tube>::iterator it = tubes.begin();
    cout << "TUBES:" << endl;
    // Iterate over the map using Iterator till end.
    while (it != tubes.end()) {
        cout << "TUBE: " << it->first << " l: " << it->second.length << " d: " << it->second.diameter << endl;
            it++;
    }
    cout << endl;
}

void printc(){
    //printa tots els connectors
    map<string, int>::iterator it = connectors.begin();
    cout << "CONNECTORS:" << endl;

    // Iterate over the map using Iterator till end.
    while (it != connectors.end()) {
        cout << "CONNECTOR: " << it->first << " d: " << it->second << endl;
            it++;
    }
    cout << endl;
}

void printv(){
    //printa tots els vectors
    map<string, tubestack>::iterator it = tubevectors.begin();
    cout << "VECTORS:" << endl;

    // Iterate over the map using Iterator till end.
    while (it != tubevectors.end()) {
        cout << "TUBEVECTOR: " << it->first << " max: " << it->second.maxsize << " cur: " << it->second.tubes.size() << endl;
        tubestack copia=it->second;
        while(!copia.tubes.empty()){
        cout << "length: " << copia.tubes.top().length << " diameter:" << copia.tubes.top().diameter  << endl;
        copia.tubes.pop();
        }
            it++;
    }
    cout << endl;

}
void deletetube(AST * inst){
    if(tubes.find(inst->down->kind)!= tubes.end())tubes.erase(tubes.find(inst->down->kind));
}
void deletetube2(AST * inst){
        if(tubes.find(inst->down->right->kind)!= tubes.end())tubes.erase(tubes.find(inst->down->right->kind));
}
void deletecon(AST* inst){
   if(connectors.find(inst->down->kind)!=connectors.end()) connectors.erase(connectors.find(inst->down->kind));
}
void deletevec(AST * inst){
    if(tubevectors.find(inst->down->kind)!=tubevectors.end()) tubevectors.erase(tubevectors.find(inst->down->kind));
}

void execute(AST *a){
	AST * inst=a->down;
	while(inst!= NULL){
		if(inst->kind=="="){
                    //cout << "tis an equal" << endl;
			if(inst->down->right->kind =="MERGE"){
                                //cout << "MERGing " << inst->down->kind ;
                                tube red;
                                red.length=-1;  red.diameter=-1;
                                set<string> delt,delc ;//set de cosas a eliminar en caso de que haya exito
                                red =merge(inst->down->right,delt,delc);
                                //cout << "RED l" << red.length << " d" << red.diameter << endl;
                                if(red.length<0 or red.diameter<0) {
                                   cout << "couldnt  MERGE" << endl;

                                  }else{
                                   // cout << " success " << endl;
                                     purget(delt);
                                     purgec(delc);
                                    //tubes.erase(tubes.find(inst->down->kind));
                                     deletetube(inst);
                                    tubes.insert(pair<string,tube>(inst->down->kind,red));
                                }
			} else if(inst->down->right->kind =="TUBE"){
                            //printv();
                                //cout << "tubing " << inst->down->kind ;
				int len =evaluate(inst->down->right->down), dia=evaluate(inst->down->right->down->right); 
                                //cout << ' ' << len << ' ' << dia << endl << endl;
                                if(len<0 or dia<0) cout << "couldnt TUBE"<<endl;
				else{
					tube red;
					red.length=len;
					red.diameter=dia;
                                        //tubes.erase(tubes.find(inst->down->kind));
                                        deletetube(inst);
					tubes.insert(pair<string,tube>(inst->down->kind,red));
				}							
			} else if(inst->down->right->kind =="CONNECTOR"){
                                //cout << "connectoring " << inst->down->kind ;
                                int diam= evaluate(inst->down->right->down);
                                if(diam<0) cout << " couldn't, negative diameter" << diam << endl;
                                else{
                                    //connectors.erase(connectors.find(inst->down->kind));
                                    deletecon(inst);
                                    connectors.insert(pair<string,int>(inst->down->kind, diam));
                                    //cout << " success" << endl;
                                }
			}else if(inst->down->right->kind =="TUBEVECTOR"){
                                //cout << "tubevectoring " << inst->down->kind << ' ' << inst->down->right->down->kind  ;
                            //printt();
                            //printc();
                            //printv();
                                if(evaluate(inst->down->right->down)>= 0){//very success
                                    //cout << " success" << endl;
                                    tubestack t;
                                    t.maxsize=evaluate(inst->down->right->down);
                                    //cout  << "maxsize " << t.maxsize << endl;
                                    //tubevectors.erase(tubevectors.find(inst->down->kind));
                                    deletevec(inst);
                                    tubevectors.insert(pair<string,tubestack>(inst->down->kind,t));
                                }else cout << " couldnt' TUBEVECTOR" << endl;
                        }else if(inst->down->right->right != NULL   and inst->down->right->right->kind =="SPLIT"){
                                //cout << "splitting ";
				AST  * split = inst ->down->right->right->down;
                                //print(split->kind);
                                //cout << split->kind << " into " << inst->down->kind << " and " << inst->down->right->kind  << endl;
				if(tubes.find(split->kind) != tubes.end()){//existeix
                                    set<string> tobecleaned;
                                    if(existt(inst->down->kind))tobecleaned.insert(inst->down->kind);
                                    if(existt(inst->down->right->kind))tobecleaned.insert(inst->down->right->kind);
                                    purget(tobecleaned);

                                    tube red,red2;
                                    red.length=tubes.find(split->kind)->second.length/2;
                                    red2.length=tubes.find(split->kind)->second.length/2 + tubes.find(split->kind)->second.length%2;
                                    red.diameter=red2.diameter= tubes.find(split->kind)->second.diameter;
                                    //tubes.erase(tubes.find(inst->down->kind));
                                    deletetube(inst);

                                    tubes.insert(pair<string,tube>(inst->down->kind,red));
                                    //print(red); print(red2);
                                    //tubes.erase(tubes.find(inst->down->right->kind));
                                    deletetube2(inst);

                                    tubes.insert(pair<string,tube>(inst->down->right->kind,red2));
                                    tubes.erase(tubes.find(split->kind));
                                    //cout << " success" << endl;
                                }
                                else cout << " couldnt SPLIT" << endl;
                        }else{
                            //cout << "copying ";
                            if(tubes.find(inst->down->right->kind)!= tubes.end() ) {
                               //cout << "tube " << inst->down->right->kind  <<  " into " << inst->down->kind  << endl;
                                tube red;
                                red.length= (tubes.find(inst->down->right->kind)->second).length;
                                red.diameter= (tubes.find(inst->down->right->kind)->second).diameter;
                               // print(red);
                                //tubes.erase(tubes.find(inst->down->kind));
                                deletetube(inst);

                                tubes.insert(pair<string,tube>(inst->down->kind, red));
                            }else if(connectors.find(inst->down->right->kind)!= connectors.end()){
                                //cout << " connector " << inst->down->right->kind  <<  " into " << inst->down->kind  << endl;
                                //connectors.erase(connectors.find(inst->down->kind));
                                deletecon(inst);
                                connectors.insert(pair<string,int>
                                                  ((inst->down->kind),
                                                   connectors.find(inst->down->right->kind)->second));
                            }else if(tubevectors.find(inst->down->right->kind)!= tubevectors.end()){
                                deletevec(inst);
                                tubestack nova=tubevectors.find(inst->down->right->kind)->second;
                                tubevectors.insert(pair<string,tubestack>(inst->down->kind,nova));
                            }else  cout << "couldn't find " << inst->down->right->kind  << endl;
                        }
					
		}
                else if(inst->kind=="WHILE"){
                    //evaluar condicions i fer execute de les instruccions mentre siguin certes
                    //cout << "whiling " << evaluateb(inst->down) << endl ;
                    int i=1;

                    if(evaluateb(inst->down)    == -1) cout << "couldnt" << endl;
                    else{
                        //cout << "success" << endl;
                        while(evaluateb(inst->down)){
                            //cout << i << "th iteration" << endl;
                            execute(inst->down->right);
                            i++;
                        }
                    }
                    //printt();
                    //printc();
                    //printv();

                }
                else if(inst->kind== "PUSH"){
                    //cout << "pushing " <<  inst->down->right->kind  << " into " <<  inst->down->kind << endl;
                    ///fa falta que ambdos existeixin i que la pila no estigui plena
                    //cout << "max " <<maxsize(inst->down->kind) << endl;

                    if(existv(inst->down->kind) && existt(inst->down->right->kind) &&
                            ((tubevectors.find(inst->down->kind)->second).tubes.size() != maxsize(inst->down->kind))){
                        //cout << " success" << endl;
                        tube red=tubes.find(inst->down->right->kind)->second;
                        deletetube2(inst);
                        (tubevectors.find(inst->down->kind)->second).tubes.push(red);
                        tubes.erase(inst->down->right->kind);

                    }else cout << "couldn't  PUSH" << endl;
                }
                else if(inst->kind== "POP"){
                    //cout << "popping " << inst->down->kind << endl;
                    ///fa falta que ambdos existeixin i que la pila no estigui buida
                  // cout << "existv" << existv(inst->down->kind) << endl;
                    if(existv(inst->down->kind)  &&  tubevectors.find(inst->down->kind)->second.tubes.size() != 0){
                     //   cout << " success" << endl;

                        tube red=(tubevectors.find(inst->down->kind)->second).tubes.top();
                        (tubevectors.find(inst->down->kind)->second).tubes.pop();
                        //tubes.erase(inst->down->right->kind);
                        deletetube2(inst);
                        tubes.insert(pair<string,tube>(inst->down->right->kind, red));
                    }else cout << "couldn't POP" << endl;
                }
                else{//tenim una expressio numerica
                     cout << evaluate(inst) << endl ;
                     //printt();
                     //printc();
                     //printv();
                }
                //cout << "next instruction" << endl;
		inst = inst->right;
	}

        return;//swiggity swooty

}


int main() {
  AST *root = NULL;
  ANTLR(plumber(&root), stdin);
  ASTPrint(root);
  execute(root);
  printt();
  printc();
  printv();
}
>>

#lexclass START
#token PLUS "\+"
#token MINUS "\-"
#token MUL "\*"
#token TUBE "TUBE"
#token SPLIT "SPLIT"
#token EQ "=" 
#token CON "CONNECTOR"
#token MERGE "MERGE"
#token LEN "LENGTH"
#token DIA "DIAMETER"
#token LPAR "\("
#token RPAR "\)"
#token COMMA "\,"
#token VEC "TUBEVECTOR"
#token OF "OF"
#token WHILE "WHILE"
#token GT ">"
#token LT "<"
#token EQCOMP "=="
#token AND "AND"
#token OR "OR"
#token NOT "NOT"
#token PUSH "PUSH"
#token POP "POP"
#token END "ENDWHILE"
#token FULL "FULL"
#token EMPTY "EMPTY"
#token NUM "[0-9]+"
#token ID "[a-zA-Z]+[0-9]*"
#token SPACE "[\ \n\t]" << zzskip();>>

//...FALTA AFEGIR  PRODUCTE SUMA I RESTA
plumber: (ops)* <<#0=createASTlist(_sibling);>>;
ops: value | WHILE^ loop| LPAR! ID COMMA! ID RPAR! EQ^ split |(PUSH^|POP^) ID ID |ID EQ^ content;
split: SPLIT^ ID;
content: TUBE^ value value | CON^ value | VEC^ OF! value| merge  |ID ;
merge: MERGE^ (mergecont ID mergecont);
mergecont :merge|ID ;
loop: LPAR! comp RPAR! plumber END!;
comp: lcomp (OR^ lcomp)*;
lcomp: llcomp (AND^ llcomp)*;
llcomp: NOT^ llcomp| final ;
final: LPAR! comp RPAR! |(FULL^|EMPTY^) LPAR! ID RPAR!|value (LT^|GT^|EQCOMP^) value  ;
//canviat recientment, potser peta
value: term ((PLUS^|MINUS^) term)*  ;//expr funciona com a num
term: atom  ((MUL^) atom )*;
atom: (LEN^|DIA^) LPAR!  ID RPAR! |NUM ;//expr funciona com a num

