/*

    María Fernanda Hernández Enriquez
    A01329383

    Tarea 6

*/

%{
/*  Include statements  */
extern FILE *yyin;
#include <stdio.h>
#include <math.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include "assignment7.tab.h"
#define NINGUNO -98765
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
struct Nodo_Tabla_De_Simbolos *funcion_main_Tope_Tabla_Simbolos;
struct Nodo_Tabla_De_Simbolos *functionSymbolTableHead;
void agregar_A_Tabla_De_Simbolos(struct Nodo_Tabla_De_Simbolos**, char const *, int, int, struct Nodo_Tabla_De_Simbolos*, struct Nodo_Arbol_Sintactico*);
void imprimir_Tabla_De_Simbolo(struct Nodo_Tabla_De_Simbolos *, char*);

/* Syntactic tree functions */
struct Nodo_Arbol_Sintactico* crear_Nodo(int, double, char*, int, int, 
  struct Nodo_Arbol_Sintactico*, struct Nodo_Arbol_Sintactico*, struct Nodo_Arbol_Sintactico*,
  struct Nodo_Arbol_Sintactico*, struct Nodo_Arbol_Sintactico*);
struct Funcion_En_Uso *puntero_Tope_De_Pila;
void imprimir_Arbol_Sintactico(struct Nodo_Arbol_Sintactico*, char*);
void imprime_Arbol_Sintactico(struct Nodo_Arbol_Sintactico*);
void recorre_Arbol_Sintactico(struct Nodo_Arbol_Sintactico*);
void expulsa_Pila();
void agregar_A_Pila(struct Nodo_Tabla_De_Simbolos*);
void funcion_auxiliar(struct Nodo_Arbol_Sintactico*);

%}

%start prog 

%union { 
  int valor_int; double ftype; 
  char* nombre_Identificador; 
  struct Nodo_Arbol_Sintactico* arbol_valor; 
  struct Nodo_Tabla_De_Simbolos* tabla_De_Simbolos_Valor; 
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
    struct Nodo_Arbol_Sintactico* raiz_Arbol_Sintactico;
    raiz_Arbol_Sintactico = crear_Nodo(NINGUNO, NINGUNO, NULL, BEGIN, NINGUNO, $4, NULL, NULL, NULL, NULL);
    imprimir_Arbol_Sintactico(raiz_Arbol_Sintactico, "main");
    imprimir_Tabla_De_Simbolo(funcion_main_Tope_Tabla_Simbolos, "main");
    printf(" OUTPUT \n\n");
    recorre_Arbol_Sintactico(raiz_Arbol_Sintactico);
};

opt_decls: decls | /* */ 
;

decls: dec ASCII_SCOLON decls | dec 
;

dec: RETURN_VARIABLE IDENTIFIER ASCII_COLON tipo { agregar_A_Tabla_De_Simbolos(&funcion_main_Tope_Tabla_Simbolos, (char*)$2, $4, NINGUNO, NULL, NULL); }
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
	agregar_A_Tabla_De_Simbolos(&funcion_main_Tope_Tabla_Simbolos, (char*)$2, FUNCTION_VALUE, $7, functionSymbolTableHead, $10);
	functionSymbolTableHead = NULL;
	}
;

opt_params: param_lst | /* */
;

param_lst: param ASCII_COMMA param_lst | param
;

param: IDENTIFIER ASCII_COLON tipo { agregar_A_Tabla_De_Simbolos(&functionSymbolTableHead, (char*)$1, $3, NINGUNO, NULL, NULL); }
;

opt_decls_for_function: decls_for_function | /* */
;

decls_for_function: dec_for_function ASCII_SCOLON decls_for_function | dec_for_function
;

dec_for_function: RETURN_VARIABLE IDENTIFIER ASCII_COLON tipo { agregar_A_Tabla_De_Simbolos(&functionSymbolTableHead, (char*)$2, $4, NINGUNO, NULL, NULL); }
;

stmt: IDENTIFIER ASCII_SET expr 
	 { struct Nodo_Arbol_Sintactico* idNode = crear_Nodo(NINGUNO, NINGUNO, (char *)$1, ID_VALUE, SET, NULL, NULL, NULL, NULL, NULL);
	  $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, SET, STMT, idNode, $3, NULL, NULL, NULL);    
	 }
	| RETURN_IF ASCII_PARENTHESES_1 expresion ASCII_PARENTHESES_2 stmt { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, IF, STMT, $3, $5, NULL, NULL, NULL); }
	| RETURN_IFELSE ASCII_PARENTHESES_1 expresion ASCII_PARENTHESES_2 stmt stmt { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, IFELSE, STMT, $3, $5, $6, NULL, NULL); }
	| RETURN_WHILE ASCII_PARENTHESES_1 expresion ASCII_PARENTHESES_2 stmt { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, WHILE, STMT, $3, $5, NULL, NULL, NULL); }
	| RETURN_READ IDENTIFIER
	{ struct Nodo_Arbol_Sintactico* idNode = crear_Nodo(NINGUNO, NINGUNO, (char *)$2, ID_VALUE, READ, NULL, NULL, NULL, NULL, NULL);
	 $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, READ, STMT, idNode, NULL, NULL, NULL, NULL);                  
	}
	| RETURN_PRINT expr { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, PRINT, STMT, $2, NULL, NULL, NULL, NULL); }
	| RETURN_BEGIN opt_stmts RETURN_END { $$ = $2; }
	| RETURN_RETURN expr { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, RETURN, STMT, $2, NULL, NULL, NULL, NULL); }
;

opt_stmts: stmt_lst { $$ = $1; }
	| /* */ { $$ = NULL; }
;

stmt_lst: stmt ASCII_SCOLON stmt_lst { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, STMT_LST, STMT_LST, $3, $1, NULL, NULL, NULL); }
	| stmt { $$ = $1; }
;

