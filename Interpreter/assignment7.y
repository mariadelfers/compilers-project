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
  BEGIN, 
  STMT, 
  SET, 
  EXPR, 
  TERM, 
  FACTOR, 
  READ, 
  PRINT, 
  IF, 
  EXPRESION, 
  IFELSE, 
  WHILE, 
  STMT_LST, 
  ADD, 
  SUBSTRACT, 
  MULTIPLY, 
  SLASH, 
  LESSTHAN, 
  GREATTHAN, 
  EQUAL, 
  LESSEQUAL, 
  GREATEQUAL, 
  VALOR_INT_, 
  VALOR_FLOAT_, 
  ID_VALUE, 
  FUNCTION_VALUE, 
  PARAMETER_VALUE, 
  ARG_LST, 
  END, 
  RETURN
};
/* Name of types node of the syntactic tree */
char* Type_node_label[] = {
  "BEGIN",
  "STMT", 
  "SET", 
  "EXPR", 
  "TERM", 
  "FACTOR", 
  "READ", 
  "PRINT", 
  "IF", 
  "EXPRESION", 
  "IFELSE", 
  "WHILE", 
  "STMT_LST", 
  "ADD", 
  "SUBSTRACT", 
  "MULTIPLY", 
  "SLASH", 
  "LESSTHAN", 
  "GREATTHAN", 
  "EQUAL", 
  "LESSEQUAL", 
  "GREATEQUAL", 
  "VALOR_INT_", 
  "VALOR_FLOAT_", 
  "ID_VALUE", 
  "FUNCTION_VALUE", 
  "PARAMETER_VALUE", 
  "ARG_LST", 
  "END", 
  "RETURN"};

/* Symbol table functions */
struct SymbolTable *function_head;
struct SymbolTable *table_head;

void insert_table(struct SymbolTable**, char const *, int, int, struct SymbolTable*, struct SymbolTable*);
void display_table(struct SymbolTable *, char*);

/* Syntactic tree functions */
struct SyntacticNode* add_node(int, double, char*, int, int, struct SyntacticNode*, struct SyntacticNode*, 
  struct SyntacticNode*, struct SyntacticNode*, struct SyntacticNode*);
struct FunctionNode *function_ptr;
void print_tree(struct SyntacticNode*, char*);
void display_tree(struct SyntacticNode*);
void cover_tree(struct SyntacticNode*);
void get_function();
void set_function(struct SymbolTable*);
void aux_function(struct SyntacticNode*);

%}

%start prog 

