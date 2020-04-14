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
"{" {return OPEN_BRACKET;} 
"}" {return CLOSE_BRACKET;} 
";" {return SEMICOLON;} 
"set" {return SET;} 
"if" {return IF;} 
"(" {return OPEN_PARENTHESES;}
")" {return CLOSE_PARENTHESES;} 
"ifelse" {return IF_ELSE;} 
"while" {return WHILE;} 
"+" {return PLUS_SIGN;} 
"-" {return MINUS_SIGN;} 
"*" {return MULTIPLICATION_SIGN;}
"/" {return DIVISION_SIGN;} 
"<" {return SMALLER_THAN_SIGN;} 
">" {return BIGGER_THAN_SIGN;} 
"=" {return EQUAL_SIGN;}
({SYMBOLS}|{ALPHABET})({ALPHABET}|{NUMBERS}|{SYMBOLS})* {return ID;} 
({NUMBERS})({NUMBERS})* {return NUM;}

%%
