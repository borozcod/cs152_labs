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

NO_IDENT1 [0-9_][a-zA-Z]+([0-9]+)?[a-zA-Z]?(_[a-zA-Z0-9]+)?
    int line_num = 0, num_chars = 0;
%%
\n ++line_num; num_chars = 0;
{FUNCTION} printf("FUNCTION\n", yytext);
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
{SUB} printf("SUB\n", yytext);
{ADD} printf("ADD\n", yytext);
{MULT} printf("MULT\n", yytext);
{DIV} printf("DIV\n", yytext);
{MOD} printf("MOD\n", yytext);
{EQ} printf("EQ\n", yytext);
{NEQ} printf("NEQ\n", yytext);
{LT} printf("LT\n", yytext);
{GT} printf("GT\n", yytext);
{LTE} printf("LTE\n", yytext);
{GTE} printf("GTE\n", yytext);
{IDENT} printf("IDENT %s\n", yytext);
{SEMICOLON} printf("SEMICOLON\n", yytext);
{COLON} printf("COLON\n", yytext);
{COMMA} printf("COMMA\n", yytext);
{L_PAREN} printf("L_PAREN\n", yytext);
{R_PAREN} printf("R_PAREN\n", yytext);
{L_SQUARE_BRACKET} printf("L_SQUARE_BRACKET\n", yytext);
{R_SQUARE_BRACKET} printf("R_SQUARE_BRACKET\n", yytext);
{ASSIGN} printf("ASSIGN\n", yytext);
{NO_IDENT1} printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", line_num, num_chars, yytext); yyterminate();
. ++num_chars;
%%

main(){
    yylex();   
}
