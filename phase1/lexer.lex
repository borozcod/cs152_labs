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
SEMICOLON [;]
COLON [:]
COMMA [,]
L_PAREN [(]
R_PAREN [)]
L_SQUARE_BRACKET [[]
R_SQUARE_BRACKET []]
ASSIGN (:=)

    int line_num = 1;
%%

\n ++line_num;
{FUNCTION} printf("FUNCTION, %d\n", yytext, line_num);
{BEGIN_PARAMS} printf("BEGIN_PARAMS\n", yytext);
{END_PARAMS} printf("END_PARAMS\n", yytext);
{BEGIN_LOCALS} printf("BEGIN_LOCALS\n", yytext);
{END_LOCALS} printf("END_LOCALS\n", yytext);
{BEGIN_BODY} printf("BEGIN_BODY\n", yytext);
{END_BODY} printf("END_BODY\n", yytext);
{INTEGER} printf("INTEGER\n", yytext);
{ARRAY} printf("ARRAY\n", yytext);
{OF} printf("OF\n", yytext);
{IF} printf("IF\n", yytext);
{THEN} printf("THEN\n", yytext);
{ENDIF} printf("ENDIF\n", yytext);
{ELSE} printf("ELSE\n", yytext);
{WHILE} printf("WHILE\n", yytext);
{DO} printf("DO\n", yytext);
{BEGINLOOP} printf("BEGINLOOP\n", yytext);
{ENDLOOP} printf("ENDLOOP\n", yytext);
{CONTINUE} printf("CONTINUE\n", yytext);
{READ} printf("READ\n", yytext);
{WRITE} printf("WRITE\n", yytext);
{AND} printf("AND\n", yytext);
{OR} printf("OR\n", yytext);
{NOT} printf("NOT\n", yytext);
{TRUE} printf("TRUE\n", yytext);
{FALSE} printf("FALSE\n", yytext);
{RETURN} printf("RETURN\n", yytext);
{IDENT} printf("IDENT %s line: %d\n", yytext, yylineno);
{SEMICOLON} printf("SEMICOLON\n", yytext);
{COLON} printf("COLON\n", yytext);
{COMMA} printf("COMMA\n", yytext);
{L_PAREN} printf("L_PAREN\n", yytext);
{R_PAREN} printf("R_PAREN\n", yytext);
{L_SQUARE_BRACKET} printf("L_SQUARE_BRACKET\n", yytext);
{R_SQUARE_BRACKET} printf("R_SQUARE_BRACKET\n", yytext);
{ASSIGN} printf("ASSIGN\n", yytext);
%%

main(){
    yylex();   
}