%union { 
  int itype; 
  double ftype; 
  char* id_name; 
  struct SyntacticNode* arbol_valor; 
  struct SymbolTable* tabla_De_Simbolos_Valor; 
}
/* Tokens */
%token RETURN_BEGIN
%token RETURN_END
%token IDENTIFIER
%token ASCII_SCOLON
%token RETURN_VARIABLE
%token ASCII_COLON 
%token RETURN_INT
%token RETURN_FLOAT
%token INTEGER_NUMBER
%token FLOATING_POINT_NUMBER
%token ASCII_SET
%token RETURN_READ
%token RETURN_PRINT 
%token RETURN_IF
%token ASCII_PARENTHESES_1
%token ASCII_PARENTHESES_2
%token RETURN_IFELSE
%token RETURN_WHILE
%token ASCII_ADD
%token ASCII_SUBSTRACT
%token ASCII_MULTIPLY
%token ASCII_SLASH
%token ASCII_LESSTHAN
%token ASCII_GREATTHAN
%token ASCII_EQUAL 
%token ASCII_LESSEQUAL
%token ASCII_GREATEQUAL
%token RETURN_FUNCTION
%token ASCII_COMMA
%token RETURN_RETURN
/* Types */
%type <arbol_valor> prog
%type <arbol_valor> stmt
%type <arbol_valor> opt_stmts
%type <arbol_valor> stmt_lst
%type <arbol_valor> expr
%type <arbol_valor> term
%type <arbol_valor> factor
%type <arbol_valor> expresion
%type <arbol_valor> RETURN_BEGIN
%type <arbol_valor> RETURN_END 
%type <arbol_valor> RETURN_VARIABLE
%type <arbol_valor> ASCII_SET
%type <arbol_valor> RETURN_READ
%type <arbol_valor> RETURN_PRINT
%type <arbol_valor> RETURN_IF
%type <arbol_valor> RETURN_IFELSE 
%type <arbol_valor> RETURN_WHILE
%type <arbol_valor> ASCII_ADD
%type <arbol_valor> ASCII_SUBSTRACT
%type <arbol_valor> ASCII_MULTIPLY 
%type <arbol_valor> ASCII_SLASH
%type <arbol_valor> ASCII_LESSTHAN
%type <arbol_valor> ASCII_GREATTHAN
%type <arbol_valor> ASCII_EQUAL
%type <arbol_valor> ASCII_LESSEQUAL
%type <arbol_valor> ASCII_GREATEQUAL
%type <arbol_valor> INTEGER_NUMBER
%type <arbol_valor> FLOATING_POINT_NUMBER
%type <arbol_valor> IDENTIFIER
%type <arbol_valor> ASCII_PARENTHESES_1
%type <arbol_valor> ASCII_PARENTHESES_2
%type <itype> tipo
%type <arbol_valor> opt_args
%type <arbol_valor> arg_lst

%%

/* Gramatic */
prog: opt_decls opt_fun_decls RETURN_BEGIN opt_stmts RETURN_END {
    struct SyntacticNode* raiz_Arbol_Sintactico;
    raiz_Arbol_Sintactico = add_node(NINGUNO, NINGUNO, NULL, BEGIN, NINGUNO, $4, NULL, NULL, NULL, NULL);
    print_tree(raiz_Arbol_Sintactico, "main");
    display_table(function_head, "main");
    printf(" OUTPUT \n\n");
    cover_tree(raiz_Arbol_Sintactico);
};

opt_decls: decls | /* */ 
;

decls: dec ASCII_SCOLON decls | dec 
;

dec: RETURN_VARIABLE IDENTIFIER ASCII_COLON tipo { insert_table(&function_head, (char*)$2, $4, NINGUNO, NULL, NULL); }
;

tipo: RETURN_INT
	 { $$ = VALOR_INT_; }
	 | RETURN_FLOAT
	 { $$ = VALOR_FLOAT_; }
;

opt_fun_decls: fun_decls | /* */
;

fun_decls: fun_dec ASCII_SCOLON fun_decls | fun_dec
;

fun_dec: RETURN_FUNCTION IDENTIFIER ASCII_PARENTHESES_1 opt_params ASCII_PARENTHESES_2 ASCII_COLON tipo opt_decls_for_function RETURN_BEGIN opt_stmts RETURN_END
	{
	insert_table(&function_head, (char*)$2, FUNCTION_VALUE, $7, table_head, $10);
	table_head = NULL;
	}
;

opt_params: param_lst | /* */
;

param_lst: param ASCII_COMMA param_lst | param
;

param: IDENTIFIER ASCII_COLON tipo { insert_table(&table_head, (char*)$1, $3, NINGUNO, NULL, NULL); }
;

opt_decls_for_function: decls_for_function | /* */
;

decls_for_function: dec_for_function ASCII_SCOLON decls_for_function | dec_for_function
;

dec_for_function: RETURN_VARIABLE IDENTIFIER ASCII_COLON tipo { insert_table(&table_head, (char*)$2, $4, NINGUNO, NULL, NULL); }
;

