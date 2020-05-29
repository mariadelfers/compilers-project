/* 
***********************************************

  COMPILADORES -- Tarea 5
  Maria Fernanda Hernandez Enriquez A01329383

***********************************************
*/

%{
/*  Include statements  */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#include <assert.h>
#include <math.h>
#define NONE -99999

/*	Lex functions  */
FILE extern *yyin;
char extern *yytext;
int yylineno;
int yylex();
int yyerror(char const * s);
double ftype;

/* Type nodes of the syntactic tree */
enum Type_nodes{
PROGRAM,
STATEMENT,
ASSIGN_STATEMENT,
IF_STATEMENT,
ITERATION_STATEMENT,
CMP_STATEMENT,
SET,
TO,
EXPRESSION,
TERM,
FACTOR,
READ,
PRINT,
IF,
COMPARISON,
IFELSE,
WHILE,
FOR,
STEP,
DO,
STATEMENT_LIST,
ADD,
SUBSTRACT,
MULTIPLY,
DIVIDE,
SMALLER_THAN,
BIGGER_THAN,
EQUAL,
BIGGER_EQUAL,
SMALLER_EQUAL,
INT_VALUE,
FLOAT_VALUE,
ID_VALUE
};

/* Name of types node of the syntactic tree */
char* Type_node_label[] = {
"PROGRAM",
"STATEMENT",
"ASSIGN_STATEMENT",
"IF_STATEMENT",
"ITERATION_STATEMENT",
"CMP_STATEMENT",
"SET",
"TO",
"EXPRESSION",
"TERM",
"FACTOR",
"READ",
"PRINT",
"IF",
"COMPARISON",
"IFELSE",
"WHILE",
"FOR",
"STEP",
"DO",
"STATEMENT_LIST",
"ADD",
"SUBSTRACT",
"MULTIPLY",
"DIVIDE",
"SMALLER_THAN",
"BIGGER_THAN",
"EQUAL",
"BIGGER_EQUAL",
"SMALLER_EQUAL",
"INT_VALUE",
"FLOAT_VALUE",
"ID_VALUE"
};
/* Symbol table functions */
struct SymbolTable *table_head;
void insert_table(struct SymbolTable**, char const *, int);
void display_table(struct SymbolTable* , char*);
/* Syntactic tree functions */
struct SyntacticNode* add_node(int, int, double, char*, int, struct SyntacticNode*, struct SyntacticNode*, struct SyntacticNode*, struct SyntacticNode*, struct SyntacticNode*);
void print_tree(struct SyntacticNode*);
void cover_tree(struct SyntacticNode*);
%}

%start program 
%union {
  int itype;
  double ftype;
  char* id_name;
  struct SyntacticNode* syntatic_type;
  struct SymbolTable* table_type;
}
/* Tokens */
%token PROGRAM_R 
%token END_R 
%token VAR_R 
%token ID 
%token INT_R 
%token FLOAT_R
%token READ_R 
%token PRINT_R
%token IF_R
%token IF_ELSE_R
%token WHILE_R
%token FOR_R
%token SET_R
%token TO_R
%token STEP_R
%token DO_R
%token OPEN_BRACKET
%token CLOSE_BRACKET
%token SEMICOLON
%token TWO_POINTS 
%token OPEN_PARENTHESES
%token CLOSE_PARENTHESES 
%token PLUS_SIGN
%token MINUS_SIGN
%token MULTIPLICATION_SIGN
%token DIVISION_SIGN
%token SMALLER_THAN_SIGN
%token BIGGER_THAN_SIGN
%token EQUAL_SIGN 
%token BIGGER_EQUAL_SIGN
%token SMALLER_EQUAL_SIGN
%token FLOAT_NUMBER
%token INT_NUMBER

