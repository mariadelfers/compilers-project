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
enum Tipos_De_Nodos_Arbol_Sintactico {
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
char* Nombres_Tipos_De_Nodos_Arbol_Sintactico[] = {
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

void insert_table(struct SymbolTable**, char const *, int, int, 
struct SymbolTable*, struct SymbolTable*);
void display_table(struct SymbolTable *, char*);

/* Syntactic tree functions */
struct SyntacticNode* add_node(int, double, char*, int, int, 
  struct SyntacticNode*, struct SyntacticNode*, struct SyntacticNode*,
  struct SyntacticNode*, struct SyntacticNode*);
struct Funcion_En_Uso *stack_ptr;
void print_tree(struct SyntacticNode*, char*);
void imprime_Arbol_Sintactico(struct SyntacticNode*);
void cover_tree(struct SyntacticNode*);
void get_function();
void set_function(struct SymbolTable*);
void aux_function(struct SyntacticNode*);

%}

%start prog 

%union { 
  int valor_int; double ftype; 
  char* nombre_Identificador; 
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
%type <valor_int> tipo
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
  int type;
  int return_type;
  union { 
    int itype; 
    double ftype; 
  } value;
  
  struct SyntacticNode *puntero_Nodo_Raiz_Arbol_Sintactico; 
  struct SymbolTable *puntero_Nodo_Tabla_Simbolos; 
  struct SymbolTable *next;
};
/* Symbol table function structure */
struct Funcion_En_Uso{
  struct SymbolTable* node_ptr;
  struct Funcion_En_Uso* pila;
  int termino_Y_Regreso;
  union { 
    int itype;  
    double ftype; 
  } value;
};

int funcion_En_Ejecucion(){ 
  return stack_ptr != NULL; 
}

int funcion_Termino_Y_Regreso(){ 
  return stack_ptr -> termino_Y_Regreso; 
}
/*
    insert_table() function
*/
void insert_table(struct SymbolTable** apuntador_Puntero_Tope_Tabla, char const *new_name, int tipo_Simbolo, int tipo_Simbolo_Regreso, 
struct SymbolTable *puntero_Nodo_Tabla_Simbolos, struct SyntacticNode *puntero_Nodo_Raiz_Arbol_Sintactico){
  
