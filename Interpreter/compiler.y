/* *************************************
    María Fernanda Hernández Enriquez

    Proyecto final
    Compiladores
************************************* */
%{
  /*  Include statements  */
#include <stdio.h>
#include <math.h>
#include "compiler.tab.h"
#include <assert.h>
#include <stdlib.h> 
#include <string.h> 
#define NONE -99999
extern FILE *yyin;
double ftype;
/* Type nodes of the syntactic tree */
enum Type_nodes { 
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
  MINUS, 
  MULTIPLICATION, 
  DIVIDE, 
  SMALLER_THAN, 
  BIGGER_THAN, 
  EQUAL, 
  SMALLER_EQUAL, 
  BIGGER_EQUAL, 
  INT_VALUE, 
  FLOAT_VALUE, 
  ID_VALUE,
  FUNCTION_VALUE,
  PARAMETER_VALUE,
  EXPRESSION_LIST,
  RETURN
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
  "MINUS", 
  "MULTIPLICATION", 
  "DIVIDE", 
  "SMALLER_THAN", 
  "BIGGER_THAN", 
  "EQUAL", 
  "SMALLER_EQUAL", 
  "BIGGER_EQUAL", 
  "INT_VALUE", 
  "FLOAT_VALUE", 
  "ID_VALUE",
  "FUNCTION_VALUE",
  "PARAMETER_VALUE",
  "EXPRESSION_LIST",
  "RETURN"
};

/* Syntactic tree functions */
struct SyntacticNode* add_node(int, int, double, char*, int,struct SyntacticNode*, 
  struct SyntacticNode*, struct SyntacticNode*, struct SyntacticNode*, struct SyntacticNode*);
void print_tree(struct SyntacticNode*, char*);
void display_tree(struct SyntacticNode*);
void cover_tree(struct SyntacticNode*);

/* Symbol table functions */
void insert_table(struct SymbolTable**, char const *, int, int, struct SymbolTable*, struct SyntacticNode*);
void display_table(struct SymbolTable *, char*);
struct SymbolTable *table_head;
struct SymbolTable *function_head;

/* Function functions */
struct FunctionNode *function_ptr;
void get_a_function();
void set_a_function(struct SymbolTable*);
void aux_function(struct SyntacticNode*);
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
%token ID
%token OPEN_BRACKET
%token CLOSE_BRACKET
%token SEMICOLON
%token VAR_R
%token TWO_POINTS 
%token INT_R
%token FLOAT_R
%token INT_NUMBER
%token FLOAT_NUMBER
%token SET_R
%token READ_R
%token PRINT_R 
%token IF_R
%token OPEN_PARENTHESES
%token CLOSE_PARENTHESES
%token IFELSE_R
%token WHILE_R
%token FOR_R
%token TO_R 
%token STEP_R
%token DO_R
%token PLUS_SIGN
%token MINUS_SIGN
%token MULTIPLICATION_SIGN
%token DIVISION_SIGN
%token SMALLER_THAN_SIGN
%token BIGGER_THAN_SIGN
%token EQUAL_SIGN 
%token SMALLER_EQUAL_SIGN
%token BIGGER_EQUAL_SIGN
%token FUNCTION_R
%token COLON
%token RETURN_R
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
%type <syntatic_type> IFELSE_R 
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
%type <itype> type
%type <syntatic_type> opt_exprs
%type <syntatic_type> expression_list

%%

program: PROGRAM_R ID OPEN_BRACKET optional_declarations optional_function_declarations CLOSE_BRACKET statement {
      struct SyntacticNode* syntaxTreeRoot;
      syntaxTreeRoot = add_node(PROGRAM, NONE, NONE, NULL, NONE, $7, NULL, NULL, NULL, NULL);
      //print_tree(syntaxTreeRoot, "main");
      cover_tree(syntaxTreeRoot);
      //display_table(table_head, "main");
    }
    ;
optional_declarations: declarations
    | /* empty */
    ;
declarations: declaration SEMICOLON declarations 
    | declaration
    ;
declaration: VAR_R ID TWO_POINTS type{
      insert_table(&table_head, (char*)$2, $4, NONE, NULL, NULL);
    }
    ;
type: INT_R { $$ = INT_VALUE; }
    | FLOAT_R { $$ = FLOAT_VALUE; }
    ;
optional_function_declarations: function_declarations
    | /* empty */
    ;
function_declarations: function_declarations function_declaration
    | function_declaration
    ;
function_declaration: FUNCTION_R ID OPEN_PARENTHESES optional_params CLOSE_PARENTHESES TWO_POINTS type OPEN_BRACKET optional_declarations CLOSE_BRACKET statement{
      insert_table(&table_head, (char*)$2, FUNCTION_VALUE, $7, function_head, $11);
      function_head = NULL;
    }
		| FUNCTION_R ID OPEN_PARENTHESES optional_params CLOSE_PARENTHESES TWO_POINTS type SEMICOLON{
      insert_table(&table_head, (char*)$2, FUNCTION_VALUE, $7, function_head, NULL);
      function_head = NULL;
    }
    ;
optional_params: params
    | /* empty */
    ;
params: param COLON params
    | param
    ;
param: VAR_R ID TWO_POINTS type {
      insert_table(&function_head, (char*)$2, $4, NONE, NULL, NULL);
    }
    ;
statement: assign_statement { $$ = $1; }
    | if_statement { $$ = $1; }
    | iteration_statement { $$ = $1; }
    | cmp_statement { $$ = $1; }
    ;
assign_statement: SET_R ID expression SEMICOLON {
      struct SyntacticNode* idNode = add_node( ID_VALUE, NONE, NONE, (char *)$2, SET, NULL, NULL, NULL, NULL, NULL);
      $$ = add_node(SET, NONE, NONE, NULL, STATEMENT, idNode, $3, NULL, NULL, NULL);
    }
    | READ_R ID SEMICOLON {
      struct SyntacticNode* idNode = add_node(ID_VALUE, NONE, NONE, (char *)$2, READ, NULL, NULL, NULL, NULL, NULL);
      $$ = add_node(READ, NONE, NONE, NULL, STATEMENT, idNode, NULL, NULL, NULL, NULL);              
    }
    | PRINT_R expression SEMICOLON {
      $$ = add_node(PRINT, NONE, NONE, NULL, STATEMENT, $2, NULL, NULL, NULL, NULL);
    }
    | RETURN_R expression SEMICOLON { 
      $$ = add_node(RETURN, NONE, NONE, NULL, STATEMENT, $2, NULL, NULL, NULL, NULL);
    }        
    ;
if_statement: IF_R OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement {
      $$ = add_node(IF, NONE, NONE, NULL, IF_STATEMENT, $3, $5, NULL, NULL, NULL);
    }
    | IFELSE_R OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement statement {
      $$ = add_node(IFELSE, NONE, NONE, NULL, IF_STATEMENT, $3, $5, $6, NULL, NULL);
    }
    ;
iteration_statement: WHILE_R OPEN_PARENTHESES comparison CLOSE_PARENTHESES statement {
      $$ = add_node(WHILE, NONE, NONE, NULL, ITERATION_STATEMENT, $3, $5, NULL, NULL, NULL);
    }
    | FOR_R SET_R ID expression TO_R expression STEP_R expression DO_R statement {
      struct SyntacticNode* idNode = add_node(ID_VALUE, NONE, NONE, (char *)$3, FOR, NULL, NULL, NULL, NULL, NULL);
      struct SyntacticNode* setNode = add_node(SET, NONE, NONE, NULL, FOR, idNode, $4, NULL, NULL, NULL);
      struct SyntacticNode* ltNode = add_node(SMALLER_EQUAL, NONE, NONE, NULL, COMPARISON, idNode, $6, NULL, NULL, NULL);
      struct SyntacticNode* stepNode = add_node(ADD, NONE, NONE, NULL, EXPRESSION, idNode, $8, NULL, NULL, NULL);
      struct SyntacticNode* setNode2 = add_node(SET, NONE, NONE, NULL, FOR, idNode, stepNode, NULL, NULL, NULL);
      $$ = add_node(FOR, NONE, NONE, NULL, ITERATION_STATEMENT, setNode, ltNode, setNode2, $10, NULL);
    }
    ;
cmp_statement: OPEN_BRACKET CLOSE_BRACKET { $$ = NULL; }
    | OPEN_BRACKET statement_list CLOSE_BRACKET { $$ = $2; }
    ;
statement_list: statement { $$ = $1;}
    | statement_list statement {
      $$ = add_node( STATEMENT_LIST, NONE, NONE, NULL, STATEMENT_LIST, $1, $2, NULL, NULL, NULL);
    }
    ;
expression: expression PLUS_SIGN term {
      $$ = add_node(ADD, NONE, NONE, NULL, EXPRESSION, $1, $3, NULL, NULL, NULL);
    }
    | expression MINUS_SIGN term{ 
      $$ = add_node(MINUS, NONE, NONE, NULL, EXPRESSION, $1, $3, NULL, NULL, NULL);
    }
    | term { $$ = $1; }
    ;
term: term MULTIPLICATION_SIGN factor {
      $$ = add_node(MULTIPLICATION, NONE, NONE, NULL, TERM, $1, $3, NULL, NULL, NULL);
    }
    | term DIVISION_SIGN factor {
      $$ = add_node(DIVIDE, NONE, NONE, NULL, TERM, $1, $3, NULL, NULL, NULL);
    }
    | factor { $$ = $1; }
    ;
factor: OPEN_PARENTHESES expression CLOSE_PARENTHESES { $$ = $2; }
    | ID { $$ = add_node(ID_VALUE, NONE, NONE, (char *)$1, FACTOR, NULL, NULL, NULL, NULL, NULL); }
    | INT_NUMBER { $$ = add_node(INT_VALUE, (int)$1, NONE, NULL, TERM, NULL, NULL, NULL, NULL, NULL); }
    | FLOAT_NUMBER { $$ = add_node(FLOAT_VALUE, NONE, ftype, NULL, TERM, NULL, NULL, NULL, NULL, NULL); }
    | ID OPEN_PARENTHESES opt_exprs CLOSE_PARENTHESES {
      $$ = add_node(FUNCTION_VALUE, NONE, NONE, (char *)$1, TERM, $3, NULL, NULL, NULL, NULL);
    }
    ;
opt_exprs: expression_list { $$ = $1; }
    | /*epsilon*/ { $$ = NULL; }
    ;
expression_list: expression_list COLON expression {
      $$ = add_node(PARAMETER_VALUE, NONE, NONE, NULL, EXPRESSION_LIST, $3, $1, NULL, NULL, NULL);
    }
    | expression {
      $$ = add_node(PARAMETER_VALUE, NONE, NONE, NULL, EXPRESSION_LIST, $1, NULL, NULL, NULL, NULL);
    }
    ;      
comparison: expression SMALLER_THAN_SIGN expression {
      $$ = add_node(SMALLER_THAN, NONE, NONE, NULL, COMPARISON, $1, $3, NULL, NULL, NULL);
    }
    | expression BIGGER_THAN_SIGN expression {
      $$ = add_node(BIGGER_THAN, NONE, NONE, NULL, COMPARISON, $1, $3, NULL, NULL, NULL);
    }
    | expression EQUAL_SIGN expression {
      $$ = add_node(EQUAL, NONE, NONE, NULL, COMPARISON, $1, $3, NULL, NULL, NULL);
    }
    | expression SMALLER_EQUAL_SIGN expression {
      $$ = add_node(SMALLER_EQUAL, NONE, NONE, NULL, COMPARISON, $1, $3, NULL, NULL, NULL);
    }
    | expression BIGGER_EQUAL_SIGN expression {
      $$ = add_node(BIGGER_EQUAL, NONE, NONE, NULL, COMPARISON, $1, $3, NULL, NULL, NULL);
    }
    ;

%%
/* Error messages */
#define MESSAGE_SET_ERROR "Incorrect parameter set."
#define MESSAGE_INCOMPATIBLE_VARIABLES "Incompatible types."
#define MESSAGE_FUNCTION_NOT_FOUND "The function doesn't exist."
#define MESSAGE_VARIABLE_NOT_FOUND "The variable doesn't exist."
#define MESSAGE_INVALID_INT "Can't assign float type to an int variable."
#define MESSAGE_INVALID_FLOAT "Can't assign int type to a float variable."

void error_handle(char *message){
  printf("Error! %s\n", message);
  exit(1);
}
/**********************************
          SYMBOL TABLE
**********************************/
/* Symbol table structure */
struct SymbolTable {
  char *name;
  int node_type;
  int return_type;
  union {
    int itype; 
    double ftype;
  } value;
  struct SyntacticNode *root_ptr; 
  struct SymbolTable *table_ptr; 
  struct SymbolTable *next;
};
/*
    insert_table() function
*/
void insert_table(struct SymbolTable** ptr_ptr_table, char const *var_name, int var_type, int type_return, struct SymbolTable *table_ptr, struct SyntacticNode *root_ptr){
  struct SymbolTable* new_symbol = (struct SymbolTable*) malloc(sizeof(struct SymbolTable));
  new_symbol->name = (char *) malloc(strlen(var_name) + 1);
  strcpy (new_symbol->name, var_name);
  new_symbol->node_type = var_type;
  new_symbol->return_type = type_return;
  new_symbol->value.itype = 0;
  new_symbol->table_ptr = table_ptr;
  new_symbol->root_ptr = root_ptr;
  new_symbol->next = (struct SymbolTable*)(*ptr_ptr_table);
  *ptr_ptr_table = new_symbol;
}
/*
    check_table() function
*/
struct SymbolTable* check_table(char const *var_name, struct SymbolTable* top_table_ptr){
  struct SymbolTable *current_ptr = top_table_ptr;
  while(current_ptr != NULL){
    assert(current_ptr->name);
    if(strcmp(current_ptr->name, var_name) == 0)
      return current_ptr;
    current_ptr = current_ptr->next;
  }
  return NULL;
}
 /* Symbol table function structure */
struct FunctionNode{
  struct SymbolTable* node_ptr;
  struct FunctionNode* stack_ptr;
  int flag;
  union {
    int itype; 
    double ftype; 
  } value;
};
int current_function(){
  return function_ptr != NULL;
}
int get_flag(){
  return function_ptr->flag;
}
/*
    get_table() function
*/
struct SymbolTable* get_table(char const *var_name){
  struct SymbolTable *current_ptr = NULL;
  if(current_function())
    current_ptr = check_table(var_name, function_ptr->node_ptr->table_ptr);
  if((current_function() && !current_ptr) || !current_function())
    current_ptr = check_table(var_name, table_head);
  if(!current_ptr)
    error_handle(MESSAGE_VARIABLE_NOT_FOUND);
  return current_ptr;
}
/*
    print_node_table() function
*/
void print_node_table(struct SymbolTable *node){
  if(node == NULL){
    return;
	}
	printf(" %s\t", node->name);
  if(node->node_type < sizeof(Type_node_label)){
    printf("\t%s", Type_node_label[node->node_type]);
  }
  else{
    printf("\t%d\n", node->node_type);
  }
  switch(node->node_type){
    case INT_VALUE:
      printf("\t\t%d\n", node->value.itype);
      break;
    case FLOAT_VALUE:
      printf("\t\t%lf\n", node->value.ftype);
      break;
    case FUNCTION_VALUE:
      assert(node->return_type < sizeof(Type_node_label));
      printf("\t\t%s\n\n", Type_node_label[node->return_type]);
      display_table(node->table_ptr, node->name);
      print_tree(node->root_ptr, node->name);
      break;
  }
}
/*
    display_table() function
*/
void display_table(struct SymbolTable* top_table_ptr, char* table_name){
	printf("__________________________________________________\n");  
	printf("\t\tSYMBOL TABLE [%s] \n", table_name);
	printf("__________________________________________________\n"); 
	printf("     VAR    |\t   TYPE        |\tVALUE\n");
  struct SymbolTable *current_ptr = top_table_ptr;
  while(current_ptr != NULL){
    print_node_table(current_ptr);
    current_ptr = current_ptr->next;
  }
	printf("\n");
}
/*
    set_int_table() function
*/
void set_int_table(char const *var_name, int new_value){
  struct SymbolTable *ptr = get_table(var_name);
  if(ptr != NULL){
    if(ptr->node_type == INT_VALUE){
      ptr->value.itype = new_value;
    }
    else{
      error_handle(MESSAGE_INVALID_INT);
    }
  }
  else{
    error_handle(MESSAGE_VARIABLE_NOT_FOUND);
  }
}
 /*
    set_float_table() function
*/
void set_float_table(char const *var_name, double new_value){
  struct SymbolTable *ptr = get_table(var_name);
  if(ptr != NULL){
    if(ptr->node_type == FLOAT_VALUE){
      ptr->value.ftype = new_value;
    }
    else{
      error_handle(MESSAGE_INVALID_FLOAT);
    }
  }
  else{
    error_handle(MESSAGE_VARIABLE_NOT_FOUND);
  }
}
/*
    set_a_function() function
*/
void set_a_function(struct SymbolTable* ptr){
  struct FunctionNode *new_function_ptr = (struct FunctionNode*) malloc(sizeof(struct FunctionNode));
  new_function_ptr->node_ptr = ptr;
  new_function_ptr->stack_ptr = function_ptr;
  new_function_ptr->flag = 0;
  new_function_ptr->value.itype = 0;
  function_ptr = new_function_ptr;
}
/*
    get_a_function() function
*/
void get_a_function(){
  struct FunctionNode* temp = function_ptr;
  function_ptr = function_ptr->stack_ptr;
  free(temp);
}
/*****************************
	    SYNTACTIC TREE
*******************************/
/* Syntactic node structure */
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
struct SyntacticNode* add_node(int type_node, int int_value, double float_value, char* id_name, int head_type_node, struct SyntacticNode* ptr1, struct SyntacticNode* ptr2, struct SyntacticNode* ptr3, struct SyntacticNode* ptr4, struct SyntacticNode* nextNode){
    struct SyntacticNode* new_node = (struct SyntacticNode*) malloc(sizeof(struct SyntacticNode));
    new_node->node_type = type_node;
    new_node->head_type_node = head_type_node;
    new_node->array_ptr[0] = ptr1;
    new_node->array_ptr[1] = ptr2;
    new_node->array_ptr[2] = ptr3;
    new_node->array_ptr[3] = ptr4;
    new_node->next = nextNode;
    if(type_node == INT_VALUE){
      new_node->value.itype = int_value;
    }
    else if(type_node == FLOAT_VALUE){
      new_node->value.ftype = float_value;
    }
    else if(type_node == ID_VALUE || type_node == FUNCTION_VALUE){
      new_node->value.id_name = (char *) malloc(strlen(id_name) + 1);
      strcpy (new_node->value.id_name, id_name);
    }
    return new_node;
}
/*
    print_tree() function
*/
void print_tree(struct SyntacticNode* root_ptr, char* name_function){
  printf("__ SYNTACTIC TREE %s __\n\n", name_function);
  display_tree(root_ptr);
}
/*
    display_tree() function
*/
void display_tree(struct SyntacticNode* node){
  if(node == NULL){
    return;
	}
  int type = node->node_type;
	if(type >= 0 && type < sizeof(Type_node_label)){
    printf("Type = %s\n", Type_node_label[type]);
  }
  else{
    printf("Type = %d\n", type);
  }
  int head = node->head_type_node;
	if(head >= 0 && head < sizeof(Type_node_label)){
		  printf("Head = %s\n", Type_node_label[head]);
		}
		else{
		  printf("Head = %d\n", head);
		}

  if(node->node_type == INT_VALUE){
    printf("Value = %d\n", node->value.itype);
  }
	 else if(node->node_type == FLOAT_VALUE){
    printf("Value = %f\n", node->value.ftype);
  }
  else if(node->node_type == ID_VALUE || node->node_type == FUNCTION_VALUE){
    printf("Value = %s\n", node->value.id_name);
  }
  int i = 0;
  for(i = 0; i < 4; i++)
    printf("Ptr [%d] = %p\n", i + 1, node->array_ptr[i]);
  printf("\n");
  for(i = 0; i < 4; i++)
    display_tree(node->array_ptr[i]);
}
/*
    int_expression() function
*/
int int_expression(struct SyntacticNode* node){
  assert(node != NULL);
  if(node->node_type == ADD){
    return int_expression(node->array_ptr[0]) + int_expression(node->array_ptr[1]);
  }
  else if(node->node_type == MINUS){
    return int_expression(node->array_ptr[0]) - int_expression(node->array_ptr[1]);
  }
  else if(node->node_type == MULTIPLICATION){
    return int_expression(node->array_ptr[0]) * int_expression(node->array_ptr[1]);
  }
  else if(node->node_type == DIVIDE){
    return int_expression(node->array_ptr[0]) / int_expression(node->array_ptr[1]);
  }
  assert(node->node_type == INT_VALUE || node->node_type == ID_VALUE || node->node_type == FUNCTION_VALUE);
  int return_value = 0;
  if(node->node_type == INT_VALUE){
    return_value = node->value.itype;
  }
  else if(node->node_type == ID_VALUE){
    struct SymbolTable *current_node = get_table(node->value.id_name);
    assert(current_node->node_type == INT_VALUE);
    return_value = current_node->value.itype;
  }
  else if(node->node_type == FUNCTION_VALUE){
    aux_function(node);
    struct SymbolTable* current_node = check_table(node->value.id_name, table_head);
    assert(current_node->return_type == INT_VALUE);    
    return_value = current_node->value.itype;
    get_a_function();
  }
  return return_value;
}
/*
    float_expression() function
*/
double float_expression(struct SyntacticNode* node){
  assert(node != NULL);
  if(node->node_type == ADD){
    return float_expression(node->array_ptr[0]) + float_expression(node->array_ptr[1]);
  }
  else if(node->node_type == MINUS){
    return float_expression(node->array_ptr[0]) - float_expression(node->array_ptr[1]);
  }
  else if(node->node_type == MULTIPLICATION){
    return float_expression(node->array_ptr[0]) * float_expression(node->array_ptr[1]);
  }
  else if(node->node_type == DIVIDE){
    return float_expression(node->array_ptr[0]) / float_expression(node->array_ptr[1]);
  }
  assert(node->node_type == ID_VALUE || node-> node_type == FLOAT_VALUE || node-> node_type == FUNCTION_VALUE);
  double return_value = 0;
  if(node->node_type == FLOAT_VALUE){
    return_value = node->value.ftype;
  }
  else if(node->node_type == ID_VALUE){
    struct SymbolTable *current_node = get_table(node->value.id_name);
    assert(current_node->node_type == FLOAT_VALUE);
    return_value = current_node->value.ftype;
  }
  else if(node-> node_type == FUNCTION_VALUE){
    aux_function(node);
    struct SymbolTable* current_node = check_table(node->value.id_name, table_head);
    assert(current_node->return_type == FLOAT_VALUE);    
    return_value = current_node->value.ftype;
    //return_value = function_ptr->value.ftype;
    get_a_function();
  }
  return return_value;
}
/*
    count_nodes() function
*/
int count_nodes(int type_node, struct SyntacticNode* node){
  int counter = 0; 
  int i = 0;
	if(node == NULL){
    return 0;
	}
  if(node->node_type == type_node){
    counter++;
  }
  else if(node->node_type == ID_VALUE){
    struct SymbolTable* current_node = get_table(node->value.id_name);
    if(current_node->node_type == type_node)
      counter++;
  }
  for(i = 0; i < 4; i++){
    counter += count_nodes(type_node, node->array_ptr[i]);
  }
  return counter;
}
/*
    check_type() function
*/
int check_type(struct SyntacticNode* node){
  int counter_int = count_nodes(INT_VALUE, node);
  int counter_float = count_nodes(FLOAT_VALUE, node);
  if(counter_int > 0 && counter_float == 0){
    return INT_VALUE;
	}
  else if(counter_int == 0 && counter_float > 0){
    return FLOAT_VALUE;
	}
  error_handle(MESSAGE_INCOMPATIBLE_VARIABLES);
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
    table_size() function
*/
int table_size(char const *var_name){
  int size = 0;
  struct SymbolTable* ptr = check_table(var_name, table_head);
	if(ptr == NULL){
		error_handle(MESSAGE_FUNCTION_NOT_FOUND);
	}
  assert(ptr);
  struct SymbolTable* current_ptr = ptr->table_ptr;
  while(current_ptr != NULL){
    size++;
    current_ptr = current_ptr->next;
  }
  return size;
}
/*
    params_size() function
*/
int params_size(struct SyntacticNode* node, int deep_node){
	int counter = 0; 
   int i = 0; 
	if(!node){
    return 0;
	}
  if(deep_node <= 1){
    counter += (node->node_type == PARAMETER_VALUE);
	}
  for(i = 0; i < 4; i++){
    counter += params_size(node->array_ptr[i], deep_node + (node->node_type == FUNCTION_VALUE));
	}
  return counter;
}
/*
    next_function() function
*/
void next_function(struct SymbolTable** ptr_ptr_function, int moves){
  int i = 0;
  for(i = 0; i < moves; i++){
    *ptr_ptr_function = (*ptr_ptr_function)->next;
	}
}
/*
    get_param() function
*/
struct SyntacticNode* get_param(struct SyntacticNode** ptr_ptr_function){
  assert(*ptr_ptr_function);
  struct SyntacticNode *ptr_next = NULL;
	switch((*ptr_ptr_function)->node_type){
		case FUNCTION_VALUE:
			assert((*ptr_ptr_function)->array_ptr[0]);
    	ptr_next = (*ptr_ptr_function)->array_ptr[0]->array_ptr[0];
			break;
		case PARAMETER_VALUE:
			ptr_next = (*ptr_ptr_function)->array_ptr[0];
			break;
	}
  (*ptr_ptr_function) = (*ptr_ptr_function)->array_ptr[0]->array_ptr[1];
  assert(ptr_next);
  return ptr_next;
}
/*
    check_param() function
*/
int check_param(struct SyntacticNode* funcNode){
  int size_function = table_size(funcNode->value.id_name);
  int total_params = params_size(funcNode, 0);
  assert(size_function >= total_params);
  struct SymbolTable* current_ptr = check_table(funcNode->value.id_name, table_head)->table_ptr;
  next_function(&current_ptr, size_function - total_params);
  struct SyntacticNode* function_ptr = funcNode;
  struct SyntacticNode* param_ptr = NULL;
  int i = 0;
  for(i = 0; i < total_params; i++){
    param_ptr = get_param(&function_ptr);
    assert(current_ptr);
    assert(param_ptr);
    if((is_int(param_ptr) && current_ptr->node_type != INT_VALUE)
    || (is_float(param_ptr) && current_ptr->node_type != FLOAT_VALUE)){
      return 0;
    }
    current_ptr = current_ptr->next;
  }
  return 1;
}
/*
    set_param() function
*/
void set_param(struct SyntacticNode* node){
  int size_function = table_size(node->value.id_name);
  int total_params = params_size(node, 0);
  assert(size_function >= total_params);
  struct SymbolTable* current_ptr = check_table(node->value.id_name, table_head)->table_ptr;
  next_function(&current_ptr, size_function - total_params);
  struct SyntacticNode* function_ptr = node;
  struct SyntacticNode* param_ptr = NULL;
  int i = 0;
  for(i = 0; i < total_params; i++){
    param_ptr = get_param(&function_ptr);
    assert(current_ptr);
    assert(param_ptr);
		switch(current_ptr->node_type){
			case INT_VALUE:
				current_ptr->value.itype = int_expression(param_ptr);
				break;
			case FLOAT_VALUE:
				assert(current_ptr->node_type == FLOAT_VALUE);
      	current_ptr->value.ftype = float_expression(param_ptr);
				break;
		}
    current_ptr = current_ptr->next;
  }
}
/*
    aux_function() function
*/
void aux_function(struct SyntacticNode* node){
  if(!check_param(node)){
    error_handle(MESSAGE_SET_ERROR);
	}
  set_param(node);
  struct SymbolTable* funcSymbol = check_table(node->value.id_name, table_head);
  set_a_function(funcSymbol);
  cover_tree(funcSymbol->root_ptr);
}
/*
    print_function() function
*/
void print_function(struct SyntacticNode* node){
  assert(node->array_ptr[0] != NULL);
	switch(node->array_ptr[0]->node_type){
		case INT_VALUE:
			printf("> %d\n", node->array_ptr[0]->value.itype);
			break;
		case FLOAT_VALUE:
			printf("> %f\n", node->array_ptr[0]->value.ftype);
			break;
	}
  if(node->array_ptr[0]->head_type_node == EXPRESSION || node->array_ptr[0]->head_type_node == TERM || node->array_ptr[0]->head_type_node == FACTOR){
    if(node->array_ptr[0]->node_type == FUNCTION_VALUE){ 
      aux_function(node->array_ptr[0]);
      struct SymbolTable* current_function = check_table(node->array_ptr[0]->value.id_name, table_head);
      if(current_function->return_type == INT_VALUE){
        printf("> %d\n", current_function->value.itype);
      }
      else{
        assert(current_function->return_type == FLOAT_VALUE);
       	printf("%lf\n", current_function->value.ftype);
      }
      get_a_function();
    }
    else{ 
      if(is_int(node->array_ptr[0])){
        printf("> %d\n", int_expression(node->array_ptr[0]));
      }
      else{
        assert(is_float(node->array_ptr[0]));
        printf(">? %lf\n", float_expression(node->array_ptr[0]));
      }
    }
  }
}
/*
    expression_function() function
*/
int expression_function(struct SyntacticNode* node){
  assert(node->array_ptr[0] != NULL);
  assert(node->array_ptr[1] != NULL);
  if(is_int(node->array_ptr[0])){
    assert(is_int(node->array_ptr[1]));
    int int_left = int_expression(node->array_ptr[0]);
    int int_rigth = int_expression(node->array_ptr[1]);
    switch(node->node_type){
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
    assert(is_float(node->array_ptr[0]));
    assert(is_float(node->array_ptr[1]));
    double float_left = float_expression(node->array_ptr[0]);
    int float_rigth = float_expression(node->array_ptr[1]);
    switch(node->node_type){
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
    while_function() function
*/
void while_function(struct SyntacticNode* node){
  assert(node->array_ptr[0] != NULL);
  while(expression_function(node->array_ptr[0])){
    cover_tree(node->array_ptr[1]);
  }
}
/*
    if_function() function
*/
void if_function(struct SyntacticNode* node){
  assert(node->array_ptr[0] != NULL);
  if(expression_function(node->array_ptr[0])){
    if(node->array_ptr[1] != NULL)
      cover_tree(node->array_ptr[1]);
  }
}
/*
    ifelse_function() function
*/
void ifelse_function(struct SyntacticNode* node){
  assert(node->array_ptr[0] != NULL);
  if(expression_function(node->array_ptr[0])){
    cover_tree(node->array_ptr[1]);
  }
  else{
    cover_tree(node->array_ptr[2]);
  }
}
/*
    set_function() function
*/
void set_function(struct SyntacticNode* node){
  assert(node->array_ptr[0] != NULL);
  assert(node->array_ptr[1] != NULL);
  struct SymbolTable* current_node = get_table(node->array_ptr[0]->value.id_name);
  assert(current_node != NULL);
  int set_ivalue;
  double set_fvalue;
  switch(current_node->node_type){
    case INT_VALUE:
      set_ivalue = int_expression(node->array_ptr[1]);
      set_int_table(current_node->name, set_ivalue);
      assert(set_ivalue == current_node->value.itype);
      break;
    case FLOAT_VALUE:
      set_fvalue = float_expression(node->array_ptr[1]);
      set_float_table(current_node->name, set_fvalue);
      assert(set_fvalue == current_node->value.ftype);
      break;
  }
}
/*
    for_function() function
*/
void for_function(struct SyntacticNode* node){
  assert(node->array_ptr[0] != NULL);
  assert(node->array_ptr[1] != NULL);
  assert(node->array_ptr[2] != NULL);
  set_function(node->array_ptr[0]);
  while(expression_function(node->array_ptr[1])){
    cover_tree(node->array_ptr[3]);
    set_function(node->array_ptr[2]);
  }
} 
/*
    read_int() function
*/
int read_int(char const *name){
  int new_value = -1;
  printf("Enter INT [%s] : ", name);
  int x = scanf("%d", &new_value);
  assert(x > 0);
  return new_value;
}
/*
    read_float() function
*/
double read_float(char const *name){
  double new_value = -1.0;
  printf("Enter INT [%s] : ", name);
  int x = scanf("%lf", &new_value);
  assert(x > 0);
  return new_value;
}
/*
    read_function() function
*/
void read_function(struct SyntacticNode* node){
  assert(node->array_ptr[0] != NULL);
  struct SymbolTable* current_node = get_table(node->array_ptr[0]->value.id_name);
  int set_ivalue;
  double set_fvalue;
  switch(current_node->node_type){
    case INT_VALUE:
      set_ivalue = read_int(current_node->name);
      set_int_table(current_node->name, set_ivalue);
      assert(set_ivalue == current_node->value.itype);
      break;
    case FLOAT_VALUE:
      set_fvalue = read_float(current_node->name);
      set_float_table(current_node->name, set_fvalue);
      assert(set_fvalue == current_node->value.ftype);
      break;
  }
}
/*
    return_function() function
*/
void return_function(struct SyntacticNode* node){
  assert(node->array_ptr[0] != NULL);
  struct FunctionNode* current_function = function_ptr;
  if(node->array_ptr[0]->node_type == INT_VALUE){
    assert(current_function->node_ptr->return_type == INT_VALUE);
    current_function->node_ptr->value.itype = node->array_ptr[0]->value.itype;
  } 
  else if(node->array_ptr[0]->node_type == FLOAT_VALUE){
    assert(current_function->node_ptr->return_type == FLOAT_VALUE);
    current_function->node_ptr->value.ftype = node->array_ptr[0]->value.ftype;
  }
  else if(node->array_ptr[0]->head_type_node == EXPRESSION
    || node->array_ptr[0]->head_type_node == TERM
    || node->array_ptr[0]->head_type_node == FACTOR){
      if(is_int(node->array_ptr[0])){
        assert(current_function->node_ptr->return_type == INT_VALUE);
        current_function->node_ptr->value.itype = int_expression(node->array_ptr[0]);
      }
      else{
        assert(is_float(node->array_ptr[0]));
        assert(current_function->node_ptr->return_type == FLOAT_VALUE);
        current_function->node_ptr->value.ftype = float_expression(node->array_ptr[0]);
      } 
  }
  function_ptr->flag = 1;
}
/*
    cover_tree() function
*/
void cover_tree(struct SyntacticNode* node){
  if(node == NULL)
    return;
  if(current_function() && get_flag())
    return;
  switch(node->node_type){
    case PROGRAM:
      break;
    case PRINT:
      print_function(node);
      break;
    case IF:
      if_function(node);
      break;
    case IFELSE:
      ifelse_function(node);
      break;
    case WHILE:
      while_function(node);
      break;
    case FOR:
      for_function(node);
      break;
    case SET:
      set_function(node);
      break;
    case READ:
      read_function(node);
      break;
    case RETURN:
      return_function(node);
      break;
  } 
  if(node->node_type != IF
    && node->node_type != IFELSE
    && node->node_type != WHILE
    && node->node_type != FOR){
    int i;
    for(i = 0; i < 4; i++)
      cover_tree(node->array_ptr[i]);
  }
}
/*
    yyerror() function
*/
int yyerror(char const * s) {
  fprintf(stderr, "Error! %s\n", s);
  return 0;
}
/*
    input_handle() function
*/
void handleInput(int argc, char **argv){
    if(argc > 1){
      yyin = fopen(argv[1], "r");
    }
    else{
      yyin = stdin;
    }
}

/*************
    MAIN
*************/
int main(int argc, char **argv) {
  handleInput(argc, argv);
  yyparse();
  return 0;
}
