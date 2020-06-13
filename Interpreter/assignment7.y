/*

    María Fernanda Hernández Enriquez
    A01329383

    Tarea 6

*/

%{
/*  Include statements  */
#include <stdio.h>
#include <math.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include "assignment7.tab.h"
#define NINGUNO -98765
extern FILE *yyin;
double ftype;
/* Type nodes of the syntactic tree */
enum Type_nodes {
  PROGRAM, 
  STATEMENT,
  STATEMENT_LIST,
  ASSIGN_STATEMENT, 
  IF_STATEMENT,
  IFELSE_STATEMENT,
  ITERATION_STATEMENT,
  CMP_STATEMENT, 
  EXPR, 
  TERM, 
  FACTOR, 
  EXPRESION, 
  SET,
  READ, 
  PRINT,
  IF, 
  IFELSE, 
  FOR,
  WHILE,  
  PLUS, 
  MINUS, 
  MULTIPLICATION, 
  DIVIDE,
  SMALLER_THAN,
  BIGGER_THAN,
  EQUAL,
  SMALLER_EQUAL,
  BIGGER_EQUAL,
  VALOR_INT_, 
  VALOR_FLOAT_, 
  ID_VALUE, 
  FUNCTION_VALUE, 
  PARAMETER_VALUE, 
  RETURN
};
/* Name of types node of the syntactic tree */
char* Type_node_label[] = {
  "PROGRAM", 
  "STATEMENT",
  "STATEMENT_LIST",
  "ASSIGN_STATEMENT", 
  "IF_STATEMENT",
  "IFELSE_STATEMENT",
  "ITERATION_STATEMENT",
  "CMP_STATEMENT", 
  "EXPR", 
  "TERM", 
  "FACTOR", 
  "EXPRESION", 
  "SET",
  "READ", 
  "PRINT",
  "IF", 
  "IFELSE", 
  "FOR",
  "WHILE",  
  "PLUS", 
  "MINUS", 
  "MULTIPLICATION", 
  "DIVIDE",
  "SMALLER_THAN",
  "BIGGER_THAN",
  "EQUAL",
  "SMALLER_EQUAL",
  "BIGGER_EQUAL",
  "VALOR_INT_", 
  "VALOR_FLOAT_", 
  "ID_VALUE", 
  "FUNCTION_VALUE", 
  "PARAMETER_VALUE", 
  "RETURN"
};

/* Symbol table functions */
void insert_table(struct SymbolTable**, char const *, int, int, struct SymbolTable*, struct SyntacticNode*);
void display_table(struct SymbolTable *, char*);
struct SymbolTable *table_head;
struct SymbolTable *function_head;
/* Syntactic tree functions */
struct SyntacticNode* add_node(int, double, char*, int, int, struct SyntacticNode*, struct SyntacticNode*, 
  struct SyntacticNode*, struct SyntacticNode*, struct SyntacticNode*);
struct FunctionNode *function_ptr;
void print_tree(struct SyntacticNode*, char*);
void display_tree(struct SyntacticNode*);
void cover_tree(struct SyntacticNode*);
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
%token IDENTIFIER
%token SEMICOLON
%token COLON
%token VAR_R
%token TO_R
%token STEP_R
%token DO_R
%token FOR_R
%token SET_R
%token TWO_POINTS 
%token INT_R
%token FLOAT_R
%token INTEGER_NUMBER
%token FLOATING_POINT_NUMBER
%token READ_R
%token PRINT_R 
%token IF_R
%token OPEN_PARENTHESES
%token CLOSE_PARENTHESES
%token OPEN_BRACKET
%token CLOSE_BRACKET
%token IF_ELSE_R
%token WHILE_R
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
%token RETURN_R
/* Types */
%type <syntatic_type> program
%type <syntatic_type> statement
%type <syntatic_type> assign_statement
%type <syntatic_type> if_statement
%type <syntatic_type> iteration_statement
%type <syntatic_type> cmp_statement
%type <syntatic_type> statement_list
%type <syntatic_type> optional_expressions
%type <syntatic_type> expression_list
%type <syntatic_type> expr
%type <syntatic_type> term
%type <syntatic_type> factor
%type <syntatic_type> expresion
%type <syntatic_type> PROGRAM_R
%type <syntatic_type> VAR_R
%type <syntatic_type> TO_R
%type <syntatic_type> STEP_R
%type <syntatic_type> DO_R
%type <syntatic_type> FOR_R
%type <syntatic_type> SET_R
%type <syntatic_type> READ_R
%type <syntatic_type> PRINT_R
%type <syntatic_type> IF_R
%type <syntatic_type> IF_ELSE_R 
%type <syntatic_type> WHILE_R
%type <syntatic_type> PLUS_SIGN
%type <syntatic_type> MINUS_SIGN
%type <syntatic_type> MULTIPLICATION_SIGN 
%type <syntatic_type> DIVISION_SIGN
%type <syntatic_type> SMALLER_THAN_SIGN
%type <syntatic_type> BIGGER_THAN_SIGN
%type <syntatic_type> EQUAL_SIGN
%type <syntatic_type> SMALLER_EQUAL_SIGN
%type <syntatic_type> BIGGER_EQUAL_SIGN
%type <syntatic_type> INTEGER_NUMBER
%type <syntatic_type> FLOATING_POINT_NUMBER
%type <syntatic_type> IDENTIFIER
%type <syntatic_type> OPEN_PARENTHESES
%type <syntatic_type> CLOSE_PARENTHESES
%type <syntatic_type> OPEN_BRACKET
%type <syntatic_type> CLOSE_BRACKET
%type <itype> type


%%

program: PROGRAM_R IDENTIFIER OPEN_BRACKET optional_declarations optional_function_declarations 
CLOSE_BRACKET statement {
    struct SyntacticNode* raiz_Arbol_Sintactico;
    raiz_Arbol_Sintactico = add_node(NINGUNO, NINGUNO, NULL, PROGRAM, NINGUNO, $7, NULL, NULL, NULL, NULL);
    //print_tree(raiz_Arbol_Sintactico, "main");
    //display_table(function_head, "main");
    //printf(" OUTPUT \n\n");
    cover_tree(raiz_Arbol_Sintactico);
display_table(function_head, "main");
    };
optional_declarations: declarations  
    | /* */ 
    ;
declarations: declaration SEMICOLON declarations  
    | declaration
    ;
declaration: VAR_R IDENTIFIER TWO_POINTS type { 
      insert_table(&function_head, (char*)$2, $4, NINGUNO, NULL, NULL); 
    };
type: INT_R { $$ = VALOR_INT_; }
    | FLOAT_R { $$ = VALOR_FLOAT_; }
    ;
optional_function_declarations: function_declarations 
    | /* */
    ;
function_declarations: function_declarations function_declaration 
    | function_declaration
    ;
function_declaration: FUNCTION_R IDENTIFIER OPEN_PARENTHESES optional_params CLOSE_PARENTHESES TWO_POINTS type OPEN_BRACKET optional_declarations CLOSE_BRACKET statement {
      insert_table(&function_head, (char*)$2, FUNCTION_VALUE, $7, table_head, $11);
	    table_head = NULL;
    }
    | FUNCTION_R IDENTIFIER OPEN_PARENTHESES optional_params CLOSE_PARENTHESES TWO_POINTS type SEMICOLON{
      insert_table(&function_head, (char*)$2, FUNCTION_VALUE, $7, table_head, NULL);
	    table_head = NULL;
    }
    ;
optional_params: params 
    | /* */
    ;
params: param COLON params 
    | param
    ;
param: VAR_R IDENTIFIER TWO_POINTS type { 
      insert_table(&table_head, (char*)$2, $4, NINGUNO, NULL, NULL); 
    };
statement: assign_statement { $$ = $1; }
    | if_statement { $$ = $1; }
    | iteration_statement { $$ = $1; }
    | cmp_statement { $$ = $1; }
    ;
assign_statement: SET_R IDENTIFIER  expr  SEMICOLON{ 
      struct SyntacticNode* idNode = add_node(NINGUNO, NINGUNO, (char *)$2, ID_VALUE, SET, NULL, NULL, NULL, NULL, NULL);
	    $$ = add_node(NINGUNO, NINGUNO, NULL, SET, STATEMENT, idNode, $3, NULL, NULL, NULL); 
    }
	  | READ_R IDENTIFIER SEMICOLON{ 
      struct SyntacticNode* idNode = add_node(NINGUNO, NINGUNO, (char *)$2, ID_VALUE, READ, NULL, NULL, NULL, NULL, NULL);
	    $$ = add_node(NINGUNO, NINGUNO, NULL, READ, STATEMENT, idNode, NULL, NULL, NULL, NULL);                  
	  }
    | PRINT_R expr SEMICOLON{ 
      $$ = add_node(NINGUNO, NINGUNO, NULL, PRINT, STATEMENT, $2, NULL, NULL, NULL, NULL); 
    }
    | RETURN_R expr SEMICOLON{ 
      $$ = add_node(NINGUNO, NINGUNO, NULL, RETURN, STATEMENT, $2, NULL, NULL, NULL, NULL); 
    }
    ;
if_statement: IF_R OPEN_PARENTHESES expresion CLOSE_PARENTHESES statement {
      $$ = add_node(NINGUNO, NINGUNO, NULL, IF, IF_STATEMENT, $3, $5, NULL, NULL, NULL);
    }
    | IF_ELSE_R OPEN_PARENTHESES expresion CLOSE_PARENTHESES statement statement {
      $$ = add_node(NINGUNO, NINGUNO, NULL, IFELSE, IFELSE_STATEMENT, $3, $5, $6, NULL, NULL);
    }
    ;
iteration_statement: WHILE_R OPEN_PARENTHESES expresion CLOSE_PARENTHESES statement {
      $$ = add_node(NINGUNO, NINGUNO, NULL, WHILE, ITERATION_STATEMENT, $3, $5, NULL, NULL, NULL);
    }
    | FOR_R SET_R IDENTIFIER expr TO_R expr STEP_R expr DO_R statement {
      struct SyntacticNode* idNode = add_node(NINGUNO, NINGUNO, (char *)$3, ID_VALUE, FOR, NULL, NULL, NULL, NULL, NULL);
      struct SyntacticNode* setNode = add_node(NINGUNO, NINGUNO, NULL, SET, FOR, idNode, $4, NULL, NULL, NULL);
      struct SyntacticNode* ltNode = add_node(NINGUNO, NINGUNO, NULL, SMALLER_EQUAL, EXPRESION, idNode, $6, NULL, NULL, NULL);
      struct SyntacticNode* stepNode = add_node(NINGUNO, NINGUNO, NULL, PLUS, EXPR, idNode, $8, NULL, NULL, NULL);
      struct SyntacticNode* setNode2 = add_node(NINGUNO, NINGUNO, NULL, SET, FOR, idNode, stepNode, NULL, NULL, NULL);
      $$ = add_node(NINGUNO, NINGUNO, NULL, FOR, ITERATION_STATEMENT, setNode, ltNode, setNode2, $10, NULL);
    }
    ;
cmp_statement: OPEN_BRACKET CLOSE_BRACKET { $$ = NULL; }
    | OPEN_BRACKET statement_list CLOSE_BRACKET { $$ = $2; }
    ;
statement_list: statement { $$ = $1; }
    | statement_list statement { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, STATEMENT_LIST, STATEMENT_LIST, $1, $2, NULL, NULL, NULL); 
    }
    ;
