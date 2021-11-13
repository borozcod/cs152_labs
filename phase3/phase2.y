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
	int inParam = 0;    
	int inArray = 0;    
    // FROM: https://www.gnu.org/software/bison/manual/html_node/Mfcalc-Symbol-Table.html
    typedef double (func_t) (double);

    struct symrec {
	char *name;
	char *id;
	char *type;
	int val;
	union
	{
	    double var;
	    func_t *fun;
	} value;
	struct symrec *next;
	
    };
    typedef struct symrec symrec;
    extern symrec *sym_table;
    symrec *putsym (char const *name, char *sym_type);
    symrec *getsym (char const *name);
    symrec *updatesym (char const *name, char *attr, char *val);
	char *newTemp();
	char *newReg();
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
%type <op_val> identifiers
%type <op_val> statement
%type <op_val> vars
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
	BEGIN_PARAMS {inParam = 1;} declarations END_PARAMS
	BEGIN_LOCALS {inParam = 0;} declarations END_LOCALS
	BEGIN_BODY statements end_body
		{};

end_body: END_BODY {
    printf("endfunc\n");
}

function_ident: FUNCTION ident 
{
	char *token = identToken;
	printf("func %s\n", token);
    count_names++;
}

ident:
	IDENT
		{
			$$ = $1;
			symrec *temp = getsym($1);
			if(temp == NULL) {
				putsym($1, "i");
			} 
		};

declarations: 
	/* epsilon */
		{}
	| declaration SEMICOLON declarations
		{};


declaration: 
	identifiers COLON INTEGER
		{
        }
	| identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER
		{
	symrec *token = getsym($1);
	char *num = $5;
	printf(".[] %s, %s\n", token->name, num);
};

identifiers: 
	ident
    {
		symrec *res = getsym($1);
        printf(". %s\n", res->name);
 		if(inParam == 1) {
			printf("= %s, %s\n", res->name, newReg());
		}           
		$$ = $1;
    }
	| ident COMMA identifiers
	{
	    $$ = $1;
	    symrec *token = getsym($1);
        printf(". %s\n", token->name);
	};

statement: 
	var ASSIGN expression
		{
			symrec *dest = getsym($1);
			symrec *src = getsym($3);

            printf("= %s, %s\n", dest->name, src->name);
			updatesym($1, "n", src->name);
			symrec *dest2 = getsym($1);
			$$ = dest->name;
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
		{
		  symrec *src1 = getsym($2);
		  printf(".< %s\n", src1->name);
		}
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
		{ $$ = $1;}
	| multiplicative_expression ADD expression
		{
            symrec *src1 = getsym("b");
            symrec *src2 = getsym($3);
            char *destID = newTemp();
			symrec *dest = putsym(destID, "t");
            printf(". %s\n", dest->name);
            printf("+ %s, %s, %s\n", dest->name, src1->name, src2->name);
			$$ = dest->name;

        }
	| multiplicative_expression SUB expression
		{
			symrec *src1 = getsym($1);
            symrec *src2 = getsym($3);
            char *destID = newTemp();
            symrec *dest = putsym(destID, "t");
            printf(". %s\n", dest->name);
            printf("- %s, %s, %s\n", dest->name, src1->name, src2->name);
            $$ = dest->name;
        };

multiplicative_expression: 
	term
		{ 
			symrec *src1 = getsym($1);
			$$ = $1;
	}
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
	{	
		char *numID = newTemp();
		symrec *num = putsym(numID, "t");	
		num->val = numberToken;
		printf(". %s\n", num->name);
		printf("= %s, %d\n", num->name, num->val);
		$$ = num->name; 
	}
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
		{$$ = $1;}
	| var COMMA vars
		{};
	

%%

int main(int argc, char **argv)
{
    yyparse();
/*
    int i = 0;
    printf("%s\n", list_of_function_names[2]);
    for(i = 0; i < count_names; i++) {
	printf("%s\n", list_of_function_names[i]);
    }
    */
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

symrec *sym_table;
symrec *
putsym (char const *name, char *sym_type)
{
  symrec *res = (symrec *) malloc (sizeof (symrec));
  res->id = strdup (name);
  res->name = strdup (name);
  res->type = sym_type;
 // res->val = NULL;
  res->value.var = 0; /* Set value to 0 even if fun. */
  res->next = sym_table;
  sym_table = res;
  return res;
}


symrec *
getsym (char const *name)
{
//printf("GET: %s\n", name);
   symrec *p = sym_table;
  for (p = sym_table; p; p = p->next)
    if (strcmp (p->id, name) == 0)
      return p;
  return NULL;
}

symrec *
updatesym (char const *name, char *attr, char *val)
{
//printf("GET: %s\n", name);
   symrec *p = sym_table;
  for (p = sym_table; p; p = p->next)
    if (strcmp (p->id, name) == 0)
		if(attr = "n"){
			p->name = val;
		}
      return p;
  return NULL;
}


int tempID = 0;
char *newTemp() {
	char *temp = (char *) malloc (sizeof (char));
    sprintf(temp, "__temp%d__", tempID);
    tempID++;
    return temp;
}

int regID = 0;
char *newReg() {
    char *temp = (char *) malloc (sizeof (char));
    sprintf(temp, "$%d", regID);
    regID++;
    return temp;
}


