/* 
	Maria Fernanda Hernandez Enriquez
	A01329383
*/
%{
#include <stdio.h>
#include "y.tab.h"
%}

ALPHABET          [a-zA-Z]
NUMBERS           [0-9]
SYMBOLS           [$|_]

%%

"\n" {yylineno++;}
"program" {return PROGRAM;}
"end" {return END;}
"set" {return SET;}
"var" {return SET;}
"int" {return INT;} 
"float" {return SET;} 
"read" {return SET;} 
"print" {return SET;}
"for" {return SET;}
"to" {return SET;} 
"step" {return SET;}
"do" {return SET;}
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
({SYMBOLS}|{ALPHABET})({ALPHABET}|{NUMBERS}|{SYMBOLS})* {return ID;} 
({NUMBERS})({NUMBERS})* {return NUM_INT;}
({NUMBERS})"."({NUMBERS})* {return NUM_FLOAT;}

%%