expresion: expr { $$ = 1; }
	| expr ASCII_LESSTHAN expr { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, LESSTHAN, EXPRESION, $1, $3, NULL, NULL, NULL); }
	| expr ASCII_GREATTHAN expr { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, GREATTHAN, EXPRESION, $1, $3, NULL, NULL, NULL); }
	| expr ASCII_EQUAL expr { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, EQUAL, EXPRESION, $1, $3, NULL, NULL, NULL); }
	| expr ASCII_LESSEQUAL expr { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, LESSEQUAL, EXPRESION, $1, $3, NULL, NULL, NULL); }
	| expr ASCII_GREATEQUAL expr { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, GREATEQUAL, EXPRESION, $1, $3, NULL, NULL, NULL); }
;

expr: expr ASCII_ADD term { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, ADD, EXPR, $1, $3, NULL, NULL, NULL); }
	| expr ASCII_SUBSTRACT term { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, SUBSTRACT, EXPR, $1, $3, NULL, NULL, NULL); }
	| term { $$ = $1; }
;

term: term ASCII_MULTIPLY factor { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, MULTIPLY, TERM, $1, $3, NULL, NULL, NULL); }
	| term ASCII_SLASH factor { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, SLASH, TERM, $1, $3, NULL, NULL, NULL); }
	| factor { $$ = $1; }
; 

factor: ASCII_PARENTHESES_1 expr ASCII_PARENTHESES_2 { $$ = $2; }
	| IDENTIFIER { $$ = crear_Nodo(NINGUNO, NINGUNO, (char *)$1, ID_VALUE, FACTOR, NULL, NULL, NULL, NULL, NULL); }
	| INTEGER_NUMBER { $$ = crear_Nodo((int)$1, NINGUNO, NULL, VALOR_INT_, TERM, NULL, NULL, NULL, NULL, NULL); }
	| FLOATING_POINT_NUMBER{ $$ = crear_Nodo(NINGUNO, ftype, NULL, VALOR_FLOAT_, TERM, NULL, NULL, NULL, NULL, NULL); }
	| IDENTIFIER ASCII_PARENTHESES_1 opt_args ASCII_PARENTHESES_2 { $$ = crear_Nodo(NINGUNO, NINGUNO, (char *)$1, FUNCTION_VALUE, TERM, $3, NULL, NULL, NULL, NULL); }
;

opt_args: arg_lst { $$ = $1; }
	| /* */ { $$ = NULL; }
;

arg_lst: expr ASCII_COMMA arg_lst { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, PARAMETER_VALUE, ARG_LST, $1, $3, NULL, NULL, NULL); }
	| expr { $$ = crear_Nodo(NINGUNO, NINGUNO, NULL, PARAMETER_VALUE, ARG_LST, $1, NULL, NULL, NULL, NULL); }
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
struct Nodo_Tabla_De_Simbolos {
  char *nombre;
  int type;
  int retorna_tipo;
  union { int valor_int; double ftype; } value;
  struct Nodo_Arbol_Sintactico *puntero_Nodo_Raiz_Arbol_Sintactico; 
  struct Nodo_Tabla_De_Simbolos *puntero_Nodo_Tabla_Simbolos; 
  struct Nodo_Tabla_De_Simbolos *siguiente;
};
/* Symbol table function structure */
struct Funcion_En_Uso{
  struct Nodo_Tabla_De_Simbolos* puntero_Simbolo_Del_Nodo;
  struct Funcion_En_Uso* pila;
  int termino_Y_Regreso;
  union { int valor_int;  double ftype; } value;
};

int funcion_En_Ejecucion(){ 
  return puntero_Tope_De_Pila != NULL; 
}

int funcion_Termino_Y_Regreso(){ 
  return puntero_Tope_De_Pila->termino_Y_Regreso; 
}
/*
    insert_table() function
*/
void agregar_A_Tabla_De_Simbolos(struct Nodo_Tabla_De_Simbolos** apuntador_Puntero_Tope_Tabla, char const *nombre_Simbolo, int tipo_Simbolo, int tipo_Simbolo_Regreso, struct Nodo_Tabla_De_Simbolos *puntero_Nodo_Tabla_Simbolos, struct Nodo_Arbol_Sintactico *puntero_Nodo_Raiz_Arbol_Sintactico){
  struct Nodo_Tabla_De_Simbolos* puntero_Nodo_Nuevo = (struct Nodo_Tabla_De_Simbolos*) malloc(sizeof(struct Nodo_Tabla_De_Simbolos));
  puntero_Nodo_Nuevo->nombre = (char *) malloc(strlen(nombre_Simbolo) + 1);
  strcpy (puntero_Nodo_Nuevo->nombre, nombre_Simbolo);
  puntero_Nodo_Nuevo->type = tipo_Simbolo;
  puntero_Nodo_Nuevo->retorna_tipo = tipo_Simbolo_Regreso;
  puntero_Nodo_Nuevo->value.valor_int = 0;
  puntero_Nodo_Nuevo->puntero_Nodo_Tabla_Simbolos = puntero_Nodo_Tabla_Simbolos;
  puntero_Nodo_Nuevo->puntero_Nodo_Raiz_Arbol_Sintactico = puntero_Nodo_Raiz_Arbol_Sintactico;
  puntero_Nodo_Nuevo->siguiente = (struct Nodo_Tabla_De_Simbolos*)(*apuntador_Puntero_Tope_Tabla);
  *apuntador_Puntero_Tope_Tabla = puntero_Nodo_Nuevo;
}

struct Nodo_Tabla_De_Simbolos* auxiliar_Tabla_Simbolos(char const *nombre_Simbolo, struct Nodo_Tabla_De_Simbolos* tope_Tabla_Simbolos){
  struct Nodo_Tabla_De_Simbolos *puntero_En_Uso = tope_Tabla_Simbolos;
  while(puntero_En_Uso != NULL){ 
    assert(puntero_En_Uso->nombre);
    if(strcmp(puntero_En_Uso->nombre, nombre_Simbolo) == 0) return puntero_En_Uso;
    puntero_En_Uso = puntero_En_Uso->siguiente;
  }
  return NULL;
}

