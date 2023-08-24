%{
#include <stdio.h>
%}

DIGIT       [0-9]
LETTER      [a-zA-Z]
VARIABLE    {LETTER}({LETTER}|{DIGIT})*
NUMBER      {DIGIT}+(\.{DIGIT}+)?(E[+-]?{DIGIT}+)?

%%
{VARIABLE}  printf("VARIABLE: %s\n", yytext);
{NUMBER}    printf("NUMBER: %s\n", yytext);
[+\-*/=]    printf("OPERATOR: %c\n", yytext[0]);
[ \t\n]     ; // Ignore whitespace and newline characters
.           printf("ERROR: Unexpected character: %c\n", yytext[0]);
%%

int main() {
    yylex();
    return 0;
}
