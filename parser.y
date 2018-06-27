%{
    #include<stdio.h>
%}

%token DIGITS
%token OPER
%token COM

%%

s: 
 | s value

value: exp | DIGITS { printf("Value: %d", $$); }

exp: DIGITS OPER DIGITS { 

    printf("\nExpr: \n $$ = %s, $1 = %s, $2:%s \n", $1, $1, $2);
    switch($2){
        case '+':
            $$ = $1 + $3; break;
        case '-':
            $$ = $1 + $3; break;
        case '*':
            $$ = $1 + $3; break;
        case '/':
            $$ = $1 + $3; break;
    } 

  }

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
