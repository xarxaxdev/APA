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
#include <vector>
#include <utility>
#include <assert.h>     /* assert */


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


typedef struct{
	int x,y; // punt que determina la cantonada superior esquerra
	int h,w; //dimensions
} tblock ;

typedef struct{
	int n, m; //dimensions
	vector< vector<int> > height; 
	map <string,tblock> blocks;
} Graella;

Graella g;


//aixo fara el debugging fàcil
void print(){
	for(int x=0; x< g.height.size();x++){
		for(int y=0; y < g.height[x].size();y++){
			cout << g.height[x][y] << ' ';
		}
		cout << '\n';
	}
}




int fits(string id, pair<int,int> dim,int insertheight,int minheight){
	bool sol=true;
	map<string,tblock>::iterator it;
	it=g.blocks.find(id);
	if(it==g.blocks.end()) return -1;
	tblock dablock=it->second;
	if(minheight>insertheight)return false;
	if(g.height[(dablock.x)+(dablock.h)-1][(dablock.y)+(dablock.w)-1]>insertheight)return false;
	int i,j;

}
int myatoi(string s){
	return atoi(&s[0]);
}

void assignar(AST *a ){
	//falta comprovar si hi cap
	AST *size=child(child(a,1),0);
	AST *place = child(child(a,1),1);
	tblock newblock;
	newblock.w=myatoi(child(size,0)->kind);
	newblock.h=myatoi(child(size,1)->kind);
	newblock.y=myatoi(child(place,1)->kind)-1;
	newblock.x=myatoi(child(place,0)->kind)-1;
	g.blocks.insert(pair<string,tblock>(&(child(a,0)->kind)[0],newblock));
	for(int j=newblock.y;j<newblock.y+newblock.h;j++){
		for(int i=newblock.x;i<newblock.x+newblock.w;i++){
			g.height[j][i]++;
		}
	}
}


bool canmove(int xmin,int xmax, int ymin, int ymax){
	for(int i=ymin;i<ymax;i++){
		for(int j=xmin;j<xmax;j++){
			cout << "comprovant" << j <<"," << i<< endl;
			if(g.height[i][j])return false;
		}
	}
	return true;
}

void move(AST* a){
	cout << child(a,0)->kind << endl;
	map<string,tblock>::iterator it =g.blocks.find(child(a,0)->kind);
	if(it==g.blocks.end() or child(a,2)->kind=="0")return;
	tblock noob=it->second;
	int offset=myatoi(child(a,2)->kind);
//cout << noob.x << ","<<noob.y << "h" << 
//	noob.h << "w" << noob.w<< endl;
	if(child(a,1)->kind=="NORTH"){
		int xmin=noob.x;
		int xmax=xmin+noob.w;
		int ymin=noob.y-offset;
		int ymax=noob.y;
		if(ymin<0)return;
		if(canmove(xmin,xmax,ymin,ymax)){
			//cout << "canmovenorth"<< endl;
			for(int i=noob.y-offset;i<noob.y-offset+noob.h;i++){
				for(int j=xmin;j<xmax;j++){
					g.height[i][j]=g.height[i][j+offset];
					g.height[i][j+offset]=0;
				}
			}
			it->second.y=noob.y-offset;
		}
	}
	else if (child(a,1)->kind=="EAST"){
		int xmin=noob.x+noob.w;
		int xmax=xmin+offset;
		int ymin=noob.y;
		int ymax=ymin+noob.h;
		if(xmax>g.n) return;
		if(canmove(xmin,xmax,ymin,ymax)){
	//		cout << "canmoveeast" << endl;
			//printejo la peça a un nou lloc
			for(int i=ymin;i<ymax;i++){
				for(int j=noob.x+offset;j<xmax;j++){
					cout << "movent a " <<j <<","<< i << " desde " << 
					j-offset <<"," << noob.y+i  << endl;
					//assert(a--);
					g.height[i][j]=g.height[i][j-offset];
					g.height[i][j-offset]=0;
				}
			}
			//lesborro de la anterior
			it->second.x=noob.x+offset;
		}
	}
	else if(child(a,1)->kind=="WEST"){
		int xmin=noob.x-offset;
		int xmax=noob.x;
		int ymin=noob.y;
		int ymax=ymin+noob.h;
		if(xmin<0)return;
		if(canmove(xmin,xmax,ymin,ymax)){
	//		cout << "canmovewest" << endl;
			for(int i=ymin;i<ymax;i++){
				for(int j=noob.x-offset;j<noob.x-offset+noob.w;j++){
					g.height[i][j]=g.height[i][j+offset];
					g.height[i][j+offset]=0;
				}
			}
		}
		it->second.x=noob.x-offset;
	}	
	else if(child(a,1)->kind=="SOUTH"){
		int xmin=noob.x;
		int xmax=xmin+noob.w;
		int ymin=noob.y+noob.h;
		int ymax=ymin+offset;
		if(ymax>g.m)return;
		if(canmove(xmin,xmax,ymin,ymax)){
			//move
//			cout << "canmovesouth" << endl;
			for(int i=noob.y+offset;i<ymax;i++){
				for(int j=xmin;j<xmax;j++){
					g.height[i][j]=g.height[i-offset][j];
					g.height[i-offset][j]=0;
				}
			}
			it->second.y=noob.y+offset;
		}
		//print();assert(0);
	}
}
void executarfuncio(string s,AST* foo){
	
		//recorrer l'arbre de DEF fins a trobar una funció amb ID ==s 
}
void push(string block,AST* a ){
	//mirar si es una coordenada o un block
	//si es una coordenada crear el now block amb id=block
	//si es un block modificar la seva x i y i actualizar la matriu
}

