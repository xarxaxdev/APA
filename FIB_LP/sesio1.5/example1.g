#header
<<
#include <string>
#include <iostream>
#include <map>
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
#include <cstdlib>
#include <cmath>



map<string,int> mapamundi;
 
// function to fill token information
void zzcr_attr(Attrib *attr, int type, char *text) {
  if (type == NUM) {
    attr->kind = "intconst";
    attr->text = text;
  }
  else if (type == ID){
    attr->kind = "ID";
    attr->text = text;
  }
  else {
    attr->kind = text;
    attr->text = "";
  }
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
#include <stdlib.h> 

int myatoi(string a){
    return atoi(&a[0]);
}
int pow(int a, int b){
    if(b==0) return 1;
    return a*pow(a,b-1);
}

int evaluate(AST * tree){
    if(tree == NULL){
        return 0; 
    }
    if(tree->kind == "+"){
        //cout << "+" << endl;
        return evaluate(tree->down) + evaluate(tree->down->right);
    }
    if (tree->kind == "-"){
        //cout << "-" << endl;
        return evaluate(tree->down) - evaluate(tree->down->right);
    }
    if (tree->kind == "/"){
        //cout << "/" << endl;
        return evaluate(tree->down) / evaluate(tree->down->right);
    }        
    if (tree->kind == "*"){
        //cout << "*" << endl;
        return evaluate(tree->down) * evaluate(tree->down->right);
    }
    if(tree->kind == "pow"){
        return pow(evaluate(tree->down) , evaluate(tree->down->right));
    }
    else{
        //cout << "kind" <<tree->kind << endl;
        //cout << "text" <<tree->text << endl;
        return myatoi(tree->text);
    }
}

void execute(AST * a){
	cout << "start2execute" << endl;
    if(a == NULL or a->down == NULL){
        return; 
    }
    AST* son= a->down; 
    cout << son->kind << ", "  << son->text << endl;
    while(son != NULL){
        if (son->kind == ":="){
		//cout << evaluate(son->down->right) << endl;
    		//cout << son->kind << ", "  << son->text << endl;
		mapamundi[son->down->text] =evaluate(son->down->right); 
	}
	if(son->kind == "write"){
   		cout << son->down->kind << ", "  << son->down->text << endl;
		if(son->down->kind=="ID")cout << mapamundi.find(son->down->text)->second << endl;
		else cout << evaluate(a->down) << endl;
	}
    	son= son->right;
    }
}

int main() {
  AST *root = NULL;
  ANTLR(program(&root), stdin);
  ASTPrint(root);
  execute(root);
}
>>

#lexclass START
#token BEGIN "begin"
#token WRITE "write"
#token POW "pow"
#token COMMA "\,"
#token PLUS "\+"
#token MINUS "\-"
#token MUL "\*"
#token DIV "\/"
#token LPAR "\("
#token RPAR "\)"
#token NUM "[0-9]+"
#token ID "[a-zA-Z]"
#token ASIG ":="
#token SPACE "[\ \n]" << zzskip();>>

program: BEGIN^ (instruction)*;
instruction: ID ASIG^ expr | WRITE^ expr;
expr: term ((PLUS^|MINUS^) term)*  ;
term:atom  ((MUL^|DIV^) atom )*;
atom: NUM| LPAR! expr RPAR!| POW^ LPAR! expr COMMA! expr RPAR! |ID ;







