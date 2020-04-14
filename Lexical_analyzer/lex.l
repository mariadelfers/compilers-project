%{
#include<stdio.h>
%}

DIGIT		[0-9]
IDENTIFIER	[a-zA-Z][a-zA-Z0-9]+|[a-zA-Z]
/*
ARITHMETIC	"+"|"-"|"*"|"/"
PUNCTUATION	"."|":"|","|";"
SYMBOL	":="|"="|"<"|">"|"<="|">="
*/
PARENTHESIS 	"("|")"
RESERVED 	else|if|while|do|foreach|for|begin|int|float|boolean|procedure|var

/*
101	Numeros enteros
102	Numeros decimales
103	Identificadores
104	Palabras reservadas
105	Operaciones aritmeticas
106	Simbolos de puntuacion
107	Simbolos
108	Parentesis
*/

%%
end {printf("%s\n", yytext); return 0;}
{DIGIT}+ {printf("101 - %s\n", yytext); fprintf(yyout, "101\n");}
[-+]{DIGIT}+ {printf("101 - %s\n", yytext); fprintf(yyout, "101\n");}
{DIGIT}+"."{DIGIT}+ {printf("102 - %s\n", yytext); fprintf(yyout, "102\n");}
[-+]{DIGIT}+"."{DIGIT}+ {printf("102 - %s\n", yytext); fprintf(yyout, "102\n");}
{RESERVED} {printf("104 - %s\n", yytext); fprintf(yyout, "104\n");}
{IDENTIFIER} {printf("103 - %s\n", yytext); fprintf(yyout, "103\n");}

"+" {printf("105 - %s\n", yytext); fprintf(yyout, "105\n");}
"-" {printf("115 - %s\n", yytext); fprintf(yyout, "115\n");}
"*" {printf("125 - %s\n", yytext); fprintf(yyout, "125\n");}
"/" {printf("135 - %s\n", yytext); fprintf(yyout, "135\n");}

"." {printf("106 - %s\n", yytext); fprintf(yyout, "106\n");}
":" {printf("116 - %s\n", yytext); fprintf(yyout, "116\n");}
"," {printf("126 - %s\n", yytext); fprintf(yyout, "126\n");}
";" {printf("136 - %s\n", yytext); fprintf(yyout, "136\n");}

":=" {printf("107 - %s\n", yytext); fprintf(yyout, "107\n");}
"=" {printf("107 - %s\n", yytext); fprintf(yyout, "107\n");}
"<" {printf("107 - %s\n", yytext); fprintf(yyout, "107\n");}
">" {printf("107 - %s\n", yytext); fprintf(yyout, "107\n");}
"<=" {printf("107 - %s\n", yytext); fprintf(yyout, "107\n");}
">=" {printf("107 - %s\n", yytext); fprintf(yyout, "107\n");}

{PARENTHESIS} {printf("108 - %s\n", yytext); fprintf(yyout, "108\n");}
%%



int main(void){
	FILE *myfile = fopen("input.txt", "r");
	yyin = myfile;
	FILE *newfile = fopen("output.txt", "w");
	yyout = newfile;
	yylex();
	return 0;
}



