%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	extern int yylex();
	extern int yyparse();
    void yyerror(const char *msg);
    extern int currLine;
    int myError = 0;
    int otherError = 0;
    
    char *identToken;
    char *compToken;
    int numberToken;
    int productionID = 0;
    char list_of_function_names[100][100];
    int numfuncs = 0;
	int inParam = 0;    
	int inArray = 0;
	
	//function call handling
	char funcParams[100][100];
	int funcRet[100];
	int numParams;

	//array assignment handling
	int firstArray = 1;
	char * lastSetIndex;

	//declaration handling 
	int numidents = 0;
	int numdecs = 0;
	char idents[100][100];
	int array[100];
	int asize[100];

    // FROM: https://www.gnu.org/software/bison/manual/html_node/Mfcalc-Symbol-Table.html
    typedef double (func_t) (double);

    struct symrec {
        char *name;
        char *id;
        char *type;
        int val;
        char *index;
        char *comp;
        char *code[4096];
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
	char *newDeclaration();
	char *newStatement();
    // we might need a temp var

//#define YYDEBUG 1
//yydebug=1;
%}


%union{
  int int_val;
  char *op_val;
}

%define parse.error verbose
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
%type <op_val> EQ
%type <op_val> NEQ
%type <op_val> LT
%type <op_val> GT
%type <op_val> LTE
%type <op_val> GTE
%type <op_val> comp
%type <op_val> var
%type <op_val> ident
%type <op_val> expression
%type <op_val> multiplicative_expression
%type <op_val> term
%type <op_val> identifiers
%type <op_val> statement
%type <op_val> vars
%type <op_val> relation_exp
%type <op_val> function
%type <op_val> declarations_param
%type <op_val> declarations_local
%type <op_val> statements
%type <op_val> function_ident
%type <op_val> bool_exp
%type <op_val> end_body
%%

prog_start: 
	functions
		{
            //printf("here");
			int foundmain = 0;
			char * maintext = "main";
			int i = 0;
			for(i = 0; i < numfuncs; i++){
				if(!strcmp(list_of_function_names[i], maintext)){
					foundmain = 1;
					if(funcRet[i] == 1){
						printf("** Line %d: Main function should not return\n", currLine);
						exit(0);
					}
				}else if(funcRet[i] != 1){
					printf("** Line %d: Non-main function '%s' does not return scalar\n", 
					currLine, list_of_function_names[i]);
					exit(0);
				}
			}
			if(!foundmain){
				printf("** Line %d: Missing main function\n", currLine);
				exit(0);
			}
		};

functions: 
	/* epsilon */
		{}
	| function functions
		{};

function: function_ident
	SEMICOLON
	BEGIN_PARAMS declarations_param END_PARAMS
	BEGIN_LOCALS declarations_local END_LOCALS
	BEGIN_BODY statements end_body
		{
            symrec *function_ident = getsym($1);
            symrec *declarations_param = getsym("declarations_param_");
            symrec *declarations_local = getsym("declarations_local_");
            symrec *statements = getsym($10);

            printf("%s", function_ident->code);
            printf("%s",declarations_param->code);
            printf("%s",declarations_local->code);
            printf("%s", statements->code);
            printf("%s", $11); // (bryan): just returns the string, idk maybe not the best way
        };

end_body: END_BODY {
    $$ = "endfunc\n\n";
}

function_ident: FUNCTION ident 
{
    // function ident runs before declarations_local, declarations_param, statements
    putsym("declarations_param_", "d");
    putsym("declarations_local_", "d");
    putsym("statements_", "s");

    char *token = identToken;
    char *code = (char *) malloc (sizeof (char));
    symrec *function_ident = putsym($2, "f");

    sprintf(code, "func %s\n", token);
    strcat(function_ident->code, code);

    strcpy(list_of_function_names[numfuncs], token);
    numfuncs++;

    $$ = function_ident->name;
};

ident:
	IDENT
		{
            
		};

declarations_local: 
	/* epsilon */
		{}
	| declaration SEMICOLON declarations_local
		{

            symrec *declarations_local = getsym("declarations_local_");

            int i = 0;
            for( i = 0; i < numidents; i++){
                putsym(idents[i], "i");
                char *code = (char *) malloc (sizeof (char));

                if(array[i]){
                    //set symbol in table to array
                    updatesym (idents[i], "t" , "a");

                    sprintf(code, ".[] %s, %d \n", idents[i], asize[i]);
                    strcat(declarations_local->code, code);

                }else{
                    //set symbol in table to int
                    updatesym (idents[i], "t" , "i");

                    sprintf(code, ". %s\n", idents[i]);
                    strcat(declarations_local->code, code);
                }
            }
            numidents = 0;
            numdecs = 0;

            $$ = "declarations_local_";

		};