stmt: IDENTIFIER ASCII_SET expr 
	 { struct SyntacticNode* idNode = add_node(NINGUNO, NINGUNO, (char *)$1, ID_VALUE, SET, NULL, NULL, NULL, NULL, NULL);
	  $$ = add_node(NINGUNO, NINGUNO, NULL, SET, STMT, idNode, $3, NULL, NULL, NULL);    
	 }
	| RETURN_IF ASCII_PARENTHESES_1 expresion ASCII_PARENTHESES_2 stmt { $$ = add_node(NINGUNO, NINGUNO, NULL, IF, STMT, $3, $5, NULL, NULL, NULL); }
	| RETURN_IFELSE ASCII_PARENTHESES_1 expresion ASCII_PARENTHESES_2 stmt stmt { $$ = add_node(NINGUNO, NINGUNO, NULL, IFELSE, STMT, $3, $5, $6, NULL, NULL); }
	| RETURN_WHILE ASCII_PARENTHESES_1 expresion ASCII_PARENTHESES_2 stmt { $$ = add_node(NINGUNO, NINGUNO, NULL, WHILE, STMT, $3, $5, NULL, NULL, NULL); }
	| RETURN_READ IDENTIFIER
	{ struct SyntacticNode* idNode = add_node(NINGUNO, NINGUNO, (char *)$2, ID_VALUE, READ, NULL, NULL, NULL, NULL, NULL);
	 $$ = add_node(NINGUNO, NINGUNO, NULL, READ, STMT, idNode, NULL, NULL, NULL, NULL);                  
	}
	| RETURN_PRINT expr { $$ = add_node(NINGUNO, NINGUNO, NULL, PRINT, STMT, $2, NULL, NULL, NULL, NULL); }
	| RETURN_BEGIN opt_stmts RETURN_END { $$ = $2; }
	| RETURN_RETURN expr { $$ = add_node(NINGUNO, NINGUNO, NULL, RETURN, STMT, $2, NULL, NULL, NULL, NULL); }
;

opt_stmts: stmt_lst { $$ = $1; }
	| /* */ { $$ = NULL; }
;

stmt_lst: stmt ASCII_SCOLON stmt_lst { $$ = add_node(NINGUNO, NINGUNO, NULL, STMT_LST, STMT_LST, $3, $1, NULL, NULL, NULL); }
	| stmt { $$ = $1; }
;

expresion: expr { $$ = 1; }
	| expr ASCII_LESSTHAN expr { $$ = add_node(NINGUNO, NINGUNO, NULL, LESSTHAN, EXPRESION, $1, $3, NULL, NULL, NULL); }
	| expr ASCII_GREATTHAN expr { $$ = add_node(NINGUNO, NINGUNO, NULL, GREATTHAN, EXPRESION, $1, $3, NULL, NULL, NULL); }
	| expr ASCII_EQUAL expr { $$ = add_node(NINGUNO, NINGUNO, NULL, EQUAL, EXPRESION, $1, $3, NULL, NULL, NULL); }
	| expr ASCII_LESSEQUAL expr { $$ = add_node(NINGUNO, NINGUNO, NULL, LESSEQUAL, EXPRESION, $1, $3, NULL, NULL, NULL); }
	| expr ASCII_GREATEQUAL expr { $$ = add_node(NINGUNO, NINGUNO, NULL, GREATEQUAL, EXPRESION, $1, $3, NULL, NULL, NULL); }
;

expr: expr ASCII_ADD term { $$ = add_node(NINGUNO, NINGUNO, NULL, ADD, EXPR, $1, $3, NULL, NULL, NULL); }
	| expr ASCII_SUBSTRACT term { $$ = add_node(NINGUNO, NINGUNO, NULL, SUBSTRACT, EXPR, $1, $3, NULL, NULL, NULL); }
	| term { $$ = $1; }
;

term: term ASCII_MULTIPLY factor { $$ = add_node(NINGUNO, NINGUNO, NULL, MULTIPLY, TERM, $1, $3, NULL, NULL, NULL); }
	| term ASCII_SLASH factor { $$ = add_node(NINGUNO, NINGUNO, NULL, SLASH, TERM, $1, $3, NULL, NULL, NULL); }
	| factor { $$ = $1; }
