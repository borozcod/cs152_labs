FUNCTION (function)
%%
{FUNCTION} printf("FUNCTION", yytext);
%%

main(){
    printf("Give me your input:\n");
    yylex();   
}
