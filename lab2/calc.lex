%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "calc.tab.h"

%}

digit (([0-9]+)?[.])?([0-9]+)([eE][+-][0-9]+)?
    int num_count = 0, num_operators = 0, num_parentheses = 0, num_eq = 0;
%%
[ \t]	; // ignore all whitespace
"("    {++num_parentheses; return LEFT_PAREN;}
")"    {++num_parentheses; return RIGHT_PAREN;}
"+"    {++num_operators; return PLUS;}
"-"    {++num_operators; return MINUS;}
"*"    {++num_operators; return MULT;}
"\/"   {++num_operators; return DIV;}
"="    {++num_eq; return EQUAL;}
{digit} {++num_count; return NUMBER;}
%%
