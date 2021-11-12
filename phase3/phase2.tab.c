/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 1 "phase2.y" /* yacc.c:339  */

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
    
    // FROM: https://www.gnu.org/software/bison/manual/html_node/Mfcalc-Symbol-Table.html
    typedef double (func_t) (double);

    struct symrec {
	char *name;
	char *type;
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
    // we might need a temp var

//#define YYDEBUG 1
//yydebug=1;

#line 104 "phase2.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* In a future release of Bison, this section will be replaced
   by #include "phase2.tab.h".  */
#ifndef YY_YY_PHASE2_TAB_H_INCLUDED
# define YY_YY_PHASE2_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    BEGIN_PARAMS = 258,
    END_PARAMS = 259,
    BEGIN_LOCALS = 260,
    END_LOCALS = 261,
    BEGIN_BODY = 262,
    END_BODY = 263,
    FUNCTION = 264,
    RETURN = 265,
    MAIN = 266,
    L_SQUARE_BRACKET = 267,
    R_SQUARE_BRACKET = 268,
    INTEGER = 269,
    ARRAY = 270,
    OF = 271,
    IF = 272,
    THEN = 273,
    ENDIF = 274,
    ELSE = 275,
    WHILE = 276,
    DO = 277,
    BEGINLOOP = 278,
    ENDLOOP = 279,
    CONTINUE = 280,
    READ = 281,
    WRITE = 282,
    AND = 283,
    OR = 284,
    NOT = 285,
    TRUE = 286,
    FALSE = 287,
    SUB = 288,
    ADD = 289,
    MULT = 290,
    DIV = 291,
    MOD = 292,
    EQ = 293,
    NEQ = 294,
    LT = 295,
    GT = 296,
    LTE = 297,
    GTE = 298,
    SEMICOLON = 299,
    COLON = 300,
    COMMA = 301,
    L_PAREN = 302,
    R_PAREN = 303,
    ASSIGN = 304,
    NUMBER = 305,
    IDENT = 306
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 40 "phase2.y" /* yacc.c:355  */

  int int_val;
  char *op_val;

#line 201 "phase2.tab.c" /* yacc.c:355  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PHASE2_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 218 "phase2.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  8
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   150

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  52
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  23
/* YYNRULES -- Number of rules.  */
#define YYNRULES  65
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  136

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   306

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    72,    72,    77,    78,    81,    88,    92,   101,   106,
     107,   112,   115,   122,   129,   137,   144,   146,   148,   150,
     152,   154,   156,   158,   162,   164,   168,   170,   179,   189,
     191,   193,   195,   199,   201,   203,   205,   207,   209,   211,
     216,   217,   221,   223,   227,   229,   233,   235,   239,   241,
     243,   245,   247,   249,   251,   253,   257,   259,   261,   263,
     265,   267,   271,   273,   278,   280
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "BEGIN_PARAMS", "END_PARAMS",
  "BEGIN_LOCALS", "END_LOCALS", "BEGIN_BODY", "END_BODY", "FUNCTION",
  "RETURN", "MAIN", "L_SQUARE_BRACKET", "R_SQUARE_BRACKET", "INTEGER",
  "ARRAY", "OF", "IF", "THEN", "ENDIF", "ELSE", "WHILE", "DO", "BEGINLOOP",
  "ENDLOOP", "CONTINUE", "READ", "WRITE", "AND", "OR", "NOT", "TRUE",
  "FALSE", "SUB", "ADD", "MULT", "DIV", "MOD", "EQ", "NEQ", "LT", "GT",
  "LTE", "GTE", "SEMICOLON", "COLON", "COMMA", "L_PAREN", "R_PAREN",
  "ASSIGN", "NUMBER", "IDENT", "$accept", "prog_start", "functions",
  "function", "end_body", "function_ident", "ident", "declarations",
  "declaration", "identifiers", "statement", "statements", "expression",
  "multiplicative_expression", "term", "expressions",
  "comma_sep_expressions", "bool_exp", "relation_and_exp", "relation_exp",
  "comp", "var", "vars", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306
};
# endif

