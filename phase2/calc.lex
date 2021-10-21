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
{IDENT} {yylval.str = yytext; return IDENT; }
. ++num_chars;
%%