struct Nodo_Tabla_De_Simbolos* adquirir_De_Tabla_Simblos(char const *nombre_Simbolo){
  struct Nodo_Tabla_De_Simbolos *puntero_En_Uso = NULL;
  if(funcion_En_Ejecucion()) puntero_En_Uso = auxiliar_Tabla_Simbolos(nombre_Simbolo, puntero_Tope_De_Pila->puntero_Simbolo_Del_Nodo->puntero_Nodo_Tabla_Simbolos);
  if((funcion_En_Ejecucion() && !puntero_En_Uso) || !funcion_En_Ejecucion()) puntero_En_Uso = auxiliar_Tabla_Simbolos(nombre_Simbolo, funcion_main_Tope_Tabla_Simbolos);
  if(!puntero_En_Uso) manejador_De_Errores(SIMBOLO_INCORRECTO, SIMBOLO_INCORRECTO_TEXTO);
  return puntero_En_Uso;
}

void imprime_Nodo_Tabla_Simbolos(struct Nodo_Tabla_De_Simbolos *nodo){
  if(nodo == NULL) return;
  printf("Simbolo \t\t\t=\t%s\n", nodo->nombre);
  if(nodo->type < sizeof(Nombres_Tipos_De_Nodos_Arbol_Sintactico)){ printf("Tipo \t\t\t\t=\t%s\n", Nombres_Tipos_De_Nodos_Arbol_Sintactico[nodo->type]);
  } else{ printf("Tipo \t\t\t\t=\t%d\n", nodo->type); }

  switch(nodo->type){
    case VALOR_INT_:
      printf("Valor \t\t\t\t=\t%d\n", nodo->value.valor_int);
      break;
    case VALOR_FLOAT_:
      printf("Valor \t\t\t\t=\t%lf\n", nodo->value.ftype);
      break;
    case FUNCTION_VALUE:
      assert(nodo->retorna_tipo < sizeof(Nombres_Tipos_De_Nodos_Arbol_Sintactico));
      printf("Tipo regresado \t\t=\t%s\n\n", Nombres_Tipos_De_Nodos_Arbol_Sintactico[nodo->retorna_tipo]);
      imprimir_Tabla_De_Simbolo(nodo->puntero_Nodo_Tabla_Simbolos, nodo->nombre);
      imprimir_Arbol_Sintactico(nodo->puntero_Nodo_Raiz_Arbol_Sintactico, nodo->nombre);
      break;
  }
  printf("Siguiente puntero \t\t=\t%p\n\n", nodo->siguiente);
}

void imprimir_Tabla_De_Simbolo(struct Nodo_Tabla_De_Simbolos* puntero_Tope_Tabla, char* nombre_Tabla){
  printf(" TABLA DE SIMBOLOS %s \n\n", nombre_Tabla);
  struct Nodo_Tabla_De_Simbolos *puntero_En_Uso = puntero_Tope_Tabla;
  while(puntero_En_Uso != NULL){
    imprime_Nodo_Tabla_Simbolos(puntero_En_Uso);
    puntero_En_Uso = puntero_En_Uso->siguiente;
  }
}

void valorint_a_simbolo(char const *nombre_Simbolo, int nuevo_Valor_Int){
  struct Nodo_Tabla_De_Simbolos *punter_Simbolo = adquirir_De_Tabla_Simblos(nombre_Simbolo);
  if(punter_Simbolo != NULL){
    if(punter_Simbolo->type == VALOR_INT_){ punter_Simbolo->value.valor_int = nuevo_Valor_Int;
    } else{ manejador_De_Errores(ASIGNACION_INT_INVALIDA, ASIGNACION_INT_INVALIDA_TEXTO); }
  } else{ manejador_De_Errores(SIMBOLO_INCORRECTO, SIMBOLO_INCORRECTO_TEXTO); }
}

void valordoble_a_simbolo(char const *nombre_Simbolo, double nuevo_Valor_Float){
  struct Nodo_Tabla_De_Simbolos *punter_Simbolo = adquirir_De_Tabla_Simblos(nombre_Simbolo);
  if(punter_Simbolo != NULL){
    if(punter_Simbolo->type == VALOR_FLOAT_){ punter_Simbolo->value.ftype = nuevo_Valor_Float;
    } else{ manejador_De_Errores(ASIGNACION_FLOAT_INVALIDA, ASIGNACION_FLOAT_INVALIDA_TEXTO); }
  }
}

void agregar_A_Pila(struct Nodo_Tabla_De_Simbolos* puntero_Simbolo_Del_Nodo){
  struct Funcion_En_Uso *puntero_Nueva_Funcion_Nodo = (struct Funcion_En_Uso*) malloc(sizeof(struct Funcion_En_Uso));
  puntero_Nueva_Funcion_Nodo->puntero_Simbolo_Del_Nodo = puntero_Simbolo_Del_Nodo;
  puntero_Nueva_Funcion_Nodo->pila = puntero_Tope_De_Pila;
  puntero_Nueva_Funcion_Nodo->termino_Y_Regreso = 0;
  puntero_Nueva_Funcion_Nodo->value.valor_int = 0;
  puntero_Tope_De_Pila = puntero_Nueva_Funcion_Nodo;
}

void expulsa_Pila(){
  struct Funcion_En_Uso* temporal = puntero_Tope_De_Pila;
  puntero_Tope_De_Pila = puntero_Tope_De_Pila->pila;
  free(temporal);
}

void imprime_Llamada_A_Pila(){
  printf("Llamada actual a pila = \t");
  struct Funcion_En_Uso* temporal = puntero_Tope_De_Pila;
  while(temporal != NULL){
    printf("\t%s\n", temporal->puntero_Simbolo_Del_Nodo->nombre);
    temporal = temporal->pila;
  }
  printf("\n");
  printf("\n");
}

