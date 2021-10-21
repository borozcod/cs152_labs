%option noyywrap

%{
#include <stdio.h>

#define YY_DECL int yylex()

#include "calc.tab.h"

%}
FUNCTION (function)
BEGIN_PARAMS (beginparams)
END_PARAMS (endparams)
BEGIN_LOCALS (beginlocals)
END_LOCALS (endlocals)
BEGIN_BODY (beginbody)
END_BODY (endbody)
INTEGER (integer)
ARRAY (array)
OF (of)
IF (if)
THEN (then)
ENDIF (endif)
ELSE (else)
WHILE (while)
DO (do)
BEGINLOOP (beginloop)
ENDLOOP (endloop)
CONTINUE (continue)
READ (read)
WRITE (write)
AND (and)
OR (or)
NOT (not)
TRUE (true)
FALSE (false)
RETURN (return)
SUB [-]
ADD [+]
MULT [\*]
DIV [\/]
MOD [%]
EQ (\=\=)
NEQ (\<\>)
LT [<]
GT [>]
LTE (<=)
GTE (>=)
IDENT [a-zA-Z]+([0-9]+)?[a-zA-Z]?(_[a-zA-Z0-9]+)?
NUMBER [0-9]+
SEMICOLON [;]
COLON [:]
COMMA [,]
L_PAREN [(]
R_PAREN [)]
L_SQUARE_BRACKET [[]
R_SQUARE_BRACKET []]
ASSIGN (:=)
NO_IDENT1 [0-9_][a-zA-Z]+([0-9]+)?[a-zA-Z]?(_[a-zA-Z0-9]+)?
NO_IDENT2 [a-zA-Z]+([0-9]+)?[a-zA-Z]?(_[a-zA-Z0-9]+)?_[^a-zA-Z0-9]
COMMENT ##[^\n]+
    int line_num = 0, num_chars = 0;
%%
\n ++line_num; num_chars = 0;
{COMMENT} {return COMMENT; }
{FUNCTION} {return FUNCTION; }
{BEGIN_PARAMS} {return BEGIN_PARAMS; }
{END_PARAMS} {return END_PARAMS; }
{BEGIN_LOCALS} {return BEGIN_LOCALS; }
{END_LOCALS} {return END_LOCALS; }
{BEGIN_BODY} {return BEGIN_BODY; }
{END_BODY} {return END_BODY; }
{INTEGER} {return INTEGER; }
{ARRAY} {return ARRAY; }
{OF} {return OF; }
{IF} {return IF; }
{THEN} {return THEN; }
{ENDIF} {return ENDIF; }
{ELSE} {return ELSE; }
{WHILE} {return WHILE; }
{DO} {return DO; }
{BEGINLOOP} {return BEGINLOOP; }
{ENDLOOP} {return ENDLOOP; }
{CONTINUE} {return CONTINUE; }
{READ} {return READ; }
{WRITE} {return WRITE; }
{AND} {return AND; }
{OR} {return OR; }
{NOT} {return NOT; }
{TRUE} {return TRUE; }
{FALSE} {return FALSE; }
{RETURN} {return RETURN; }
{SUB} {return SUB; }
{ADD} {return ADD; }
{MULT} {return MULT; }
{DIV} {return DIV; }
{MOD} {return MOD; }
{EQ} {return EQ; }
{NEQ} {return NEQ; }
{LT} {return LT; }
{GT} {return GT; }
{LTE} {return LTE; }
{GTE} {return GTE; }
{IDENT} {return IDENT; }
{NUMBER} {return NUMBER; }
{SEMICOLON} {return SEMICOLON; }
{COLON} {return COLON; }
{COMMA} {return COMMA; }
{L_PAREN} {return L_PAREN; }
{R_PAREN} {return R_PAREN; }
{L_SQUARE_BRACKET} {return L_SQUARE_BRACKET; }
{R_SQUARE_BRACKET} {return R_SQUARE_BRACKET; }
{ASSIGN} {return ASSIGN; }
{NO_IDENT1} {return NO_IDENT1; }
{NO_IDENT2} {return NO_IDENT2; }
. ++num_chars;
%%
