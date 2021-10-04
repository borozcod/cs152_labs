NUMBER [0-9]+
PLUS [+]
MINUS [-]
MULT [*]
DIV [\/]
L_PAREN [\(]
R_PAREN [\)]
EQUAL [=]

    int num_count = 0, num_operators = 0, num_parentheses = 0, num_eq = 0;
%%
{NUMBER} printf("NUMBER: [%s]\n", yytext); ++num_count;
{PLUS} printf("PLUS: [%s]\n", yytext); ++num_operators;
{MINUS} printf("MINUS: [%s]\n", yytext); ++num_operators;
{MULT} printf("MULT: [%s]\n", yytext); ++num_operators;
{DIV} printf("DIV: [%s]\n", yytext); ++num_operators;
{L_PAREN} printf("L_PAREN: [%s]\n", yytext); ++num_parentheses;
{R_PAREN} printf("R_PAREN: [%s]\n", yytext); ++num_parentheses;
{EQUAL} printf("EQUAL: [%s]\n", yytext); ++num_eq;
%%

main(){
    printf("Give me your input:\n");
    yylex();   
    printf("ints: %d, operators: %d, parentheses: %d, equal: %d\n", num_count, num_operators, num_parentheses, num_eq);
}