/*****************************
	    SYNTACTIC TREE
*******************************/

struct Nodo_Arbol_Sintactico {
  int type;
  int padre_Tipo_De_Nodo;
  struct Nodo_Arbol_Sintactico *arreglo_De_Punteros[4];
  union { int valor_int; double ftype; char *nombre_Identificador;
  } value;
  struct Nodo_Arbol_Sintactico *siguiente;
};

struct Nodo_Arbol_Sintactico* crear_Nodo(int i_Value, double d_Value, char* nombre_Identificador, int type, int padre_Tipo_De_Nodo, struct Nodo_Arbol_Sintactico* puntero_1, struct Nodo_Arbol_Sintactico* puntero_2, struct Nodo_Arbol_Sintactico* puntero_3, struct Nodo_Arbol_Sintactico* puntero_4, struct Nodo_Arbol_Sintactico* sieguiente_Nodo){
    struct Nodo_Arbol_Sintactico* puntero_Nodo_Nuevo = (struct Nodo_Arbol_Sintactico*) malloc(sizeof(struct Nodo_Arbol_Sintactico));
    puntero_Nodo_Nuevo->type = type;
    puntero_Nodo_Nuevo->padre_Tipo_De_Nodo = padre_Tipo_De_Nodo;
    puntero_Nodo_Nuevo->arreglo_De_Punteros[0] = puntero_1;
    puntero_Nodo_Nuevo->arreglo_De_Punteros[1] = puntero_2;
    puntero_Nodo_Nuevo->arreglo_De_Punteros[2] = puntero_3;
    puntero_Nodo_Nuevo->arreglo_De_Punteros[3] = puntero_4;
    puntero_Nodo_Nuevo->siguiente = sieguiente_Nodo;
    if(type == VALOR_INT_){ puntero_Nodo_Nuevo->value.valor_int = i_Value;
    } else if(type == VALOR_FLOAT_){ puntero_Nodo_Nuevo->value.ftype = d_Value;
    } else if(type == ID_VALUE){ puntero_Nodo_Nuevo->value.nombre_Identificador = (char *) malloc(strlen(nombre_Identificador) + 1);
      strcpy (puntero_Nodo_Nuevo->value.nombre_Identificador, nombre_Identificador);
    } else if(type == FUNCTION_VALUE){ puntero_Nodo_Nuevo->value.nombre_Identificador = (char *) malloc(strlen(nombre_Identificador) + 1);
      strcpy (puntero_Nodo_Nuevo->value.nombre_Identificador, nombre_Identificador); }
    return puntero_Nodo_Nuevo;
}

void imprime_Tipo_Nodo(int type, char* label){
  if(type >= 0 && type < sizeof(Nombres_Tipos_De_Nodos_Arbol_Sintactico)){ printf("%s \t\t=\t%s\n", label, Nombres_Tipos_De_Nodos_Arbol_Sintactico[type]);
  } else{ printf("%s \t\t_\t%d\n", label, type); }
}

void imprimir_Arbol_Sintactico(struct Nodo_Arbol_Sintactico* arbol_Sintactico_Nodo_Raiz, char* nombre_D_Funcion){
  printf(" ARBOL SINTACTICO %s \n\n", nombre_D_Funcion);
  imprime_Arbol_Sintactico(arbol_Sintactico_Nodo_Raiz);
}

void imprime_Arbol_Sintactico(struct Nodo_Arbol_Sintactico* nodo){
  if(nodo == NULL) return;
  imprime_Tipo_Nodo(nodo->type, "Tipo \t\t");
  imprime_Tipo_Nodo(nodo->padre_Tipo_De_Nodo, "padre_Tipo_De_Nodo");

  if(nodo->type == VALOR_INT_){ printf("Valor del nodo \t\t\t=\t%d\n", nodo->value.valor_int);
  } else if(nodo->type == ID_VALUE){ printf("Valor del nodo \t\t\t=\t%s\n", nodo->value.nombre_Identificador);
  } else if(nodo->type == VALOR_FLOAT_){ printf("Valor del nodo \t\t\t=\t%f\n", nodo->value.ftype);
  } else if(nodo->type == FUNCTION_VALUE){ printf("Valor del nodo \t\t\t=\t%s\n", nodo->value.nombre_Identificador);}
  int i = 0;
  for(i = 0; i < 4; i++) printf("Puntero numero %d \t\t=\t%p\n", i + 1, nodo->arreglo_De_Punteros[i]);
  printf("\n");
  for(i = 0; i < 4; i++) imprime_Arbol_Sintactico(nodo->arreglo_De_Punteros[i]);
}

int funcion_Integer_Expresion(struct Nodo_Arbol_Sintactico* intger_Node_Expresion){
  assert(intger_Node_Expresion != NULL);
  if(intger_Node_Expresion->type == ADD){ return funcion_Integer_Expresion(intger_Node_Expresion->arreglo_De_Punteros[0]) + funcion_Integer_Expresion(intger_Node_Expresion->arreglo_De_Punteros[1]);
  } else if(intger_Node_Expresion->type == SUBSTRACT){ return funcion_Integer_Expresion(intger_Node_Expresion->arreglo_De_Punteros[0]) - funcion_Integer_Expresion(intger_Node_Expresion->arreglo_De_Punteros[1]);
  } else if(intger_Node_Expresion->type == MULTIPLY){ return funcion_Integer_Expresion(intger_Node_Expresion->arreglo_De_Punteros[0]) * funcion_Integer_Expresion(intger_Node_Expresion->arreglo_De_Punteros[1]);
  } else if(intger_Node_Expresion->type == SLASH){ return funcion_Integer_Expresion(intger_Node_Expresion->arreglo_De_Punteros[0]) / funcion_Integer_Expresion(intger_Node_Expresion->arreglo_De_Punteros[1]); }
  assert(intger_Node_Expresion->type == VALOR_INT_ || intger_Node_Expresion->type == ID_VALUE || intger_Node_Expresion->type == FUNCTION_VALUE);
  int valor_a_retornar = 0;
  if(intger_Node_Expresion->type == VALOR_INT_){ valor_a_retornar = intger_Node_Expresion->value.valor_int;
  } else if(intger_Node_Expresion->type == ID_VALUE){
    struct Nodo_Tabla_De_Simbolos *nodo_Actl = adquirir_De_Tabla_Simblos(intger_Node_Expresion->value.nombre_Identificador);
    assert(nodo_Actl->type == VALOR_INT_);
    valor_a_retornar = nodo_Actl->value.valor_int;
  } else if(intger_Node_Expresion->type == FUNCTION_VALUE){
    funcion_auxiliar(intger_Node_Expresion);
    struct Nodo_Tabla_De_Simbolos* funcion_Actual_En_Uso = auxiliar_Tabla_Simbolos(intger_Node_Expresion->value.nombre_Identificador, funcion_main_Tope_Tabla_Simbolos);
    assert(funcion_Actual_En_Uso->retorna_tipo == VALOR_INT_);    
    valor_a_retornar = puntero_Tope_De_Pila->value.valor_int;
    expulsa_Pila();
  }
  return valor_a_retornar;
}