; 

factor: ASCII_PARENTHESES_1 expr ASCII_PARENTHESES_2 { $$ = $2; }
	| IDENTIFIER { $$ = add_node(NINGUNO, NINGUNO, (char *)$1, ID_VALUE, FACTOR, NULL, NULL, NULL, NULL, NULL); }
	| INTEGER_NUMBER { $$ = add_node((int)$1, NINGUNO, NULL, VALOR_INT_, TERM, NULL, NULL, NULL, NULL, NULL); }
	| FLOATING_POINT_NUMBER{ $$ = add_node(NINGUNO, ftype, NULL, VALOR_FLOAT_, TERM, NULL, NULL, NULL, NULL, NULL); }
	| IDENTIFIER ASCII_PARENTHESES_1 opt_args ASCII_PARENTHESES_2 { $$ = add_node(NINGUNO, NINGUNO, (char *)$1, FUNCTION_VALUE, TERM, $3, NULL, NULL, NULL, NULL); }
;

opt_args: arg_lst { $$ = $1; }
	| /* */ { $$ = NULL; }
;

arg_lst: expr ASCII_COMMA arg_lst { $$ = add_node(NINGUNO, NINGUNO, NULL, PARAMETER_VALUE, ARG_LST, $1, $3, NULL, NULL, NULL); }
	| expr { $$ = add_node(NINGUNO, NINGUNO, NULL, PARAMETER_VALUE, ARG_LST, $1, NULL, NULL, NULL, NULL); }
;
%%

/* Error codes */
#define SIMBOLO_INCORRECTO 1
#define ASIGNACION_INT_INVALIDA 2
#define ASIGNACION_FLOAT_INVALIDA  3
#define TIPO_DATO_ERRONEO 4
#define ASIGNACION_ERRONEA 5
/* Error message */
#define SIMBOLO_INCORRECTO_TEXTO "Error. Simbolo inexistente."
#define ASIGNACION_INT_INVALIDA_TEXTO "Error. Asignacion de int en float."
#define ASIGNACION_FLOAT_INVALIDA_TEXTO "Error. Asignacion de float en int."
#define TIPO_DATO_ERRONEO_TEXTO "Error .Operacion con mas de un tipo de dato."
#define ASIGNACION_ERRONEA_TEXTO "Error. Conjunto de parametros incorrecto"

