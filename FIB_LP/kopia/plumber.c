/*
 * A n t l r  T r a n s l a t i o n  H e a d e r
 *
 * Terence Parr, Will Cohen, and Hank Dietz: 1989-2001
 * Purdue University Electrical Engineering
 * With AHPCRC, University of Minnesota
 * ANTLR Version 1.33MR33
 *
 *   /opt/pccts/bin/antlr -gt plumber.g
 *
 */

#define ANTLR_VERSION	13333
#include "pcctscfg.h"
#include "pccts_stdio.h"

#include <string>
#include <iostream>
#include <assert.h>
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
#define GENAST

#include "ast.h"

#define zzSET_SIZE 8
#include "antlr.h"
#include "tokens.h"
#include "dlgdef.h"
#include "mode.h"

/* MR23 In order to remove calls to PURIFY use the antlr -nopurify option */

#ifndef PCCTS_PURIFY
#define PCCTS_PURIFY(r,s) memset((char *) &(r),'\0',(s));
#endif

#include "ast.c"
zzASTgvars

ANTLR_INFO





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

int evaluate(AST * a, bool & error){
//cout << a->kind << endl;
if(error)return-1;
if(isdigit((a->kind)[0])){
return myatoi(a->kind);
} else if(a->kind=="LENGTH"){
//cout <<" its length" << endl;
//cout << a->down->kind << endl
if(tubes.find(a->down->kind)!= tubes.end() ){
return tubes.find(a->down->kind)->second.length;
}
else {
error=true;
return -1;
}
} else if(a->kind=="DIAMETER"){
if(tubes.find(a->down->kind) != tubes.end())return tubes.find(a->down->kind)->second.diameter;
else if(connectors.find(a->down->kind) != connectors.end()) return connectors.find(a->down->kind)->second;
else {
error=true;
return -1;
}
}
else if(a->kind == "+"){
//cout << "+" << endl;
int b =evaluate(a->down,error);
if(error) return -1;
int c = evaluate(a->down->right,error);
if(error) return -1;
return b + c;
}
else if (a->kind == "-"){
//cout << "-" << endl;
int b =evaluate(a->down,error);
if(error) return -1;
int c = evaluate(a->down->right,error);
if(error) return -1;
return b - c;
}
else if (a->kind == "*"){
//cout << "*" << endl;
int b =evaluate(a->down,error);
if(error) return -1;
int c = evaluate(a->down->right,error);
if(error) return -1;
return b * c;
}
//si no es cap altre cas la expressio esta malament
error=true;
return -1;
}


int evaluateb(AST * a){
//no em fa falta una variable de error ja que quan retorno -1 es considera que la expressio es erronia
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
bool error = false;
int b=evaluate(a->down,error) ;
if(error) return -1;
int c =     evaluate(a->down->right,error);
if(error) return -1;
return (b > c);
}else if(a->kind=="<"){
//cout << '\<' <<" returns"  <<  (evaluate(a->down) < evaluate(a->down->right)) << endl ;
bool error = false;
int b=evaluate(a->down,error) ;
if(error) return -1;
int c =     evaluate(a->down->right,error);
if(error) return -1;
return (b < c);
}else if(a->kind=="=="){
//cout << '\=' <<  '\=' <<" returns"  <<  (evaluate(a->down) == evaluate(a->down->right)) << endl ;
bool error = false;
int b=evaluate(a->down,error) ;
if(error) return -1;
int c =     evaluate(a->down->right,error);
if(error) return -1;
return (b == c);
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
bool error=false;
int b = evaluate(a,error);
if(error) return -1;
return b;//es un numero o expressio numerica
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
bool error = false,error2=false;
int len = evaluate(inst->down->right->down,error);
int dia=evaluate(inst->down->right->down->right,error2);
//cout << ' ' << len << ' ' << dia << endl << endl;
if(error)cout << "unexistant variable at TUBE LENGTH" << endl;
else if(error2)cout << "unexistant variable at TUBE DIAMETER" << endl;
else if(len<0 or dia<0) cout << "couldnt TUBE, negative length or diameter"<<endl;
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
bool error=false;
int diam= evaluate(inst->down->right->down,error);
if(error) cout << "unexistant variable at CONNECTOR DIAMETER" << endl;
else if(diam<0) cout << " couldn't, negative diameter" << diam << endl;
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
bool error=false;
int a= evaluate(inst->down->right->down,error);
if(error) cout << "couldnt unexistant variable at TUBEVECTOR MAXSIZE"<< endl;
if(a>= 0){//very success
//cout << " success" << endl;
tubestack t;
t.maxsize=a;
//cout  << "maxsize " << t.maxsize << endl;
//tubevectors.erase(tubevectors.find(inst->down->kind));
deletevec(inst);
tubevectors.insert(pair<string,tubestack>(inst->down->kind,t));
}else cout << " couldnt' TUBEVECTOR,negative value" << endl;
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
int imo= evaluateb(inst->down);
if(imo  == -1) cout << "couldnt iterate (1 iteration)" << endl;
else{
//cout << "success" << endl;
while(imo){
if(imo == -1){
//hem fet coses rares amb condicions
cout << "couldn't evaluate ("<< i << " iteration)" << endl;
break;
}
//cout << i << "th iteration" << endl;
execute(inst->down->right);
imo= evaluateb(inst->down);
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

                    }else {
cout << "couldn't  PUSH" << endl;

                        //assert(0);
}
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
bool error = false;
int a = evaluate(inst,error);
if(error) cout << "couldn't evaluate " << inst->kind  << endl;
else  cout << a << endl ;
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

void
#ifdef __USE_PROTOS
plumber(AST**_root)
#else
plumber(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    while ( (setwd1[LA(1)]&0x1) ) {
      ops(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzLOOP(zztasp2);
    }
    zzEXIT(zztasp2);
    }
  }
  (*_root)=createASTlist(_sibling);
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd1, 0x2);
  }
}

