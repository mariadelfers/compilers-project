/* *************************************
    María Fernanda Hernández Enriquez

    Proyecto final
    Compiladores
************************************* */
%{
#include <stdlib.h>
#include <math.h>
#include "compiler.tab.h"
#define END_OF_FILE             -100
double ftype;
%} 

ALPHABET	[a-zA-Z]
DIGIT		[0-9]
NUMBERS		[1-9]

%%
program		{ return PROGRAM_R; }
var		    { return VAR_R; }
set		    { return SET_R; }
read		{ return READ_R; }
print		{ return PRINT_R; }
if		    { return IF_R; }
ifelse		{ return IFELSE_R; }
for		    { return FOR_R; }
to		    { return TO_R; }
step		{ return STEP_R; }
do		    { return DO_R; }
while		{ return WHILE_R; }
int		    { return INT_R; }
float		{ return FLOAT_R; }
fun		    { return FUNCTION_R; }
return		{ return RETURN_R; }

"{"		{ return OPEN_BRACKET; }
"}"		{ return CLOSE_BRACKET; }
"("		{ return OPEN_PARENTHESES; }
")"		{ return CLOSE_PARENTHESES; }
","		{ return COLON; }
";"		{ return SEMICOLON; }
":"		{ return TWO_POINTS; }
"+"		{ return PLUS_SIGN; }
"-"		{ return MINUS_SIGN; }
"*"		{ return MULTIPLICATION_SIGN; }
"/"		{ return DIVISION_SIGN; }
"="		{ return EQUAL_SIGN; }
"<"		{ return SMALLER_THAN_SIGN; }
">"		{ return BIGGER_THAN_SIGN; }
"<="    { return SMALLER_EQUAL_SIGN; }
">="	{ return BIGGER_EQUAL_SIGN; }

("-")?{DIGIT}*                                          { yylval.itype = atoi(yytext); return INT_NUMBER;}

("-")?(({NUMBERS}{DIGIT}*|"0")"."({DIGIT}*{DIGIT}))     { ftype = atof(yytext); return FLOAT_NUMBER; }

("$"|{ALPHABET}|"_")("$"|{ALPHABET}|"_"|{DIGIT})*           { yylval.id_name = strdup(yytext); return ID; }

<<EOF>>		{ return END_OF_FILE; } 
" "		{ ; }
"\t" 		{ ; }
"\n"		{ yylineno++; } 
.		{ return 1100; } 
%%
