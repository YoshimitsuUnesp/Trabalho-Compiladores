%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
#include "fonte.tab.h"
%}

DIGITO       [0-9]
CARACTERE    [a-zA-Z]
STRING       {CARACTERE}({CARACTERE}|{DIGITO})*
INT          {DIGITO}+
FLOAT        {DIGITO}+\.{DIGITO}+(E[+-]?{DIGITO}+)?
PONTUACAO    ["'"-"."-","]

%%
"if"           { return (IF);}
"else"         { return (ELSE);}
"while"        { return (WHILE);}
"return"       { return (RETURN);}
"print"        { return (PRINT);}
{STRING}       {sscanf(yytext, "%s", yylval.string); return (STRING);}
{INT}          {yylval.num_int = atoi(yytext); return (INT);}
{FLOAT}        {yylval.num_float = atof(yytext); return (FLOAT);}
{PONTUACAO}    {sscanf(yytext, "%c", yylval.string); return (PONTUACAO);}

"!"            { return (DIF);}
"{"            { return (ABRE_CHAVE);}
"}"            { return (FECHA_CHAVE);}
"="            { return (ATRIBUICAO);}
"=="           { return (IGUAL);} 
">="           { return (MAIOR_IGUAL);}
"<="           { return (MENOR_IGUAL);}
"//"           { return (COMENTARIO);}
"("            { return (ABRE_PAREN);}
")"            { return (FECHA_PAREN);}
"+"            { return (SOMA);}
"-"            { return (SUB);}
"*"            { return (MULT);}
"/"            { return (DIV);}
";"            { return (EOL);}
"["            { return (ABRE_COL);}
"]"            { return (FECHA_COL);}
[ \t\n\f\r]    ; // Ignora newline e espaco em branco
.              printf("ERRO LEXICO: Caractere inesperado: %c\n", yytext[0]);
%%