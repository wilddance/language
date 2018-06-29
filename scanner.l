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
OPER        ("+"|"-"|"*"|"/"|"%")
DIGITS      [0-9]+
REL_OPER    ("=="|"<"|"<="|">"|">="|"<>")
ASSIGN      (":=")
IDENT       ([a-z]+)

%%

\n {}
{REL_OPER}  { printf("[F] REL_OPER: %s\n", yytext); yylval.val = 1; return REL_OPER; }
{BEG}       { d("[F]Beg\n");        return BEG; }
{END}       { printf("[F]End\n");        return END; }

"{"       { d("[F]Beg\n");        return BEG; }
"}"       { printf("[F]End\n");        return END; }
{BOOL_VAL}  { d("[F]Bool val\n");    

if(strcmp(yytext, "true") == 0)
    yylval.val = 1; 
else 
    yylval.val = 0;

return DIGITS;

}
{PRINT}     { printf("[F]IFELSE\n");      return IFELSE; }
{IFELSE}     { printf("[F]IFELSE\n");      return IFELSE; }
{WHILE}     { printf("[F]While\n");      return WHILE; }
{ELSE}     { printf("[F]ELSE\n");      return ELSE; }
{END_ST}    { printf("[F]End_st\n");     return END_ST; }
{BOOL_VAL}  { printf("[F]Bool\n");       return BOOL_VAL; }
{DEBUG}     { printf("[F]Debug\n");      return DEBUG;}
{IF}        { printf("[F]If\n");         return IF;}
{READ}      { printf("[F] Read\n");      return READ;}
{DIGITS}    { yylval.val = atoi(yytext);            printf("[F]Zwracam liczbe: %d\n", yylval.val); return DIGITS; } 
{OPER}      { yylval.ch = yytext[0];                printf("[F]Zwracam oper %c \n", yylval.ch); return OPER; }
{IDENT}     { yylval.s= strndup(yytext, yyleng+1);  printf("[F]IDENT: %s\n", yylval.s);  return IDENT; }
{COM}       { }

%%

/*
{  { d("[F] Start block: %s\n"); return STARTBLOCK; }
}  { d("[F] Stop block: %s\n"); return ENDBLOCK; }
{KEYWORD}   { d("KEYWORD: %s\n",yytext); return IDENT; }
.     printf("[F]Unkown: %s\n", yytext);

{COM}       {}
{ASSIGN}    cout<<"ASSIGN "<<yytext<<endl;
{OPER}      cout<<"NUM_OP "<<yytext<<endl;
{BOOL}      cout<<"BOOL "<<yytext<<endl;

int main() {

    yylex();

    return 0;

}*/
