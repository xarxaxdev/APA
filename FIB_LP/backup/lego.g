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
AST* createASTnode(Attrib* attr,int ttype, char *textt);
>>

<<
#include <cstdlib>
#include <cmath>

//global structures
AST *root;


// function to fill token information
void zzcr_attr(Attrib *attr, int type, char *text) {
/*  if (type == ID) {
    attr->kind = "id";
    attr->text = text;
  }
  else {*/
    attr->kind = text;
    attr->text = "";
//  }
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



int main() {
  root = NULL;
  ANTLR(lego(&root), stdin);
  ASTPrint(root);
}
>>

#lexclass START
#token NUM "[0-9]*"
#token POP "POP"
#token GRID "Grid"
#token PUSH "PUSH"
#token FITS "FITS"
#token NORTH "NORTH"
#token EAST "EAST"
#token SOUTH "SOUTH"
#token WEST "WEST"
#token MOVE "MOVE"
#token DEF "DEF"
#token ENDEF "ENDEF"
#token WHILE "WHILE"
#token AND "AND"
#token LT "\<"
#token EQ "\="
#token MT "\>"
#token PLACE "PLACE"
#token HEIGHT "HEIGHT"
#token COMMA "\,"
#token LPAR "\("
#token RPAR "\)"
#token LCOR "\["
#token RCOR "\]"
#token AT "AT"
#token BEE "B[0-9]"
#token ID "[a-z A-z][a-z A-Z 0-9]*"
#token SPACE "[\ \n]" << zzskip();>>


lego: grid ops defs <<#0=createASTlist(_sibling);>>;
grid: GRID^ NUM NUM;

ops: (bloc|move|loop|foo|height)* <<#0=createASTlist(_sibling);>>;
bloc: BEE EQ^  (place|push);
place:PLACE^ coord AT! indef ;
push: indef PUSH^  pop;
pop:  indef	 (POP^ BEE)*;
indef : coord|BEE;
coord: LPAR! NUM COMMA! NUM RPAR! <<#0=createASTlist(_sibling);>>;



move: MOVE^ BEE dir NUM;
dir:(NORTH|EAST|SOUTH|WEST);

loop :WHILE^ condicio LCOR! ops RCOR! ;
condicio:LPAR! exprs RPAR!;
exprs: cosa (AND^ cosa)*;
cosa:fits|comp;
fits: FITS^ LPAR! misparam RPAR!;
misparam: BEE COMMA! unpar COMMA! NUM ;
unpar:NUM COMMA! NUM <<#0=createASTlist(_sibling);>>;
comp: value  (MT^|LT^) value;
value:NUM|height;
height: HEIGHT^ LPAR! BEE RPAR!;

foo: ID;

defs: (def)* <<#0=createASTlist(_sibling);>>;
def: DEF^ ID ops ENDEF!;






