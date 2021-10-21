%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
%}

%left FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE RETURN SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE IDENT NUMBER SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN NO_IDENT1 NO_IDENT2 COMMENT

%start expr 

%%

ident: IDENT { printf ("ident -> $1", $1); }
;

%%

int main() {
  yyin = stdin;
  do {
    printf("Parse.\n");
    yyparse();
  } while(!feof(yyin));

  return 0;
}

void yyerror(const char* s) {
  exit(1);
}