void pop(AST * a){
	//resoldre primer si child(a,2) es un pop amb una crida recursiva
	//

}

void executar(AST *a, AST* foo){
	int n=0;
	//int assertion=5;
	while (child(a,n) != NULL){
	cout << "executant " << child(a,n)->kind << endl; 
	if(child(a,n)->kind=="="){
		if(child(child(a,n),1)->kind =="PLACE"){
			assignar(child(a,n));
			cout << "tipus PLACE" << endl;
		}
		else if(child(child(a,n),1)->kind =="PUSH");
		else if(child(child(a,n),1)->kind =="POP");
		else cout << "error" << endl;
	} 
	else if(child(a,n)->kind=="MOVE") move(child(a,n)) ;
	else if(child(a,n)->kind=="WHILE")  ;
	else if(child(a,n)->kind=="HEIGHT")  ;
	else executarfuncio(child(a,n)->kind,foo);
	n++;
	//print();
	//assert(assertion--);
	cout << endl << endl;
	}
}

void construirGraella(AST * grid){
	g.n=myatoi(child(grid,0)->kind);
	g.m=myatoi(child(grid,1)->kind);
	g.height=vector<vector<int> >(g.m,vector<int>(g.n,0));
}

void executeListInstrucctions(AST *a){
	//Construir la nostra Graella
	AST *grid =child(a,0);
	cout << "Construint graella"  <<endl;
	construirGraella(grid);
	cout << "Graella construida" << endl;
	cout << endl;
	//Executar les nostres instruccions
	executar(child(a,1),child(a,2));
}




int main() {
  root = NULL;
  ANTLR(lego(&root), stdin);
  ASTPrint(root);
  //executeListInstrucctions(root);
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
#token FOO "[a-z A-z][a-z A-Z 0-9]*"
#token SPACE "[\ \n]" << zzskip();>>


lego: grid ops defs <<#0=createASTlist(_sibling);>>;
grid: GRID^ NUM NUM;

ops: (bloc|move|loop|foo|height)* <<#0=createASTlist(_sibling);>>;
bloc: BEE EQ^  (place|push);
place:PLACE^ coord AT! coord ;
push: indef (PUSH^  pop)*;
pop:  BEE (POP^ push)*;
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

foo: FOO;

defs: (def)* <<#0=createASTlist(_sibling);>>;
def: DEF^ FOO ops ENDEF!;