expr: expr PLUS_SIGN term { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, PLUS, EXPR, $1, $3, NULL, NULL, NULL); 
    }
	  | expr MINUS_SIGN term { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, MINUS, EXPR, $1, $3, NULL, NULL, NULL); 
    }
	  | term { $$ = $1; }
    ;
term: term MULTIPLICATION_SIGN factor { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, MULTIPLICATION, TERM, $1, $3, NULL, NULL, NULL); 
    }
    | term DIVISION_SIGN factor { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, DIVIDE, TERM, $1, $3, NULL, NULL, NULL); 
    }
    | factor { $$ = $1; }
    ; 
factor: OPEN_PARENTHESES expr CLOSE_PARENTHESES { $$ = $2; }
    | IDENTIFIER { 
      $$ = add_node(NINGUNO, NINGUNO, (char *)$1, ID_VALUE, FACTOR, NULL, NULL, NULL, NULL, NULL); 
    }
    | INTEGER_NUMBER { 
      $$ = add_node((int)$1, NINGUNO, NULL, VALOR_INT_, TERM, NULL, NULL, NULL, NULL, NULL); 
    }
    | FLOATING_POINT_NUMBER{ 
      $$ = add_node(NINGUNO, ftype, NULL, VALOR_FLOAT_, TERM, NULL, NULL, NULL, NULL, NULL); 
    }
    | IDENTIFIER OPEN_PARENTHESES optional_expressions CLOSE_PARENTHESES { 
      $$ = add_node(NINGUNO, NINGUNO, (char *)$1, FUNCTION_VALUE, TERM, $3, NULL, NULL, NULL, NULL); 
    }
    ;
