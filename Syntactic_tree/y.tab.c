/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 10 "yac.y" /* yacc.c:339  */

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

#line 167 "y.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "y.tab.h".  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    PROGRAM_R = 258,
    END_R = 259,
    VAR_R = 260,
    ID = 261,
    INT_R = 262,
    FLOAT_R = 263,
    READ_R = 264,
    PRINT_R = 265,
    IF_R = 266,
    IF_ELSE_R = 267,
    WHILE_R = 268,
    FOR_R = 269,
    SET_R = 270,
    TO_R = 271,
    STEP_R = 272,
    DO_R = 273,
    OPEN_BRACKET = 274,
    CLOSE_BRACKET = 275,
    SEMICOLON = 276,
    TWO_POINTS = 277,
    OPEN_PARENTHESES = 278,
    CLOSE_PARENTHESES = 279,
    PLUS_SIGN = 280,
    MINUS_SIGN = 281,
    MULTIPLICATION_SIGN = 282,
    DIVISION_SIGN = 283,
    SMALLER_THAN_SIGN = 284,
    BIGGER_THAN_SIGN = 285,
    EQUAL_SIGN = 286,
    BIGGER_EQUAL_SIGN = 287,
    SMALLER_EQUAL_SIGN = 288,
    FLOAT_NUMBER = 289,
    INT_NUMBER = 290
  };
#endif
/* Tokens.  */
#define PROGRAM_R 258
#define END_R 259
#define VAR_R 260
#define ID 261
#define INT_R 262
#define FLOAT_R 263
#define READ_R 264
#define PRINT_R 265
#define IF_R 266
#define IF_ELSE_R 267
#define WHILE_R 268
#define FOR_R 269
#define SET_R 270
#define TO_R 271
#define STEP_R 272
#define DO_R 273
#define OPEN_BRACKET 274
#define CLOSE_BRACKET 275
#define SEMICOLON 276
#define TWO_POINTS 277
#define OPEN_PARENTHESES 278
#define CLOSE_PARENTHESES 279
#define PLUS_SIGN 280
#define MINUS_SIGN 281
#define MULTIPLICATION_SIGN 282
#define DIVISION_SIGN 283
#define SMALLER_THAN_SIGN 284
#define BIGGER_THAN_SIGN 285
#define EQUAL_SIGN 286
#define BIGGER_EQUAL_SIGN 287
#define SMALLER_EQUAL_SIGN 288
#define FLOAT_NUMBER 289
#define INT_NUMBER 290

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 112 "yac.y" /* yacc.c:355  */

  int itype;
  double ftype;
  char* id_name;
  struct SyntacticNode* syntatic_type;
  struct SymbolTable* table_type;

#line 285 "y.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 302 "y.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   105

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  36
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  16
/* YYNRULES -- Number of rules.  */
#define YYNRULES  39
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  92

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   290

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   198,   198,   206,   207,   210,   211,   214,   220,   221,
     224,   225,   226,   227,   230,   234,   238,   243,   247,   253,
     256,   266,   267,   270,   271,   276,   279,   282,   285,   288,
     291,   294,   295,   298,   301,   306,   309,   312,   315,   318
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "PROGRAM_R", "END_R", "VAR_R", "ID",
  "INT_R", "FLOAT_R", "READ_R", "PRINT_R", "IF_R", "IF_ELSE_R", "WHILE_R",
  "FOR_R", "SET_R", "TO_R", "STEP_R", "DO_R", "OPEN_BRACKET",
  "CLOSE_BRACKET", "SEMICOLON", "TWO_POINTS", "OPEN_PARENTHESES",
  "CLOSE_PARENTHESES", "PLUS_SIGN", "MINUS_SIGN", "MULTIPLICATION_SIGN",
  "DIVISION_SIGN", "SMALLER_THAN_SIGN", "BIGGER_THAN_SIGN", "EQUAL_SIGN",
  "BIGGER_EQUAL_SIGN", "SMALLER_EQUAL_SIGN", "FLOAT_NUMBER", "INT_NUMBER",
  "$accept", "program", "optional_declarations", "declarations",
  "declaration", "type", "statement", "assign_statement", "if_statement",
  "iteration_statement", "cmp_statement", "statement_list", "expression",
  "term", "factor", "comparison", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290
};
# endif

