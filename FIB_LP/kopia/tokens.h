#ifndef tokens_h
#define tokens_h
/* tokens.h -- List of labelled tokens and stuff
 *
 * Generated from: plumber.g
 *
 * Terence Parr, Will Cohen, and Hank Dietz: 1989-2001
 * Purdue University Electrical Engineering
 * ANTLR Version 1.33MR33
 */
#define zzEOF_TOKEN 1
#define PLUS 2
#define MINUS 3
#define MUL 4
#define TUBE 5
#define SPLIT 6
#define EQ 7
#define CON 8
#define MERGE 9
#define LEN 10
#define DIA 11
#define LPAR 12
#define RPAR 13
#define COMMA 14
#define VEC 15
#define OF 16
#define WHILE 17
#define GT 18
#define LT 19
#define EQCOMP 20
#define AND 21
#define OR 22
#define NOT 23
#define PUSH 24
#define POP 25
#define END 26
#define FULL 27
#define EMPTY 28
#define NUM 29
#define ID 30
#define SPACE 31

#ifdef __USE_PROTOS
void plumber(AST**_root);
#else
extern void plumber();
#endif

#ifdef __USE_PROTOS
void ops(AST**_root);
#else
extern void ops();
#endif

#ifdef __USE_PROTOS
void split(AST**_root);
#else
extern void split();
#endif

#ifdef __USE_PROTOS
void content(AST**_root);
#else
extern void content();
#endif

#ifdef __USE_PROTOS
void merge(AST**_root);
#else
extern void merge();
#endif

#ifdef __USE_PROTOS
void mergecont(AST**_root);
#else
extern void mergecont();
#endif

#ifdef __USE_PROTOS
void loop(AST**_root);
#else
extern void loop();
#endif

#ifdef __USE_PROTOS
void comp(AST**_root);
#else
extern void comp();
#endif

#ifdef __USE_PROTOS
void lcomp(AST**_root);
#else
extern void lcomp();
#endif

#ifdef __USE_PROTOS
void llcomp(AST**_root);
#else
extern void llcomp();
#endif

#ifdef __USE_PROTOS
void final(AST**_root);
#else
extern void final();
#endif

#ifdef __USE_PROTOS
void value(AST**_root);
#else
extern void value();
#endif

#ifdef __USE_PROTOS
void term(AST**_root);
#else
extern void term();
#endif

#ifdef __USE_PROTOS
void atom(AST**_root);
#else
extern void atom();
#endif

#endif
extern SetWordType zzerr1[];
extern SetWordType zzerr2[];
extern SetWordType zzerr3[];
extern SetWordType zzerr4[];
extern SetWordType setwd1[];
extern SetWordType zzerr5[];
extern SetWordType zzerr6[];
extern SetWordType zzerr7[];
extern SetWordType zzerr8[];
extern SetWordType setwd2[];
extern SetWordType zzerr9[];
extern SetWordType zzerr10[];
extern SetWordType zzerr11[];
extern SetWordType setwd3[];
