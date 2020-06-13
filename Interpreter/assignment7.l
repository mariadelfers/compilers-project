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
begin       {return RETURN_BEGIN;}
end         {return RETURN_END;}
var         {return RETURN_VARIABLE;}
int         {return RETURN_INT;}
float       {return RETURN_FLOAT;}
if          {return RETURN_IF;}
ifelse      {return RETURN_IFELSE;}
while       {return RETURN_WHILE;}
read        {return RETURN_READ;}
print       {return RETURN_PRINT;}
fun         {return RETURN_FUNCTION;}
return      {return RETURN_RETURN;}
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