#define YYPACT_NINF -22

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-22)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
       3,    18,    29,     8,   -22,    28,    35,    31,   -22,    36,
      26,    52,    28,    15,    62,    -4,    68,    71,    74,    83,
      93,     1,   -22,   -22,   -22,   -22,   -22,   -22,   -22,   -22,
     -22,    79,   -22,    -4,   -22,   -22,    21,    22,   -22,    -4,
      -4,    -4,    95,    -4,   -22,   -22,    25,   -22,   -21,   -22,
      -4,    -4,    -4,    -4,    54,    78,    80,    81,    -4,    67,
     -22,   -22,   -22,    22,    22,   -22,   -22,    -4,    -4,    -4,
      -4,    -4,    52,    52,    52,    56,   -22,    49,    49,    49,
      49,    49,   -22,    52,   -22,    -4,   -22,     0,    -4,   -17,
      52,   -22
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     0,     1,     4,     0,     0,     3,     6,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     2,    10,    11,    12,    13,     5,     8,     9,
       7,     0,    32,     0,    34,    33,     0,    27,    30,     0,
       0,     0,     0,     0,    21,    23,     0,    15,     0,    16,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      22,    24,    31,    25,    26,    28,    29,     0,     0,     0,
       0,     0,     0,     0,     0,     0,    14,    35,    36,    37,
      39,    38,    17,     0,    19,     0,    18,     0,     0,     0,
       0,    20
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -22,   -22,   -22,    91,   -22,   -22,   -14,   -22,   -22,   -22,
     -22,   -22,   -15,    27,    37,    55
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     7,     8,     9,    30,    22,    23,    24,    25,
      26,    46,    54,    37,    38,    55
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      36,    90,    32,    62,    50,    51,     1,    45,    50,    51,
      14,    15,    16,    17,    18,    19,    20,    88,    48,    33,
      21,    44,    28,    29,     3,    50,    51,     5,    59,     4,
      34,    35,    61,     6,    14,    15,    16,    17,    18,    19,
      20,    10,    49,    75,    21,    60,    50,    51,    13,    52,
      53,    11,    77,    78,    79,    80,    81,    12,    82,    83,
      84,    14,    15,    16,    17,    18,    19,    20,    31,    86,
      87,    21,    85,    89,    50,    51,    91,    63,    64,    50,
      51,    50,    51,    67,    68,    69,    70,    71,    76,    65,
      66,    39,    50,    51,    40,    56,    57,    41,    42,    43,
      47,    58,    72,    27,    73,    74
};

