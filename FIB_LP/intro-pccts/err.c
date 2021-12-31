/*
 * A n t l r  S e t s / E r r o r  F i l e  H e a d e r
 *
 * Generated from: example1.g
 *
 * Terence Parr, Russell Quong, Will Cohen, and Hank Dietz: 1989-2001
 * Parr Research Corporation
 * with Purdue University Electrical Engineering
 * With AHPCRC, University of Minnesota
 * ANTLR Version 1.33MR33
 */

#define ANTLR_VERSION	13333
#include "pcctscfg.h"
#include "pccts_stdio.h"

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
#define zzSET_SIZE 4
#include "antlr.h"
#include "ast.h"
#include "tokens.h"
#include "dlgdef.h"
#include "err.h"

ANTLRChar *zztokens[8]={
	/* 00 */	"Invalid",
	/* 01 */	"@",
	/* 02 */	"NUM",
	/* 03 */	"PLUS",
	/* 04 */	"SPACE",
	/* 05 */	"MINUS",
	/* 06 */	"DIV",
	/* 07 */	"MUL"
};
SetWordType zzerr1[4] = {0x28,0x0,0x0,0x0};
SetWordType zzerr2[4] = {0x2c,0x0,0x0,0x0};
SetWordType zzerr3[4] = {0x4,0x0,0x0,0x0};
SetWordType zzerr4[4] = {0xc0,0x0,0x0,0x0};
SetWordType zzerr5[4] = {0xec,0x0,0x0,0x0};
SetWordType setwd1[8] = {0x0,0x0,0x36,0x37,0x0,0x37,0x8,
	0x8};
