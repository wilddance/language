%{
    #include"parser.h"
    #include"../defs.h"
    #include<stdlib.h>
    #include<stdarg.h>
    #include<string>

    void d(const char* msg, ...){
        if(getenv("FLEX_DEBUG") != NULL){
            va_list ap;
            va_start(ap, msg);
            printf(msg, ap);
            va_end(ap);
        }
    }

%}

%option yylineno

BEG         "begin"
WHILE       "while"
END         "end"
IFELSE      "ifelse"
ELSE        "else"
PRINT       "print"
EXIT        "exit"
COM         ("#".*\n)
END_ST      ";"
DEBUG       ("debug")
BOOL_OP     ("and"|"or")
IF          "if"|"IF"
READ        "read"
BOOL_VAL    ("true"|"false")
NUM_OPER        ("+"|"-"|"*"|"/"|"%")
DIGITS      "-"?[0-9]+
REL_OPER    ("=="|"<"|"<="|">"|">="|"<>")
ASSIGN      (":=")
IDENT       ([a-z]+)

%%

\n {}

{NUM_OPER}  { 

printf("[F] NUM_OPER: %s\n", yytext); 

if(strcmp(yytext, "+") == 0) yylval.val = PLUS; else
if(strcmp(yytext, "-") == 0) yylval.val = MINUS; else
if(strcmp(yytext, "*") == 0) yylval.val = MUL; else
if(strcmp(yytext, "/") == 0) yylval.val = DIV; else
if(strcmp(yytext, "%") == 0) yylval.val = MOD; else

return NUM_OPER; 
}

{REL_OPER}  { 


if(strcmp(yytext, "==") == 0) yylval.val = EQ; else
if(strcmp(yytext, "<") == 0) yylval.val = L; else
if(strcmp(yytext, "<=") == 0) yylval.val = LOE; else
if(strcmp(yytext, ">") == 0) yylval.val = G; else
if(strcmp(yytext, ">=") == 0) yylval.val = GOE; else
if(strcmp(yytext, "<>") == 0) yylval.val = DIFF;

printf("[F] REL_OPER: %s(%d)\n", yytext, yylval.val); 

return REL_OPER; 
}

{BEG}       { d("[F]Beg\n");        return BEG; }
{END}       { printf("[F]End\n");        return END; }
{PRINT}     { printf("[F]Print\n");      return PRINT; }
{EXIT}       { printf("[F]Exit\n");        return EXIT; }

"{"       { d("[F]Beg\n");        return BEG; }
"}"       { printf("[F]End\n");        return END; }
{BOOL_VAL}  { d("[F]Bool val\n");    

if(strcmp(yytext, "true") == 0)
    yylval.val = 1; 
else 
    yylval.val = 0;

return DIGITS;

}
{IFELSE}     { printf("[F]IFELSE\n");      return IFELSE; }
{WHILE}     { printf("[F]While\n");      return WHILE; }
{ELSE}     { printf("[F]ELSE\n");      return ELSE; }
{END_ST}    { printf("[F]End_st\n");     return END_ST; }
{BOOL_VAL}  { printf("[F]Bool\n");       return BOOL_VAL; }
{DEBUG}     { printf("[F]Debug\n");      return DEBUG;}
{IF}        { printf("[F]If\n");         return IF;}
{READ}      { printf("[F] Read\n");      return READ;}
{DIGITS}    { yylval.val = atoi(yytext);            printf("[F]Zwracam liczbe: %d\n", yylval.val); return DIGITS; } 
{IDENT}     { yylval.s= strndup(yytext, yyleng+1);  printf("[F]IDENT: %s\n", yylval.s);  return IDENT; }
{COM}       { }

%%
