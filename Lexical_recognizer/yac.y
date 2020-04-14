/* 
	Maria Fernanda Hernandez Enriquez
	A01329383
*/
%{

#include <stdio.h>

FILE extern *yyin;
char extern *yytext;
int yylineno;
int yylex();
int yyerror(char const * s);

%}

%token PROGRAM END ID OPEN_BRACKET CLOSE_BRACKET SEMICOLON SET IF OPEN_PARENTHESES
%token CLOSE_PARENTHESES IF_ELSE WHILE PLUS_SIGN MINUS_SIGN MULTIPLICATION_SIGN
%token DIVISION_SIGN NUM SMALLER_THAN_SIGN BIGGER_THAN_SIGN EQUAL_SIGN
%start program
%%

program : PROGRAM ID optional_statements END {printf("Accepted!\n"); return 0;}
        ;

optional_statements :   OPEN_BRACKET CLOSE_BRACKET
                    |   OPEN_BRACKET statements_list CLOSE_BRACKET
                    |   instructions
                    ;

statements_list :   instructions statements_list1
                ;

statements_list1 :   instructions statements_list1
		 |   %empty
		 ;

instructions    :   SEMICOLON
                |   statements SEMICOLON
                ;

statements  :   SET ID arithmetic
            |   IF OPEN_PARENTHESES comparison CLOSE_PARENTHESES optional_statements
            |   IF_ELSE OPEN_PARENTHESES comparison CLOSE_PARENTHESES optional_statements optional_statements
            |   WHILE OPEN_PARENTHESES comparison CLOSE_PARENTHESES optional_statements
            ;

arithmetic  :   term arithmetic1
            ;

arithmetic1 :   PLUS_SIGN term arithmetic1
            |   MINUS_SIGN term arithmetic1
            |   %empty
            ;

comparison  :   arithmetic SMALLER_THAN_SIGN arithmetic
            |   arithmetic BIGGER_THAN_SIGN arithmetic
            |   arithmetic EQUAL_SIGN arithmetic
            ;

term    :   factor term1
        ;
term1   :   MULTIPLICATION_SIGN factor term1
        |   DIVISION_SIGN factor term1
        |   %empty
        ;

factor  :   OPEN_PARENTHESES arithmetic CLOSE_PARENTHESES
        |   ID
        |   NUM
        ;

%%

int yyerror(char const * s) {
  fprintf(stderr, "¡%s! '%s'. line: %d.\n", s, yytext, yylineno);
}

int main(int argc, char *argv[]) {
    if (argc == 1) {
		printf("¡Error! Where is the input file? Please verify you are in the "
          "right path.\n");
    } else {
        FILE *my_file = fopen(argv[1], "r");
        if (!my_file) {
            printf("I can't open a.snazzle.file!");
            return -1;
        }
        yyin = my_file;
        yyparse();
    } 
    fclose(yyin);
    printf("\n");
    return 0;
}
