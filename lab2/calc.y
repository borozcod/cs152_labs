%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
%}

%left LEFT_PAREN RIGHT_PAREN PLUS MINUS MULT DIV NUMBER EQUAL

%start expr 

%%

expr: LEFT_PAREN expr RIGHT_PAREN expr 
    | expr PLUS
    | expr MINUS
    | expr MULT
    | expr DIV
    | expr NUMBER
    | expr EQUAL
    |
;

%%

int main() {
  yyin = stdin;
  extern int num_operators;
  extern int num_count;
  extern int num_parentheses;
  extern int num_eq;
  do {
    printf("Parse.\n");
    yyparse();
  } while(!feof(yyin));
  printf("Parenthesis are balanced!\n");
  printf("Operators: %d\n", num_operators);
  printf("Integers: %d\n", num_count);
  printf("Parentheses: %d\n", num_parentheses);
  printf("Equal: %d\n", num_eq);

  return 0;
}

void yyerror(const char* s) {
  fprintf(stderr, "Parse error: %s. Parenthesis are not balanced!\n", s);
  exit(1);
}

