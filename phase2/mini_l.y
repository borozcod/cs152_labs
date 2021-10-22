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

function: FUNCTION ident SEMICOLON BEGIN_PARAMS declarationseq END_PARAMS BEGIN_LOCALS declarationseq END_LOCALS BEGIN_BODY statements END_BODY


ident: IDENT {printf("ident -> IDENT %s\n", $1);} 

declarationseq: declaration declarationseq | {printf("declaration -> epsilone\n");}

declaration:
    ident declarations {printf("identifiers -> ident\n");}

declarations:
    COMMA ident declarations {printf("identifiers -> ident COMMA identifiers\n");} 
    | COLON arr INTEGER SEMICOLON {printf("declaration -> identifier COLON INTEGER\n");}

arr: ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF {printf("declaration -> identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");} | {printf("declarations -> epsilon\n");}

/*Statement*/
statements: statement SEMICOLON statements |

assignment: var ASSIGN expression

ifstmt: IF {printf("match!!!\n");} boolexpr THEN statements else ENDIF SEMICOLON
else:
     ELSE statements {printf("IF bool_exp THEN statements ELSE statements ENDIF\n");} 
    | {printf("statement -> IF bool_exp THEN statements ENDIF\n");}

statement: 
    assignment {printf("statement -> var ASSIGN expression\n");}
    | ifstmt


/*Expression*/

expression: multexpression expressionseq
expressionseq: 
      ADD multexpression expressionseq
    | SUB multexpression expressionseq
    |

multexpression: term termseq
termseq:
      MULT term termseq
    | DIV term termseq
    | MOD term termseq
    | 

neg: SUB | 

termoption: 
      var {printf("term -> var\n");}
    | NUMBER {printf("term -> NUMBER\n");} 
    | L_PAREN expression R_PAREN {printf("term -> L_PAREN expression R_PAREN\n");}

term: 
      neg termoption
    | ident L_PAREN expressionlist R_PAREN
expressionlist: expression expressioncomma
expressioncomma: COMMA expression expressioncomma  | 


var: ident {printf("var -> ident\n");}
    | ident L_SQUARE_BRACKET expression R_SQUARE_BRACKET {printf("var -> ident L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}
 

/*Relation Expr*/
not: NOT | 
comp: 
    EQ {printf("comp -> EQ\n");} 
    | NEQ {printf("comp -> NEQ\n");}
    | LT {printf("comp -> LT\n");}
    | GT {printf("comp -> GT\n");}
    | LTE {printf("comp -> LTE\n");}
    | GTE {printf("comp -> GTE\n");}

boolexpr: relationandexpr boolexprseq
boolexprseq: OR relationandexpr boolexprseq | {printf("bool_exp -> relation_and_exp\n");} 

relationandexpr: relationexpr relationandexprseq 
relationandexprseq: AND relationexpr relationandexprseq |

relationexpr: not relationexproptions
relationexproptions: expression comp expression
    | TRUE
    | FALSE
    | L_PAREN boolexpr R_PAREN 

   

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

