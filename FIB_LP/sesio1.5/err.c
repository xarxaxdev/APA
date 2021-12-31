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
#define zzSET_SIZE 4
#include "antlr.h"
#include "ast.h"
#include "tokens.h"
#include "dlgdef.h"
#include "err.h"

ANTLRChar *zztokens[16]={
	/* 00 */	"Invalid",
	/* 01 */	"@",
	/* 02 */	"BEGIN",
	/* 03 */	"WRITE",
	/* 04 */	"POW",
	/* 05 */	"COMMA",
	/* 06 */	"PLUS",
	/* 07 */	"MINUS",
	/* 08 */	"MUL",
	/* 09 */	"DIV",
	/* 10 */	"LPAR",
	/* 11 */	"RPAR",
	/* 12 */	"NUM",
	/* 13 */	"ID",
	/* 14 */	"ASIG",
	/* 15 */	"SPACE"
};
SetWordType zzerr1[4] = {0x8,0x20,0x0,0x0};
SetWordType zzerr2[4] = {0xc0,0x0,0x0,0x0};
SetWordType zzerr3[4] = {0x0,0x3,0x0,0x0};
SetWordType zzerr4[4] = {0x10,0x34,0x0,0x0};
SetWordType setwd1[16] = {0x0,0xd6,0x0,0xd5,0x0,0xd0,0xc8,
	0xc8,0xa0,0xa0,0x0,0xd0,0x0,0xd5,0x0,
	0x0};