void manejador_De_Errores(int codigo_Error, char *texto_Error){
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
  new_node -> type = var_type;
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
    manejador_De_Errores(SIMBOLO_INCORRECTO, SIMBOLO_INCORRECTO_TEXTO);
  }
  return current_ptr;
}
/*
    print_node_table() function
*/
void print_node_table(struct SymbolTable *node){
  if(node == NULL) return;

  printf("Simbolo \t\t\t=\t%s\n", node->name);
  if(node->node_type < sizeof(Type_node_label)){ 
    printf("Tipo \t\t\t\t=\t%s\n", Type_node_label[node->node_type]);
  } 
  else { 
    printf("Tipo \t\t\t\t=\t%d\n", node->node_type); 
  }

  switch(node->node_type){
    case VALOR_INT_:
      printf("Valor \t\t\t\t=\t%d\n", node->value.itype);
      break;
    case VALOR_FLOAT_:
      printf("Valor \t\t\t\t=\t%lf\n", node->value.ftype);
      break;
    case FUNCTION_VALUE:
      assert(node->return_type < sizeof(Type_node_label));
      printf("Tipo regresado \t\t=\t%s\n\n", Type_node_label[node->return_type]);
      display_table(node->table_ptr, node->name);
      print_tree(node->root_ptr, node->name);
      break;
  }
  printf("Siguiente puntero \t\t=\t%p\n\n", node->next);
}
/*
    display_table() function
*/
void display_table(struct SymbolTable* top_table_ptr, char* name_table){
  printf(" TABLA DE SIMBOLOS %s \n\n", name_table);
  struct SymbolTable *current_ptr = top_table_ptr;
  while(current_ptr != NULL){
    print_node_table(current_ptr);
    current_ptr = current_ptr -> next;
  }
}
/*
    get_int_table() function
*/
void get_int_table(char const *var_name, int new_value){
  struct SymbolTable *ptr = get_table(var_name);
  if(ptr != NULL){
    if(ptr -> node_type == VALOR_INT_){ 
      ptr -> value.itype = new_value;
    } 
    else{ 
      manejador_De_Errores(ASIGNACION_INT_INVALIDA, ASIGNACION_INT_INVALIDA_TEXTO); 
    }
  } 
  else{ 
    manejador_De_Errores(SIMBOLO_INCORRECTO, SIMBOLO_INCORRECTO_TEXTO); 
  }
}
/*
    get_float_table() function
*/
void get_float_table(char const *var_name, double new_value){
  struct SymbolTable *ptr = get_table(var_name);
  if(ptr != NULL){
    if(ptr -> node_type == VALOR_FLOAT_){ 
      ptr -> value.ftype = new_value;
    } 
    else{ 
      manejador_De_Errores(ASIGNACION_FLOAT_INVALIDA, ASIGNACION_FLOAT_INVALIDA_TEXTO); 
    }
  }
}
/*
    set_function() function
*/
void set_function(struct SymbolTable* ptr){
  struct FunctionNode *new_function_ptr = (struct FunctionNode*) malloc(sizeof(struct FunctionNode));
  new_function_ptr -> node_ptr = ptr;
  new_function_ptr -> stack_ptr = function_ptr;
  new_function_ptr -> flag = 0;
  new_function_ptr -> value.itype = 0;
  function_ptr = new_function_ptr;
}
/*
    get_function() function
*/
void get_function(){
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
  struct SyntacticNode* ptr4, struct SyntacticNode* ptr4, struct SyntacticNode* next_node){
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
  if(node->node_type == ADD){ 
    return int_expression(node->array_ptr[0]) + int_expression(node->array_ptr[1]);
  } 
  else if(node->node_type == SUBSTRACT){ 
    return int_expression(node->array_ptr[0]) - int_expression(node->array_ptr[1]);
  } 
  else if(node->node_type == MULTIPLY){ 
    return int_expression(node->array_ptr[0]) * int_expression(node->array_ptr[1]);
  } 
  else if(node->node_type == SLASH){ 
    return int_expression(node->array_ptr[0]) / int_expression(node->array_ptr[1]); 
  }
  
  assert(node->node_type == VALOR_INT_ || node->node_type == ID_VALUE || node->node_type == FUNCTION_VALUE);
  int return_value = 0;
  if(node->node_type == VALOR_INT_){ 
    return_value = node->value.itype;
  } 
  else if(node->node_type == ID_VALUE){
    struct SymbolTable *current_node = get_table(node->value.id_name);
    assert(current_node->type == VALOR_INT_);
    return_value = current_node->value.itype;
  } 
  else if(node->node_type == FUNCTION_VALUE){
    aux_function(node);
    struct SymbolTable* current_function = check_table(node->value.id_name, function_head);
    assert(current_function->return_type == VALOR_INT_);    
    return_value = function_ptr->value.itype;
    get_function();
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
  else if(node->node_type == SUBSTRACT){ 
    return float_expression(node->array_ptr[0]) - float_expression(node->array_ptr[1]);
  } 
  else if(node->node_type == MULTIPLY){ 
    return float_expression(node->array_ptr[0]) * float_expression(node->array_ptr[1]);
  } 
  else if(node->node_type == SLASH){ 
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
    get_function();
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
    counter += count_nodes(type_node, nodo->array_ptr[i]); 
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
  manejador_De_Errores(TIPO_DATO_ERRONEO, TIPO_DATO_ERRONEO_TEXTO);
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
    manejador_De_Errores(ASIGNACION_ERRONEA, ASIGNACION_ERRONEA_TEXTO); 
  }
  set_param(node);
  struct SymbolTable* var_function = check_table(node->value.id_name, function_head);
  set_function(var_function);
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
      get_function();
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
int expression_function(struct SyntacticNode* nodo_Expresion){
  assert(nodo_Expresion->array_ptr[0] != NULL);
  assert(nodo_Expresion->array_ptr[1] != NULL);
  if(is_int(nodo_Expresion->array_ptr[0])){
    assert(is_int(nodo_Expresion->array_ptr[1]));
    int int_Izq = int_expression(nodo_Expresion->array_ptr[0]);
    int int_Der = int_expression(nodo_Expresion->array_ptr[1]);
    switch(nodo_Expresion->node_type){
      case LESSTHAN:
        return int_Izq < int_Der;
      case GREATTHAN:
        return int_Izq > int_Der;
      case EQUAL:
        return int_Izq == int_Der;
      case LESSEQUAL:
        return int_Izq <= int_Der;
      case GREATEQUAL:
        return int_Izq >= int_Der;
    }
  }
  else{
    assert(is_float(nodo_Expresion->array_ptr[0]));
    assert(is_float(nodo_Expresion->array_ptr[1]));
    double double_Izq = float_expression(nodo_Expresion->array_ptr[0]);
    int double_Der = float_expression(nodo_Expresion->array_ptr[1]);
    switch(nodo_Expresion->node_type){
      case LESSTHAN:
        return double_Izq < double_Der;
      case GREATTHAN:
        return double_Izq > double_Der;
      case EQUAL:
        return double_Izq == double_Der;
      case LESSEQUAL:
        return double_Izq <= double_Der;
      case GREATEQUAL:
        return double_Izq >= double_Der;
    }
  }
  assert(NULL);
  return -1;
}
/*
    while_function() function
*/
void while_function(struct SyntacticNode* nodo_While){
  assert(nodo_While->array_ptr[0] != NULL);
  while(expression_function(nodo_While->array_ptr[0])){
    cover_tree(nodo_While->array_ptr[1]);
  }
}
/*
    if_function() function
*/
void if_function(struct SyntacticNode* nodo_if){
  assert(nodo_if->array_ptr[0] != NULL);
  if(expression_function(nodo_if->array_ptr[0])){
    if(nodo_if->array_ptr[1] != NULL) cover_tree(nodo_if->array_ptr[1]);
  }
}
/*
    ifelse_function() function
*/
void ifelse_function(struct SyntacticNode* nodo_IfElse){
  assert(nodo_IfElse->array_ptr[0] != NULL);
  if(expression_function(nodo_IfElse->array_ptr[0])){ 
    cover_tree(nodo_IfElse->array_ptr[1]);
  } 
  else{ 
    cover_tree(nodo_IfElse->array_ptr[2]);
  }
}
/*
    set_function() function
*/
void set_function(struct SyntacticNode* nodo_Set){
  assert(nodo_Set->array_ptr[0] != NULL);
  assert(nodo_Set->array_ptr[1] != NULL);
  struct SymbolTable* nodo_Actl = get_table(nodo_Set->array_ptr[0]->value.id_name);
  assert(nodo_Actl != NULL);
  int expr_Valor_a_Set;
  double expr_valordoble_a_Set;
  switch(nodo_Actl->node_type){
    case VALOR_INT_:
      expr_Valor_a_Set = int_expression(nodo_Set->array_ptr[1]);
      get_int_table(nodo_Actl->name, expr_Valor_a_Set);
      assert(expr_Valor_a_Set == nodo_Actl->value.itype);
      break;
    case VALOR_FLOAT_:
      expr_valordoble_a_Set = float_expression(nodo_Set->array_ptr[1]);
      get_float_table(nodo_Actl->name, expr_valordoble_a_Set);
      assert(expr_valordoble_a_Set == nodo_Actl->value.ftype);
      break;
  }
}
/*
    read_int() function
*/
int read_int(){
  int valor_int = -1;
  printf("Asigna valor a Int = ");
  int scanf_valor_retorna = scanf("%d", &valor_int);
  assert(scanf_valor_retorna > 0);
  return valor_int;
}
/*
    read_float() function
*/
double read_float(){
  double ftype = -1.0;
  printf("Asigna valor a Float = ");
  int scanf_valor_retorna = scanf("%lf", &ftype);
  assert(scanf_valor_retorna > 0);
  return ftype;
}
/*
    read_function() function
*/
void read_function(struct SyntacticNode* nodo_Leer){
  assert(nodo_Leer->array_ptr[0] != NULL);
  struct SymbolTable* nodo_Actl = get_table(nodo_Leer->array_ptr[0]->value.id_name);
  int valor_a_set;
  double valordoble_a_set;
  switch(nodo_Actl->node_type){
    case VALOR_INT_:
      valor_a_set = read_int();
      get_int_table(nodo_Actl->name, valor_a_set);
      assert(valor_a_set == nodo_Actl->value.itype);
      break;
    case VALOR_FLOAT_:
      valordoble_a_set = read_float();
      get_float_table(nodo_Actl->name, valordoble_a_set);
      assert(valordoble_a_set == nodo_Actl->value.ftype);
      break;
  }
}
/*
    return_function() function
*/
void return_function(struct SyntacticNode* nodo_Return){
  assert(nodo_Return->array_ptr[0] != NULL);
  struct FunctionNode* funcion_actual = function_ptr;
  if(nodo_Return->array_ptr[0]->node_type == VALOR_INT_){
    assert(funcion_actual->node_ptr->return_type == VALOR_INT_);
    funcion_actual->node_ptr->value.itype = nodo_Return->array_ptr[0]->value.itype;
  } else if(nodo_Return->array_ptr[0]->node_type == VALOR_FLOAT_){
    assert(funcion_actual->node_ptr->return_type == VALOR_FLOAT_);
    funcion_actual->node_ptr->value.ftype = nodo_Return->array_ptr[0]->value.ftype;
  } else if(nodo_Return->array_ptr[0]->head_type_node == EXPR || nodo_Return->array_ptr[0]->head_type_node == TERM || nodo_Return->array_ptr[0]->head_type_node == FACTOR){
    if(nodo_Return->array_ptr[0]->node_type == FUNCTION_VALUE){ 
    } else{ if(is_int(nodo_Return->array_ptr[0])){
        assert(funcion_actual->node_ptr->return_type == VALOR_INT_);
        funcion_actual->node_ptr->value.itype = int_expression(nodo_Return->array_ptr[0]);
      } else{
        assert(is_float(nodo_Return->array_ptr[0]));
        assert(funcion_actual->node_ptr->return_type == VALOR_FLOAT_);
        funcion_actual->node_ptr->value.ftype = float_expression(nodo_Return->array_ptr[0]);
      }
    }
  }
  function_ptr->flag = 1;
}
/*
    cover_tree() function
*/
void cover_tree(struct SyntacticNode* nodo){
  if(nodo == NULL) return;

  if(current_function() && get_flag()) return;

  switch(nodo->node_type){
  	case BEGIN:
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
    for(i = 0; i < 4; i++) cover_tree(nodo->array_ptr[i]);
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
void manejo_entrada(int argc, char **argv){
    if(argc > 1){ yyin = fopen(argv[1], "r");
    } else{ yyin = stdin; }
}
/*************
    MAIN
*************/
int main(int argc, char **argv) {
  manejo_entrada(argc, argv);
  yyparse();
  return 0;
}