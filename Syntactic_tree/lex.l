/* 
	Maria Fernanda Hernandez Enriquez
	A01329383
*/
%{
#include <stdio.h>
#include "y.tab.h"
#define SYMBOL_SPACE 	-118
#define NEW_LINE	-119
#define END_OF_FILE	-100
double ftype;
%}

ALPHABET        [a-zA-Z]
NUMBERS         [0-9]
SYMBOLS         [$|_]

%%

"\n" {yylineno++;}
"program" {return PROGRAM_R;}
"end" {return END_R;}
"set" {return SET_R;}
"var" {return VAR_R;}
"int" {return INT_R;} 
"float" {return FLOAT_R;} 
"read" {return READ_R;} 
"print" {return PRINT_R;}
"for" {return FOR_R;}
"to" {return TO_R;} 
"step" {return STEP_R;}
"do" {return DO_R;}
"if" {return IF_R;}
"ifelse" {return IF_ELSE_R;} 
"while" {return WHILE_R;} 
"{" {return OPEN_BRACKET;} 
"}" {return CLOSE_BRACKET;} 
";" {return SEMICOLON;} 
":" {return TWO_POINTS;} 
"(" {return OPEN_PARENTHESES;}
")" {return CLOSE_PARENTHESES;} 
"+" {return PLUS_SIGN;} 
"-" {return MINUS_SIGN;} 
"*" {return MULTIPLICATION_SIGN;}
"/" {return DIVISION_SIGN;} 
"<" {return SMALLER_THAN_SIGN;} 
">" {return BIGGER_THAN_SIGN;} 
"=" {return EQUAL_SIGN;}
"<=" {return SMALLER_EQUAL_SIGN;}
">=" {return BIGGER_EQUAL_SIGN;}

({NUMBERS})({NUMBERS})*  { yylval.itype = atoi(yytext); return INT_NUMBER; }
({NUMBERS})*"."({NUMBERS})({NUMBERS})* { ftype = atof(yytext); return FLOAT_NUMBER; }
({SYMBOLS}|{ALPHABET})({ALPHABET}|{NUMBERS}|{SYMBOLS})* { yylval.id_name = strdup(yytext); return ID; }
<<EOF>>	{ return END_OF_FILE; } 
" "	{ ; } 
"\t"	{ ; } 
.	{ return 1100; }
%%

