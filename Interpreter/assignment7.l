/*

    María Fernanda Hernández Enriquez
    A01329383

    Tarea 6

*/

%{
#include <stdlib.h>
#include <math.h>
#include "assignment7.tab.h"
#define FILE_END -100
double ftype;
%} 

%option yylineno
ALPHABET [a-zA-Z]
DIGIT [0-9]
NUMBERS [1-9]

%%
begin     {return PROGRAM_R;}
end         {return RETURN_END;}
var         {return VAR_R;}
int         {return INT_R;}
float       {return FLOAT_R;}
if          {return IF_R;}
ifelse      {return IF_ELSE_R;}
while       {return WHILE_R;}
read        {return READ_R;}
print       {return PRINT_R;}
fun         {return FUNCTION_R;}
return      {return RETURN_R;}
"<-"        {return ASCII_SET;}
"="         {return EQUAL_SIGN;}
"<"         {return SMALLER_THAN_SIGN;}
">"         {return BIGGER_THAN_SIGN;}
";"         {return SEMICOLON;}
":"         {return TWO_POINTS;}
"<="        {return SMALLER_EQUAL_SIGN;}
">="        {return BIGGER_EQUAL_SIGN;}
"+"         {return PLUS_SIGN;}
"-"         {return MINUS_SIGN;}
"*"         {return MULTIPLICATION_SIGN;}
"/"         {return DIVISION_SIGN;}
"("         {return OPEN_PARENTHESES;}
")"         {return CLOSE_PARENTHESES;}
","         {return ASCII_COMMA;}

("-")?{DIGIT}* {yylval.itype = atoi(yytext); return INTEGER_NUMBER;}
("-")?(({NUMBERS}{DIGIT}*|"0")"."({DIGIT}*{DIGIT})) {ftype = atof(yytext); return FLOATING_POINT_NUMBER;}
("$"|{ALPHABET}|"_")("$"|{ALPHABET}|"_"|{DIGIT})* {yylval.id_name= strdup(yytext); return IDENTIFIER;}

<<EOF>>     {return FILE_END;}
" "         {;}
"\t"        {;}
"\n"        {yylineno++;}
.           {return 1100;}
%%