declarations_param: 
	/* epsilon */
		{}
	| declaration SEMICOLON declarations_param
		{

            symrec *declarations_param = getsym("declarations_param_");
            int i = 0;
            for(i = 0; i < numidents; i++){
                putsym(idents[i], "i");

                char *code = (char *) malloc (sizeof (char));
                if(array[i]){

                    sprintf(code, ".[] %s, %d\n", idents[i], asize[i]);
                    strcat(declarations_param->code, code);

                }else{
                    sprintf(code, ". %s\n", idents[i]);
                    strcat(declarations_param->code, code);
                }
                //set symbol in table to int
                updatesym(idents[i], "t" , "i");

                sprintf(code, "= %s, $%d\n", idents[i], i);
                strcat(declarations_param->code, code);

                //printf("= %s, $%d\n", idents[i], i);
            }
            numidents = 0;
            numdecs = 0;

            $$ = "declarations_param_";

        };


declaration: 
	identifiers COLON INTEGER
		{
		int i = 0;
		for(i = 0; i < numdecs; i++){
			array[numidents + i] = 0;
		}
		numidents += numdecs; numdecs = 0;
        }
	| identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER
		{
		int i = 0;
		for(i = 0; i < numdecs; i++){
			array[numidents + i] = 1;
			asize[numidents + i] = atoi($5);
		}
		numidents += numdecs; numdecs = 0;
};

identifiers: 
	ident
    {   
		$$ = $1;
		//printf("NEW TOKEN ADDED: %s, num tokens: %d\n", $1, numidents+numdecs);
		strcpy(idents[numidents + numdecs], $1);
  		numdecs ++;
    }
	| ident COMMA identifiers
	{
		//printf("NEW TOKEN ADDED: %s, num tokens: %d\n", $1, numidents+numdecs);
		strcpy(idents[numidents + numdecs], $1);
  		numdecs ++;
	    $$ = $1;
	    symrec *token = getsym($1);
	};

statement: 
	var ASSIGN expression
		{
            char *statementID = newStatement();
            symrec *thisStatement = putsym(statementID, "s");

			symrec *dest = getsym($1);
			symrec *src = getsym($3);
		    char *code = (char *) malloc (sizeof (char));

            // code from expression
            strcat(thisStatement->code, src->code);

			if(dest->type == "a") {
                sprintf(code, "[]= %s, %s, %s\n", dest->name, lastSetIndex, src->name);
                strcat(thisStatement->code, code);
			}
			else if(src->type == "a"){
                sprintf(code, "=[] %s, %s, %s\n", dest->name, src->name, src->index);
                strcat(thisStatement->code, code);
			}else{
                sprintf(code, "= %s, %s\n", dest->name, src->name);
                strcat(thisStatement->code, code);
			}

			firstArray = 1;
			$$ = thisStatement->name;
        }
	| IF bool_exp THEN statements ENDIF
		{

        }
	| IF bool_exp THEN statements ELSE statements ENDIF
		{
            char *statementID = newStatement();
            symrec *thisStatement = putsym(statementID, "s");
            char *code = (char *) malloc (sizeof (char));

            symrec *bool_exp = getsym($2);
            symrec *ifStatements = getsym($4);
            symrec *elseStatements = getsym($6);


        }
	| WHILE bool_exp BEGINLOOP statements ENDLOOP
		{ 
			printf("in loop\n");
		}
	| DO BEGINLOOP statements ENDLOOP WHILE bool_exp
		{}
	| READ vars
		{
            char *statementID = newStatement();
            symrec *thisStatement = putsym(statementID, "s");
            char *code = (char *) malloc (sizeof (char));
            
			
            symrec *src1 = getsym($2);
            if(src1->type == "a") {
                sprintf(code, ".[]< %s, %s\n", src1->name, src1->index);
                strcat(thisStatement->code, code);
            } else {
                sprintf(code, ".< %s\n", src1->name);
                strcat(thisStatement->code, code);
            }
			firstArray = 1;
            $$ = thisStatement->name;
		}
	| WRITE vars
		{

            char *statementID = newStatement();
            symrec *thisStatement = putsym(statementID, "s");

            char *code = (char *) malloc (sizeof (char));

			symrec *src1 = getsym($2);
			if(src1->type == "a") {
                sprintf(code, ".[]> %s, %s\n", src1->id, src1->index);
                strcat(thisStatement->code, code);
			} else {
                sprintf(code, ".> %s\n", src1->name);
                strcat(thisStatement->code, code);
			}

			firstArray = 1;

            $$ = thisStatement->name;
		}
	| CONTINUE
		{}
	| RETURN expression
		{
            char *statementID = newStatement();
            symrec *thisStatement = putsym(statementID, "s");

            symrec *src1 = getsym($2);
			funcRet[numfuncs-1] = 1;

            char *code = (char *) malloc (sizeof (char));

            sprintf(code, "ret %s\n", src1->name);
            strcat(thisStatement->code, code);
            $$ = thisStatement->name;
		};
	
