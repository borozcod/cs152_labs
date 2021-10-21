%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
%}
%token IDENT
%type <str> IDENT

%union{
char* str;
}

%%
ident: IDENT { printf("ident -> %s \n", $1); };

%%

int main() {
  yyparse();
  return 0;
}

void yyerror(const char* s) {
    exit(1);
}