double funcion_Double_Expresion(struct Nodo_Arbol_Sintactico* flot_Node_Expresion){
  assert(flot_Node_Expresion != NULL);
  if(flot_Node_Expresion->type == ADD){ return funcion_Double_Expresion(flot_Node_Expresion->arreglo_De_Punteros[0]) + funcion_Double_Expresion(flot_Node_Expresion->arreglo_De_Punteros[1]);
  } else if(flot_Node_Expresion->type == SUBSTRACT){ return funcion_Double_Expresion(flot_Node_Expresion->arreglo_De_Punteros[0]) - funcion_Double_Expresion(flot_Node_Expresion->arreglo_De_Punteros[1]);
  } else if(flot_Node_Expresion->type == MULTIPLY){ return funcion_Double_Expresion(flot_Node_Expresion->arreglo_De_Punteros[0]) * funcion_Double_Expresion(flot_Node_Expresion->arreglo_De_Punteros[1]);
  } else if(flot_Node_Expresion->type == SLASH){ return funcion_Double_Expresion(flot_Node_Expresion->arreglo_De_Punteros[0]) / funcion_Double_Expresion(flot_Node_Expresion->arreglo_De_Punteros[1]); }
  assert(flot_Node_Expresion->type == ID_VALUE || flot_Node_Expresion-> type == VALOR_FLOAT_ || flot_Node_Expresion-> type == FUNCTION_VALUE);
  double valor_a_retornar = 0;
  if(flot_Node_Expresion->type == VALOR_FLOAT_){ valor_a_retornar = flot_Node_Expresion->value.ftype;
  } else if(flot_Node_Expresion->type == ID_VALUE){
    struct Nodo_Tabla_De_Simbolos *nodo_Actl = adquirir_De_Tabla_Simblos(flot_Node_Expresion->value.nombre_Identificador);
    assert(nodo_Actl->type == VALOR_FLOAT_);
    valor_a_retornar = nodo_Actl->value.ftype;
  } else if(flot_Node_Expresion-> type == FUNCTION_VALUE){
    funcion_auxiliar(flot_Node_Expresion);
    struct Nodo_Tabla_De_Simbolos* funcion_Actual_En_Uso = auxiliar_Tabla_Simbolos(flot_Node_Expresion->value.nombre_Identificador, funcion_main_Tope_Tabla_Simbolos);
    assert(funcion_Actual_En_Uso->retorna_tipo == VALOR_FLOAT_);    
    valor_a_retornar = puntero_Tope_De_Pila->value.ftype;
    expulsa_Pila();
  }
  return valor_a_retornar;
}

int cuenta_Tipo_Nodo_Subarbol(int tipo_Nodoo, struct Nodo_Arbol_Sintactico* nodo){
  if(nodo == NULL) return 0;
  int contador = 0;
  if(nodo->type == tipo_Nodoo){ contador++;
  } else if(nodo->type == ID_VALUE){ 
    struct Nodo_Tabla_De_Simbolos* identificador_nodo_actual = adquirir_De_Tabla_Simblos(nodo->value.nombre_Identificador);
    if(identificador_nodo_actual->type == tipo_Nodoo) contador++;
  }
  int i = 0;
  for(i = 0; i < 4; i++){ contador += cuenta_Tipo_Nodo_Subarbol(tipo_Nodoo, nodo->arreglo_De_Punteros[i]); }
  return contador;
}

int expresion_Tipos(struct Nodo_Arbol_Sintactico* nodo_Expresion){
  int cont_nodo_subarbol_int = cuenta_Tipo_Nodo_Subarbol(VALOR_INT_, nodo_Expresion);
  int cont_nodo_subarbol_doble = cuenta_Tipo_Nodo_Subarbol(VALOR_FLOAT_, nodo_Expresion);
  if(cont_nodo_subarbol_int > 0 && cont_nodo_subarbol_doble == 0) return VALOR_INT_;
  else if(cont_nodo_subarbol_int == 0 && cont_nodo_subarbol_doble > 0) return VALOR_FLOAT_;
  manejador_De_Errores(TIPO_DATO_ERRONEO, TIPO_DATO_ERRONEO_TEXTO);
  return 0;
} 

int expresion_Es_Int(struct Nodo_Arbol_Sintactico* nodo_Expresion){ return expresion_Tipos(nodo_Expresion) == VALOR_INT_; }
int expresion_Es_Float(struct Nodo_Arbol_Sintactico* nodo_Expresion){ return expresion_Tipos(nodo_Expresion) == VALOR_FLOAT_; }

