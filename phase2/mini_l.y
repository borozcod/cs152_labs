%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
%}
%token IDENT
%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE RETURN SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE NUMBER SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN NO_IDENT1 NO_IDENT2 COMMENT
%type <str> IDENT

%union{
char* str;
}
%start input
%%
input: 
line
| input '\n' line

line: '\n' 
    | function '\n' {printf("exp");}

function: FUNCTION ident SEMICOLON BEGIN_PARAMS declaration END_PARAMS BEGIN_LOCALS declaration END_LOCALS BEGIN_BODY statement END_BODY


ident: IDENT {printf("ident %s\n", $1);} 

identifiers: ident {printf("identifiers -> ident\n");} | 

declaration:
    identifiers declarations
    | declaration declaration
    | {printf("declaration -> epsilone\n");}

declarations:
    COMMA identifiers declarations {printf("delaration comma\n");} 
    | COLON arr INTEGER SEMICOLON {printf("delaration ident COLON INTEGER\n");}

arr: ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF {printf("delaration array\n");} | 



statement: var ASSIGN expression


expression: multexpression expops
expops: ADD multexpression
    | SUB multexpression
    |

multexpression: term termop
termop: MULT term
    | DIV term
    | MOD term
    | 

neg: SUB | 
termoption: var | NUMBER | L_PAREN expression R_PAREN
term: neg termoption
    | identifiers L_PAREN expressionlist R_PAREN
expressionlist: expression expressions
expressions: COMMA expression expressions | 


var: identifiers | identifiers L_SQUARE_BRACKET expression R_SQUARE_BRACKET
    

%%
int main() {
  yyin = stdin;
  do {
    yyparse();
  } while(!feof(yyin));
  return 0;
}

void yyerror(const char* s) {
printf("%s\n", s);
    exit(1);
}