void
#ifdef __USE_PROTOS
ops(AST**_root)
#else
ops(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (setwd1[LA(1)]&0x4) ) {
    value(zzSTR); zzlink(_root, &_sibling, &_tail);
  }
  else {
    if ( (LA(1)==WHILE) ) {
      zzmatch(WHILE); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      loop(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (LA(1)==LPAR) ) {
        zzmatch(LPAR);  zzCONSUME;
        zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
        zzmatch(COMMA);  zzCONSUME;
        zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
        zzmatch(RPAR);  zzCONSUME;
        zzmatch(EQ); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        split(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {
        if ( (setwd1[LA(1)]&0x8) ) {
          {
            zzBLOCK(zztasp2);
            zzMake0;
            {
            if ( (LA(1)==PUSH) ) {
              zzmatch(PUSH); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
            }
            else {
              if ( (LA(1)==POP) ) {
                zzmatch(POP); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
              }
              else {zzFAIL(1,zzerr1,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
            }
            zzEXIT(zztasp2);
            }
          }
          zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
          zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
        }
        else {
          if ( (LA(1)==ID) ) {
            zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
            zzmatch(EQ); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
            content(zzSTR); zzlink(_root, &_sibling, &_tail);
          }
          else {zzFAIL(1,zzerr2,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
        }
      }
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd1, 0x10);
  }
}

void
#ifdef __USE_PROTOS
split(AST**_root)
#else
split(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(SPLIT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
  zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd1, 0x20);
  }
}

void
#ifdef __USE_PROTOS
content(AST**_root)
#else
content(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==TUBE) ) {
    zzmatch(TUBE); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
    value(zzSTR); zzlink(_root, &_sibling, &_tail);
    value(zzSTR); zzlink(_root, &_sibling, &_tail);
  }
  else {
    if ( (LA(1)==CON) ) {
      zzmatch(CON); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      value(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {
      if ( (LA(1)==VEC) ) {
        zzmatch(VEC); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        zzmatch(OF);  zzCONSUME;
        value(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {
        if ( (LA(1)==MERGE) ) {
          merge(zzSTR); zzlink(_root, &_sibling, &_tail);
        }
        else {
          if ( (LA(1)==ID) ) {
            zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
          }
          else {zzFAIL(1,zzerr3,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
        }
      }
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd1, 0x40);
  }
}

void
#ifdef __USE_PROTOS
merge(AST**_root)
#else
merge(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(MERGE); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    mergecont(zzSTR); zzlink(_root, &_sibling, &_tail);
    zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
    mergecont(zzSTR); zzlink(_root, &_sibling, &_tail);
    zzEXIT(zztasp2);
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd1, 0x80);
  }
}

void
#ifdef __USE_PROTOS
mergecont(AST**_root)
#else
mergecont(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==MERGE) ) {
    merge(zzSTR); zzlink(_root, &_sibling, &_tail);
  }
  else {
    if ( (LA(1)==ID) ) {
      zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
    }
    else {zzFAIL(1,zzerr4,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x1);
  }
}

void
#ifdef __USE_PROTOS
loop(AST**_root)
#else
loop(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  zzmatch(LPAR);  zzCONSUME;
  comp(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(RPAR);  zzCONSUME;
  plumber(zzSTR); zzlink(_root, &_sibling, &_tail);
  zzmatch(END);  zzCONSUME;
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x2);
  }
}

void
#ifdef __USE_PROTOS
comp(AST**_root)
#else
comp(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  lcomp(zzSTR); zzlink(_root, &_sibling, &_tail);
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    while ( (LA(1)==OR) ) {
      zzmatch(OR); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      lcomp(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzLOOP(zztasp2);
    }
    zzEXIT(zztasp2);
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x4);
  }
}

void
#ifdef __USE_PROTOS
lcomp(AST**_root)
#else
lcomp(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  llcomp(zzSTR); zzlink(_root, &_sibling, &_tail);
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    while ( (LA(1)==AND) ) {
      zzmatch(AND); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      llcomp(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzLOOP(zztasp2);
    }
    zzEXIT(zztasp2);
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x8);
  }
}

void
#ifdef __USE_PROTOS
llcomp(AST**_root)
#else
llcomp(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==NOT) ) {
    zzmatch(NOT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
    llcomp(zzSTR); zzlink(_root, &_sibling, &_tail);
  }
  else {
    if ( (setwd2[LA(1)]&0x10) ) {
      final(zzSTR); zzlink(_root, &_sibling, &_tail);
    }
    else {zzFAIL(1,zzerr5,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd2, 0x20);
  }
}

void
#ifdef __USE_PROTOS
final(AST**_root)
#else
final(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (LA(1)==LPAR) ) {
    zzmatch(LPAR);  zzCONSUME;
    comp(zzSTR); zzlink(_root, &_sibling, &_tail);
    zzmatch(RPAR);  zzCONSUME;
  }
  else {
    if ( (setwd2[LA(1)]&0x40) ) {
      {
        zzBLOCK(zztasp2);
        zzMake0;
        {
        if ( (LA(1)==FULL) ) {
          zzmatch(FULL); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        }
        else {
          if ( (LA(1)==EMPTY) ) {
            zzmatch(EMPTY); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
          }
          else {zzFAIL(1,zzerr6,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
        }
        zzEXIT(zztasp2);
        }
      }
      zzmatch(LPAR);  zzCONSUME;
      zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
      zzmatch(RPAR);  zzCONSUME;
    }
    else {
      if ( (setwd2[LA(1)]&0x80) ) {
        value(zzSTR); zzlink(_root, &_sibling, &_tail);
        {
          zzBLOCK(zztasp2);
          zzMake0;
          {
          if ( (LA(1)==LT) ) {
            zzmatch(LT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
          }
          else {
            if ( (LA(1)==GT) ) {
              zzmatch(GT); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
            }
            else {
              if ( (LA(1)==EQCOMP) ) {
                zzmatch(EQCOMP); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
              }
              else {zzFAIL(1,zzerr7,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
            }
          }
          zzEXIT(zztasp2);
          }
        }
        value(zzSTR); zzlink(_root, &_sibling, &_tail);
      }
      else {zzFAIL(1,zzerr8,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd3, 0x1);
  }
}

void
#ifdef __USE_PROTOS
value(AST**_root)
#else
value(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  term(zzSTR); zzlink(_root, &_sibling, &_tail);
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    while ( (setwd3[LA(1)]&0x2) ) {
      {
        zzBLOCK(zztasp3);
        zzMake0;
        {
        if ( (LA(1)==PLUS) ) {
          zzmatch(PLUS); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        }
        else {
          if ( (LA(1)==MINUS) ) {
            zzmatch(MINUS); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
          }
          else {zzFAIL(1,zzerr9,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
        }
        zzEXIT(zztasp3);
        }
      }
      term(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzLOOP(zztasp2);
    }
    zzEXIT(zztasp2);
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd3, 0x4);
  }
}

void
#ifdef __USE_PROTOS
term(AST**_root)
#else
term(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  atom(zzSTR); zzlink(_root, &_sibling, &_tail);
  {
    zzBLOCK(zztasp2);
    zzMake0;
    {
    while ( (LA(1)==MUL) ) {
      {
        zzBLOCK(zztasp3);
        zzMake0;
        {
        zzmatch(MUL); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        zzEXIT(zztasp3);
        }
      }
      atom(zzSTR); zzlink(_root, &_sibling, &_tail);
      zzLOOP(zztasp2);
    }
    zzEXIT(zztasp2);
    }
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd3, 0x8);
  }
}

void
#ifdef __USE_PROTOS
atom(AST**_root)
#else
atom(_root)
AST **_root;
#endif
{
  zzRULE;
  zzBLOCK(zztasp1);
  zzMake0;
  {
  if ( (setwd3[LA(1)]&0x10) ) {
    {
      zzBLOCK(zztasp2);
      zzMake0;
      {
      if ( (LA(1)==LEN) ) {
        zzmatch(LEN); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
      }
      else {
        if ( (LA(1)==DIA) ) {
          zzmatch(DIA); zzsubroot(_root, &_sibling, &_tail); zzCONSUME;
        }
        else {zzFAIL(1,zzerr10,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
      }
      zzEXIT(zztasp2);
      }
    }
    zzmatch(LPAR);  zzCONSUME;
    zzmatch(ID); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
    zzmatch(RPAR);  zzCONSUME;
  }
  else {
    if ( (LA(1)==NUM) ) {
      zzmatch(NUM); zzsubchild(_root, &_sibling, &_tail); zzCONSUME;
    }
    else {zzFAIL(1,zzerr11,&zzMissSet,&zzMissText,&zzBadTok,&zzBadText,&zzErrk); goto fail;}
  }
  zzEXIT(zztasp1);
  return;
fail:
  zzEXIT(zztasp1);
  zzsyn(zzMissText, zzBadTok, (ANTLRChar *)"", zzMissSet, zzMissTok, zzErrk, zzBadText);
  zzresynch(setwd3, 0x20);
  }
}
