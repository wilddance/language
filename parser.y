%{
    #include<stdio.h>
%}

%union{
    int val;
    char ch;
}

%token DIGITS
%token OPER
%token COM

%type<val> exp DIGITS value
%type<ch> OPER 

%%

s: 
 | s value

value: exp { printf("Value: %d", $$); }

exp: exp OPER DIGITS {

    puts("Mamy expr!");
    printf("$1 = %d\n", $1);
    printf("$2 = %c\n", $2);
    printf("$3 = %d\n", $3);

    $$ = $1 + $3;

    switch($2){
        case '+':
            $$ = $1 + $3; break;
        case '-':
            $$ = $1 - $3; break;
        case '*':
            $$ = $1 * $3; break;
        case '/':
            $$ = $1 / $3; break;
    }

}

exp: DIGITS


%%

/*

line:  DIGITS { printf("LICZBA %d", $$); } | 
DIGITS PLUS { printf("LICXZBA z plusem %d", $$); }
        | COM {printf("Dupa");}

*/

void yyerror(char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}

int main() {
        printf("Zaczynamy parsowanie\n");
		yyparse();
}
