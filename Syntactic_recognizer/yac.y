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

%token PROGRAM END ID VAR INT FLOAT READ PRINT FOR SET TO STEP DO NUM_INT NUM_FLOAT
%token OPEN_BRACKET CLOSE_BRACKET SEMICOLON TWO_POINTS OPEN_PARENTHESES CLOSE_PARENTHESES 
%token IF IF_ELSE WHILE PLUS_SIGN MINUS_SIGN MULTIPLICATION_SIGN DIVISION_SIGN
%token NUM SMALLER_THAN_SIGN BIGGER_THAN_SIGN EQUAL_SIGN BIGGER_EQUAL_SIGN SMALLER_EQUAL_SIGN
%start program
%%

program : PROGRAM ID OPEN_BRACKET optional_declarations CLOSE_BRACKET statement {printf("Accepted!\n"); return 0;}
        ;

optional_declarations :	declarations
		      |	%empty
		      ;

declarations : declaration SEMICOLON declarations
	     | declaration
	     ;

declaration : VAR ID TWO_POINTS type
	    ;

type : INT
     | FLOAT
     ;
                    	
statement : assign_statement
	  | if_statement
	  | iteration_statement
	  | cmp_statement
	  ;

assign_statement : SET ID expresion SEMICOLON
		| READ ID SEMICOLON
		| PRINT expresion SEMICOLON
		;

if_statement : IF OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement
	     | IF_ELSE OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement statement
	     ;

iteration_statement : WHILE OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement
		    | FOR SET ID expresion TO expresion STEP expresion DO statement
            	    ;

cmp_statement : OPEN_BRACKET CLOSE_BRACKET
	      | OPEN_BRACKET statement_list CLOSE_BRACKET
	      ;

statement_list : statement
	       | statement_list statement
	       ;

expresion : expresion PLUS_SIGN term
	  | expresion MINUS_SIGN term 
	  | term
     	  ;

term : term MULTIPLICATION_SIGN factor 
     | term DIVISION_SIGN factor
     | factor
     ;

factor : OPEN_PARENTHESES expresion CLOSE_PARENTHESES
        | ID
        | NUM_INT
	| NUM_FLOAT
        ;

comparison  :   expresion SMALLER_THAN_SIGN expresion
            |   expresion BIGGER_THAN_SIGN expresion
            |   expresion EQUAL_SIGN expresion
	    |   expresion SMALLER_EQUAL_SIGN expresion
	    |   expresion BIGGER_EQUAL_SIGN expresion
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
            printf("I can't open file!");
            return -1;
        }
        yyin = my_file;
        yyparse();
    } 
    fclose(yyin);
    printf("\n");
    return 0;
}
