%{
#include <stdio.h>
#include "y.tab.h"
%}
/* 
	Maria Fernanda Hernandez Enriquez
	A01329383
*/
%{
#include <stdio.h>
#include "y.tab.h"
float ftype;
%}

ALPHABET        [a-zA-Z]
NUMBERS         [0-9]
SYMBOLS         [$|_]

%%

"\n" {yylineno++;}
"program" {return PROGRAM;}
"end" {return END;}
"set" {return SET;}
"var" {return VAR;}
"int" {return INT;} 
"float" {return FLOAT;} 
"read" {return READ;} 
"print" {return PRINT;}
"for" {return FOR;}
"to" {return TO;} 
"step" {return STEP;}
"do" {return DO;}
"if" {return IF;}
"ifelse" {return IF_ELSE;} 
"while" {return WHILE;} 
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

({SYMBOLS}|{ALPHABET})({ALPHABET}|{NUMBERS}|{SYMBOLS})* {yylval.idtype = strdup(yytext); return ID;}
({NUMBERS})({NUMBERS})* {yylval.idtype = strdup(yytext); return NUM_INT;}
({NUMBERS})*"."({NUMBERS})({NUMBERS})* {yylval.idtype = strdup(yytext); return NUM_FLOAT;}
. {}
%%
/*
({SYMBOLS}|{ALPHABET})({ALPHABET}|{NUMBERS}|{SYMBOLS})* {return ID;} 
({NUMBERS})({NUMBERS})* {yylval.itype = atoi(yytext); return NUM_INT;}
{NUMBERS}"."{NUMBERS}* {yylval.ftype = atoi(yytext); return NUM_FLOAT;}
*/