int longitud_Tabla_Simbolos(char const *nombre_D_Funcion){
  struct Nodo_Tabla_De_Simbolos* simbolo_Funcion = auxiliar_Tabla_Simbolos(nombre_D_Funcion, funcion_main_Tope_Tabla_Simbolos);
  assert(simbolo_Funcion);
  struct Nodo_Tabla_De_Simbolos* simbolo_actual_en_funcion_ = simbolo_Funcion->puntero_Nodo_Tabla_Simbolos;
  int long_simbolo_tabla = 0;
  while(simbolo_actual_en_funcion_ != NULL){
    long_simbolo_tabla++;
    simbolo_actual_en_funcion_ = simbolo_actual_en_funcion_->siguiente;
  }
  return long_simbolo_tabla;
}

int cuenta_Parametros(struct Nodo_Arbol_Sintactico* nodo, int profunidad_Desde_Nodo_Raiz){
  if(!nodo) return 0;
  int contador = 0;
  if(profunidad_Desde_Nodo_Raiz <= 1) contador += (nodo->type == PARAMETER_VALUE);
  int i = 0;
  for(i = 0; i < 4; i++) contador += cuenta_Parametros(nodo->arreglo_De_Punteros[i], profunidad_Desde_Nodo_Raiz + (nodo->type == FUNCTION_VALUE));
  return contador;
}

void avanza_Puntero_Tabla_Simbolos(struct Nodo_Tabla_De_Simbolos** apuntador_Puntero_Simbolo_Tabla_Simbolos, int cant_movimientos){
  int i = 0;
  for(i = 0; i < cant_movimientos; i++) *apuntador_Puntero_Simbolo_Tabla_Simbolos = (*apuntador_Puntero_Simbolo_Tabla_Simbolos)->siguiente;
}

struct Nodo_Arbol_Sintactico* obtener_Siguiente_Parametro(struct Nodo_Arbol_Sintactico** apuntador_Puntero_Nodo_Subarbol){
  assert(*apuntador_Puntero_Nodo_Subarbol);
  struct Nodo_Arbol_Sintactico *puntero_Siguiente_Parametro = NULL;
  if((*apuntador_Puntero_Nodo_Subarbol)->type == FUNCTION_VALUE){
    assert((*apuntador_Puntero_Nodo_Subarbol)->arreglo_De_Punteros[0]);
    puntero_Siguiente_Parametro = (*apuntador_Puntero_Nodo_Subarbol)->arreglo_De_Punteros[0]->arreglo_De_Punteros[0];
  } else {
    assert((*apuntador_Puntero_Nodo_Subarbol)->type == PARAMETER_VALUE);
     puntero_Siguiente_Parametro = (*apuntador_Puntero_Nodo_Subarbol)->arreglo_De_Punteros[0]; 
     }
  (*apuntador_Puntero_Nodo_Subarbol) = (*apuntador_Puntero_Nodo_Subarbol)->arreglo_De_Punteros[0]->arreglo_De_Punteros[1];
  assert(puntero_Siguiente_Parametro);
  return puntero_Siguiente_Parametro;
}

int parametros_Correctos(struct Nodo_Arbol_Sintactico* funcion_Nodo){
  int funcion_Longitud_Tabla_Simbolos = longitud_Tabla_Simbolos(funcion_Nodo->value.nombre_Identificador);
  printf("Longitud Tabla de Simbolos = \t%d\n", funcion_Longitud_Tabla_Simbolos);
  int cantidad_Parametros = cuenta_Parametros(funcion_Nodo, 0);
  printf("Cantidad de Parametros = \t%d\n", cantidad_Parametros);
  assert(funcion_Longitud_Tabla_Simbolos >= cantidad_Parametros);
  struct Nodo_Tabla_De_Simbolos* puntero_Parametro_Actuall = auxiliar_Tabla_Simbolos(funcion_Nodo->value.nombre_Identificador, funcion_main_Tope_Tabla_Simbolos)->puntero_Nodo_Tabla_Simbolos;
  avanza_Puntero_Tabla_Simbolos(&puntero_Parametro_Actuall, funcion_Longitud_Tabla_Simbolos - cantidad_Parametros);
  struct Nodo_Arbol_Sintactico* puntero_de_funcion_subarbol = funcion_Nodo;
  struct Nodo_Arbol_Sintactico* puntero_parametro_actual = NULL;
  int i = 0;
  for(i = 0; i < cantidad_Parametros; i++){
    puntero_parametro_actual = obtener_Siguiente_Parametro(&puntero_de_funcion_subarbol);
    assert(puntero_Parametro_Actuall);
    assert(puntero_parametro_actual);
    if((expresion_Es_Int(puntero_parametro_actual) && puntero_Parametro_Actuall->type != VALOR_INT_) || (expresion_Es_Float(puntero_parametro_actual) && puntero_Parametro_Actuall->type != VALOR_FLOAT_)){
      return 0;
    }
    puntero_Parametro_Actuall = puntero_Parametro_Actuall->siguiente;
  }
  return 1;
}

void asigna_Parametros(struct Nodo_Arbol_Sintactico* funcion_Nodo){
  int funcion_Longitud_Tabla_Simbolos = longitud_Tabla_Simbolos(funcion_Nodo->value.nombre_Identificador);
  int cantidad_Parametros = cuenta_Parametros(funcion_Nodo, 0);
  assert(funcion_Longitud_Tabla_Simbolos >= cantidad_Parametros);
  struct Nodo_Tabla_De_Simbolos* puntero_Parametro_Actuall = auxiliar_Tabla_Simbolos(funcion_Nodo->value.nombre_Identificador, funcion_main_Tope_Tabla_Simbolos)->puntero_Nodo_Tabla_Simbolos;
  avanza_Puntero_Tabla_Simbolos(&puntero_Parametro_Actuall, funcion_Longitud_Tabla_Simbolos - cantidad_Parametros);
  struct Nodo_Arbol_Sintactico* puntero_de_funcion_subarbol = funcion_Nodo;
  struct Nodo_Arbol_Sintactico* puntero_parametro_actual = NULL;
  int i = 0;
  for(i = 0; i < cantidad_Parametros; i++){
    puntero_parametro_actual = obtener_Siguiente_Parametro(&puntero_de_funcion_subarbol);
    assert(puntero_Parametro_Actuall);
    assert(puntero_parametro_actual);
    if(puntero_Parametro_Actuall->type == VALOR_INT_){
      puntero_Parametro_Actuall->value.valor_int = funcion_Integer_Expresion(puntero_parametro_actual);
    } else{
      assert(puntero_Parametro_Actuall->type == VALOR_FLOAT_);
      puntero_Parametro_Actuall->value.ftype = funcion_Double_Expresion(puntero_parametro_actual);
    }
    puntero_Parametro_Actuall = puntero_Parametro_Actuall->siguiente;
  }
}