static const yytype_uint8 yycheck[] =
{
      15,    18,     6,    24,    25,    26,     3,    21,    25,    26,
       9,    10,    11,    12,    13,    14,    15,    17,    33,    23,
      19,    20,     7,     8,     6,    25,    26,    19,    43,     0,
      34,    35,    46,     5,     9,    10,    11,    12,    13,    14,
      15,     6,    21,    58,    19,    20,    25,    26,    22,    27,
      28,    20,    67,    68,    69,    70,    71,    21,    72,    73,
      74,     9,    10,    11,    12,    13,    14,    15,     6,    83,
      85,    19,    16,    88,    25,    26,    90,    50,    51,    25,
      26,    25,    26,    29,    30,    31,    32,    33,    21,    52,
      53,    23,    25,    26,    23,    40,    41,    23,    15,     6,
      21,     6,    24,    12,    24,    24
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     3,    37,     6,     0,    19,     5,    38,    39,    40,
       6,    20,    21,    22,     9,    10,    11,    12,    13,    14,
      15,    19,    42,    43,    44,    45,    46,    39,     7,     8,
      41,     6,     6,    23,    34,    35,    48,    49,    50,    23,
      23,    23,    15,     6,    20,    42,    47,    21,    48,    21,
      25,    26,    27,    28,    48,    51,    51,    51,     6,    48,
      20,    42,    24,    49,    49,    50,    50,    29,    30,    31,
      32,    33,    24,    24,    24,    48,    21,    48,    48,    48,
      48,    48,    42,    42,    42,    16,    42,    48,    17,    48,
      18,    42
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    36,    37,    38,    38,    39,    39,    40,    41,    41,
      42,    42,    42,    42,    43,    43,    43,    44,    44,    45,
      45,    46,    46,    47,    47,    48,    48,    48,    49,    49,
      49,    50,    50,    50,    50,    51,    51,    51,    51,    51
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     6,     1,     0,     3,     1,     4,     1,     1,
       1,     1,     1,     1,     4,     3,     3,     5,     6,     5,
      10,     2,     3,     1,     2,     3,     3,     1,     3,     3,
       1,     3,     1,     1,     1,     3,     3,     3,     3,     3
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 199 "yac.y" /* yacc.c:1646  */
    {
        struct SyntacticNode* root;
        root = add_node(PROGRAM, NONE, NONE, NULL, NONE, (yyvsp[0].syntatic_type), NULL, NULL, NULL, NULL);
        display_table(table_head, "main");
      }
#line 1445 "y.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 215 "yac.y" /* yacc.c:1646  */
    {
            insert_table(&table_head, (char*)(yyvsp[-2].syntatic_type), (yyvsp[0].itype));
        }
#line 1453 "y.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 220 "yac.y" /* yacc.c:1646  */
    { (yyval.itype) = INT_VALUE; }
#line 1459 "y.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 221 "yac.y" /* yacc.c:1646  */
    { (yyval.itype) = FLOAT_VALUE; }
#line 1465 "y.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 224 "yac.y" /* yacc.c:1646  */
    { (yyval.syntatic_type) = (yyvsp[0].syntatic_type); }
#line 1471 "y.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 225 "yac.y" /* yacc.c:1646  */
    { (yyval.syntatic_type) = (yyvsp[0].syntatic_type); }
#line 1477 "y.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 226 "yac.y" /* yacc.c:1646  */
    { (yyval.syntatic_type) = (yyvsp[0].syntatic_type); }
#line 1483 "y.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 227 "yac.y" /* yacc.c:1646  */
    { (yyval.syntatic_type) = (yyvsp[0].syntatic_type); }
#line 1489 "y.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 230 "yac.y" /* yacc.c:1646  */
    {
            struct SyntacticNode* node = add_node(SET, NONE, NONE, (char *)(yyvsp[-2].syntatic_type), ID_VALUE, NULL, NULL, NULL, NULL, NULL);
            (yyval.syntatic_type) = add_node(SET, NONE, NONE, NULL, STATEMENT, node, (yyvsp[-1].syntatic_type), NULL, NULL, NULL);
        }
#line 1498 "y.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 234 "yac.y" /* yacc.c:1646  */
    {
            struct SyntacticNode* node = add_node(READ, NONE, NONE, (char *)(yyvsp[-1].syntatic_type), ID_VALUE, NULL, NULL, NULL, NULL, NULL);
            (yyval.syntatic_type) = add_node(READ, NONE, NONE, NULL, STATEMENT, node, NULL, NULL, NULL, NULL);              
        }
#line 1507 "y.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 238 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(PRINT, NONE, NONE, NULL,  STATEMENT, (yyvsp[-1].syntatic_type), NULL, NULL, NULL, NULL);
        }