/* Types */
%type <syntatic_type> program
%type <syntatic_type> statement
%type <syntatic_type> assign_statement
%type <syntatic_type> if_statement
%type <syntatic_type> iteration_statement
%type <syntatic_type> cmp_statement
%type <syntatic_type> statement_list
%type <syntatic_type> expression
%type <syntatic_type> term
%type <syntatic_type> factor
%type <syntatic_type> comparison
%type <syntatic_type> OPEN_BRACKET
%type <syntatic_type> CLOSE_BRACKET 
%type <syntatic_type> PROGRAM_R
%type <syntatic_type> VAR_R
%type <syntatic_type> SET_R
%type <syntatic_type> READ_R
%type <syntatic_type> PRINT_R
%type <syntatic_type> IF_R
%type <syntatic_type> IF_ELSE_R
%type <syntatic_type> WHILE_R
%type <syntatic_type> FOR_R
%type <syntatic_type> TO_R
%type <syntatic_type> STEP_R
%type <syntatic_type> DO_R
%type <syntatic_type> PLUS_SIGN
%type <syntatic_type> MINUS_SIGN
%type <syntatic_type> MULTIPLICATION_SIGN 
%type <syntatic_type> DIVISION_SIGN
%type <syntatic_type> SMALLER_THAN_SIGN
%type <syntatic_type> BIGGER_THAN_SIGN
%type <syntatic_type> EQUAL_SIGN
%type <syntatic_type> SMALLER_EQUAL_SIGN
%type <syntatic_type> BIGGER_EQUAL_SIGN
%type <syntatic_type> INT_NUMBER
%type <syntatic_type> FLOAT_NUMBER
%type <syntatic_type> ID
%type <syntatic_type> OPEN_PARENTHESES
%type <syntatic_type> CLOSE_PARENTHESES
%type <itype>  type
%%

/* Gramatic */
program : PROGRAM_R ID OPEN_BRACKET optional_declarations CLOSE_BRACKET statement 
      {
        struct SyntacticNode* root;
        root = add_node(PROGRAM, NONE, NONE, NULL, NONE, $6, NULL, NULL, NULL, NULL);
	//print_tree	
	cover_tree(root);        
	display_table(table_head, "main");
      }
		;

optional_declarations : declarations
        | %empty
        ;

declarations : declaration SEMICOLON declarations 
        | declaration
        ;

declaration : VAR_R ID TWO_POINTS type
        {
            insert_table(&table_head, (char*)$2, $4);
        }
        ;

type : INT_R { $$ = INT_VALUE; }
        | FLOAT_R { $$ = FLOAT_VALUE; }
        ;

statement : assign_statement { $$ = $1; }
        | if_statement { $$ = $1; }
        | iteration_statement { $$ = $1; }
        | cmp_statement { $$ = $1; }
        ;

assign_statement : SET_R ID expression SEMICOLON {
            struct SyntacticNode* node = add_node(SET, NONE, NONE, (char *)$2, ID_VALUE, NULL, NULL, NULL, NULL, NULL);
            $$ = add_node(SET, NONE, NONE, NULL, STATEMENT, node, $3, NULL, NULL, NULL);
        }
        | READ_R ID SEMICOLON {
            struct SyntacticNode* node = add_node(READ, NONE, NONE, (char *)$2, ID_VALUE, NULL, NULL, NULL, NULL, NULL);
            $$ = add_node(READ, NONE, NONE, NULL, STATEMENT, node, NULL, NULL, NULL, NULL);              
        }
        | PRINT_R expression SEMICOLON {
            $$ = add_node(PRINT, NONE, NONE, NULL,  STATEMENT, $2, NULL, NULL, NULL, NULL);
        }     
        ;

if_statement : IF_R OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement
        {
          $$ = add_node(IF, NONE, NONE, NULL, IF_STATEMENT, $3, $5, NULL, NULL, NULL);
        }
        | IF_ELSE_R OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement statement
        {
          $$ = add_node(IFELSE, NONE, NONE, NULL, IF_STATEMENT, $3, $5, $6, NULL, NULL);
        }
;

iteration_statement : WHILE_R OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement {
            $$ = add_node(WHILE, NONE, NONE, NULL, ITERATION_STATEMENT, $3, $5, NULL, NULL, NULL);
        }
        | FOR_R SET_R ID expression TO_R expression STEP_R expression DO_R statement {
            struct SyntacticNode* node = add_node(ID_VALUE, NONE, NONE, (char *)$3, FOR, NULL, NULL, NULL, NULL, NULL);
            struct SyntacticNode* set_node = add_node(FOR, NONE, NONE, NULL, SET, node, $4, NULL, NULL, NULL);
            struct SyntacticNode* smaller_than_node = add_node(SMALLER_EQUAL, NONE, NONE, NULL, EXPRESSION, node, $6, NULL, NULL, NULL);
            struct SyntacticNode* step_node = add_node(COMPARISON, NONE, NONE, NULL, ADD, node, $8, NULL, NULL, NULL);
            struct SyntacticNode* set_node_2 = add_node(FOR, NONE, NONE, NULL, SET, node, step_node, NULL, NULL, NULL);
            $$ = add_node(FOR, NONE, NONE, NULL, ITERATION_STATEMENT, set_node, smaller_than_node, set_node_2, $10, NULL);
        }
        ;

