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
#include <assert.h>
#include <ctype.h>

/*	Lex functions  */
FILE extern *yyin;
char extern *yytext;
int yylineno;
int yylex();
int yyerror(char const * s);
float ftype;

/* Symbol table variables & functions */
int size = 0;
int flag_1 = 0;
int flag_2 = 0;
int flag_3 = 0;
void insert(char*, char*);
void display();
void search(char name_tmp[]);
void check_table(char name_tmp[]);
void check_type(char var_one[], char var_two[]);
void print(char*);
%}

%start program
%union{
	int itype;
	float ftype;
	char* idtype;	
	char* s_type;	
	struct SymbolTable* st_type;	
}

/* Tokens */
%token PROGRAM END VAR ID INT FLOAT NUM_INT NUM_FLOAT
%token READ PRINT FOR SET TO STEP DO
%token OPEN_BRACKET CLOSE_BRACKET SEMICOLON TWO_POINTS 
%token OPEN_PARENTHESES CLOSE_PARENTHESES 
%token IF IF_ELSE WHILE PLUS_SIGN MINUS_SIGN MULTIPLICATION_SIGN DIVISION_SIGN
%token SMALLER_THAN_SIGN BIGGER_THAN_SIGN EQUAL_SIGN 
%token BIGGER_EQUAL_SIGN SMALLER_EQUAL_SIGN
%token VALUE_INT VALUE_FLOAT

/* Types */
%type <s_type> OPEN_PARENTHESES
%type <s_type> CLOSE_PARENTHESES
%type <s_type> expression
%type <s_type> term
%type <s_type> factor
%type <s_type> NUM_INT
%type <s_type> NUM_FLOAT
%type <s_type> ID
%type <s_type> VALUE_INT
%type <s_type> VALUE_FLOAT

/*

*/
%%
program : PROGRAM ID OPEN_BRACKET optional_declarations CLOSE_BRACKET statement {printf("\n\t************************\n\t  Program accepted!:)\n\t************************\n"); return 0;}
        ;

optional_declarations :	declarations
		|	%empty
		;

declarations : declaration SEMICOLON declarations
		| declaration
		;

declaration : VAR ID TWO_POINTS type {insert($2, yytext);}
		;

type : INT 
		| FLOAT
		;
                    	
statement : assign_statement
		| if_statement
		| iteration_statement
		| cmp_statement
		;

assign_statement : SET ID expression SEMICOLON {check_table($2); if(flag_2 == 1) return 0;}
		| READ ID SEMICOLON {check_table($2); if(flag_2 == 1) return 0;}
		| PRINT expression SEMICOLON
		;

if_statement : IF OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement
		| IF_ELSE OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement statement
		;

iteration_statement : WHILE OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement
		| FOR SET ID expression TO expression STEP expression DO statement
		;

cmp_statement : OPEN_BRACKET CLOSE_BRACKET
		| OPEN_BRACKET statement_list CLOSE_BRACKET
		;

statement_list : statement
		| statement_list statement
		;

expression : expression PLUS_SIGN term {check_type($1, $3); if(flag_3 == 1) return 0;}
		| expression MINUS_SIGN term {check_type($1, $3); if(flag_3 == 1) return 0;}
		| term  
		;

term : term MULTIPLICATION_SIGN factor  {check_type($1, $3); if(flag_3 == 1) return 0;}
		| term DIVISION_SIGN factor {check_type($1, $3); if(flag_3 == 1) return 0;}
		| factor  
		;

factor : OPEN_PARENTHESES expression CLOSE_PARENTHESES
		| ID {check_table($1); if(flag_2 == 1) return 0;}
		| NUM_INT {$$ = "1";}
		| NUM_FLOAT {$$ = "2";}
		;

comparison  :   expression SMALLER_THAN_SIGN expression
		|   expression BIGGER_THAN_SIGN expression
		|   expression EQUAL_SIGN expression
		|   expression SMALLER_EQUAL_SIGN expression
		|   expression BIGGER_EQUAL_SIGN expression
		;

%%

int yyerror(char const * s) {
	fprintf(stderr, "%s! '%s'. line: %d.\n", s, yytext, yylineno);
	flag_1 = 1;
}

/* Symbol table structure */
struct SymbolTable{
	char name[10], type[10];
	int flag_type;
	union{
		int itype;
		float ftype;	
	}value;
	struct SymbolTable *next;
};
struct SymbolTable *first, *last;

void print(char *var){
	printf("[ %s ]", var);
}

/*******************
		MAIN
********************/
int main(int argc, char *argv[]) {
    if (argc == 1) {
	printf("I don't find your input file\n");
    } else {
        FILE *my_file = fopen(argv[1], "r");
        if (!my_file) {
            printf("I can't open file!");
            return -1;
        }
        yyin = my_file;
        yyparse();
		//printf("%d, %d", flag_1, flag_2);
		if (flag_1 == 0 && flag_2 == 0 && flag_3 == 0){
			display();
		}
    } 
    fclose(yyin);
    printf("\n");
    return 0;
}

/* 
	Insert() function
*/
void insert(char *var_name, char *var_type){
	search(var_name);
	if (flag_1 == 0){
		struct SymbolTable *p;
		p = malloc(sizeof(struct SymbolTable));
		strcpy(p->name, var_name);
		strcpy(p->type, var_type);
		p->next = NULL;
		if(strcmp(p->type, "int") == 0){
			p->flag_type = 1;
		}
		else if(strcmp(p->type, "float") == 0){
			p->flag_type = 2;
		}
		else{
			p->flag_type = 0;
		}

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
}

/* 
	Display() function: 
*/
void display(){
	int i ;
	struct SymbolTable *p;
	p = first;
	printf("\n\tNAME\t\tTYPE\n");
	printf("\t________________________\n");
	for(i = 0; i < size; i++){
		printf("\t%s\t\t%s\n", p->name, p->type);
		p = p->next;	
	}
}
/* 
	Search() function: 
*/
void search(char name_tmp[]){
	int i = 0;
	struct SymbolTable *p;
	p = first;
	for(i = 0; i < size; i++){
		if(strcmp(p->name, name_tmp) == 0){
			flag_1 = 1;
			break;
		}
		p = p->next;
	}
}
/* 
	Check_table() function: 
*/
void check_table(char name_tmp[]){
	flag_2 = 1;
	int i = 0;
	struct SymbolTable *p;
	p = first;
	for(i = 0; i < size; i++){
		if(strcmp(p->name, name_tmp) == 0){
			flag_2 = 0;	
		}
		p = p->next;
	}
	if(flag_2 == 1){
		printf("' %s ' doesn't exist.", name_tmp);	
	}
}

/* 
	Check_type() function: 
*/
void check_type(char var_one[], char var_two[]){
	int type_one = 0;
	int type_two = 0;
	char value_int[] = "1";
	char value_float[] = "1";
 	if(strcmp(var_one, value_int) == 0){
		type_one = 1;
	}
	else if(strcmp(var_one, value_float) == 0){
		type_one = 2;
	}
	if(strcmp(var_two, value_int) == 0){
		type_two = 1;	
	}
	else if(strcmp(var_two, value_float) == 0){
		type_two = 2;	
	}
	struct SymbolTable *p;
	p = first;
	int i = 0;

	for(i = 0; i < size; i++){
		if(strcmp(p->name, var_one) == 0){
			type_one = p->flag_type;
		}
		else if(strcmp(p->name, var_two) == 0){
			type_two = p->flag_type;
		}
		p = p->next;
	}

	if (type_one != type_two){
		flag_3 = 1;	
	}
	if(flag_3 == 1){
		printf("Incompatible types.");	
	}
}