statements: 
	statement SEMICOLON/* epsilon */
		{
            char *statementID = newStatement();
            symrec *thisStatement = putsym(statementID, "s");
            symrec *addCode = getsym($1);

            strcat(thisStatement->code, addCode->code);

            $$ = thisStatement->name;
        }
	| statement SEMICOLON statements
		{
            char *statementID = newStatement();
            symrec *thisStatement = putsym(statementID, "s");
            symrec *addCode = getsym($1);
            symrec *stms = getsym($3);

            strcat(thisStatement->code, addCode->code);
            strcat(thisStatement->code, stms->code);

            $$ = thisStatement->name;
        };
// expression needs to add code and return the temp variable the code evaluates to.
expression: 
	multiplicative_expression
		{ $$ = $1;}
	| multiplicative_expression ADD expression
		{

            symrec *src1 = getsym($1);
            symrec *src2 = getsym($3);
            char *destID = newTemp();
			symrec *dest = putsym(destID, "t");

            char *codeInit = (char *) malloc (sizeof (char));
            char *code = (char *) malloc (sizeof (char));

            // Add code for multiplicative_expression and expression
            strcat(dest->code, src1->code);
            strcat(dest->code, src2->code);

            sprintf(codeInit, ". %s\n", dest->name);
            strcat(dest->code, codeInit);

            sprintf(code, "+ %s, %s, %s\n", dest->name, src1->name, src2->name);
            strcat(dest->code, code);

			$$ = dest->name;

        }
	| multiplicative_expression SUB expression
		{
			symrec *src1 = getsym($1);
            symrec *src2 = getsym($3);
            char *destID = newTemp();
            symrec *dest = putsym(destID, "t");
            

            char *codeInit = (char *) malloc (sizeof (char));
            char *code = (char *) malloc (sizeof (char));

            // Add code for multiplicative_expression and expression
            strcat(dest->code, src1->code);
            strcat(dest->code, src2->code);

            sprintf(codeInit, ". %s\n", dest->name);
            strcat(dest->code, codeInit);

            sprintf(code, "- %s, %s, %s\n", dest->name, src1->name, src2->name);
            strcat(dest->code, code);

            $$ = dest->name;
        };

multiplicative_expression: 
	term
		{ 
			$$ = $1;
	    }
	| term MULT multiplicative_expression
		{ 
			symrec *src1 = getsym($1);
            symrec *src2 = getsym($3);
            char *destID = newTemp();
            symrec *dest = putsym(destID, "t");
            printf(". %s\n", dest->name);
            printf("* %s, %s, %s\n", dest->name, src1->name, src2->name);
            $$ = dest->name;
		}
	| term DIV multiplicative_expression
		{ 	symrec *src1 = getsym($1);
            symrec *src2 = getsym($3);
            char *destID = newTemp();
            symrec *dest = putsym(destID, "t");
            printf(". %s\n", dest->name);
            printf("/ %s, %s, %s\n", dest->name, src1->name, src2->name);
            $$ = dest->name; 
			}
	| term MOD multiplicative_expression
		{ 	symrec *src1 = getsym($1);
            symrec *src2 = getsym($3);
            char *destID = newTemp();
            symrec *dest = putsym(destID, "t");
            printf(". %s\n", dest->name);
            printf("%% %s, %s, %s\n", dest->name, src1->name, src2->name);
            $$ = dest->name;
		};