#define YYPACT_NINF -57

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-57)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      20,   -17,    19,   -57,    20,    -5,   -57,   -57,   -57,   -57,
      48,   -17,     8,    51,    14,    26,   -17,    60,   -17,    17,
     -57,   -17,   -57,   -57,    62,    73,    25,    74,    75,    79,
      66,    10,    87,    87,    63,   -57,   -17,   -17,    78,    43,
      83,    44,    84,   -39,    10,   -57,    -9,   -57,   -20,   -30,
     -57,    -6,   -57,   -57,    87,    69,    85,    92,    86,    90,
      79,    56,   -57,   -57,    10,    79,   -57,   -57,    10,   -57,
      10,   -57,   -57,    76,    10,    10,    10,    10,    10,    10,
     -57,   -57,    87,    69,   101,    77,   -57,   -57,   -57,   -57,
     -57,   -57,    10,    79,    87,    87,    79,    98,   -17,   110,
     -57,   -57,    81,   -57,    89,    88,   -57,   -57,   -57,   -57,
     -57,   -57,    97,    10,   -57,   -57,    29,   -57,   -57,   103,
     111,   -57,   -57,   -57,    10,   -57,   -57,   -57,   -57,    79,
     -57,    87,   -57,   112,   -57,   -57
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       3,     0,     0,     2,     3,     0,     8,     7,     1,     4,
       0,     9,    13,     0,     0,     0,     0,     0,     9,     0,
      14,     9,    10,    11,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    22,     0,     0,    62,     0,
       0,     0,     0,     0,     0,    35,    62,    23,    26,    29,
      33,     0,    50,    52,     0,     0,     0,    44,    46,     0,
       0,    64,    20,    21,     0,    24,     6,     5,     0,    12,
       0,    36,    34,     0,    40,     0,     0,     0,     0,     0,
      51,    53,     0,     0,     0,     0,    56,    57,    58,    59,
      60,    61,     0,     0,     0,     0,     0,     0,     0,     0,
      25,    15,     0,    37,    42,     0,    41,    28,    27,    30,
      31,    32,     0,     0,    54,    48,     0,    45,    47,     0,
       0,    65,    63,    38,     0,    39,    55,    49,    16,     0,
      18,     0,    43,     0,    19,    17
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -57,   -57,   129,   -57,   -57,   -57,    -1,     0,   -57,   130,
     -57,   -56,     2,   -10,   -57,   -57,    23,   -32,    53,   -57,
      67,   -13,   -35
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     3,     4,    67,     5,    46,    13,    14,    15,
      39,    40,    55,    48,    49,   105,   106,    56,    57,    58,
      92,    50,    62
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
       7,    59,    63,    64,    97,    77,    78,    79,    70,   100,
      12,    71,     6,    75,    76,    12,    41,    12,    22,     8,
      12,    25,    85,    61,    61,    80,    81,    43,    38,     1,
      72,    23,    24,    47,     6,    38,    38,   116,    74,    10,
     119,    82,    38,    43,    45,     6,    73,    41,   128,   129,
     112,    11,    41,    83,    16,    17,    84,    44,    18,    38,
      45,     6,   117,   121,    38,    21,    99,   109,   110,   111,
     101,    19,   102,   133,    26,    28,   104,   107,   108,    27,
      41,    29,    42,    41,    84,    61,    60,    65,    30,    31,
      64,    66,    38,    68,   115,    38,    32,    38,    69,   134,
      33,    34,    98,    93,    35,    36,    37,    86,    87,    88,
      89,    90,    91,    96,    95,   127,    41,    51,    52,    53,
      43,    94,   120,   122,   103,   114,   104,   130,    38,   123,
       6,   135,   131,     9,    54,   124,   125,    45,     6,    86,
      87,    88,    89,    90,    91,   126,    20,   132,   118,   103,
     113
};