cmp_statement : OPEN_BRACKET CLOSE_BRACKET { $$ = NULL; }
        | OPEN_BRACKET statement_list CLOSE_BRACKET { $$ = $2; }
        ;

statement_list : statement { $$ = $1;}
        | statement_list statement {
            $$ = add_node(STATEMENT_LIST, NONE, NONE, NULL, STATEMENT_LIST, $1, $2, NULL, NULL, NULL);
        }
        ;

expression : expression PLUS_SIGN term {
            $$ = add_node(ADD, NONE, NONE, NULL, COMPARISON, $1, $3, NULL, NULL, NULL);
        }
        | expression MINUS_SIGN term {
            $$ = add_node(SUBSTRACT, NONE, NONE, NULL, COMPARISON, $1, $3, NULL, NULL, NULL);
        }
        | term { $$ = $1; }
        ;

term : term MULTIPLICATION_SIGN factor {
            $$ = add_node(MULTIPLY, NONE, NONE, NULL, TERM, $1, $3, NULL, NULL, NULL);
        }
        | term DIVISION_SIGN factor {
            $$ = add_node(DIVIDE, NONE, NONE, NULL, TERM, $1, $3, NULL, NULL, NULL);
        }
        | factor { $$ = $1; }
        ;

factor : OPEN_PARENTHESES expression CLOSE_PARENTHESES { $$ = $2; }
       | ID {
            $$ = add_node(ID_VALUE, NONE, NONE, (char *)$1, FACTOR, NULL, NULL, NULL, NULL, NULL);
       }
       | INT_NUMBER {
            $$ = add_node(INT_VALUE, (int)$1, NONE, NULL, TERM, NULL, NULL, NULL, NULL, NULL);
       }
       | FLOAT_NUMBER {
          $$ = add_node(FLOAT_VALUE, NONE, ftype, NULL, TERM, NULL, NULL, NULL, NULL, NULL);
       }
        ;

comparison : expression SMALLER_THAN_SIGN expression {
            $$ = add_node(SMALLER_THAN, NONE, NONE, NULL, EXPRESSION, $1, $3, NULL, NULL, NULL);
        }
        | expression BIGGER_THAN_SIGN expression {
            $$ = add_node(BIGGER_THAN, NONE, NONE, NULL, EXPRESSION, $1, $3, NULL, NULL, NULL);
        }
        | expression EQUAL_SIGN expression {
            $$ = add_node(EQUAL, NONE, NONE, NULL,  EXPRESSION, $1, $3, NULL, NULL, NULL);
        }
        | expression SMALLER_EQUAL_SIGN expression {
            $$ = add_node(SMALLER_EQUAL, NONE, NONE, NULL, EXPRESSION, $1, $3, NULL, NULL, NULL);
        }
        | expression BIGGER_EQUAL_SIGN expression {
            $$ = add_node(BIGGER_EQUAL, NONE, NONE, NULL, EXPRESSION, $1, $3, NULL, NULL, NULL);
        }
        ;

%%

/* Error codes */
#define VARIABLE_NOT_FOUND  1
#define INVALID_INT 2
#define INVALID_FLOAT 3
#define INCOMPATIBLE_VARIABLES 4
#define SET_ERROR 5
/* Error message */
#define MESSAGE_VARIABLE_NOT_FOUND "The variable doesn't exist."
#define MESSAGE_INVALID_INT "Can't assign float type to an int variable."
#define MESSAGE_INVALID_FLOAT "Can't assign int type to a float variable."
#define MESSAGE_INCOMPATIBLE_VARIABLES "Incompatible types."
#define MESSAGE_SET_ERROR "Incorrect parameter set."

void error_handler(int errorCode, char *errorMessage){
    printf("Error #%d: %s\n", errorCode, errorMessage);
    exit(1);
}

/**********************************
		SYMBOL TABLE
**********************************/

/* Symbol table structure */
struct SymbolTable {
    char *name;
    int symbol_type;
    union {
        int itype; 
        double ftype; 
    } value;

