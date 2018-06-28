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

COM         ("#".*\n)
DEBUG       ("debug")
BOOL_OP     ("and"|"or")
KEYWORD     ("while"|"print"|"begin"|"end"|"exit")
IF          "if"|"IF"
READ        "read"
BOOL_VAL    ("true"|"false")
OPER        ("+"|"-"|"*"|"/"|"%")
DIGITS      [0-9]+
REL_OPER    ("=="|"<"|"<="|">"|">="|"<>")
ASSIGN      (":=")
IDENT       ([a-z]+)

%%

{  { d("[F] Start block: %s\n"); return STARTBLOCK; }
}  { d("[F] Stop block: %s\n"); return ENDBLOCK; }
{REL_OPER}  { 

printf("[F] REL_OPER: %s\n", yytext); 
        yylval.val = 1;
    
  return REL_OPER; 
}

{BOOL_VAL}  { d("[F]Bool\n");       return BOOL_VAL; }
{DEBUG}     { d("[F]Debug\n");      return DEBUG;}
{IF}        { d("[F]If\n");         return IF;}
{READ}      { d("[F] Read\n");      return READ;}
{DIGITS}    { yylval.val = atoi(yytext);            printf("[F]Zwracam liczbe: %d\n", yylval.val); return DIGITS; } 
{OPER}      { yylval.ch = yytext[0];                printf("[F]Zwracam oper %c \n", yylval.ch); return OPER; }
{IDENT}     { yylval.s= strndup(yytext, yyleng+1);  printf("[F]IDENT: %s\n", yylval.s);  return IDENT; }
{COM}       { }

%%

/*
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
