%{

  #include <iostream>
  using namespace std;

%}

COM         ("#".*\n)
BOOL_OP     ("and"|"or")
KEYWORD     ("if"|"while"|"print"|"read"|"begin"|"end"|"exit")
BOOL        ("true"|"false")
OPER        ("+"|"-"|"*"|"/"|"%")
DIGIT       ([0-9])
DIGITS      {DIGIT}*
REL         ("="|"<"|"<="|">"|">="|"<>")
ASSIGN      (":=")
IDENT       ([a-zA-Z]+)

%%

{COM}       {}
{ASSIGN}    cout<<"ASSIGN "<<yytext<<endl;
{OPER}      cout<<"NUM_OP "<<yytext<<endl;
{DIGITS}    cout<<"DIGIT "<<yytext<<endl;
{BOOL}      cout<<"BOOL "<<yytext<<endl;
{KEYWORD}   cout<<"KEYWORD "<<yytext<<endl;
{IDENT}     cout<<"IDENT "<<yytext<<endl;
";"|" "|\n      {}  
.           cout<<"Unkown: "<<yytext<<endl;

%%

int main() {

    yylex();

    return 0;

}
