/* 
*******************************************************

  COMPILADORES -- Tarea 4
  Maria Fernanda Hernandez Enriquez A01329383
  This code implements a symbol table using a linked
  list data structure.

*******************************************************
*/

%{
/*  Include statements  */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>

/*	Lex functions  */
FILE extern *yyin;
char extern *yytext;
int yylineno;
int yylex();
int yyerror(char const * s);

/* Symbol table structure */
struct SymbolTable{
	char name[10], type[10];
	struct SymbolTable *next;
};
struct SymbolTable *first, *last;

/* Symbol table functions */
int size = 0;
int flag_1 = 0;
int flag_2 = 0;
void insert(char*, char*);
void display();
void search(char name_tmp[]);
%}

/* Tokens from lex.l */
%start program
%token PROGRAM END ID VAR INT FLOAT READ PRINT FOR SET TO STEP DO NUM_INT NUM_FLOAT
%token OPEN_BRACKET CLOSE_BRACKET SEMICOLON TWO_POINTS OPEN_PARENTHESES CLOSE_PARENTHESES 
%token IF IF_ELSE WHILE PLUS_SIGN MINUS_SIGN MULTIPLICATION_SIGN DIVISION_SIGN
%token NUM SMALLER_THAN_SIGN BIGGER_THAN_SIGN EQUAL_SIGN BIGGER_EQUAL_SIGN SMALLER_EQUAL_SIGN


/* Gramatic */
%%
program : PROGRAM ID OPEN_BRACKET optional_declarations CLOSE_BRACKET statement {printf("Program accepted!\n"); return 0;}
        ;

optional_declarations :	declarations
					  |	%empty
					  ;

declarations : declaration SEMICOLON declarations
			 | declaration
			 ;

declaration : VAR id_save TWO_POINTS type ;

id_save : ID {insert(yytext,"-"); if(flag_1 == 1) return 0;} ;

type : INT
     | FLOAT
     ;
                    	
statement : assign_statement
	  | if_statement
	  | iteration_statement
	  | cmp_statement
	  ;

assign_statement : SET id_check expresion SEMICOLON 
				 | READ id_check SEMICOLON
				 | PRINT expresion SEMICOLON
				 ;

id_check : ID {search(yytext); if(flag_2 == 0) printf("' %s ' doesn't exist.", yytext); return 0;} ;

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
/*******************
	    MAIN
********************/
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
		if (flag_1 == 0 && flag_2 == 1){
			display();
		}
    } 
    fclose(yyin);
    printf("\n");
    return 0;
}

/* 
	Insert() function: 
	Perform a check to make sure the current name does not 
	exist in the table. If name does not exist, space is 
	allocated for a struct and added to	the table.
*/
void insert(char *var_name, char* var_type){
	
	search(var_name);
	if (flag_1 == 0){
		struct SymbolTable *p;
		p = malloc(sizeof(struct SymbolTable));
		
		strcpy(p->name, var_name);
		strcpy(p->type, var_type);
		p->next = NULL;
		
		if (size == 0){
			
			first = p;
			last = p;	
		}
		else{
			last->next = p;
			last = p;	
		}
		size++;
	}
	else{
		printf("\n\tThe variable ' %s ' already exists!", var_name);
	}
	//printf("\n\tVariable inserted.\n");
}
/* 
	Display() function: 
	Print the entire symbol table in the current state.
*/
void display(){
	int i ;
	struct SymbolTable *p;
	p = first;
	printf("\n\tNAME\t\tTYPE\n");
	for(i = 0; i < size; i++){
		printf("\t%s\t\t%s\n", p->name, p->type);
		p = p->next;	
	}
}
/* 
	Search() function: 
	Searches the name inside the current list linked.
	If there is variable with the same name, flag_1 turns
	to 1.If not, continue with 0. And flag_2 represents
	if a variable is used but doesn't exist in the
	symbol table. 
*/
void search(char name_tmp[]){
	flag_2 = 0;	
	int i = 0;
	struct SymbolTable *p;
	p = first;
	for(i = 0; i < size; i++){
		if(strcmp(p->name, name_tmp) == 0){
			flag_1 = 1;
			flag_2 = 1;	
			break;
		}
		p = p->next;
	}
}