void funcion_auxiliar(struct Nodo_Arbol_Sintactico* funcion_Nodo){
  if(!parametros_Correctos(funcion_Nodo)){ manejador_De_Errores(ASIGNACION_ERRONEA, ASIGNACION_ERRONEA_TEXTO); }
  asigna_Parametros(funcion_Nodo);
  struct Nodo_Tabla_De_Simbolos* simbolo_Funcion = auxiliar_Tabla_Simbolos(funcion_Nodo->value.nombre_Identificador, funcion_main_Tope_Tabla_Simbolos);
  agregar_A_Pila(simbolo_Funcion);
  imprime_Llamada_A_Pila();
  recorre_Arbol_Sintactico(simbolo_Funcion->puntero_Nodo_Raiz_Arbol_Sintactico);
}

void funcion_Imprimir(struct Nodo_Arbol_Sintactico* imprime_Nodo){
  assert(imprime_Nodo->arreglo_De_Punteros[0] != NULL);
  if(imprime_Nodo->arreglo_De_Punteros[0]->type == VALOR_INT_){ printf("%d\n", imprime_Nodo->arreglo_De_Punteros[0]->value.valor_int);
  } else if(imprime_Nodo->arreglo_De_Punteros[0]->type == VALOR_FLOAT_){ printf("%f\n", imprime_Nodo->arreglo_De_Punteros[0]->value.ftype);
  } else if(imprime_Nodo->arreglo_De_Punteros[0]->padre_Tipo_De_Nodo == EXPR || imprime_Nodo->arreglo_De_Punteros[0]->padre_Tipo_De_Nodo == TERM || imprime_Nodo->arreglo_De_Punteros[0]->padre_Tipo_De_Nodo == FACTOR){
    if(imprime_Nodo->arreglo_De_Punteros[0]->type == FUNCTION_VALUE){ 
      funcion_auxiliar(imprime_Nodo->arreglo_De_Punteros[0]);
      struct Nodo_Tabla_De_Simbolos* funcion_Actual_En_Uso = auxiliar_Tabla_Simbolos(imprime_Nodo->arreglo_De_Punteros[0]->value.nombre_Identificador, funcion_main_Tope_Tabla_Simbolos);
      if(funcion_Actual_En_Uso->retorna_tipo == VALOR_INT_){ printf("%d\n", puntero_Tope_De_Pila->value.valor_int);
      } else{
        assert(funcion_Actual_En_Uso->retorna_tipo == VALOR_FLOAT_);
        printf("%lf\n", puntero_Tope_De_Pila->value.ftype);
      }
      expulsa_Pila();
    } else{ if(expresion_Es_Int(imprime_Nodo->arreglo_De_Punteros[0])){ printf("%d\n", funcion_Integer_Expresion(imprime_Nodo->arreglo_De_Punteros[0]));
      } else{
        assert(expresion_Es_Float(imprime_Nodo->arreglo_De_Punteros[0]));
        printf("%lf\n", funcion_Double_Expresion(imprime_Nodo->arreglo_De_Punteros[0]));
      }
    }
  }
}

