%{
    #include"parser.h"
    #include<stdlib.h>

%}

COM         ("#".*\n)
BOOL_OP     ("and"|"or")
KEYWORD     ("if"|"while"|"print"|"read"|"begin"|"end"|"exit")
BOOL        ("true"|"false")
OPER        ("+"|"-"|"*"|"/"|"%")
DIGITS      [0-9]+
REL         ("="|"<"|"<="|">"|">="|"<>")
ASSIGN      (":=")
IDENT       ([a-zA-Z]+)

%%

{COM} { printf("[F]COM\n"); return COM; }
{DIGITS}    { yylval.val = atoi(yytext); printf("[F]Zwracam liczbe: %d\n", yylval.val); return DIGITS; } 
{OPER} {  yylval.ch = yytext[0]; printf("[F]Zwracam oper %c \n", yylval.ch); return OPER; }
%%

/*
.     printf("[F]Unkown: %s\n", yytext);

{COM}       {}
{ASSIGN}    cout<<"ASSIGN "<<yytext<<endl;
{OPER}      cout<<"NUM_OP "<<yytext<<endl;
{BOOL}      cout<<"BOOL "<<yytext<<endl;
{KEYWORD}   cout<<"KEYWORD "<<yytext<<endl;
{IDENT}     cout<<"IDENT "<<yytext<<endl;

int main() {

    yylex();

    return 0;

}*/
