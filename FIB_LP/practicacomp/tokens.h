#ifndef tokens_h
#define tokens_h
/* tokens.h -- List of labelled tokens and stuff
 *
 * Generated from: lego.g
 *
 * Terence Parr, Will Cohen, and Hank Dietz: 1989-2001
 * Purdue University Electrical Engineering
 * ANTLR Version 1.33MR33
 */
#define zzEOF_TOKEN 1
#define NUM 2
#define POP 3
#define GRID 4
#define PUSH 5
#define FITS 6
#define NORTH 7
#define EAST 8
#define SOUTH 9
#define WEST 10
#define MOVE 11
#define DEF 12
#define ENDEF 13
#define WHILE 14
#define AND 15
#define LT 16
#define EQ 17
#define MT 18
#define PLACE 19
#define HEIGHT 20
#define COMMA 21
#define LPAR 22
#define RPAR 23
#define LCOR 24
#define RCOR 25
#define AT 26
#define BEE 27
#define FOO 28
#define SPACE 29

#ifdef __USE_PROTOS
void lego(AST**_root);
#else
extern void lego();
#endif

#ifdef __USE_PROTOS
void grid(AST**_root);
#else
extern void grid();
#endif

#ifdef __USE_PROTOS
void ops(AST**_root);
#else
extern void ops();
#endif

#ifdef __USE_PROTOS
void bloc(AST**_root);
#else
extern void bloc();
#endif

#ifdef __USE_PROTOS
void place(AST**_root);
#else
extern void place();
#endif

#ifdef __USE_PROTOS
void push(AST**_root);
#else
extern void push();
#endif

#ifdef __USE_PROTOS
void pop(AST**_root);
#else
extern void pop();
#endif

#ifdef __USE_PROTOS
void indef(AST**_root);
#else
extern void indef();
#endif

#ifdef __USE_PROTOS
void coord(AST**_root);
#else
extern void coord();
#endif

#ifdef __USE_PROTOS
void move(AST**_root);
#else
extern void move();
#endif

#ifdef __USE_PROTOS
void dir(AST**_root);
#else
extern void dir();
#endif

#ifdef __USE_PROTOS
void loop(AST**_root);
#else
extern void loop();
#endif

#ifdef __USE_PROTOS
void condicio(AST**_root);
#else
extern void condicio();
#endif

#ifdef __USE_PROTOS
void exprs(AST**_root);
#else
extern void exprs();
#endif

#ifdef __USE_PROTOS
void cosa(AST**_root);
#else
extern void cosa();
#endif

#ifdef __USE_PROTOS
void fits(AST**_root);
#else
extern void fits();
#endif

#ifdef __USE_PROTOS
void misparam(AST**_root);
#else
extern void misparam();
#endif

#ifdef __USE_PROTOS
void unpar(AST**_root);
#else
extern void unpar();
#endif

#ifdef __USE_PROTOS
void comp(AST**_root);
#else
extern void comp();
#endif

#ifdef __USE_PROTOS
void value(AST**_root);
#else
extern void value();
#endif

#ifdef __USE_PROTOS
void height(AST**_root);
#else
extern void height();
#endif

#ifdef __USE_PROTOS
void foo(AST**_root);
#else
extern void foo();
#endif

#ifdef __USE_PROTOS
void defs(AST**_root);
#else
extern void defs();
#endif

#ifdef __USE_PROTOS
void def(AST**_root);
#else
extern void def();
#endif

#endif
extern SetWordType zzerr1[];
extern SetWordType setwd1[];
extern SetWordType zzerr2[];
extern SetWordType zzerr3[];
extern SetWordType setwd2[];
extern SetWordType zzerr4[];
extern SetWordType zzerr5[];
extern SetWordType zzerr6[];
extern SetWordType setwd3[];
extern SetWordType setwd4[];