term: 
	var
		{
		char *varID = newTemp();
		symrec *tempvar = putsym(varID, "t");	
		symrec *src1 = getsym($1);
        

        char *codeInit = (char *) malloc (sizeof (char)); // temp variable delcaration
        char *code = (char *) malloc (sizeof (char));
        

		if(src1->type == "a"){
            sprintf(codeInit, ". %s\n", tempvar->name);
            strcat(tempvar->code, codeInit);

            sprintf(code, "=[] %s, %s, %s\n", tempvar->name, src1->name, src1->index);
            strcat(tempvar->code, code);

		}else{
            
            sprintf(codeInit, ". %s\n", tempvar->name);
            strcat(tempvar->code, codeInit);

            sprintf(code, "= %s, %s\n", tempvar->name, src1->name);
            strcat(tempvar->code, code);
		}
		
		$$ = tempvar->name; 
	    }
	| SUB var
		{}
	| NUMBER
	{	
		char *numID = newTemp();
		symrec *num = putsym(numID, "t");	

        char *codeInit = (char *) malloc (sizeof (char)); // temp variable delcaration
        char *code = (char *) malloc (sizeof (char));

        num->val = numberToken;
        sprintf(codeInit, ". %s\n", num->name);
        strcat(num->code, codeInit);

        sprintf(code, "= %s, %d\n", num->name, num->val);
        strcat(num->code, code);

		$$ = num->name; 
	}
	| SUB NUMBER
		{}
	| L_PAREN expression R_PAREN
		{ $$ = $2; }
	| SUB L_PAREN expression R_PAREN
		{}
	| ident L_PAREN expressions R_PAREN
	{  
		char *varID = newTemp();
		symrec *tempvar = putsym(varID, "t");	
		symrec *src1 = getsym($1);
		printf(". %s\n", tempvar->name);
		printf("call %s, %s\n", $1, tempvar->name);
		$$ = tempvar->name; 
		
	};

expressions: 
	/* epsilon */
		{}
	| comma_sep_expressions
		{	
			int i = numParams-1;
			for( i = numParams-1; i >= 0; i--){
				printf("param %s\n", funcParams[i]);
			}
			numParams = 0;
		};

comma_sep_expressions: 
	expression
	{ 
		symrec *src1 = getsym($1);
		strcpy(funcParams[numParams],src1->name);
		numParams++;
	}
	| expression COMMA comma_sep_expressions
	{
		symrec *src1 = getsym($1);
		strcpy(funcParams[numParams],src1->name);
		numParams++;
	};

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
		{
			char *compID = newTemp();
	        symrec *dest = putsym(compID, "t");
	        symrec *src1 = getsym($1);
	        symrec *src2 = getsym($3);
       		printf(". %s\n", dest->name);
        	printf("%s %s, %s, %s \n", $2,  dest->name, src1->name, src2->name);
        	//$$ = num->name;		
		}
	| NOT expression comp expression
		{
			// For the not
			char *compID1 = newTemp();
	        symrec *dest1 = putsym(compID1, "t");
			// For the comp
			char *compID2 = newTemp();
	        symrec *dest2 = putsym(compID2, "t");

	        symrec *src1 = getsym($2);
	        symrec *src2 = getsym($4);

       		printf(". %s\n", dest2->name);
			printf("%s %s, %s, %s \n", $3,  dest2->name, src1->name, src2->name);

       		printf(". %s\n", dest1->name);
        	printf("! %s, %s \n", dest1->name, dest2->name);
        	$$ = dest2->name;
		}
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
		{$$ = $1;}
	| NEQ
		{
			$$ = "!=";// Only one that is different
		}
	| LT
		{$$ = $1;}
	| GT
		{$$ = $1;}
	| LTE
		{$$ = $1;}
	| GTE
		{$$ = $1;};

var: 
	ident
		{$$ = $1;}
	|  ident L_SQUARE_BRACKET expression R_SQUARE_BRACKET
		{
			if(firstArray){
				lastSetIndex = $3;
				firstArray = 0;
			}
			//putsym($1, "a");
			updatesym($1, "i", $3);
            $$ = $1; /*test*/
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
  //res->value.var = 0; /* Set value to 0 even if fun. */
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
  printf("** Line %d: Undeclared variable: %s\n", currLine, name);
  exit(0);
  return NULL;
}

symrec *
updatesym (char const *name, char *attr, char *val)
{
//printf("GET: %s\n", name);
   symrec *p = sym_table;
  for (p = sym_table; p; p = p->next)
    if (strcmp (p->id, name) == 0)
		if(attr == "n"){
			p->name = val;
		}else if(attr == "t"){
			p->type = val;
		} else if (attr == "i") {
            p->index = val;
        }
      return p;
  return NULL;
}


int tempID = 0;
char *newTemp() {
	char *temp = (char *) malloc (sizeof (char));
    sprintf(temp, "__temp__%d", tempID);
    tempID++;
    return temp;
}

int declarationID = 0;
char *newDeclaration() {
	char *temp = (char *) malloc (sizeof (char));
    sprintf(temp, "__dec__%d", declarationID);
    declarationID++;
    return temp;
}

int statementID = 0;
char *newStatement() {
	char *temp = (char *) malloc (sizeof (char));
    sprintf(temp, "__state__%d", statementID);
    statementID++;
    return temp;
}

int regID = 0;
char *newReg() {
    char *temp = (char *) malloc (sizeof (char));
    sprintf(temp, "$%d", regID);
    regID++;
    return temp;
}