optional_expressions: expression_list { $$ = $1; }
	  | /* */ { $$ = NULL; }
    ;
expression_list: expression_list COLON expr { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, PARAMETER_VALUE, ARG_LST, $3, $1, NULL, NULL, NULL); 
    }
	  | expr { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, PARAMETER_VALUE, ARG_LST, $1, NULL, NULL, NULL, NULL); 
    }
    ;
expresion: expr SMALLER_THAN_SIGN expr { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, SMALLER_THAN, EXPRESION, $1, $3, NULL, NULL, NULL); 
    }
    | expr BIGGER_THAN_SIGN expr { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, BIGGER_THAN, EXPRESION, $1, $3, NULL, NULL, NULL); 
    }
    | expr EQUAL_SIGN expr { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, EQUAL, EXPRESION, $1, $3, NULL, NULL, NULL); 
    }
    | expr SMALLER_EQUAL_SIGN expr { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, SMALLER_EQUAL, EXPRESION, $1, $3, NULL, NULL, NULL); 
    }
    | expr BIGGER_EQUAL_SIGN expr { 
      $$ = add_node(NINGUNO, NINGUNO, NULL, BIGGER_EQUAL, EXPRESION, $1, $3, NULL, NULL, NULL); 
    }
    ;
%%

/* Error codes */
#define VARIABLE_NOT_FOUND 1
#define INVALID_INT  2
#define INVALID_FLOAT  3
#define INCOMPATIBLE_VARIABLES  4
#define SET_ERROR 5
/* Error message */
#define MESSAGE_VARIABLE_NOT_FOUND "The variable doesn't exist."
#define MESSAGE_INVALID_INT "Can't assign float type to an int variable."
#define MESSAGE_INVALID_FLOAT "Can't assign int type to a float variable."
#define MESSAGE_INCOMPATIBLE_VARIABLES "Incompatible types."
#define MESSAGE_SET_ERROR "Incorrect parameter set."