    struct SymbolTable *next;
};
/*
    insert_table() function
*/
void insert_table(struct SymbolTable** ptr_ptr_table, char const *var_name, int var_type){
    struct SymbolTable* new_node = (struct SymbolTable*) malloc(sizeof(struct SymbolTable));
    new_node -> name = (char *) malloc(strlen(var_name) + 1);
    strcpy (new_node -> name, var_name);
    new_node -> symbol_type = var_type;
    new_node -> value.itype = 0;
    new_node -> next = (struct SymbolTable*)(*ptr_ptr_table);
    *ptr_ptr_table = new_node;
}
/*
    print_symbol_table() function
*/
void print_symbol_table(struct SymbolTable *node){
    if(node == NULL){
        return;
    } 
    if(node -> symbol_type < sizeof(Type_node_label)){
        printf("| %s |\t", Type_node_label[node -> symbol_type]);
    }
    else{
        printf("| %d |\t", node -> symbol_type);
    }
    switch(node -> symbol_type){
        case INT_VALUE:
        printf("| %d |\n", node -> value.itype);
        break;
        case FLOAT_VALUE:
        printf("| %lf |\n", node -> value.ftype);
        break;
    }
    printf("\n");
}
/*
    diaplay_table() function
*/
void display_table(struct SymbolTable* table_head, char* tableName){
    printf("___________________________________\n");
    printf("|     Type       |        Value    |\n");
    printf("___________________________________\n");
    struct SymbolTable *ptr = table_head;
    while(ptr != NULL){
        print_symbol_table(ptr);
        ptr = ptr->next;
    }
    printf("_____________________________________\n");
}
/*
    search_table() function
*/
struct SymbolTable* search(char const *var_name, struct SymbolTable* head){ 	 
    struct SymbolTable *ptr = head;
// struct SymbolTable *ptr = NULL;
	while(ptr != NULL){
		assert(ptr -> name);
		if(strcmp(ptr -> name, var_name) == 0){
			return ptr;
		}
		ptr = ptr -> next;
	}
	return NULL;
}
struct SymbolTable* search_table(char const *var_name){
	struct SymbolTable *ptr = NULL;
	ptr = search(var_name, table_head);
	if(!ptr){
		error_handler(VARIABLE_NOT_FOUND, MESSAGE_VARIABLE_NOT_FOUND);
	}
	return ptr;
}
/*
    set_int_value() function
*/
void set_int_value(char const *var_name, int new_value){
    struct SymbolTable *ptr = search_table(var_name);
    if(ptr != NULL){
        if(ptr -> symbol_type == INT_VALUE){
            ptr -> value.itype = new_value;
        }
    else{
      error_handler(INVALID_INT, MESSAGE_INVALID_INT);
    }
  }
  else{
    error_handler(VARIABLE_NOT_FOUND, MESSAGE_VARIABLE_NOT_FOUND);
  }
}
/*
    set_float_value() function
*/
void set_float_value(char const *var_name, double new_value){
    struct SymbolTable *ptr = search_table(var_name);
    if(ptr != NULL){
        if(ptr -> symbol_type == FLOAT_VALUE){
            ptr -> value.ftype = new_value;
        }
    }
    else{
      error_handler(INVALID_FLOAT, 
        MESSAGE_INVALID_FLOAT);
    }
}

/*****************************
		SYNTACTIC TREE
*******************************/

