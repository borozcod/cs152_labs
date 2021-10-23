%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;
void yyerror(const char* s);
%}

%define parse.error verbose 

%token IDENT
%token EQUAL
%token FUNCTION BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY INTEGER ARRAY OF IF THEN ENDIF ELSE WHILE DO BEGINLOOP ENDLOOP CONTINUE READ WRITE AND OR NOT TRUE FALSE RETURN SUB ADD MULT DIV MOD EQ NEQ LT GT LTE GTE NUMBER SEMICOLON COLON COMMA L_PAREN R_PAREN L_SQUARE_BRACKET R_SQUARE_BRACKET ASSIGN NO_IDENT1 NO_IDENT2 COMMENT


%union{
 char* str;
}

%type<str> IDENT
%start input

%%
input: line
| input '\n' line

line: '\n' 
    | function line
    |

function: FUNCTION ident SEMICOLON BEGIN_PARAMS declarationseq END_PARAMS BEGIN_LOCALS declarationseq END_LOCALS BEGIN_BODY statements END_BODY

ident:
NO_IDENT1 {yyerror("syntax error, identifier must begin with a letter" );} 
| NO_IDENT2 {yyerror("syntax error, identifier must begin with a letter" );} 
| IDENT {printf("ident -> IDENT %s\n", $1);} 

declarationseq: declaration declarationseq | {printf("declaration -> epsilone\n");}

declaration:
    ident declarations {printf("identifiers -> ident\n");}

declarations:
    COMMA ident declarations {printf("identifiers -> ident COMMA identifiers\n");} 
    | COLON arr INTEGER SEMICOLON {printf("declaration -> identifier COLON INTEGER\n");}

arr: ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF {printf("declaration -> identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER\n");} | {printf("declarations -> epsilon\n");}

/*Statement*/
comment: COMMENT

statements: 
comment statements {printf("statement -> comment\n");}
| statement SEMICOLON statements 
| {printf("statements -> epsilon\n");}

assignment: var ASSIGN expression

ifstmt: IF boolexpr THEN statements else ENDIF
else:
     ELSE statements {printf("IF bool_exp THEN statements ELSE statements ENDIF\n");} 
    | {printf("statement -> IF bool_exp THEN statements ENDIF\n");}
while: WHILE boolexpr BEGINLOOP statements ENDLOOP {printf("statement -> WHILE bool_exp BEGINLOOP statements ENDLOOP\n");}
do: DO BEGINLOOP statements ENDLOOP WHILE boolexpr {printf("statement -> DO BEGINLOOP statements ENDLOOP WHILE bool_exp\n");}
read: READ vars {printf("statement -> READ vars\n");}
write: WRITE vars {printf("statement -> WRITE vars\n");}
return: RETURN expression {printf("statement -> return expression\n");}

vars: var varcomma
varcomma: COMMA var varcomma | 

statement: 
    assignment {printf("statement -> var ASSIGN expression\n");}
    | ifstmt
    | while
    | do
    | read
    | write
    | CONTINUE {printf("statement -> CONTINUE\n");}
    | return


/*Expression*/

expression: multexpression expressionseq
expressionseq: 
      ADD multexpression expressionseq {printf("expression -> multiplicative_expression ADD multiplicative_expression\n");}
    | SUB multexpression expressionseq  {printf("expression -> multiplicative_expression SUB multiplicative_expression\n");}
    |

multexpression: term termseq
termseq:
      MULT term termseq {printf("multiplicative_expression -> term MULT term\n");}
    | DIV term termseq {printf("multiplicative_expression -> term DIV term\n");}
    | MOD term termseq {printf("multiplicative_expression -> term MOD term\n");}
    | 

neg: SUB |

termoption: 
     NUMBER {printf("term -> NUMBER\n");} 
    | L_PAREN expression R_PAREN {printf("term -> L_PAREN expression R_PAREN\n");}

term: neg ident termmatch | neg termoption

termmatch: matchterm
    | notmatchterm
    |
matchterm: L_PAREN expressionlist R_PAREN {printf("ident L_PAREN expressionlist R_PAREN\n");}
notmatchterm: L_SQUARE_BRACKET expression R_SQUARE_BRACKET {printf("var -> ident L_SQUARE_BRACKET expression R_SQUARE_BRACKET\n");}

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
relationexproptions: 
      expression comp expression {printf("relation_exp -> expression comp expression\n");}
    | TRUE {printf("relation_exp -> TRUE\n");}
    | FALSE {printf("relation_exp -> FALSE\n");}
    | L_PAREN boolexpr R_PAREN {printf("relation_exp -> L_PAREN boolexpr R_PAREN\n");}

%%
int main() {
  yyin = stdin;
  do {
    yyparse();
  } while(!feof(yyin));
  return 0;
}

void yyerror(const char* s) {
    extern int line_num;
    printf("%s in line %d\n", s, line_num);
    exit(1);
}