void error_handle(int codigo_Error, char *texto_Error){
  printf("¡Ops! Error numero %d: %s\n", codigo_Error, texto_Error);
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
  return function_ptr -> flag; 
}
/*
    insert_table() function
*/
void insert_table(struct SymbolTable** ptr_ptr_table, char const *var_name, int var_type, int type_return, 
struct SymbolTable *table_ptr, struct SyntacticNode *root_ptr){
  struct SymbolTable* new_node = (struct SymbolTable*) malloc(sizeof(struct SymbolTable));
  new_node -> name = (char *) malloc(strlen(var_name) + 1);
  strcpy (new_node->name, var_name);
  new_node -> node_type = var_type;
  new_node -> return_type = type_return;
  new_node -> value.itype = 0;
  new_node -> table_ptr = table_ptr;
  new_node -> root_ptr = root_ptr;
  new_node -> next = (struct SymbolTable*)(*ptr_ptr_table);
  *ptr_ptr_table = new_node;
}
/*
    check_table() function
*/
struct SymbolTable* check_table(char const *var_name, struct SymbolTable* top_table_ptr){
  struct SymbolTable *current_ptr = top_table_ptr;
  while(current_ptr != NULL){ 
    assert(current_ptr -> name);
    if(strcmp(current_ptr -> name, var_name) == 0) {
      return current_ptr;
    }
    current_ptr = current_ptr -> next;
  }
  return NULL;
}
/*
    get_table() function
*/
struct SymbolTable* get_table(char const *var_name){
  struct SymbolTable *current_ptr = NULL;
  if(current_function()) {
    current_ptr = check_table(var_name, function_ptr->node_ptr->table_ptr);
  }
  if((current_function() && !current_ptr) || !current_function()) {
    current_ptr = check_table(var_name, function_head);
  }
  if(!current_ptr) {
    error_handle(VARIABLE_NOT_FOUND, MESSAGE_VARIABLE_NOT_FOUND);
  }
  return current_ptr;
}
/*
    print_node_table() function
*/
void print_node_table(struct SymbolTable *node){
  if(node == NULL) return;

  printf("   %s\t", node->name);
  if(node->node_type < sizeof(Type_node_label)){ 
    printf("%s", Type_node_label[node->node_type]);
  } 
  else { 
    printf("%s", node->node_type); 
  }

  switch(node->node_type){
    case VALOR_INT_:
      printf("\t%d\n", node->value.itype);
      break;
    case VALOR_FLOAT_:
      printf("\t%lf\n", node->value.ftype);
      break;
    case FUNCTION_VALUE:
      assert(node->return_type < sizeof(Type_node_label));
      printf("\t%s\n", Type_node_label[node->return_type]);
      display_table(node->table_ptr, node->name);
      print_tree(node->root_ptr, node->name);
      break;
  }
  //printf("Siguiente puntero \t\t=\t%p\n\n", node->next);
}
/*
    display_table() function
*/
void display_table(struct SymbolTable* top_table_ptr, char* name_table){
  printf(" TABLA DE SIMBOLOS (%s) \n\n", name_table);
  printf(" Simbolo  |   Tipo    |  Valor\n");
  struct SymbolTable *current_ptr = top_table_ptr;
  while(current_ptr != NULL){
    print_node_table(current_ptr);
    current_ptr = current_ptr -> next;
  }
}
/*
    set_int_table() function
*/
void set_int_table(char const *var_name, int new_value){
  struct SymbolTable *ptr = get_table(var_name);
  if(ptr != NULL){
    if(ptr -> node_type == VALOR_INT_){  
      ptr -> value.itype = new_value;
//printf("[%s = %d]\n", ptr->name, ptr->value.itype);
    } 
    else{ 
      error_handle(INVALID_INT , MESSAGE_INVALID_INT); 
    }
  } 
  else{ 
    error_handle(VARIABLE_NOT_FOUND, MESSAGE_VARIABLE_NOT_FOUND); 
  }
}
/*
    set_float_table() function
*/
void set_float_table(char const *var_name, double new_value){
  struct SymbolTable *ptr = get_table(var_name);
  if(ptr != NULL){
    if(ptr -> node_type == VALOR_FLOAT_){ 
      ptr -> value.ftype = new_value;
    } 
    else{ 
      error_handle(INVALID_FLOAT , MESSAGE_INVALID_FLOAT); 
    }
  }
}
/*
    set_a_function() function
*/
void set_a_function(struct SymbolTable* ptr){
  struct FunctionNode *new_function_ptr = (struct FunctionNode*) malloc(sizeof(struct FunctionNode));
  new_function_ptr -> node_ptr = ptr;
  new_function_ptr -> stack_ptr = function_ptr;
  new_function_ptr -> flag = 0;
  new_function_ptr -> value.itype = 0;
  function_ptr = new_function_ptr;
}
/*
    get_a_function() function
*/
void get_a_function(){
  struct FunctionNode* temp = function_ptr;
  function_ptr = function_ptr -> stack_ptr;
  free(temp);
}
/*
    print_call_function() function
*/
void print_call_function(){
  printf("Llamada actual a pila = \t");
  struct FunctionNode* temp = function_ptr;
  while(temp != NULL){
    printf("\t%s\n", temp->node_ptr->name);
    temp = temp->stack_ptr;
  }
  printf("\n");
  printf("\n");
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
struct SyntacticNode* add_node(int ivalue, double fvalue, char* id_name, 
  int node_type, int head_type_node, struct SyntacticNode* ptr1, struct SyntacticNode* ptr2, 
  struct SyntacticNode* ptr3, struct SyntacticNode* ptr4, struct SyntacticNode* next_node){
    struct SyntacticNode* new_node = (struct SyntacticNode*) malloc(sizeof(struct SyntacticNode));
    new_node->node_type = node_type;
    new_node->head_type_node = head_type_node;
    new_node->array_ptr[0] = ptr1;
    new_node->array_ptr[1] = ptr2;
    new_node->array_ptr[2] = ptr3;
    new_node->array_ptr[3] = ptr4;
    new_node->next = next_node;
    if(node_type == VALOR_INT_) { 
      new_node->value.itype = ivalue;
    } 
    else if(node_type == VALOR_FLOAT_) { 
      new_node->value.ftype = fvalue;
    } 
    else if(node_type == ID_VALUE) { 
      new_node->value.id_name = (char *) malloc(strlen(id_name) + 1);
      strcpy (new_node->value.id_name, id_name);
    } 
    else if(node_type == FUNCTION_VALUE){ 
      new_node->value.id_name = (char *) malloc(strlen(id_name) + 1);
      strcpy (new_node->value.id_name, id_name); 
    }
    return new_node;
}
/*
    print_node_tree() function
*/
void print_node_tree(int type, char* label){
  if(type >= 0 && type < sizeof(Type_node_label)){ 
    printf("%s \t\t=\t%s\n", label, Type_node_label[type]);
  } 
  else{ 
    printf("%s \t\t_\t%d\n", label, type); 
  }
}
/*
    print_tree() function
*/
void print_tree(struct SyntacticNode* root_ptr, char* name_function){
  printf(" ARBOL SINTACTICO %s \n\n", name_function);
  display_tree(root_ptr);
}
/*
    display_tree() function
*/
void display_tree(struct SyntacticNode* node){
  if(node == NULL) return;
  print_node_tree(node->node_type, "Tipo \t\t");
  print_node_tree(node->head_type_node, "head_type_node");

  if(node->node_type == VALOR_INT_){ 
    printf("Valor del nodo \t\t\t=\t%d\n", node->value.itype);
  } 
  else if(node->node_type == ID_VALUE){ 
    printf("Valor del nodo \t\t\t=\t%s\n", node->value.id_name);
  } 
  else if(node->node_type == VALOR_FLOAT_){ 
    printf("Valor del nodo \t\t\t=\t%f\n", node->value.ftype);
  } 
  else if(node->node_type == FUNCTION_VALUE){ 
    printf("Valor del nodo \t\t\t=\t%s\n", node->value.id_name);
  }
  int i = 0;
  for(i = 0; i < 4; i++) { 
    printf("Puntero numero %d \t\t=\t%p\n", i + 1, node->array_ptr[i]);
  }
  printf("\n");
  for(i = 0; i < 4; i++) {
    display_tree(node->array_ptr[i]);
  }
}
/*
    int_expression() function
*/
int int_expression(struct SyntacticNode* node){
  assert(node != NULL);
  if(node->node_type == PLUS){ 
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
  
  assert(node->node_type == VALOR_INT_ || node->node_type == ID_VALUE || node->node_type == FUNCTION_VALUE);
  int return_value = 0;
  if(node->node_type == VALOR_INT_){ 
    return_value = node->value.itype;
  } 
  else if(node->node_type == ID_VALUE){
    struct SymbolTable *current_node = get_table(node->value.id_name);
    assert(current_node->node_type == VALOR_INT_);
    return_value = current_node->value.itype;
  } 
  else if(node->node_type == FUNCTION_VALUE){
    aux_function(node);
    struct SymbolTable* current_function = check_table(node->value.id_name, function_head);
    assert(current_function->return_type == VALOR_INT_);    
    return_value = function_ptr->value.itype;
    get_a_function();
  }
  return return_value;
}
/*
    float_expression() function
*/
double float_expression(struct SyntacticNode* node){
  assert(node != NULL);
  if(node->node_type == PLUS){ 
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
  assert(node->node_type == ID_VALUE || node-> node_type == VALOR_FLOAT_ || node-> node_type == FUNCTION_VALUE);
  double return_value = 0;
  if(node->node_type == VALOR_FLOAT_){ 
    return_value = node->value.ftype;
  } 
  else if(node->node_type == ID_VALUE){
    struct SymbolTable *current_node = get_table(node->value.id_name);
    assert(current_node->node_type == VALOR_FLOAT_);
    return_value = current_node->value.ftype;
  } 
  else if(node-> node_type == FUNCTION_VALUE){
    aux_function(node);
    struct SymbolTable* current_function = check_table(node->value.id_name, function_head);
    assert(current_function->return_type == VALOR_FLOAT_);    
    return_value = function_ptr->value.ftype;
    get_a_function();
  }
  return return_value;
}
/*
    count_nodes() function
*/
int count_nodes(int type_node, struct SyntacticNode* node){
   int counter = 0;
  if(node == NULL) {
    return 0;
  }
  if(node->node_type == type_node){ 
    counter++;
  } 
  else if(node->node_type == ID_VALUE){ 
    struct SymbolTable* current_node = get_table(node->value.id_name);
    if(current_node->node_type == type_node){
      counter++;
    }
  }
  int i = 0;
  for(i = 0; i < 4; i++){ 
    counter += count_nodes(type_node, node->array_ptr[i]); 
  }
  return counter;
}
/*
    check_type() function
*/
int check_type(struct SyntacticNode* node){
  int counter_int = count_nodes(VALOR_INT_, node);
  int counter_float = count_nodes(VALOR_FLOAT_, node);
  if(counter_int > 0 && counter_float == 0){ 
    return VALOR_INT_;
  }
  else if(counter_int == 0 && counter_float > 0){
    return VALOR_FLOAT_;
  }
  error_handle(INCOMPATIBLE_VARIABLES , MESSAGE_INCOMPATIBLE_VARIABLES );
  return 0;
} 
/*
    is_int() function
*/
int is_int(struct SyntacticNode* node){ 
  return check_type(node) == VALOR_INT_; 
}
/*
    is_float() function
*/
int is_float(struct SyntacticNode* node){ 
  return check_type(node) == VALOR_FLOAT_; 
}
/*
    table_size() function
*/
int table_size(char const *name){
  struct SymbolTable* ptr = check_table(name, function_head);
  assert(ptr);
  struct SymbolTable* current_ptr = ptr->table_ptr;
  int size = 0;
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
  if(!node){
    return 0;
  }
  int counter = 0;
  if(deep_node <= 1) {
    counter += (node->node_type == PARAMETER_VALUE);
  }
  int i = 0;
  for(i = 0; i < 4; i++) {
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
  struct SyntacticNode *ptr_param = NULL;
  if((*ptr_ptr_function)->node_type == FUNCTION_VALUE){
    assert((*ptr_ptr_function)->array_ptr[0]);
    ptr_param = (*ptr_ptr_function)->array_ptr[0]->array_ptr[0];
  } 
  else {
    assert((*ptr_ptr_function)->node_type == PARAMETER_VALUE);
     ptr_param = (*ptr_ptr_function)->array_ptr[0]; 
  }
  (*ptr_ptr_function) = (*ptr_ptr_function)->array_ptr[0]->array_ptr[1];
  assert(ptr_param);
  return ptr_param;
}
/*
    check_param() function
*/
int check_param(struct SyntacticNode* node){
  int size_function = table_size(node->value.id_name);
  printf("Longitud Tabla de Simbolos = \t%d\n", size_function);
  int total_params = params_size(node, 0);
  printf("Cantidad de Parametros = \t%d\n", total_params);
  assert(size_function >= total_params);
  struct SymbolTable* current_ptr = check_table(node->value.id_name, function_head)->table_ptr;
  next_function(&current_ptr, size_function - total_params);
  struct SyntacticNode* function_ptr = node;
  struct SyntacticNode* param_ptr = NULL;
  int i = 0;
  for(i = 0; i < total_params; i++){
    param_ptr = get_param(&function_ptr);
    assert(current_ptr);
    assert(param_ptr);
    if((is_int(param_ptr) && current_ptr->node_type != VALOR_INT_) || 
    (is_float(param_ptr) && current_ptr->node_type != VALOR_FLOAT_)) {
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
  struct SymbolTable* current_ptr = check_table(node->value.id_name, function_head)->table_ptr;
  next_function(&current_ptr, size_function - total_params);
  struct SyntacticNode* function_ptr = node;
  struct SyntacticNode* param_ptr = NULL;
  int i = 0;
  for(i = 0; i < total_params; i++){
    param_ptr = get_param(&function_ptr);
    assert(current_ptr);
    assert(param_ptr);
    if(current_ptr->node_type == VALOR_INT_){
      current_ptr->value.itype = int_expression(param_ptr);
    } 
    else{
      assert(current_ptr->node_type == VALOR_FLOAT_);
      current_ptr->value.ftype = float_expression(param_ptr);
    }
    current_ptr = current_ptr->next;
  }
}
/*
    aux_function() function
*/
void aux_function(struct SyntacticNode* node){
  if(!check_param(node)){ 
    error_handle(SET_ERROR, MESSAGE_SET_ERROR); 
  }
  set_param(node);
  struct SymbolTable* var_function = check_table(node->value.id_name, function_head);
  set_a_function(var_function);
  print_call_function();
  cover_tree(var_function->root_ptr);
}
/*
    print_function() function
*/
void print_function(struct SyntacticNode* node) {
  assert(node->array_ptr[0] != NULL);
  if(node->array_ptr[0]->node_type == VALOR_INT_) { 
    printf("%d\n", node->array_ptr[0]->value.itype);
  } 
  else if(node->array_ptr[0]->node_type == VALOR_FLOAT_) { 
    printf("%f\n", node->array_ptr[0]->value.ftype);
  } 
  else if(node->array_ptr[0]->head_type_node == EXPR 
  || node->array_ptr[0]->head_type_node == TERM 
  || node->array_ptr[0]->head_type_node == FACTOR) {
    if(node->array_ptr[0]->node_type == FUNCTION_VALUE) { 
      aux_function(node->array_ptr[0]);
      struct SymbolTable* current_function = check_table(node->array_ptr[0]->value.id_name, function_head);
      if(current_function->return_type == VALOR_INT_){ 
        printf("%d\n", function_ptr->value.itype);
      } 
      else{
        assert(current_function->return_type == VALOR_FLOAT_);
        printf("%lf\n", function_ptr->value.ftype);
      }
      get_a_function();
    } 
    else{ 
      if(is_int(node->array_ptr[0])){ 
        printf("%d\n", int_expression(node->array_ptr[0]));
      } 
      else{
        assert(is_float(node->array_ptr[0]));
        printf("%lf\n", float_expression(node->array_ptr[0]));
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
    if(node->array_ptr[1] != NULL) {
      cover_tree(node->array_ptr[1]);
    }
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
    case VALOR_INT_:
      set_ivalue = int_expression(node->array_ptr[1]);
      set_int_table(current_node->name, set_ivalue);
      assert(set_ivalue == current_node->value.itype);
      break;
    case VALOR_FLOAT_:
      set_fvalue = float_expression(node->array_ptr[1]);
      set_float_table(current_node->name, set_fvalue);
      assert(set_fvalue == current_node->value.ftype);
      break;
  }
}
/*
    read_int() function
*/
int read_int(){
  int new_value = -1;
  printf("Asigna valor entero = ");
  int x = scanf("%d", &new_value);
  assert(x > 0);
  return new_value;
}
/*
    read_float() function
*/
double read_float(){
  double new_value = -1.0;
  printf("Asigna valor flotante = ");
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
    case VALOR_INT_:
      set_ivalue = read_int();
      set_int_table(current_node->name, set_ivalue);
      assert(set_ivalue == current_node->value.itype);
      break;
    case VALOR_FLOAT_:
      set_fvalue = read_float();
      set_float_table(current_node->name, set_fvalue);
      assert(set_fvalue == current_node->value.ftype);
      break;
  }
}
/*
    return_function() function
*/
void return_function(struct SyntacticNode* node){
  assert(node -> array_ptr[0] != NULL);
  struct FunctionNode* current_function = function_ptr;
  if(node -> array_ptr[0] -> node_type == VALOR_INT_){
    assert(current_function -> node_ptr -> return_type == VALOR_INT_);
    current_function -> node_ptr -> value.itype = node -> array_ptr[0] -> value.itype;
  } 
  else if(node -> array_ptr[0] -> node_type == VALOR_FLOAT_){
    assert(current_function -> node_ptr -> return_type == VALOR_FLOAT_);
    current_function -> node_ptr -> value.ftype = node -> array_ptr[0] -> value.ftype;
  } 
  else if(node -> array_ptr[0] -> head_type_node == EXPR 
  || node -> array_ptr[0] -> head_type_node == TERM 
  || node -> array_ptr[0] -> head_type_node == FACTOR){
    if(node -> array_ptr[0] -> node_type == FUNCTION_VALUE){} 
    else{ 
      if(is_int(node -> array_ptr[0])){
        assert(current_function -> node_ptr -> return_type == VALOR_INT_);
        current_function -> node_ptr -> value.itype = int_expression(node -> array_ptr[0]);
      } else{
        assert(is_float(node -> array_ptr[0]));
        assert(current_function -> node_ptr -> return_type == VALOR_FLOAT_);
        current_function -> node_ptr -> value.ftype = float_expression(node -> array_ptr[0]);
      }
    }
  }
  function_ptr -> flag = 1;
}
/*
    cover_tree() function
*/
void cover_tree(struct SyntacticNode* nodo){
  if(nodo == NULL) return;

  if(current_function() && get_flag()) return;

  switch(nodo->node_type){
  	case PROGRAM:
      break;

    case PRINT:
      print_function(nodo);
      break;

    case IF:
      if_function(nodo);
      break;

    case IFELSE:
      ifelse_function(nodo);
      break;

    case WHILE:
      while_function(nodo);
      break;

    case SET:
      set_function(nodo);
      break;

    case READ:
      read_function(nodo);
      break;
    
    case RETURN:
      return_function(nodo);
      break;
  } 

  if(nodo->node_type != IF && nodo->node_type != IFELSE && nodo->node_type != WHILE){
    int i;
    for(i = 0; i < 4; i++) {
      cover_tree(nodo->array_ptr[i]);
    }
  }
}
/*
    yyerror() function
*/
int yyerror(char const * s) {
  fprintf(stderr, "Error = \t%s\n", s);
  return 0;
}
/*
    input_handle() function
*/
void input_handle(int argc, char **argv){
    if(argc > 1){ yyin = fopen(argv[1], "r");
    } else{ yyin = stdin; }
}
/*************
    MAIN
*************/
int main(int argc, char **argv) {
  input_handle(argc, argv);
  yyparse();
  return 0;
}