/* Syntactic tree node structure */
struct SyntacticNode {
  int node_type;
  int head_type_node;
  union {
    int itype;
    double ftype; 
    char *id_name; 
  } value;
  struct SyntacticNode *array_ptr[4];
  struct SyntacticNode *next;
};
/*
    add_node() function
*/
struct SyntacticNode* add_node(int node_type, int ivalue, double fvalue, char* id_name, int head_type_node,
  struct SyntacticNode* ptr1, struct SyntacticNode* ptr2, 
  struct SyntacticNode* ptr3, struct SyntacticNode* ptr4, struct SyntacticNode* nextNode){

    struct SyntacticNode* new_node = (struct SyntacticNode*) malloc(sizeof(struct SyntacticNode));
    new_node -> node_type = node_type;
    new_node -> head_type_node = head_type_node;
    new_node -> array_ptr[0] = ptr1;
    new_node -> array_ptr[1] = ptr2;
    new_node -> array_ptr[2] = ptr3;
    new_node -> array_ptr[3] = ptr4;
    new_node -> next = nextNode;
    if(node_type == INT_VALUE){
      new_node -> value.itype = ivalue;
    }
    else if(node_type == FLOAT_VALUE){
      new_node -> value.ftype = fvalue;
    }
    else if(node_type == ID_VALUE){
      new_node -> value.id_name = (char *) malloc(strlen(id_name) + 1);
      strcpy (new_node -> value.id_name, id_name);
    }
    return new_node;
}
/*
    rpint_node() function
*/
void print_node(int type, char* label){
  if(type >= 0 && type < sizeof(Type_node_label)){
    printf("%s: %s\n", label, Type_node_label[type]);
  }
  else{
    printf("%s: %d\n", label, type);
  }
}
/*
    print_tree() function
*/
void print_tree(struct SyntacticNode* node){
    if(node == NULL)
        return;
    print_node(node -> node_type, "node_type");
    printf("address = %p\n", node);
    print_node(node -> head_type_node, "head_type_node");
    if(node -> node_type == INT_VALUE){
        printf("Node value = %d\n", node -> value.itype);
    }
    else if(node -> node_type == ID_VALUE){
        printf("Node value = %s\n", node -> value.id_name);
    }
    else if(node -> node_type == FLOAT_VALUE){
        printf("Node value = %f\n", node -> value.ftype);
    }
    int i = 0;
    for(i = 0; i < 4; i++){
        printf("ptr #%d: %p\n", i + 1, node -> array_ptr[i]);
    }
    printf("\n");
    for(i = 0; i < 4; i++){
        print_tree(node -> array_ptr[i]);
    }
}
/*
    int_expression() function
*/
int int_expression(struct SyntacticNode* iexpression_node){
    assert(iexpression_node != NULL);
    if(iexpression_node -> node_type == ADD){
        return int_expression(iexpression_node -> array_ptr[0]) + int_expression(iexpression_node -> array_ptr[1]);
    }
    else if(iexpression_node -> node_type == SUBSTRACT){
        return int_expression(iexpression_node -> array_ptr[0]) - int_expression(iexpression_node -> array_ptr[1]);
    }
    else if(iexpression_node -> node_type == MULTIPLY){
        return int_expression(iexpression_node -> array_ptr[0]) * int_expression(iexpression_node -> array_ptr[1]);
    }
    else if(iexpression_node -> node_type == DIVIDE){
        return int_expression(iexpression_node -> array_ptr[0]) / int_expression(iexpression_node -> array_ptr[1]);
    }
    assert(iexpression_node -> node_type == INT_VALUE || iexpression_node -> node_type == ID_VALUE);
    int return_value = 0;
    if(iexpression_node -> node_type == INT_VALUE){
        return_value = iexpression_node -> value.itype;
    }
    else if(iexpression_node -> node_type == ID_VALUE){
        struct SymbolTable *tmp = search_table(iexpression_node -> value.id_name);
        assert(tmp -> symbol_type == INT_VALUE);
        return_value = tmp -> value.itype;
    }
    return return_value;
}
/*
    float_expression() function
*/
double float_expression(struct SyntacticNode* fexpression_node){
    assert(fexpression_node != NULL);
    if(fexpression_node -> node_type == ADD){
        return float_expression(fexpression_node -> array_ptr[0]) + float_expression(fexpression_node -> array_ptr[1]);
    }
    else if(fexpression_node -> node_type == SUBSTRACT){
        return float_expression(fexpression_node -> array_ptr[0]) - float_expression(fexpression_node -> array_ptr[1]);
    }
    else if(fexpression_node -> node_type == MULTIPLY){
        return float_expression(fexpression_node -> array_ptr[0]) * float_expression(fexpression_node -> array_ptr[1]);
    }
    else if(fexpression_node -> node_type == DIVIDE){
        return float_expression(fexpression_node -> array_ptr[0]) / float_expression(fexpression_node -> array_ptr[1]);
    }
    assert(fexpression_node -> node_type == ID_VALUE || fexpression_node -> node_type == FLOAT_VALUE);
    double return_value = 0;
    if(fexpression_node -> node_type == FLOAT_VALUE){
        return_value = fexpression_node -> value.ftype;
    }
    else if(fexpression_node -> node_type == ID_VALUE){
        struct SymbolTable *ptr = search_table(fexpression_node -> value.id_name);
        assert(ptr -> symbol_type == FLOAT_VALUE);
        return_value = ptr -> value.ftype;
    }
    return return_value;
}
/*
    get_type() function
*/
int get_type(int type, struct SyntacticNode* node){
    if(node == NULL){
        return 0;
    }
    int count = 0;
    if(node -> node_type == type){
        count++;
    }
    else if(node -> node_type == ID_VALUE){
        struct SymbolTable* ptr = search_table(node -> value.id_name);
        if(ptr -> symbol_type == type)
        count++;
    }
    int i = 0;
    for(i = 0; i < 4; i++){
        count += get_type(type, node -> array_ptr[i]);
    }
    return count;
}
/*
    check_type() function
*/
int check_type(struct SyntacticNode* node){
    int int_subtree = get_type(INT_VALUE, node);
    int float_subtree = get_type(FLOAT_VALUE, node);
    if(int_subtree > 0 && float_subtree == 0){
        return INT_VALUE;
    }
    else if(int_subtree == 0 && float_subtree > 0){
        return FLOAT_VALUE;
    }
    error_handler(INCOMPATIBLE_VARIABLES, MESSAGE_INCOMPATIBLE_VARIABLES);
    return 0;
}
/*
    is_int() function
*/
int is_int(struct SyntacticNode* node){
     return check_type(node) == INT_VALUE;
}
/*
    is_float() function
*/
int is_float(struct SyntacticNode* node){
    return check_type(node) == FLOAT_VALUE;
}
/*
    comparison_function() function
*/
int comparison_function(struct SyntacticNode* node){
    assert(node -> array_ptr[0] != NULL);
    assert(node -> array_ptr[1] != NULL);
    if(is_int(node -> array_ptr[0])){
        assert(is_int(node -> array_ptr[1]));
        int int_left = int_expression(node -> array_ptr[0]);
        int int_rigth = int_expression(node -> array_ptr[1]);
        switch(node -> node_type){
        case SMALLER_THAN:
            return int_left < int_rigth;
        case BIGGER_THAN:
            return int_left > int_rigth;
        case EQUAL:
            return int_left == int_rigth;
        case SMALLER_EQUAL:
            return int_left <= int_rigth;
        case BIGGER_EQUAL:
            return int_left >= int_rigth;
        }
    }
    else{
        assert(is_float(node -> array_ptr[0]));
        assert(is_float(node -> array_ptr[1]));
        double float_left = float_expression(node -> array_ptr[0]);
        int float_rigth = float_expression(node -> array_ptr[1]);
        switch(node -> node_type){
        case SMALLER_THAN:
            return float_left < float_rigth;
        case BIGGER_THAN:
            return float_left > float_rigth;
        case EQUAL:
            return float_left == float_rigth;
        case SMALLER_EQUAL:
            return float_left <= float_rigth;
        case BIGGER_EQUAL:
            return float_left >= float_rigth;
        }
    }
    assert(NULL);
    return -1;
}
/*
    set_statement() function
*/
void set_statement(struct SyntacticNode* node){
    assert(node -> array_ptr[0] != NULL);
    assert(node -> array_ptr[1] != NULL);
    struct SymbolTable* ptr = search_table(node -> array_ptr[0] -> value.id_name);
    assert(ptr != NULL);
    int set_ivalue;
    double set_fvalue;
    switch(ptr -> symbol_type){
        case INT_VALUE:
        set_ivalue = int_expression(node -> array_ptr[1]);
        set_int_value(ptr -> name, set_ivalue);
        assert(set_ivalue == ptr -> value.itype);
        break;
        case FLOAT_VALUE:
        set_fvalue = float_expression(node -> array_ptr[1]);
        set_float_value(ptr -> name, set_fvalue);
        assert(set_fvalue == ptr -> value.ftype);
        break;
    }
}
/*
    if_statement() function
*/
void if_statement(struct SyntacticNode* node){
    assert(node -> array_ptr[0] != NULL);
    if(comparison_function(node -> array_ptr[0])){
        if(node -> array_ptr[1] != NULL){
            cover_tree(node -> array_ptr[1]);
        }
    }
}
/*
    ifelse_statement() function
*/
void ifelse_statement(struct SyntacticNode* node){
	assert(node -> array_ptr[0] != NULL);
	if(comparison_function(node -> array_ptr[0])){
		cover_tree(node -> array_ptr[1]);	
	}
	else{
		cover_tree(node -> array_ptr[2]);	
	}
}
/*
    while_statement() function
*/
void while_statement(struct SyntacticNode* node){
	assert(node -> array_ptr[0] != NULL);
	while(comparison_function(node -> array_ptr[0])){
		cover_tree(node -> array_ptr[1]);	
	}
}
/* 
	for_statement() function: 
*/
void for_statement(struct SyntacticNode* node){
	assert(node -> array_ptr[0] != NULL);
	assert(node -> array_ptr[1] != NULL);
	assert(node -> array_ptr[2] != NULL);	
	set_statement(node -> array_ptr[0]);	
	while(comparison_function(node -> array_ptr[1])){
		cover_tree(node -> array_ptr[3]);
		set_statement(node -> array_ptr[2]);	
	}
}
/*
    read_int() function
*/
int read_int(){
	int int_value = -1;
	printf("Enter int value: ");
	int scanf_value = scanf("%d", &int_value);
	assert(scanf_value > 0);
	return int_value;
}
/*
    read_float() function
*/
double read_float(){
	double float_value = -1.0;
	printf("Enter float value: ");
	int scanf_value = scanf("%lf", &float_value);
	assert(scanf_value > 0);
	return float_value;
}
/*
    read_funciton() function
*/
void read_function(struct SyntacticNode* node){
  assert(node -> array_ptr[0] != NULL);
  struct SymbolTable* ptr = search_table(node -> array_ptr[0] -> value.id_name);
  int set_ivalue;
  double set_fvalue;
  switch(ptr -> symbol_type){
    case INT_VALUE:
      set_ivalue = read_int();
      set_int_value(ptr -> name, set_ivalue);
      assert(set_ivalue == ptr -> value.itype);
      break;
    case FLOAT_VALUE:
      set_fvalue = read_float();
      set_float_value(ptr -> name, set_fvalue);
      assert(set_fvalue == ptr -> value.ftype);
      break;
  }
}
/*
    print_function() function
*/
void print_function(struct SyntacticNode* node){
  assert(node -> array_ptr[0] != NULL);
  if(node -> array_ptr[0] -> node_type == INT_VALUE){
    printf("%d\n", node -> array_ptr[0] -> value.itype);
  } 
  else if(node -> array_ptr[0] -> node_type == FLOAT_VALUE){
    printf("%f\n", node -> array_ptr[0] -> value.ftype);
  }
  else if(node -> array_ptr[0] -> head_type_node == COMPARISON 
    || node -> array_ptr[0] -> head_type_node == TERM
    || node -> array_ptr[0] -> head_type_node == FACTOR){ 
      if(is_int(node -> array_ptr[0])){
        printf("%d\n", int_expression(node -> array_ptr[0]));
      }
      else{
        assert(is_float(node->array_ptr[0]));
        printf("%lf\n", float_expression(node->array_ptr[0]));
      }
  }
}
/*
    cover_tree() function
*/
void cover_tree(struct SyntacticNode* node){
//printf("[ %s ]\n", node->value.id_name);
  if(node == NULL)
    return;
  switch(node->node_type){
    case PROGRAM:
        break;
    case SET:
        set_statement(node);
        break;
    case READ:
        read_function(node);
        break;
    case PRINT:
        print_function(node);
        break;
    case IF:
        if_statement(node);
        break;
    case IFELSE:
        ifelse_statement(node);
        break;
    case WHILE:
        while_statement(node);
        break;
    case FOR:
        for_statement(node);
        break;
  } 
  if(node -> node_type != IF
    && node -> node_type != IFELSE
    && node -> node_type != WHILE
    && node -> node_type != FOR){

    int i;
    for(i = 0; i < 4; i++)
      cover_tree(node -> array_ptr[i]);
  }
}
/*
    input_handler() function
*/
void input_handler(int argc, char **argv){
    if(argc > 1){
      yyin = fopen(argv[1], "r");
    }
    else{
      yyin = stdin;
    }
}
/*
    yyerror() function
*/
int yyerror(char const * s) {
  fprintf(stderr, "Error: %s\n", s);
  return 0;
}

/******************************
		    MAIN
********************************/
int main(int argc, char **argv) {
  #ifdef _PRINT_PARSE_TRACE
  extern int yydebug;
  yydebug = 1;
  #endif
  input_handler(argc, argv);
  yyparse();
  return 0;
}
