/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

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
#line 112 "yac.y" /* yacc.c:1909  */

  int itype;
  double ftype;
  char* id_name;
  struct SyntacticNode* syntatic_type;
  struct SymbolTable* table_type;

#line 132 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
