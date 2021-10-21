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

function: FUNCTION ident BEGIN_PARAMS declaration END_PARAMS
ident: IDENT {printf("ident %s\n", $1);} 
declaration: ident COLON INTEGER {printf("delaration ident\n");} | {printf("declaration -> epsilone\n");}

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