#line 1515 "y.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 244 "yac.y" /* yacc.c:1646  */
    {
          (yyval.syntatic_type) = add_node(IF, NONE, NONE, NULL, IF_STATEMENT, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1523 "y.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 248 "yac.y" /* yacc.c:1646  */
    {
          (yyval.syntatic_type) = add_node(IFELSE, NONE, NONE, NULL, IF_STATEMENT, (yyvsp[-3].syntatic_type), (yyvsp[-1].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL);
        }
#line 1531 "y.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 253 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(WHILE, NONE, NONE, NULL, ITERATION_STATEMENT, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1539 "y.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 256 "yac.y" /* yacc.c:1646  */
    {
            struct SyntacticNode* node = add_node(ID_VALUE, NONE, NONE, (char *)(yyvsp[-7].syntatic_type), FOR, NULL, NULL, NULL, NULL, NULL);
            struct SyntacticNode* set_node = add_node(FOR, NONE, NONE, NULL, SET, node, (yyvsp[-6].syntatic_type), NULL, NULL, NULL);
            struct SyntacticNode* smaller_than_node = add_node(SMALLER_EQUAL, NONE, NONE, NULL, EXPRESSION, node, (yyvsp[-4].syntatic_type), NULL, NULL, NULL);
            struct SyntacticNode* step_node = add_node(COMPARISON, NONE, NONE, NULL, ADD, node, (yyvsp[-2].syntatic_type), NULL, NULL, NULL);
            struct SyntacticNode* set_node_2 = add_node(FOR, NONE, NONE, NULL, SET, node, step_node, NULL, NULL, NULL);
            (yyval.syntatic_type) = add_node(FOR, NONE, NONE, NULL, ITERATION_STATEMENT, set_node, smaller_than_node, set_node_2, (yyvsp[0].syntatic_type), NULL);
        }
#line 1552 "y.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 266 "yac.y" /* yacc.c:1646  */
    { (yyval.syntatic_type) = NULL; }
#line 1558 "y.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 267 "yac.y" /* yacc.c:1646  */
    { (yyval.syntatic_type) = (yyvsp[-1].syntatic_type); }
#line 1564 "y.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 270 "yac.y" /* yacc.c:1646  */
    { (yyval.syntatic_type) = (yyvsp[0].syntatic_type);}
#line 1570 "y.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 271 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(STATEMENT_LIST, NONE, NONE, NULL, STATEMENT_LIST, (yyvsp[-1].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1578 "y.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 276 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(ADD, NONE, NONE, NULL, COMPARISON, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1586 "y.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 279 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(SUBSTRACT, NONE, NONE, NULL, COMPARISON, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1594 "y.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 282 "yac.y" /* yacc.c:1646  */
    { (yyval.syntatic_type) = (yyvsp[0].syntatic_type); }
#line 1600 "y.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 285 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(MULTIPLY, NONE, NONE, NULL, TERM, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1608 "y.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 288 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(DIVIDE, NONE, NONE, NULL, TERM, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1616 "y.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 291 "yac.y" /* yacc.c:1646  */
    { (yyval.syntatic_type) = (yyvsp[0].syntatic_type); }
#line 1622 "y.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 294 "yac.y" /* yacc.c:1646  */
    { (yyval.syntatic_type) = (yyvsp[-1].syntatic_type); }
#line 1628 "y.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 295 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(ID_VALUE, NONE, NONE, (char *)(yyvsp[0].syntatic_type), FACTOR, NULL, NULL, NULL, NULL, NULL);
       }
#line 1636 "y.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 298 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(INT_VALUE, (int)(yyvsp[0].syntatic_type), NONE, NULL, TERM, NULL, NULL, NULL, NULL, NULL);
       }
#line 1644 "y.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 301 "yac.y" /* yacc.c:1646  */
    {
          (yyval.syntatic_type) = add_node(FLOAT_VALUE, NONE, ftype, NULL, TERM, NULL, NULL, NULL, NULL, NULL);
       }
#line 1652 "y.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 306 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(SMALLER_THAN, NONE, NONE, NULL, EXPRESSION, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1660 "y.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 309 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(BIGGER_THAN, NONE, NONE, NULL, EXPRESSION, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1668 "y.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 312 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(EQUAL, NONE, NONE, NULL,  EXPRESSION, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1676 "y.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 315 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(SMALLER_EQUAL, NONE, NONE, NULL, EXPRESSION, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1684 "y.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 318 "yac.y" /* yacc.c:1646  */
    {
            (yyval.syntatic_type) = add_node(BIGGER_EQUAL, NONE, NONE, NULL, EXPRESSION, (yyvsp[-2].syntatic_type), (yyvsp[0].syntatic_type), NULL, NULL, NULL);
        }
#line 1692 "y.tab.c" /* yacc.c:1646  */
    break;


#line 1696 "y.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 323 "yac.y" /* yacc.c:1906  */


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
    new_node->name = (char *) malloc(strlen(var_name) + 1);
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
    if(node->symbol_type < sizeof(Type_node_label)){
        printf("| %s |\t", Type_node_label[node->symbol_type]);
    }
    else{
        printf("| %d |\t", node->symbol_type);
    }
    switch(node->symbol_type){
        case INT_VALUE:
        printf("| %d |\n", node->value.itype);
        break;
        case FLOAT_VALUE:
        printf("| %lf |\n", node->value.ftype);
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
struct SymbolTable* search_table(char const *var_name){
  struct SymbolTable *ptr = NULL;
  if(!ptr)
    error_handler(VARIABLE_NOT_FOUND, MESSAGE_VARIABLE_NOT_FOUND);
  return ptr;
}
/*
    set_int_value() function
*/
void set_int_value(char const *var_name, int new_value){
    struct SymbolTable *ptr = search_table(var_name);
    if(ptr != NULL){
        if(ptr->symbol_type == INT_VALUE){
            ptr->value.itype = new_value;
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
        if(ptr->symbol_type == FLOAT_VALUE){
            ptr->value.ftype = new_value;
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
    new_node->node_type = node_type;
    new_node->head_type_node = head_type_node;
    new_node->array_ptr[0] = ptr1;
    new_node->array_ptr[1] = ptr2;
    new_node->array_ptr[2] = ptr3;
    new_node->array_ptr[3] = ptr4;
    new_node->next = nextNode;
    if(node_type == INT_VALUE){
      new_node->value.itype = ivalue;
    }
    else if(node_type == FLOAT_VALUE){
      new_node->value.ftype = fvalue;
    }
    else if(node_type == ID_VALUE){
      new_node->value.id_name = (char *) malloc(strlen(id_name) + 1);
      strcpy (new_node->value.id_name, id_name);
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
    print_node(node->node_type, "node_type");
    printf("address = %p\n", node);
    print_node(node->head_type_node, "head_type_node");
    if(node->node_type == INT_VALUE){
        printf("Node value = %d\n", node->value.itype);
    }
    else if(node->node_type == ID_VALUE){
        printf("Node value = %s\n", node->value.id_name);
    }
    else if(node->node_type == FLOAT_VALUE){
        printf("Node value = %f\n", node->value.ftype);
    }
    int i = 0;
    for(i = 0; i < 4; i++){
        printf("ptr #%d: %p\n", i + 1, node->array_ptr[i]);
    }
    printf("\n");
    for(i = 0; i < 4; i++){
        print_tree(node->array_ptr[i]);
    }
}
/*
    int_expression() function
*/
int int_expression(struct SyntacticNode* iexpression_node){
    assert(iexpression_node != NULL);
    if(iexpression_node->node_type == ADD){
        return int_expression(iexpression_node->array_ptr[0]) + int_expression(iexpression_node->array_ptr[1]);
    }
    else if(iexpression_node->node_type == SUBSTRACT){
        return int_expression(iexpression_node->array_ptr[0]) - int_expression(iexpression_node->array_ptr[1]);
    }
    else if(iexpression_node->node_type == MULTIPLY){
        return int_expression(iexpression_node->array_ptr[0]) * int_expression(iexpression_node->array_ptr[1]);
    }
    else if(iexpression_node->node_type == DIVIDE){
        return int_expression(iexpression_node->array_ptr[0]) / int_expression(iexpression_node->array_ptr[1]);
    }
    assert(iexpression_node->node_type == INT_VALUE || iexpression_node->node_type == ID_VALUE);
    int return_value = 0;
    if(iexpression_node->node_type == INT_VALUE){
        return_value = iexpression_node->value.itype;
    }
    else if(iexpression_node->node_type == ID_VALUE){
        struct SymbolTable *tmp = search_table(iexpression_node->value.id_name);
        assert(tmp -> symbol_type == INT_VALUE);
        return_value = tmp->value.itype;
    }
    return return_value;
}
/*
    float_expression() function
*/
double float_expression(struct SyntacticNode* fexpression_node){
    assert(fexpression_node != NULL);
    if(fexpression_node->node_type == ADD){
        return float_expression(fexpression_node->array_ptr[0]) + float_expression(fexpression_node->array_ptr[1]);
    }
    else if(fexpression_node->node_type == SUBSTRACT){
        return float_expression(fexpression_node->array_ptr[0]) - float_expression(fexpression_node->array_ptr[1]);
    }
    else if(fexpression_node->node_type == MULTIPLY){
        return float_expression(fexpression_node->array_ptr[0]) * float_expression(fexpression_node->array_ptr[1]);
    }
    else if(fexpression_node->node_type == DIVIDE){
        return float_expression(fexpression_node->array_ptr[0]) / float_expression(fexpression_node->array_ptr[1]);
    }
    assert(fexpression_node->node_type == ID_VALUE || fexpression_node-> node_type == FLOAT_VALUE);
    double return_value = 0;
    if(fexpression_node->node_type == FLOAT_VALUE){
        return_value = fexpression_node->value.ftype;
    }
    else if(fexpression_node->node_type == ID_VALUE){
        struct SymbolTable *ptr = search_table(fexpression_node->value.id_name);
        assert(ptr->symbol_type == FLOAT_VALUE);
        return_value = ptr->value.ftype;
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
    if(node->node_type == type){
        count++;
    }
    else if(node->node_type == ID_VALUE){
        struct SymbolTable* ptr = search_table(node->value.id_name);
        if(ptr->symbol_type == type)
        count++;
    }
    int i = 0;
    for(i = 0; i < 4; i++){
        count += get_type(type, node->array_ptr[i]);
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
    set_statement() function
*/
void set_statement(struct SyntacticNode* node){
    assert(node->array_ptr[0] != NULL);
    assert(node->array_ptr[1] != NULL);
    struct SymbolTable* ptr = search_table(node->array_ptr[0]->value.id_name);
    assert(ptr != NULL);
    int set_ivalue;
    double set_fvalue;
    switch(ptr->symbol_type){
        case INT_VALUE:
        set_ivalue = int_expression(node->array_ptr[1]);
        set_int_value(ptr->name, set_ivalue);
        assert(set_ivalue == ptr->value.itype);
        break;
        case FLOAT_VALUE:
        set_fvalue = float_expression(node->array_ptr[1]);
        set_float_value(ptr->name, set_fvalue);
        assert(set_fvalue == ptr->value.ftype);
        break;
    }
}
/*
    if_statement() function
*/
void if_statement(struct SyntacticNode* node){
    assert(node->array_ptr[0] != NULL);
    if(comparison_function(node->array_ptr[0])){
        if(node->array_ptr[1] != NULL){
            cover_tree(node->array_ptr[1]);
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
  assert(node->array_ptr[0] != NULL);
  struct SymbolTable* ptr = search_table(node->array_ptr[0]->value.id_name);
  int set_ivalue;
  double set_fvalue;
  switch(ptr->symbol_type){
    case INT_VALUE:
      set_ivalue = read_int();
      set_int_value(ptr->name, set_ivalue);
      assert(set_ivalue == ptr->value.itype);
      break;
    case FLOAT_VALUE:
      set_fvalue = read_float();
      set_float_value(ptr->name, set_fvalue);
      assert(set_fvalue == ptr->value.ftype);
      break;
  }
}
/*
    print_function() function
*/
void print_function(struct SyntacticNode* node){
  assert(node->array_ptr[0] != NULL);
  if(node->array_ptr[0]->node_type == INT_VALUE){
    printf("%d\n", node->array_ptr[0]->value.itype);
  } 
  else if(node->array_ptr[0]->node_type == FLOAT_VALUE){
    printf("%f\n", node->array_ptr[0]->value.ftype);
  }
  else if(node->array_ptr[0]->head_type_node == COMPARISON 
    || node->array_ptr[0]->head_type_node == TERM
    || node->array_ptr[0]->head_type_node == FACTOR){ 
      if(is_int(node->array_ptr[0])){
        printf("%d\n", int_expression(node->array_ptr[0]));
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