int funcion_Expresion(struct Nodo_Arbol_Sintactico* nodo_Expresion){
  assert(nodo_Expresion->arreglo_De_Punteros[0] != NULL);
  assert(nodo_Expresion->arreglo_De_Punteros[1] != NULL);
  if(expresion_Es_Int(nodo_Expresion->arreglo_De_Punteros[0])){
    assert(expresion_Es_Int(nodo_Expresion->arreglo_De_Punteros[1]));
    int int_Izq = funcion_Integer_Expresion(nodo_Expresion->arreglo_De_Punteros[0]);
    int int_Der = funcion_Integer_Expresion(nodo_Expresion->arreglo_De_Punteros[1]);
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
    assert(expresion_Es_Float(nodo_Expresion->arreglo_De_Punteros[0]));
    assert(expresion_Es_Float(nodo_Expresion->arreglo_De_Punteros[1]));
    double double_Izq = funcion_Double_Expresion(nodo_Expresion->arreglo_De_Punteros[0]);
    int double_Der = funcion_Double_Expresion(nodo_Expresion->arreglo_De_Punteros[1]);
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

void funcion_While(struct Nodo_Arbol_Sintactico* nodo_While){
  assert(nodo_While->arreglo_De_Punteros[0] != NULL);
  while(funcion_Expresion(nodo_While->arreglo_De_Punteros[0])){
    recorre_Arbol_Sintactico(nodo_While->arreglo_De_Punteros[1]);
  }
}

void funcion_If(struct Nodo_Arbol_Sintactico* nodo_if){
  assert(nodo_if->arreglo_De_Punteros[0] != NULL);
  if(funcion_Expresion(nodo_if->arreglo_De_Punteros[0])){
    if(nodo_if->arreglo_De_Punteros[1] != NULL) recorre_Arbol_Sintactico(nodo_if->arreglo_De_Punteros[1]);
  }
}

void funcion_IfElse(struct Nodo_Arbol_Sintactico* nodo_IfElse){
  assert(nodo_IfElse->arreglo_De_Punteros[0] != NULL);
  if(funcion_Expresion(nodo_IfElse->arreglo_De_Punteros[0])){ recorre_Arbol_Sintactico(nodo_IfElse->arreglo_De_Punteros[1]);
  } else{ recorre_Arbol_Sintactico(nodo_IfElse->arreglo_De_Punteros[2]);
  }
}

void funcion_Set(struct Nodo_Arbol_Sintactico* nodo_Set){
  assert(nodo_Set->arreglo_De_Punteros[0] != NULL);
  assert(nodo_Set->arreglo_De_Punteros[1] != NULL);
  struct Nodo_Tabla_De_Simbolos* nodo_Actl = adquirir_De_Tabla_Simblos(nodo_Set->arreglo_De_Punteros[0]->value.nombre_Identificador);
  assert(nodo_Actl != NULL);
  int expr_Valor_a_Set;
  double expr_valordoble_a_Set;
  switch(nodo_Actl->type){
    case VALOR_INT_:
      expr_Valor_a_Set = funcion_Integer_Expresion(nodo_Set->arreglo_De_Punteros[1]);
      valorint_a_simbolo(nodo_Actl->nombre, expr_Valor_a_Set);
      assert(expr_Valor_a_Set == nodo_Actl->value.valor_int);
      break;
    case VALOR_FLOAT_:
      expr_valordoble_a_Set = funcion_Double_Expresion(nodo_Set->arreglo_De_Punteros[1]);
      valordoble_a_simbolo(nodo_Actl->nombre, expr_valordoble_a_Set);
      assert(expr_valordoble_a_Set == nodo_Actl->value.ftype);
      break;
  }
}

int leer_Int(){
  int valor_int = -1;
  printf("Asigna valor a Int = ");
  int scanf_valor_retorna = scanf("%d", &valor_int);
  assert(scanf_valor_retorna > 0);
  return valor_int;
}

double leer_Double(){
  double ftype = -1.0;
  printf("Asigna valor a Float = ");
  int scanf_valor_retorna = scanf("%lf", &ftype);
  assert(scanf_valor_retorna > 0);
  return ftype;
}

void funcion_Leer(struct Nodo_Arbol_Sintactico* nodo_Leer){
  assert(nodo_Leer->arreglo_De_Punteros[0] != NULL);
  struct Nodo_Tabla_De_Simbolos* nodo_Actl = adquirir_De_Tabla_Simblos(nodo_Leer->arreglo_De_Punteros[0]->value.nombre_Identificador);
  int valor_a_set;
  double valordoble_a_set;
  switch(nodo_Actl->type){
    case VALOR_INT_:
      valor_a_set = leer_Int();
      valorint_a_simbolo(nodo_Actl->nombre, valor_a_set);
      assert(valor_a_set == nodo_Actl->value.valor_int);
      break;
    case VALOR_FLOAT_:
      valordoble_a_set = leer_Double();
      valordoble_a_simbolo(nodo_Actl->nombre, valordoble_a_set);
      assert(valordoble_a_set == nodo_Actl->value.ftype);
      break;
  }
}

void funcion_Return(struct Nodo_Arbol_Sintactico* nodo_Return){
  assert(nodo_Return->arreglo_De_Punteros[0] != NULL);
  struct Funcion_En_Uso* funcion_actual = puntero_Tope_De_Pila;
  if(nodo_Return->arreglo_De_Punteros[0]->type == VALOR_INT_){
    assert(funcion_actual->puntero_Simbolo_Del_Nodo->retorna_tipo == VALOR_INT_);
    funcion_actual->puntero_Simbolo_Del_Nodo->value.valor_int = nodo_Return->arreglo_De_Punteros[0]->value.valor_int;
  } else if(nodo_Return->arreglo_De_Punteros[0]->type == VALOR_FLOAT_){
    assert(funcion_actual->puntero_Simbolo_Del_Nodo->retorna_tipo == VALOR_FLOAT_);
    funcion_actual->puntero_Simbolo_Del_Nodo->value.ftype = nodo_Return->arreglo_De_Punteros[0]->value.ftype;
  } else if(nodo_Return->arreglo_De_Punteros[0]->padre_Tipo_De_Nodo == EXPR || nodo_Return->arreglo_De_Punteros[0]->padre_Tipo_De_Nodo == TERM || nodo_Return->arreglo_De_Punteros[0]->padre_Tipo_De_Nodo == FACTOR){
    if(nodo_Return->arreglo_De_Punteros[0]->type == FUNCTION_VALUE){ 
    } else{ if(expresion_Es_Int(nodo_Return->arreglo_De_Punteros[0])){
        assert(funcion_actual->puntero_Simbolo_Del_Nodo->retorna_tipo == VALOR_INT_);
        funcion_actual->puntero_Simbolo_Del_Nodo->value.valor_int = funcion_Integer_Expresion(nodo_Return->arreglo_De_Punteros[0]);
      } else{
        assert(expresion_Es_Float(nodo_Return->arreglo_De_Punteros[0]));
        assert(funcion_actual->puntero_Simbolo_Del_Nodo->retorna_tipo == VALOR_FLOAT_);
        funcion_actual->puntero_Simbolo_Del_Nodo->value.ftype = funcion_Double_Expresion(nodo_Return->arreglo_De_Punteros[0]);
      }
    }
  }
  puntero_Tope_De_Pila->termino_Y_Regreso = 1;
}

void recorre_Arbol_Sintactico(struct Nodo_Arbol_Sintactico* nodo){
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
    for(i = 0; i < 4; i++) recorre_Arbol_Sintactico(nodo->arreglo_De_Punteros[i]);
  }
}

int yyerror(char const * s) {
  fprintf(stderr, "Error = \t%s\n", s);
  return 0;
}

void manejo_entrada(int argc, char **argv){
    if(argc > 1){ yyin = fopen(argv[1], "r");
    } else{ yyin = stdin; }
}

int main(int argc, char **argv) {
  manejo_entrada(argc, argv);
  yyparse();
  return 0;
}