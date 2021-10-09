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

%%
{FUNCTION} printf("FUNCTION", yytext);
{BEGIN_PARAMS} printf("BEGIN_PARAMS", yytext);
{END_PARAMS} printf("END_PARAMS", yytext);
{BEGIN_LOCALS} printf("BEGIN_LOCALS", yytext);
{END_LOCALS} printf("END_LOCALS", yytext);
{BEGIN_BODY} printf("BEGIN_BODY", yytext);
{END_BODY} printf("END_BODY", yytext);
{INTEGER} printf("INTEGER", yytext);
{ARRAY} printf("ARRAY", yytext);
{OF} printf("OF", yytext);
{IF} printf("IF", yytext);
{THEN} printf("THEN", yytext);
{ENDIF} printf("ENDIF", yytext);
{ELSE} printf("ELSE", yytext);
{WHILE} printf("WHILE", yytext);
{DO} printf("DO", yytext);
{BEGINLOOP} printf("BEGINLOOP", yytext);
{ENDLOOP} printf("ENDLOOP", yytext);
{CONTINUE} printf("CONTINUE", yytext);
{READ} printf("READ", yytext);
{WRITE} printf("WRITE", yytext);
{AND} printf("AND", yytext);
{OR} printf("OR", yytext);
{NOT} printf("NOT", yytext);
{TRUE} printf("TRUE", yytext);
{FALSE} printf("FALSE", yytext);
{RETURN} printf("RETURN", yytext);
{IDENT} printf("IDENT %s", yytext);
{SEMICOLON} printf("SEMICOLON", yytext);
{COLON} printf("COLON", yytext);
{COMMA} printf("COMMA", yytext);
{L_PAREN} printf("L_PAREN", yytext);
{R_PAREN} printf("R_PAREN", yytext);
{L_SQUARE_BRACKET} printf("L_SQUARE_BRACKET", yytext);
{R_SQUARE_BRACKET} printf("R_SQUARE_BRACKET", yytext);
{ASSIGN} printf("ASSIGN", yytext);
%%

main(){
    printf("Give me your input:\n");
    yylex();   
}
