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
	int numLabels = 0;
	
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
	#define numkeywords 26
	char *kws[numkeywords] = {
		"function",
		"beginparams",
		"endparams",
		"beginlocals",
		"endlocals",
		"beginbody",
		"endbody",
		"integer",
		"array",
		"of",
		"if",
		"then",
		"endif",
		"else",
		"while",
		"do",
		"beginloop",
		"endloop",
		"read",
		"write",
		"and",
		"or",
		"not",
		"true",
		"false",
		"return"
		};

	char idents[100][100];
	int array[100];
	int asize[100];
	char code[10000];

	//loop and branch handling
	int currentLoop = 0;
	int inLoop = 0;
	int numloops = 0;
	int maxdepth = 0;
    // FROM: https://www.gnu.org/software/bison/manual/html_node/Mfcalc-Symbol-Table.html
    typedef double (func_t) (double);

    struct symrec {
	char *name;
	char *id;
	char *type;
	int val;
	char *index;
	char *comp;
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
	char *newLabel();
	char *newEndLoop();
	char *newBeginLoop();
    // we might need a temp var

//#define YYDEBUG 1
//yydebug=1;
%}


%union{
  int int_val;
  struct{
	char *name;
	char code[10000];
  } op_val;
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
%type <op_val> expressions
%type <op_val> comma_sep_expressions
%type <op_val> end_body
%type <op_val> statements
%type <op_val> bool_exp
%type <op_val> relation_and_exp
%type <op_val> beginloop
%%

prog_start: 
	functions
		{
			int foundmain = 0;
			char * maintext = "main";
			int i = 0;
			for(i = 0; i < numfuncs; i++){
				if(!strcmp(list_of_function_names[i], maintext)){
					foundmain = 1;
					if(funcRet[i] == 1){
						printf("** Line %d: Main function should not return\n", currLine);
					}
				}else if(funcRet[i] != 1){
					printf("** Line %d: Non-main function '%s' does not return scalar\n", 
					currLine, list_of_function_names[i]);
				}
			}
			if(!foundmain){
				printf("** Line %d: Missing main function\n", currLine);
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
			printf("%s",$10.code);
			printf("%s",$11.code);
			strcpy(code,"");
		};

end_body: END_BODY {
    sprintf($$.code,"endfunc\n\n");
}

function_ident: FUNCTION ident 
{
	char *token = identToken;
	putsym($2.name, "f");
	printf("func %s\n", token);
	strcpy(list_of_function_names[numfuncs], token);
    numfuncs++;
};

ident:
	IDENT
		{
			// $$ = $1;
			// symrec *temp = getsym($1);
			// /*
			// 	KEY:
			// 	a = array
			// 	i = var
			// 	f = func
			// */
			// if(temp == NULL) {
			// 	if(inArray){
			// 		putsym($1, "a");
			// 	} else {
			// 	    putsym($1, "i");
			// 	}
			// } 
		};

declarations_local: 
	/* epsilon */
		{}
	| declaration SEMICOLON declarations_local
		{
		//check if duplicates in idents
		int id1 = 0; int id2 = 0; int kw = 0;
		for( id1 = 0; id1 < numidents; id1++){
			
			for( id2 = 0; id2 < id1; id2++){
				if(id1 == id2){
					continue;
				}
				if(strcmp(idents[id1], idents[id2]) == 0){
					printf("** Line %d: identifier %s is already declared\n", currLine, idents[id1]);
				}
			}
			
			for(kw = 0; kw < numkeywords; kw++){
				if(strcmp(idents[id1],  kws[kw]) == 0){
					printf("** Line %d: identifier name %s is a restricted keyword\n", currLine, idents[id1]);
				}
			}
		}

		int i = 0;
		for( i = 0; i < numidents; i++){
			putsym(idents[i], "i");
			if(array[i]){
			//set symbol in table to array
			updatesym (idents[i], "t" , "a");
			if(asize[i] <= 0){
				printf("** Line %d: Array %s must of at least size 1 \n", currLine, idents[i]);
			}
			printf(".[] %s, %d \n", idents[i], asize[i]);
			}else{
			//set symbol in table to int
			updatesym (idents[i], "t" , "i");
			printf(". %s\n", idents[i]);
			}
		}
		numidents = 0;
		numdecs = 0;
		};

declarations_param: 
	/* epsilon */
		{}
	| declaration SEMICOLON declarations_param
		{
		//check if duplicates in idents
		int id1 = 0; int id2 = 0; int kw = 0;
		for( id1 = 0; id1 < numidents; id1++){
			
			for( id2 = 0; id2 < id1; id2++){
				if(id1 == id2){
					continue;
				}
				if(strcmp(idents[id1], idents[id2]) == 0){
					printf("** Line %d: identifier %s is already declared\n", currLine, idents[id1]);
				}
			}
			
			for(kw = 0; kw < numkeywords; kw++){
				if(strcmp(idents[id1],  kws[kw]) == 0){
					printf("** Line %d: identifier name %s is a restricted keyword\n", currLine, idents[id1]);
				}
			}
		}

		int i = 0;
		for(i = 0; i < numidents; i++){
			putsym(idents[i], "i");
			if(array[i]){
			printf(".[] %s, %d\n", idents[i], asize[i]);
			}else{
			printf(". %s\n", idents[i]);
			}
			//set symbol in table to int
			updatesym (idents[i], "t" , "i");
			printf("= %s, $%d\n", idents[i], i);
		}
		numidents = 0;
		numdecs = 0;
		
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
			asize[numidents + i] = atoi($5.name);
		}
		numidents += numdecs; numdecs = 0;
};

identifiers: 
	ident
    {   
		$$.name = $1.name;
		//printf("NEW TOKEN ADDED: %s, num tokens: %d\n", $1, numidents+numdecs);
		strcpy(idents[numidents + numdecs], $1.name);
  		numdecs ++;
    }
	| ident COMMA identifiers
	{
		$$.name = $1.name;
		//printf("NEW TOKEN ADDED: %s, num tokens: %d\n", $1, numidents+numdecs);
		strcpy(idents[numidents + numdecs], $1.name);
  		numdecs ++;
	};

statement: 
	var ASSIGN expression
		{
			symrec *dest = getsym($1.name);
			symrec *src = getsym($3.name);
			//printf("last set index: %s\n", lastSetIndex);
            strcat($$.code, $3.code);
			if(dest->type == "a") {
            	sprintf(code,"[]= %s, %s, %s\n", dest->name, lastSetIndex, src->name);
				strcat($$.code,code);
			}
			else if(src->type == "a"){
				sprintf(code,"=[] %s, %s, %s\n", dest->name, src->name, src->index);
				strcat($$.code,code);
			}else{
				sprintf(code,"= %s, %s\n", dest->name, src->name);
				strcat($$.code,code);
			}
			//updatesym($3, "n", dest->name);
			symrec *dest2 = getsym($1.name);
			firstArray = 1;
			$$.name = dest->name;
			
        }
	| IF bool_exp THEN statements ENDIF
		{

			char *endIfLabel = newLabel();

			strcat($$.code,$2.code); // bool_exp code

			sprintf(code,"! %s, %s\n", $2.name, $2.name);
			strcat($$.code, code);

			sprintf(code,"?:= %s, %s\n", endIfLabel, $2.name); // check
			strcat($$.code, code); 

			strcat($$.code,$4.code); //  code for if
			sprintf(code,":= %s\n", endIfLabel); // go to endif
			strcat($$.code, code); 

			sprintf(code,": %s\n", endIfLabel); // endif label
			strcat($$.code, code); 
		}
	| IF bool_exp THEN statements ELSE statements ENDIF
		{
			char *elseLabel = newLabel();
			char *endIfLabel = newLabel();

			strcat($$.code,$2.code); // bool_exp code

			sprintf(code,"! %s, %s\n", $2.name, $2.name);
			strcat($$.code, code);

			sprintf(code,"?:= %s, %s\n", elseLabel, $2.name); // check
			strcat($$.code, code); 

			strcat($$.code,$4.code); //  code for if
			sprintf(code,":= %s\n", endIfLabel); // go to endif
			strcat($$.code, code); 

			sprintf(code,": %s\n", elseLabel); // else label
			strcat($$.code, code); 
			strcat($$.code,$6.code); // code for else

			sprintf(code,": %s\n", endIfLabel); // endif label
			strcat($$.code, code); 
		}
	| WHILE bool_exp beginloop statements endloop 
		{

			char *loopBegin = $3.code;
			char *loopEnd = newEndLoop();

			sprintf(code,": %s\n", loopBegin);
			strcat($$.code, code); // bool_exp code

			strcat($$.code,$2.code); // bool_exp code
			sprintf(code,"! %s, %s\n", $2.name, $2.name);
			strcat($$.code, code); 

			sprintf(code, "?:= %s, %s\n", loopEnd,$2.name);
			strcat($$.code,code);

			strcat($$.code,$4.code);

			sprintf(code, ":= %s\n: %s\n", loopBegin, loopEnd);
			strcat($$.code,code);
		}
	| DO beginloop statements endloop WHILE bool_exp
		{
			char *loopBegin = $2.code;

			sprintf(code, ": %s\n", loopBegin);
			strcat($$.code,code);
			strcat($$.code,$3.code);
			strcat($$.code,code);
			strcat($$.code,$6.code);
			sprintf(code, "?:= %s, %s\n",loopBegin,$6.name);
			strcat($$.code,code);
		}
	| READ vars
		{
			symrec *src1 = getsym($2.name);
            if(src1->type == "a") {
                sprintf(code,".[]< %s, %s\n", src1->name, src1->index);
				strcat($$.code,code);
				
            } else {
                sprintf(code,".< %s\n", src1->name);
				strcat($$.code,code);
            }
			firstArray = 1;
		}
	| WRITE vars
		{
			symrec *src1 = getsym($2.name);
            strcat($$.code,$2.code);
			if(src1->type == "a") {
				sprintf(code,".[]> %s, %s\n", src1->id, src1->index);
				strcat($$.code,code);
			} else {
				sprintf(code,".> %s\n", src1->name);
				strcat($$.code,code);
			}
			firstArray = 1;
		}
	| CONTINUE
		{
			if(inLoop <= 0) {
				printf("** Line %d: continue statement outside loop\n", currLine);
			}

			sprintf(code, ":= __BeginLoop__%d\n", currentLoop);
			strcat($$.code,code);
		}
	| RETURN expression
		{
			strcat($$.code, $2.code);
			symrec *src1 = getsym($2.name);
			funcRet[numfuncs-1] = 1;
			sprintf(code,"ret %s\n", src1->name);
			strcat($$.code,code);
		};
beginloop: BEGINLOOP {

	inLoop++;
	currentLoop++;
	if(currentLoop > maxdepth){
		maxdepth = currentLoop;
	}

	char loopBegin[15];
	sprintf(loopBegin,"__BeginLoop__%d", currentLoop);
	strcat($$.code,loopBegin);
}

endloop: ENDLOOP {
	inLoop--;
	currentLoop--;
	if(inLoop==0){
		currentLoop+=maxdepth;
		maxdepth = 0;
	}
}

statements: 
	statement SEMICOLON/* epsilon */
		{
			//strcat($$.code,$1.code);
		}
	| statement SEMICOLON statements
		{	
			//strcat($$.code,$1.code);
			strcat($$.code,$3.code);
		};

expression: 
	multiplicative_expression
		{ 
			$$.name = $1.name;
			//strcat($$.code, $1.code);
		}
	| multiplicative_expression ADD expression
		{
			
            symrec *src1 = getsym($1.name);
            symrec *src2 = getsym($3.name);

            //strcat($$.code,$1.code);
            strcat($$.code,$3.code);

            char *destID = newTemp();
			symrec *dest = putsym(destID, "t");
            sprintf(code,". %s\n", dest->name);
			strcat($$.code,code);
            sprintf(code,"+ %s, %s, %s\n", dest->name, src1->name, src2->name);
			strcat($$.code,code);
			$$.name = dest->name;

        }
	| multiplicative_expression SUB expression
		{
			symrec *src1 = getsym($1.name);
            symrec *src2 = getsym($3.name);
            char *destID = newTemp();
            symrec *dest = putsym(destID, "t");
            sprintf(code,". %s\n", dest->name);
			strcat($$.code,code);
            sprintf(code,"- %s, %s, %s\n", dest->name, src1->name, src2->name);
			strcat($$.code,code);
            $$.name = dest->name;
        };

multiplicative_expression: 
	term
		{ 
			$$.name = $1.name;
			//strcpy($$.code, $1.code);
			
		}
	| term MULT multiplicative_expression
		{ 
			symrec *src1 = getsym($1.name);
            symrec *src2 = getsym($3.name);
            char *destID = newTemp();
            //strcat($$.code,$1.code);
            strcat($$.code,$3.code);
            symrec *dest = putsym(destID, "t");
            sprintf(code,". %s\n", dest->name);
			strcat($$.code,code);
            sprintf(code,"* %s, %s, %s\n", dest->name, src1->name, src2->name);
			strcat($$.code,code);
            $$.name = dest->name;
		}
	| term DIV multiplicative_expression
		{ 	symrec *src1 = getsym($1.name);
            symrec *src2 = getsym($3.name);
            char *destID = newTemp();
			strcat($$.code,$3.code);
            symrec *dest = putsym(destID, "t");
            sprintf(code,". %s\n", dest->name);
			strcat($$.code,code);
            sprintf(code,"/ %s, %s, %s\n", dest->name, src1->name, src2->name);
			strcat($$.code,code);
            $$.name = dest->name; 
			}
	| term MOD multiplicative_expression
		{ 	symrec *src1 = getsym($1.name);
            symrec *src2 = getsym($3.name);
            char *destID = newTemp();
			strcat($$.code,$3.code);
            symrec *dest = putsym(destID, "t");
            sprintf(code,". %s\n", dest->name);
			strcat($$.code,code);
            sprintf(code,"%% %s, %s, %s\n", dest->name, src1->name, src2->name);
			strcat($$.code,code);
            $$.name = dest->name;
			};

term: 
	var
		{
		char *varID = newTemp();
		symrec *tempvar = putsym(varID, "t");	
		symrec *src1 = getsym($1.name);
		if(src1->type == "a"){
			sprintf(code,". %s\n", tempvar->name);
			strcat($$.code,code);
			sprintf(code,"=[] %s, %s, %s\n", tempvar->name, src1->name, src1->index);
			strcat($$.code,code);
		}else{
			sprintf(code,". %s\n", tempvar->name);
			strcat($$.code,code);
			sprintf(code,"= %s, %s\n", tempvar->name, src1->name);
			strcat($$.code,code);
		}
		
		$$.name = tempvar->name; 
	    }
	| SUB var
		{}
	| NUMBER
	{	
		char *numID = newTemp();
		symrec *num = putsym(numID, "t");	
		num->val = numberToken;
		sprintf(code,". %s\n", num->name);
		strcat($$.code,code);
		sprintf(code,"= %s, %d\n", num->name, num->val);
		strcat($$.code,code);
		$$.name = num->name; 
	}
	| SUB NUMBER
		{ 
			strcat($$.code,$2.code);
		}
	| L_PAREN expression R_PAREN
		{ 
            strcat($$.code,$2.code);
            $$.name = $2.name;
        }
	| SUB L_PAREN expression R_PAREN
		{
			strcat($$.code,$3.code);
		}
	| ident L_PAREN expressions R_PAREN
	{  
		strcat($$.code,$3.code);
		char *varID = newTemp();
		symrec *tempvar = putsym(varID, "t");	
		symrec *src1 = getsym($1.name);
		sprintf(code,". %s\n", tempvar->name);
		strcat($$.code,code);
		sprintf(code,"call %s, %s\n", $1.name, tempvar->name);
		strcat($$.code,code);
		$$.name = tempvar->name; 
		
	};

expressions: 
	/* epsilon */
		{}
	| comma_sep_expressions
		{
			for(int i = numParams-1; i >= 0; i--){
				sprintf(code,"param %s\n", funcParams[i]);
				strcat($$.code,code);
			}
			numParams = 0;
		};

comma_sep_expressions: 
	expression
	{ 
		//strcat($$.code, $1.code);
		symrec *src1 = getsym($1.name);
		strcpy(funcParams[numParams],src1->name);
		numParams++;
	}
	| expression COMMA comma_sep_expressions
	{
		//strcat($$.code, $1.code);
		strcat($$.code, $3.code);
		symrec *src1 = getsym($1.name);
		strcpy(funcParams[numParams],src1->name);
		numParams++;
	};

bool_exp:
	relation_and_exp
		{$$ = $1;}
	| relation_and_exp OR bool_exp
		{};

relation_and_exp:
	relation_exp
		{$$ = $1;}
	| relation_exp AND relation_and_exp
		{};

relation_exp:
	expression comp expression
		{
			char *compID = newTemp();
	        symrec *dest = putsym(compID, "t");
	        symrec *src1 = getsym($1.name);
	        symrec *src2 = getsym($3.name);

			strcat($$.code,$3.code);

       		sprintf(code,". %s\n", dest->name);
			strcat($$.code,code);
        	sprintf(code,"%s %s, %s, %s \n", $2.name,  dest->name, src1->name, src2->name);
			strcat($$.code,code);

        	$$.name = dest->name;	
		}
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
		{$$.name = $1.name;}
	| NEQ
		{
			$$.name = "!=";// Only one that is different
		}
	| LT
		{$$.name = $1.name;}
	| GT
		{$$.name = $1.name;}
	| LTE
		{$$.name = $1.name;}
	| GTE
		{$$.name = $1.name;};

var: 
	ident
		{
			$$.name = $1.name;
			symrec *src1 = getsym($1.name);
			if(strcmp(src1->type, "a") == 0){
				printf("** Line %d: used array variable %s is missing a specified index\n", currLine, $1.name);
			}
		}
	|  ident L_SQUARE_BRACKET expression R_SQUARE_BRACKET
		{
			if(firstArray){
				lastSetIndex = $3.name;
				firstArray = 0;
			}
			symrec *src1 = getsym($1.name);
			if(strcmp(src1->type, "a") != 0){
				printf("** Line %d: Attempting to get index of non-array %s\n", currLine, $1.name);
			}
             strcat($$.code,$3.code);
			//putsym($1, "a");
			updatesym($1.name, "i", $3.name);
            $$.name = $1.name; /*test*/
        };
vars:
	var
		{
			$$.name = $1.name;
			strcat($$.code,$1.code);
		}
	| var COMMA vars
		{
			strcat($$.code,$1.code);
			strcat($$.code,$3.code);
		};
	

%%

int main(int argc, char **argv)
{
    yyparse();
/*
    int i = 0;
    sprintf($$.code,"%s\n", list_of_function_names[2]);
    for(i = 0; i < count_names; i++) {
	sprintf($$.code,"%s\n", list_of_function_names[i]);
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
  printf("** Line %d: Undeclared variable: %s\n", currLine, name);
  return sym_table;
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

int regID = 0;
char *newReg() {
    char *temp = (char *) malloc (sizeof (char));
    sprintf(temp, "$%d", regID);
    regID++;
    return temp;
}

int labelID = 0;
char *newLabel() {
    char *temp = (char *) malloc (sizeof (char));
    sprintf(temp, "__label__%d", labelID);
    labelID++;
    return temp;
}

char *newBeginLoop() {
    char *temp = (char *) malloc (sizeof (char));
    sprintf(temp, "__BeginLoop__%d", currentLoop);
    return temp;
}

char *newEndLoop() {
    char *temp = (char *) malloc (sizeof (char));
    sprintf(temp, "__EndLoop__%d", currentLoop);
    return temp;
}

