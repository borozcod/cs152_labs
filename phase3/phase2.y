%{
    #include<stdio.h>
    #include<string.h>
    void yyerror(const char *msg);
    extern int currLine;
    int myError = 0;
    int otherError = 0;
    
    char *identToken;
    int numberToken;
    int productionID = 0;
    char list_of_function_names[100][100];
    int count_names = 0;
    // we might need a temp var

//#define YYDEBUG 1
//yydebug=1;
%}


%union{
  int int_val;
  char *op_val;
}

%error-verbose
%start prog_start
%token BEGIN_PARAMS END_PARAMS BEGIN_LOCALS END_LOCALS BEGIN_BODY END_BODY
%token FUNCTION RETURN MAIN
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token INTEGER ARRAY OF
%token IF THEN ENDIF ELSE
%token WHILE DO BEGINLOOP ENDLOOP  CONTINUE
%token READ WRITE
%token AND OR NOT TRUE FALSE
%token SUB ADD MULT DIV MOD
%token EQ NEQ LT GT LTE GTE
%token SEMICOLON COLON COMMA L_PAREN R_PAREN ASSIGN

%token <op_val> NUMBER
%token <op_val> IDENT
%type <op_val> var
%type <op_val> ident
%type <op_val> expression
%type <op_val> multiplicative_expression
%type <op_val> term

%%

prog_start: 
	functions
		{};

functions: 
	/* epsilon */
		{}
	| function functions
		{};

function: function_ident
	SEMICOLON
	BEGIN_PARAMS declarations END_PARAMS
	BEGIN_LOCALS declarations END_LOCALS
	BEGIN_BODY statements END_BODY
		{};

function_ident: FUNCTION ident 
{
	char *token = identToken;
	printf("func name: %s\n", token);
    strcpy( list_of_function_names[count_names], token);
    count_names++;
}

ident:
	IDENT
		{ $$ = $1;};

declarations: 
	/* epsilon */
		{}
	| declaration SEMICOLON declarations
		{};

declaration: 
	identifiers COLON INTEGER
		{}
	| identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER
		{};

identifiers: 
	ident
		{}
	| ident COMMA identifiers
		{};


statement: 
	var ASSIGN expression
		{
            char *dest = $1;
            char *src = $3;
            char *name = $1;
            printf("name = %s\n", name);
            printf("= %s, %s\n", dest, src);
        }
	| IF bool_exp THEN statements ENDIF
		{}
	| IF bool_exp THEN statements ELSE statements ENDIF
		{}
	| WHILE bool_exp BEGINLOOP statements ENDLOOP
		{}
	| DO BEGINLOOP statements ENDLOOP WHILE bool_exp
		{}
	| READ vars
		{}
	| WRITE vars
		{}
	| CONTINUE
		{}
	| RETURN expression
		{};
	
statements: 
	statement SEMICOLON/* epsilon */
		{}
	| statement SEMICOLON statements
		{};

expression: 
	multiplicative_expression
		{ $$ = "_temp";}
	| multiplicative_expression ADD expression
		{
            char *src1 = $1;
            char *src2 = $3;
            char *dest = "_temp";
            printf("+ %s, %s, %s\n", dest, src1, src2);
            $$ = dest;

        }
	| multiplicative_expression SUB expression
		{
            char *src1 = $1;
            char *src2 = $3;
            char *dest = "_temp";
            printf("- %s, %s, %s\n", dest, src1, src2);
            $$ = dest;
        };

multiplicative_expression: 
	term
		{ $$ = $1; }
	| term MULT multiplicative_expression
		{ $$ = "FILL1"; }
	| term DIV multiplicative_expression
		{ $$ = "FILL2"; }
	| term MOD multiplicative_expression
		{ $$ = "FILL3"; };

term: 
	var
		{$$ = $1; }
	| SUB var
		{}
	| NUMBER
		{$$ = $1; }
	| SUB NUMBER
		{}
	| L_PAREN expression R_PAREN
		{}
	| SUB L_PAREN expression R_PAREN
		{}
	| ident L_PAREN expressions R_PAREN
		{};

expressions: 
	/* epsilon */
		{}
	| comma_sep_expressions
		{};

comma_sep_expressions: 
	expression
		{}
	| expression COMMA comma_sep_expressions
		{};

bool_exp:
	relation_and_exp
		{}
	| relation_and_exp OR bool_exp
		{};

relation_and_exp:
	relation_exp
		{}
	| relation_exp AND relation_and_exp
		{};

relation_exp:
	expression comp expression
		{}
	| NOT expression comp expression
		{}
	| TRUE
		{}
	| NOT TRUE
		{}
	| FALSE
		{}
	| NOT FALSE
		{}
	| L_PAREN bool_exp R_PAREN
		{}
	| NOT L_PAREN bool_exp R_PAREN
		{};

comp:
	EQ
		{}
	| NEQ
		{}
	| LT
		{}
	| GT
		{}
	| LTE
		{}
	| GTE
		{};

var: 
	ident
		{$$ = $1;}
	| ident L_SQUARE_BRACKET expression R_SQUARE_BRACKET
		{
            $$ = 0; /*test*/
        };
vars:
	var
		{}
	| var COMMA vars
		{};
	

%%

int main(int argc, char **argv)
{
    yyparse();

    int i = 0;
    printf("%s\n", list_of_function_names[2]);
    for(i = 0; i < count_names; i++) {
	printf("%s\n", list_of_function_names[i]);
    }
    return 0;
}

void yyerror(const char *msg)
{
   if(myError == 0)
   {
      printf("** Line %d: %s\n", currLine, msg);
      otherError = 1;
   }
   else
   {
      if(otherError == 1)
      {
         printf("   (%s)\n", msg);
         otherError = 0;
      }
   }
   myError = 0;
}