  struct SymbolTable* new_node = (struct SymbolTable*) malloc(sizeof(struct SymbolTable));
  new_node -> name = (char *) malloc(strlen(new_name) + 1);
  strcpy (new_node->name, new_name);
  new_node -> type = tipo_Simbolo;
  new_node -> return_type = tipo_Simbolo_Regreso;
  new_node -> value.itype = 0;
  new_node -> puntero_Nodo_Tabla_Simbolos = puntero_Nodo_Tabla_Simbolos;
  new_node -> puntero_Nodo_Raiz_Arbol_Sintactico = puntero_Nodo_Raiz_Arbol_Sintactico;
  new_node -> next = (struct SymbolTable*)(*apuntador_Puntero_Tope_Tabla);
  *apuntador_Puntero_Tope_Tabla = new_node;
}
/*
    check_table() function
*/
struct SymbolTable* check_table(char const *new_name, struct SymbolTable* tope_Tabla_Simbolos){
  struct SymbolTable *current_ptr = tope_Tabla_Simbolos;
  while(current_ptr != NULL){ 
    assert(current_ptr -> name);
    if(strcmp(current_ptr -> name, new_name) == 0) {
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
  if(funcion_En_Ejecucion()) {
    current_ptr = check_table(var_name, stack_ptr->node_ptr->puntero_Nodo_Tabla_Simbolos);
  }
  if((funcion_En_Ejecucion() && !current_ptr) || !funcion_En_Ejecucion()) {
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
  if(node->type < sizeof(Nombres_Tipos_De_Nodos_Arbol_Sintactico)){ 
    printf("Tipo \t\t\t\t=\t%s\n", Nombres_Tipos_De_Nodos_Arbol_Sintactico[node->type]);
  } 
  else { 
    printf("Tipo \t\t\t\t=\t%d\n", node->type); 
  }

  switch(node->type){
    case VALOR_INT_:
      printf("Valor \t\t\t\t=\t%d\n", node->value.itype);
      break;
    case VALOR_FLOAT_:
      printf("Valor \t\t\t\t=\t%lf\n", node->value.ftype);
      break;
    case FUNCTION_VALUE:
      assert(node->return_type < sizeof(Nombres_Tipos_De_Nodos_Arbol_Sintactico));
      printf("Tipo regresado \t\t=\t%s\n\n", Nombres_Tipos_De_Nodos_Arbol_Sintactico[node->return_type]);
      display_table(node->puntero_Nodo_Tabla_Simbolos, node->name);
      print_tree(node->puntero_Nodo_Raiz_Arbol_Sintactico, node->name);
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
void get_int_table(char const *nombre_Simbolo, int nuevo_Valor_Int){
  struct SymbolTable *punter_Simbolo = get_table(nombre_Simbolo);
  if(punter_Simbolo != NULL){
    if(punter_Simbolo->type == VALOR_INT_){ punter_Simbolo->value.itype = nuevo_Valor_Int;
    } else{ manejador_De_Errores(ASIGNACION_INT_INVALIDA, ASIGNACION_INT_INVALIDA_TEXTO); }
  } else{ manejador_De_Errores(SIMBOLO_INCORRECTO, SIMBOLO_INCORRECTO_TEXTO); }
}
/*
    get_float_table() function
*/
void get_float_table(char const *nombre_Simbolo, double nuevo_Valor_Float){
  struct SymbolTable *punter_Simbolo = get_table(nombre_Simbolo);
  if(punter_Simbolo != NULL){
    if(punter_Simbolo->type == VALOR_FLOAT_){ punter_Simbolo->value.ftype = nuevo_Valor_Float;
    } else{ manejador_De_Errores(ASIGNACION_FLOAT_INVALIDA, ASIGNACION_FLOAT_INVALIDA_TEXTO); }
  }
}
/*
    set_function() function
*/
void set_function(struct SymbolTable* node_ptr){
  struct Funcion_En_Uso *new_function_ptr = (struct Funcion_En_Uso*) malloc(sizeof(struct Funcion_En_Uso));
  new_function_ptr -> node_ptr = node_ptr;
  new_function_ptr -> pila = stack_ptr;
  new_function_ptr -> termino_Y_Regreso = 0;
  new_function_ptr -> value.itype = 0;
  stack_ptr = new_function_ptr;
}
/*
    get_function() function
*/
void get_function(){
  struct Funcion_En_Uso* temp = stack_ptr;
  stack_ptr = stack_ptr->pila;
  free(temp);
}
/*
    print_call_function() function
*/
void imprime_Llamada_A_Pila(){
  printf("Llamada actual a pila = \t");
  struct Funcion_En_Uso* temporal = stack_ptr;
  while(temporal != NULL){
    printf("\t%s\n", temporal->node_ptr->name);
    temporal = temporal->pila;
  }
  printf("\n");
  printf("\n");
}

/*****************************
	    SYNTACTIC TREE
*******************************/
/* Syntactic node structure */
struct SyntacticNode {
  int type;
  int padre_Tipo_De_Nodo;
  struct SyntacticNode *array_ptr[4];
  union { 
    int itype; 
    double ftype; 
    char *nombre_Identificador;
  } value;
  struct SyntacticNode *next;
};
/*
    insert_node() function
*/
struct SyntacticNode* add_node(int i_Value, double d_Value, char* nombre_Identificador, 
  int type, int padre_Tipo_De_Nodo, struct SyntacticNode* puntero_1, struct SyntacticNode* puntero_2, 
  struct SyntacticNode* puntero_3, struct SyntacticNode* puntero_4, struct SyntacticNode* sieguiente_Nodo){
    struct SyntacticNode* new_node = (struct SyntacticNode*) malloc(sizeof(struct SyntacticNode));
    new_node->type = type;
    new_node->padre_Tipo_De_Nodo = padre_Tipo_De_Nodo;
    new_node->array_ptr[0] = puntero_1;
    new_node->array_ptr[1] = puntero_2;
    new_node->array_ptr[2] = puntero_3;
    new_node->array_ptr[3] = puntero_4;
    new_node->next = sieguiente_Nodo;
    if(type == VALOR_INT_) { 
      new_node->value.itype = i_Value;
    } 
    else if(type == VALOR_FLOAT_) { 
      new_node->value.ftype = d_Value;
    } 
    else if(type == ID_VALUE) { 
      new_node->value.nombre_Identificador = (char *) malloc(strlen(nombre_Identificador) + 1);
      strcpy (new_node->value.nombre_Identificador, nombre_Identificador);
    } 
    else if(type == FUNCTION_VALUE){ 
      new_node->value.nombre_Identificador = (char *) malloc(strlen(nombre_Identificador) + 1);
      strcpy (new_node->value.nombre_Identificador, nombre_Identificador); 
    }
    return new_node;
}
/*
    insert_node() function
*/
void imprime_Tipo_Nodo(int type, char* label){
  if(type >= 0 && type < sizeof(Nombres_Tipos_De_Nodos_Arbol_Sintactico)){ printf("%s \t\t=\t%s\n", label, Nombres_Tipos_De_Nodos_Arbol_Sintactico[type]);
  } else{ printf("%s \t\t_\t%d\n", label, type); }
}
/*
    insert_node() function
*/
void print_tree(struct SyntacticNode* arbol_Sintactico_Nodo_Raiz, char* nombre_D_Funcion){
  printf(" ARBOL SINTACTICO %s \n\n", nombre_D_Funcion);
  imprime_Arbol_Sintactico(arbol_Sintactico_Nodo_Raiz);
}
/*
    insert_node() function
*/
void imprime_Arbol_Sintactico(struct SyntacticNode* nodo){
  if(nodo == NULL) return;
  imprime_Tipo_Nodo(nodo->type, "Tipo \t\t");
  imprime_Tipo_Nodo(nodo->padre_Tipo_De_Nodo, "padre_Tipo_De_Nodo");

  if(nodo->type == VALOR_INT_){ printf("Valor del nodo \t\t\t=\t%d\n", nodo->value.itype);
  } else if(nodo->type == ID_VALUE){ printf("Valor del nodo \t\t\t=\t%s\n", nodo->value.nombre_Identificador);
  } else if(nodo->type == VALOR_FLOAT_){ printf("Valor del nodo \t\t\t=\t%f\n", nodo->value.ftype);
  } else if(nodo->type == FUNCTION_VALUE){ printf("Valor del nodo \t\t\t=\t%s\n", nodo->value.nombre_Identificador);}
  int i = 0;
  for(i = 0; i < 4; i++) printf("Puntero numero %d \t\t=\t%p\n", i + 1, nodo->array_ptr[i]);
  printf("\n");
  for(i = 0; i < 4; i++) imprime_Arbol_Sintactico(nodo->array_ptr[i]);
}
/*
    insert_node() function
*/
int funcion_Integer_Expresion(struct SyntacticNode* intger_Node_Expresion){
  assert(intger_Node_Expresion != NULL);
  if(intger_Node_Expresion->type == ADD){ return funcion_Integer_Expresion(intger_Node_Expresion->array_ptr[0]) + funcion_Integer_Expresion(intger_Node_Expresion->array_ptr[1]);
  } else if(intger_Node_Expresion->type == SUBSTRACT){ return funcion_Integer_Expresion(intger_Node_Expresion->array_ptr[0]) - funcion_Integer_Expresion(intger_Node_Expresion->array_ptr[1]);
  } else if(intger_Node_Expresion->type == MULTIPLY){ return funcion_Integer_Expresion(intger_Node_Expresion->array_ptr[0]) * funcion_Integer_Expresion(intger_Node_Expresion->array_ptr[1]);
  } else if(intger_Node_Expresion->type == SLASH){ return funcion_Integer_Expresion(intger_Node_Expresion->array_ptr[0]) / funcion_Integer_Expresion(intger_Node_Expresion->array_ptr[1]); }
  assert(intger_Node_Expresion->type == VALOR_INT_ || intger_Node_Expresion->type == ID_VALUE || intger_Node_Expresion->type == FUNCTION_VALUE);
  int valor_a_retornar = 0;
  if(intger_Node_Expresion->type == VALOR_INT_){ valor_a_retornar = intger_Node_Expresion->value.itype;
  } else if(intger_Node_Expresion->type == ID_VALUE){
    struct SymbolTable *nodo_Actl = get_table(intger_Node_Expresion->value.nombre_Identificador);
    assert(nodo_Actl->type == VALOR_INT_);
    valor_a_retornar = nodo_Actl->value.itype;
  } else if(intger_Node_Expresion->type == FUNCTION_VALUE){
    aux_function(intger_Node_Expresion);
    struct SymbolTable* funcion_Actual_En_Uso = check_table(intger_Node_Expresion->value.nombre_Identificador, function_head);
    assert(funcion_Actual_En_Uso->return_type == VALOR_INT_);    
    valor_a_retornar = stack_ptr->value.itype;
    get_function();
  }
  return valor_a_retornar;
}
/*
    insert_node() function
*/
double funcion_Double_Expresion(struct SyntacticNode* flot_Node_Expresion){
  assert(flot_Node_Expresion != NULL);
  if(flot_Node_Expresion->type == ADD){ return funcion_Double_Expresion(flot_Node_Expresion->array_ptr[0]) + funcion_Double_Expresion(flot_Node_Expresion->array_ptr[1]);
  } else if(flot_Node_Expresion->type == SUBSTRACT){ return funcion_Double_Expresion(flot_Node_Expresion->array_ptr[0]) - funcion_Double_Expresion(flot_Node_Expresion->array_ptr[1]);
  } else if(flot_Node_Expresion->type == MULTIPLY){ return funcion_Double_Expresion(flot_Node_Expresion->array_ptr[0]) * funcion_Double_Expresion(flot_Node_Expresion->array_ptr[1]);
  } else if(flot_Node_Expresion->type == SLASH){ return funcion_Double_Expresion(flot_Node_Expresion->array_ptr[0]) / funcion_Double_Expresion(flot_Node_Expresion->array_ptr[1]); }
  assert(flot_Node_Expresion->type == ID_VALUE || flot_Node_Expresion-> type == VALOR_FLOAT_ || flot_Node_Expresion-> type == FUNCTION_VALUE);
  double valor_a_retornar = 0;
  if(flot_Node_Expresion->type == VALOR_FLOAT_){ valor_a_retornar = flot_Node_Expresion->value.ftype;
  } else if(flot_Node_Expresion->type == ID_VALUE){
    struct SymbolTable *nodo_Actl = get_table(flot_Node_Expresion->value.nombre_Identificador);
    assert(nodo_Actl->type == VALOR_FLOAT_);
    valor_a_retornar = nodo_Actl->value.ftype;
  } else if(flot_Node_Expresion-> type == FUNCTION_VALUE){
    aux_function(flot_Node_Expresion);
    struct SymbolTable* funcion_Actual_En_Uso = check_table(flot_Node_Expresion->value.nombre_Identificador, function_head);
    assert(funcion_Actual_En_Uso->return_type == VALOR_FLOAT_);    
    valor_a_retornar = stack_ptr->value.ftype;
    get_function();
  }
  return valor_a_retornar;
}
/*
    insert_node() function
*/
int cuenta_Tipo_Nodo_Subarbol(int tipo_Nodoo, struct SyntacticNode* nodo){
  if(nodo == NULL) return 0;
  int contador = 0;
  if(nodo->type == tipo_Nodoo){ contador++;
  } else if(nodo->type == ID_VALUE){ 
    struct SymbolTable* identificador_nodo_actual = get_table(nodo->value.nombre_Identificador);
    if(identificador_nodo_actual->type == tipo_Nodoo) contador++;
  }
  int i = 0;
  for(i = 0; i < 4; i++){ contador += cuenta_Tipo_Nodo_Subarbol(tipo_Nodoo, nodo->array_ptr[i]); }
  return contador;
}
/*
    insert_node() function
*/
int expresion_Tipos(struct SyntacticNode* nodo_Expresion){
  int cont_nodo_subarbol_int = cuenta_Tipo_Nodo_Subarbol(VALOR_INT_, nodo_Expresion);
  int cont_nodo_subarbol_doble = cuenta_Tipo_Nodo_Subarbol(VALOR_FLOAT_, nodo_Expresion);
  if(cont_nodo_subarbol_int > 0 && cont_nodo_subarbol_doble == 0) return VALOR_INT_;
  else if(cont_nodo_subarbol_int == 0 && cont_nodo_subarbol_doble > 0) return VALOR_FLOAT_;
  manejador_De_Errores(TIPO_DATO_ERRONEO, TIPO_DATO_ERRONEO_TEXTO);
  return 0;
} 
/*
    insert_node() function
*/
int expresion_Es_Int(struct SyntacticNode* nodo_Expresion){ return expresion_Tipos(nodo_Expresion) == VALOR_INT_; }
/*
    insert_node() function
*/
int expresion_Es_Float(struct SyntacticNode* nodo_Expresion){ return expresion_Tipos(nodo_Expresion) == VALOR_FLOAT_; }
/*
    insert_node() function
*/
int longitud_Tabla_Simbolos(char const *nombre_D_Funcion){
  struct SymbolTable* simbolo_Funcion = check_table(nombre_D_Funcion, function_head);
  assert(simbolo_Funcion);
  struct SymbolTable* simbolo_actual_en_funcion_ = simbolo_Funcion->puntero_Nodo_Tabla_Simbolos;
  int long_simbolo_tabla = 0;
  while(simbolo_actual_en_funcion_ != NULL){
    long_simbolo_tabla++;
    simbolo_actual_en_funcion_ = simbolo_actual_en_funcion_->next;
  }
  return long_simbolo_tabla;
}
/*
    insert_node() function
*/
int cuenta_Parametros(struct SyntacticNode* nodo, int profunidad_Desde_Nodo_Raiz){
  if(!nodo) return 0;
  int contador = 0;
  if(profunidad_Desde_Nodo_Raiz <= 1) contador += (nodo->type == PARAMETER_VALUE);
  int i = 0;
  for(i = 0; i < 4; i++) contador += cuenta_Parametros(nodo->array_ptr[i], profunidad_Desde_Nodo_Raiz + (nodo->type == FUNCTION_VALUE));
  return contador;
}
/*
    insert_node() function
*/
void avanza_Puntero_Tabla_Simbolos(struct SymbolTable** apuntador_Puntero_Simbolo_Tabla_Simbolos, int cant_movimientos){
  int i = 0;
  for(i = 0; i < cant_movimientos; i++) *apuntador_Puntero_Simbolo_Tabla_Simbolos = (*apuntador_Puntero_Simbolo_Tabla_Simbolos)->next;
}
/*
    insert_node() function
*/
struct SyntacticNode* obtener_Siguiente_Parametro(struct SyntacticNode** apuntador_Puntero_Nodo_Subarbol){
  assert(*apuntador_Puntero_Nodo_Subarbol);
  struct SyntacticNode *puntero_Siguiente_Parametro = NULL;
  if((*apuntador_Puntero_Nodo_Subarbol)->type == FUNCTION_VALUE){
    assert((*apuntador_Puntero_Nodo_Subarbol)->array_ptr[0]);
    puntero_Siguiente_Parametro = (*apuntador_Puntero_Nodo_Subarbol)->array_ptr[0]->array_ptr[0];
  } else {
    assert((*apuntador_Puntero_Nodo_Subarbol)->type == PARAMETER_VALUE);
     puntero_Siguiente_Parametro = (*apuntador_Puntero_Nodo_Subarbol)->array_ptr[0]; 
     }
  (*apuntador_Puntero_Nodo_Subarbol) = (*apuntador_Puntero_Nodo_Subarbol)->array_ptr[0]->array_ptr[1];
  assert(puntero_Siguiente_Parametro);
  return puntero_Siguiente_Parametro;
}
/*
    insert_node() function
*/
int parametros_Correctos(struct SyntacticNode* funcion_Nodo){
  int funcion_Longitud_Tabla_Simbolos = longitud_Tabla_Simbolos(funcion_Nodo->value.nombre_Identificador);
  printf("Longitud Tabla de Simbolos = \t%d\n", funcion_Longitud_Tabla_Simbolos);
  int cantidad_Parametros = cuenta_Parametros(funcion_Nodo, 0);
  printf("Cantidad de Parametros = \t%d\n", cantidad_Parametros);
  assert(funcion_Longitud_Tabla_Simbolos >= cantidad_Parametros);
  struct SymbolTable* puntero_Parametro_Actuall = check_table(funcion_Nodo->value.nombre_Identificador, function_head)->puntero_Nodo_Tabla_Simbolos;
  avanza_Puntero_Tabla_Simbolos(&puntero_Parametro_Actuall, funcion_Longitud_Tabla_Simbolos - cantidad_Parametros);
  struct SyntacticNode* puntero_de_funcion_subarbol = funcion_Nodo;
  struct SyntacticNode* puntero_parametro_actual = NULL;
  int i = 0;
  for(i = 0; i < cantidad_Parametros; i++){
    puntero_parametro_actual = obtener_Siguiente_Parametro(&puntero_de_funcion_subarbol);
    assert(puntero_Parametro_Actuall);
    assert(puntero_parametro_actual);
    if((expresion_Es_Int(puntero_parametro_actual) && puntero_Parametro_Actuall->type != VALOR_INT_) || (expresion_Es_Float(puntero_parametro_actual) && puntero_Parametro_Actuall->type != VALOR_FLOAT_)){
      return 0;
    }
    puntero_Parametro_Actuall = puntero_Parametro_Actuall->next;
  }
  return 1;
}
/*
    insert_node() function
*/
void asigna_Parametros(struct SyntacticNode* funcion_Nodo){
  int funcion_Longitud_Tabla_Simbolos = longitud_Tabla_Simbolos(funcion_Nodo->value.nombre_Identificador);
  int cantidad_Parametros = cuenta_Parametros(funcion_Nodo, 0);
  assert(funcion_Longitud_Tabla_Simbolos >= cantidad_Parametros);
  struct SymbolTable* puntero_Parametro_Actuall = check_table(funcion_Nodo->value.nombre_Identificador, function_head)->puntero_Nodo_Tabla_Simbolos;
  avanza_Puntero_Tabla_Simbolos(&puntero_Parametro_Actuall, funcion_Longitud_Tabla_Simbolos - cantidad_Parametros);
  struct SyntacticNode* puntero_de_funcion_subarbol = funcion_Nodo;
  struct SyntacticNode* puntero_parametro_actual = NULL;
  int i = 0;
  for(i = 0; i < cantidad_Parametros; i++){
    puntero_parametro_actual = obtener_Siguiente_Parametro(&puntero_de_funcion_subarbol);
    assert(puntero_Parametro_Actuall);
    assert(puntero_parametro_actual);
    if(puntero_Parametro_Actuall->type == VALOR_INT_){
      puntero_Parametro_Actuall->value.itype = funcion_Integer_Expresion(puntero_parametro_actual);
    } else{
      assert(puntero_Parametro_Actuall->type == VALOR_FLOAT_);
      puntero_Parametro_Actuall->value.ftype = funcion_Double_Expresion(puntero_parametro_actual);
    }
    puntero_Parametro_Actuall = puntero_Parametro_Actuall->next;
  }
}
/*
    insert_node() function
*/
void aux_function(struct SyntacticNode* funcion_Nodo){
  if(!parametros_Correctos(funcion_Nodo)){ manejador_De_Errores(ASIGNACION_ERRONEA, ASIGNACION_ERRONEA_TEXTO); }
  asigna_Parametros(funcion_Nodo);
  struct SymbolTable* simbolo_Funcion = check_table(funcion_Nodo->value.nombre_Identificador, function_head);
  set_function(simbolo_Funcion);
  imprime_Llamada_A_Pila();
  cover_tree(simbolo_Funcion->puntero_Nodo_Raiz_Arbol_Sintactico);
}
/*
    insert_node() function
*/
void funcion_Imprimir(struct SyntacticNode* imprime_Nodo){
  assert(imprime_Nodo->array_ptr[0] != NULL);
  if(imprime_Nodo->array_ptr[0]->type == VALOR_INT_){ printf("%d\n", imprime_Nodo->array_ptr[0]->value.itype);
  } else if(imprime_Nodo->array_ptr[0]->type == VALOR_FLOAT_){ printf("%f\n", imprime_Nodo->array_ptr[0]->value.ftype);
  } else if(imprime_Nodo->array_ptr[0]->padre_Tipo_De_Nodo == EXPR || imprime_Nodo->array_ptr[0]->padre_Tipo_De_Nodo == TERM || imprime_Nodo->array_ptr[0]->padre_Tipo_De_Nodo == FACTOR){
    if(imprime_Nodo->array_ptr[0]->type == FUNCTION_VALUE){ 
      aux_function(imprime_Nodo->array_ptr[0]);
      struct SymbolTable* funcion_Actual_En_Uso = check_table(imprime_Nodo->array_ptr[0]->value.nombre_Identificador, function_head);
      if(funcion_Actual_En_Uso->return_type == VALOR_INT_){ printf("%d\n", stack_ptr->value.itype);
      } else{
        assert(funcion_Actual_En_Uso->return_type == VALOR_FLOAT_);
        printf("%lf\n", stack_ptr->value.ftype);
      }
      get_function();
    } else{ if(expresion_Es_Int(imprime_Nodo->array_ptr[0])){ printf("%d\n", funcion_Integer_Expresion(imprime_Nodo->array_ptr[0]));
      } else{
        assert(expresion_Es_Float(imprime_Nodo->array_ptr[0]));
        printf("%lf\n", funcion_Double_Expresion(imprime_Nodo->array_ptr[0]));
      }
    }
  }
}
/*
    insert_node() function
*/
int funcion_Expresion(struct SyntacticNode* nodo_Expresion){
  assert(nodo_Expresion->array_ptr[0] != NULL);
  assert(nodo_Expresion->array_ptr[1] != NULL);
  if(expresion_Es_Int(nodo_Expresion->array_ptr[0])){
    assert(expresion_Es_Int(nodo_Expresion->array_ptr[1]));
    int int_Izq = funcion_Integer_Expresion(nodo_Expresion->array_ptr[0]);
    int int_Der = funcion_Integer_Expresion(nodo_Expresion->array_ptr[1]);
    switch(nodo_Expresion->type){
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
    assert(expresion_Es_Float(nodo_Expresion->array_ptr[0]));
    assert(expresion_Es_Float(nodo_Expresion->array_ptr[1]));
    double double_Izq = funcion_Double_Expresion(nodo_Expresion->array_ptr[0]);
    int double_Der = funcion_Double_Expresion(nodo_Expresion->array_ptr[1]);
    switch(nodo_Expresion->type){
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
    insert_node() function
*/
void funcion_While(struct SyntacticNode* nodo_While){
  assert(nodo_While->array_ptr[0] != NULL);
  while(funcion_Expresion(nodo_While->array_ptr[0])){
    cover_tree(nodo_While->array_ptr[1]);
  }
}
/*
    insert_node() function
*/
void funcion_If(struct SyntacticNode* nodo_if){
  assert(nodo_if->array_ptr[0] != NULL);
  if(funcion_Expresion(nodo_if->array_ptr[0])){
    if(nodo_if->array_ptr[1] != NULL) cover_tree(nodo_if->array_ptr[1]);
  }
}
/*
    insert_node() function
*/
void funcion_IfElse(struct SyntacticNode* nodo_IfElse){
  assert(nodo_IfElse->array_ptr[0] != NULL);
  if(funcion_Expresion(nodo_IfElse->array_ptr[0])){ cover_tree(nodo_IfElse->array_ptr[1]);
  } else{ cover_tree(nodo_IfElse->array_ptr[2]);
  }
}
/*
    insert_node() function
*/
void funcion_Set(struct SyntacticNode* nodo_Set){
  assert(nodo_Set->array_ptr[0] != NULL);
  assert(nodo_Set->array_ptr[1] != NULL);
  struct SymbolTable* nodo_Actl = get_table(nodo_Set->array_ptr[0]->value.nombre_Identificador);
  assert(nodo_Actl != NULL);
  int expr_Valor_a_Set;
  double expr_valordoble_a_Set;
  switch(nodo_Actl->type){
    case VALOR_INT_:
      expr_Valor_a_Set = funcion_Integer_Expresion(nodo_Set->array_ptr[1]);
      get_int_table(nodo_Actl->name, expr_Valor_a_Set);
      assert(expr_Valor_a_Set == nodo_Actl->value.itype);
      break;
    case VALOR_FLOAT_:
      expr_valordoble_a_Set = funcion_Double_Expresion(nodo_Set->array_ptr[1]);
      get_float_table(nodo_Actl->name, expr_valordoble_a_Set);
      assert(expr_valordoble_a_Set == nodo_Actl->value.ftype);
      break;
  }
}
/*
    insert_node() function
*/
int leer_Int(){
  int valor_int = -1;
  printf("Asigna valor a Int = ");
  int scanf_valor_retorna = scanf("%d", &valor_int);
  assert(scanf_valor_retorna > 0);
  return valor_int;
}
/*
    insert_node() function
*/
double leer_Double(){
  double ftype = -1.0;
  printf("Asigna valor a Float = ");
  int scanf_valor_retorna = scanf("%lf", &ftype);
  assert(scanf_valor_retorna > 0);
  return ftype;
}
/*
    insert_node() function
*/
void funcion_Leer(struct SyntacticNode* nodo_Leer){
  assert(nodo_Leer->array_ptr[0] != NULL);
  struct SymbolTable* nodo_Actl = get_table(nodo_Leer->array_ptr[0]->value.nombre_Identificador);
  int valor_a_set;
  double valordoble_a_set;
  switch(nodo_Actl->type){
    case VALOR_INT_:
      valor_a_set = leer_Int();
      get_int_table(nodo_Actl->name, valor_a_set);
      assert(valor_a_set == nodo_Actl->value.itype);
      break;
    case VALOR_FLOAT_:
      valordoble_a_set = leer_Double();
      get_float_table(nodo_Actl->name, valordoble_a_set);
      assert(valordoble_a_set == nodo_Actl->value.ftype);
      break;
  }
}
/*
    insert_node() function
*/
void funcion_Return(struct SyntacticNode* nodo_Return){
  assert(nodo_Return->array_ptr[0] != NULL);
  struct Funcion_En_Uso* funcion_actual = stack_ptr;
  if(nodo_Return->array_ptr[0]->type == VALOR_INT_){
    assert(funcion_actual->node_ptr->return_type == VALOR_INT_);
    funcion_actual->node_ptr->value.itype = nodo_Return->array_ptr[0]->value.itype;
  } else if(nodo_Return->array_ptr[0]->type == VALOR_FLOAT_){
    assert(funcion_actual->node_ptr->return_type == VALOR_FLOAT_);
    funcion_actual->node_ptr->value.ftype = nodo_Return->array_ptr[0]->value.ftype;
  } else if(nodo_Return->array_ptr[0]->padre_Tipo_De_Nodo == EXPR || nodo_Return->array_ptr[0]->padre_Tipo_De_Nodo == TERM || nodo_Return->array_ptr[0]->padre_Tipo_De_Nodo == FACTOR){
    if(nodo_Return->array_ptr[0]->type == FUNCTION_VALUE){ 
    } else{ if(expresion_Es_Int(nodo_Return->array_ptr[0])){
        assert(funcion_actual->node_ptr->return_type == VALOR_INT_);
        funcion_actual->node_ptr->value.itype = funcion_Integer_Expresion(nodo_Return->array_ptr[0]);
      } else{
        assert(expresion_Es_Float(nodo_Return->array_ptr[0]));
        assert(funcion_actual->node_ptr->return_type == VALOR_FLOAT_);
        funcion_actual->node_ptr->value.ftype = funcion_Double_Expresion(nodo_Return->array_ptr[0]);
      }
    }
  }
  stack_ptr->termino_Y_Regreso = 1;
}
/*
    insert_node() function
*/
void cover_tree(struct SyntacticNode* nodo){
  if(nodo == NULL) return;

  if(funcion_En_Ejecucion() && funcion_Termino_Y_Regreso()) return;

  switch(nodo->type){
  	case BEGIN:
      break;

    case PRINT:
      funcion_Imprimir(nodo);
      break;

    case IF:
      funcion_If(nodo);
      break;

    case IFELSE:
      funcion_IfElse(nodo);
      break;

    case WHILE:
      funcion_While(nodo);
      break;

    case SET:
      funcion_Set(nodo);
      break;

    case READ:
      funcion_Leer(nodo);
      break;
    
    case RETURN:
      funcion_Return(nodo);
      break;
  } 

  if(nodo->type != IF && nodo->type != IFELSE && nodo->type != WHILE){
    int i;
    for(i = 0; i < 4; i++) cover_tree(nodo->array_ptr[i]);
  }
}
/*
    insert_node() function
*/
int yyerror(char const * s) {
  fprintf(stderr, "Error = \t%s\n", s);
  return 0;
}
/*
    insert_node() function
*/
void manejo_entrada(int argc, char **argv){
    if(argc > 1){ yyin = fopen(argv[1], "r");
    } else{ yyin = stdin; }
}
/*
    insert_node() function
*/
int main(int argc, char **argv) {
  manejo_entrada(argc, argv);
  yyparse();
  return 0;
}