static const yytype_uint8 yycheck[] =
{
       1,    33,    37,    12,    60,    35,    36,    37,    47,    65,
      11,    50,    51,    33,    34,    16,    29,    18,    18,     0,
      21,    21,    54,    36,    37,    31,    32,    33,    29,     9,
      43,    14,    15,    31,    51,    36,    37,    93,    47,    44,
      96,    47,    43,    33,    50,    51,    44,    60,    19,    20,
      82,     3,    65,    51,    46,     4,    54,    47,    44,    60,
      50,    51,    94,    98,    65,     5,    64,    77,    78,    79,
      68,    45,    70,   129,    12,    50,    74,    75,    76,     6,
      93,     7,    16,    96,    82,    98,    23,    44,    13,    10,
      12,     8,    93,    49,    92,    96,    17,    98,    14,   131,
      21,    22,    46,    18,    25,    26,    27,    38,    39,    40,
      41,    42,    43,    23,    28,   113,   129,    30,    31,    32,
      33,    29,    24,    13,    48,    48,   124,    24,   129,    48,
      51,    19,    21,     4,    47,    46,    48,    50,    51,    38,
      39,    40,    41,    42,    43,    48,    16,   124,    95,    48,
      83
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     9,    53,    54,    55,    57,    51,    58,     0,    54,
      44,     3,    58,    59,    60,    61,    46,     4,    44,    45,
      61,     5,    59,    14,    15,    59,    12,     6,    50,     7,
      13,    10,    17,    21,    22,    25,    26,    27,    58,    62,
      63,    73,    16,    33,    47,    50,    58,    64,    65,    66,
      73,    30,    31,    32,    47,    64,    69,    70,    71,    69,
      23,    73,    74,    74,    12,    44,     8,    56,    49,    14,
      47,    50,    73,    64,    47,    33,    34,    35,    36,    37,
      31,    32,    47,    64,    64,    69,    38,    39,    40,    41,
      42,    43,    72,    18,    29,    28,    23,    63,    46,    64,
      63,    64,    64,    48,    64,    67,    68,    64,    64,    65,
      65,    65,    69,    72,    48,    64,    63,    69,    70,    63,
      24,    74,    13,    48,    46,    48,    48,    64,    19,    20,
      24,    21,    68,    63,    69,    19
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    52,    53,    54,    54,    55,    56,    57,    58,    59,
      59,    60,    60,    61,    61,    62,    62,    62,    62,    62,
      62,    62,    62,    62,    63,    63,    64,    64,    64,    65,
      65,    65,    65,    66,    66,    66,    66,    66,    66,    66,
      67,    67,    68,    68,    69,    69,    70,    70,    71,    71,
      71,    71,    71,    71,    71,    71,    72,    72,    72,    72,
      72,    72,    73,    73,    74,    74
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     0,     2,    11,     1,     2,     1,     0,
       3,     3,     8,     1,     3,     3,     5,     7,     5,     6,
       2,     2,     1,     2,     2,     3,     1,     3,     3,     1,
       3,     3,     3,     1,     2,     1,     2,     3,     4,     4,
       0,     1,     1,     3,     1,     3,     1,     3,     3,     4,
       1,     2,     1,     2,     3,     4,     1,     1,     1,     1,
       1,     1,     1,     4,     1,     3
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 73 "phase2.y" /* yacc.c:1646  */
    {}
#line 1395 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 3:
#line 77 "phase2.y" /* yacc.c:1646  */
    {}
#line 1401 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 4:
#line 79 "phase2.y" /* yacc.c:1646  */
    {}
#line 1407 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 5:
#line 86 "phase2.y" /* yacc.c:1646  */
    {}
#line 1413 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 6:
#line 88 "phase2.y" /* yacc.c:1646  */
    {
    printf("endfunc\n");
}
#line 1421 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 7:
#line 93 "phase2.y" /* yacc.c:1646  */
    {
	char *token = identToken;
	printf("func %s\n", token);
    strcpy( list_of_function_names[count_names], token);
    count_names++;
}
#line 1432 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 8:
#line 102 "phase2.y" /* yacc.c:1646  */
    { (yyval.op_val) = (yyvsp[0].op_val);}
#line 1438 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 9:
#line 106 "phase2.y" /* yacc.c:1646  */
    {}
#line 1444 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 108 "phase2.y" /* yacc.c:1646  */
    {}
#line 1450 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 113 "phase2.y" /* yacc.c:1646  */
    {
        }
#line 1457 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 116 "phase2.y" /* yacc.c:1646  */
    {
	char *token = (yyvsp[-7].op_val);
	char *num = (yyvsp[-3].op_val);
	printf(".[] _%s, %s\n", token, num);
}
#line 1467 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 123 "phase2.y" /* yacc.c:1646  */
    {
	    putsym((yyvsp[0].op_val), "i");
	    symrec *res = getsym((yyvsp[0].op_val));
            printf(". _%s\n", res->name);
	    (yyval.op_val) = (yyvsp[0].op_val);
}
#line 1478 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 130 "phase2.y" /* yacc.c:1646  */
    {
	    (yyval.op_val) = (yyvsp[-2].op_val);
	    char *token = (yyvsp[-2].op_val);
            printf(". _%s\n", token);
	}
#line 1488 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 138 "phase2.y" /* yacc.c:1646  */
    {
            char *dest = (yyvsp[-2].op_val);
            char *src = (yyvsp[0].op_val);
            char *name = (yyvsp[-2].op_val);
            printf("= %s, %s\n", dest, src);
        }
#line 1499 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 145 "phase2.y" /* yacc.c:1646  */
    {}
#line 1505 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 147 "phase2.y" /* yacc.c:1646  */
    {}
#line 1511 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 149 "phase2.y" /* yacc.c:1646  */
    {}
#line 1517 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 151 "phase2.y" /* yacc.c:1646  */
    {}
#line 1523 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 20:
#line 153 "phase2.y" /* yacc.c:1646  */
    {}
#line 1529 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 21:
#line 155 "phase2.y" /* yacc.c:1646  */
    {}
#line 1535 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 22:
#line 157 "phase2.y" /* yacc.c:1646  */
    {}
#line 1541 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 159 "phase2.y" /* yacc.c:1646  */
    {}
#line 1547 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 24:
#line 163 "phase2.y" /* yacc.c:1646  */
    {}
#line 1553 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 165 "phase2.y" /* yacc.c:1646  */
    {}
#line 1559 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 26:
#line 169 "phase2.y" /* yacc.c:1646  */
    { (yyval.op_val) = (yyvsp[0].op_val);}
#line 1565 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 27:
#line 171 "phase2.y" /* yacc.c:1646  */
    {
            char *src1 = (yyvsp[-2].op_val);
            char *src2 = (yyvsp[0].op_val);
            char *dest = "_temp";
            printf("+ %s, %s, %s\n", dest, src1, src2);
            (yyval.op_val) = dest;

        }
#line 1578 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 180 "phase2.y" /* yacc.c:1646  */
    {
            char *src1 = (yyvsp[-2].op_val);
            char *src2 = (yyvsp[0].op_val);
            char *dest = "_temp";
            printf("- %s, %s, %s\n", dest, src1, src2);
            (yyval.op_val) = dest;
        }
#line 1590 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 29:
#line 190 "phase2.y" /* yacc.c:1646  */
    { (yyval.op_val) = (yyvsp[0].op_val); }
#line 1596 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 30:
#line 192 "phase2.y" /* yacc.c:1646  */
    { (yyval.op_val) = "FILL1"; }
#line 1602 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 31:
#line 194 "phase2.y" /* yacc.c:1646  */
    { (yyval.op_val) = "FILL2"; }
#line 1608 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 32:
#line 196 "phase2.y" /* yacc.c:1646  */
    { (yyval.op_val) = "FILL3"; }
#line 1614 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 33:
#line 200 "phase2.y" /* yacc.c:1646  */
    {(yyval.op_val) = (yyvsp[0].op_val); }
#line 1620 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 34:
#line 202 "phase2.y" /* yacc.c:1646  */
    {}
#line 1626 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 35:
#line 204 "phase2.y" /* yacc.c:1646  */
    {(yyval.op_val) = (yyvsp[0].op_val); }
#line 1632 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 36:
#line 206 "phase2.y" /* yacc.c:1646  */
    {}
#line 1638 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 37:
#line 208 "phase2.y" /* yacc.c:1646  */
    {}
#line 1644 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 38:
#line 210 "phase2.y" /* yacc.c:1646  */
    {}
#line 1650 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 39:
#line 212 "phase2.y" /* yacc.c:1646  */
    {}
#line 1656 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 216 "phase2.y" /* yacc.c:1646  */
    {}
#line 1662 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 218 "phase2.y" /* yacc.c:1646  */
    {}
#line 1668 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 222 "phase2.y" /* yacc.c:1646  */
    {}
#line 1674 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 224 "phase2.y" /* yacc.c:1646  */
    {}
#line 1680 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 228 "phase2.y" /* yacc.c:1646  */
    {}
#line 1686 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 230 "phase2.y" /* yacc.c:1646  */
    {}
#line 1692 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 46:
#line 234 "phase2.y" /* yacc.c:1646  */
    {}
#line 1698 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 47:
#line 236 "phase2.y" /* yacc.c:1646  */
    {}
#line 1704 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 240 "phase2.y" /* yacc.c:1646  */
    {}
#line 1710 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 242 "phase2.y" /* yacc.c:1646  */
    {}
#line 1716 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 244 "phase2.y" /* yacc.c:1646  */
    {}
#line 1722 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 246 "phase2.y" /* yacc.c:1646  */
    {}
#line 1728 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 248 "phase2.y" /* yacc.c:1646  */
    {}
#line 1734 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 53:
#line 250 "phase2.y" /* yacc.c:1646  */
    {}
#line 1740 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 252 "phase2.y" /* yacc.c:1646  */
    {}
#line 1746 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 254 "phase2.y" /* yacc.c:1646  */
    {}
#line 1752 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 258 "phase2.y" /* yacc.c:1646  */
    {}
#line 1758 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 260 "phase2.y" /* yacc.c:1646  */
    {}
#line 1764 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 262 "phase2.y" /* yacc.c:1646  */
    {}
#line 1770 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 264 "phase2.y" /* yacc.c:1646  */
    {}
#line 1776 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 266 "phase2.y" /* yacc.c:1646  */
    {}
#line 1782 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 268 "phase2.y" /* yacc.c:1646  */
    {}
#line 1788 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 272 "phase2.y" /* yacc.c:1646  */
    {(yyval.op_val) = (yyvsp[0].op_val);}
#line 1794 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 63:
#line 274 "phase2.y" /* yacc.c:1646  */
    {
            (yyval.op_val) = 0; /*test*/
        }
#line 1802 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 64:
#line 279 "phase2.y" /* yacc.c:1646  */
    {}
#line 1808 "phase2.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 281 "phase2.y" /* yacc.c:1646  */
    {}
#line 1814 "phase2.tab.c" /* yacc.c:1646  */
    break;


#line 1818 "phase2.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 284 "phase2.y" /* yacc.c:1906  */


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
  res->name = strdup (name);
  res->type = sym_type;
  res->value.var = 0; /* Set value to 0 even if fun. */
  res->next = sym_table;
  sym_table = res;
  return res;
}


symrec *
getsym (char const *name)
{
   symrec *p = sym_table;
  for (p = sym_table; p; p = p->next)
    if (strcmp (p->name, name) == 0)
      return p;
  return NULL;
}


