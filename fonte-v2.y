%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(char *s);
%}

%union{
    char* string;
    int num_int;
    float num_float;
}

%token STRING INT FLOAT SEPARADORES PONTUACAO 
%token ATRIBUICAO IF WHILE IGUAL
%token ABRE_CHAVE FECHA_CHAVE MAIOR_IGUAL MENOR_IGUAL 
%token COMENTARIO ABRE_PAREN FECHA_PAREN EOL
%token SOMA SUB MULT DIV
%token ABRE_COL FECHA_COL RETURN PRINT DIF

%type <string> STRING
%type <num_int> INT
%type <num_float> FLOAT

%%

programa:
    | programa declaracao EOL
    ;

bloco_cmd: 
      ABRE_CHAVE declaracoes FECHA_CHAVE
    ;

declaracoes:
    | declaracoes declaracao EOL
    | declaracoes bloco_cmd EOL
    ;

declaracao:
      atrib
    | if_cond
    | while
    | bloco_cmd
    | chamada
    | printa
    | retorna
    | comenta
    ;

atrib: 
      STRING ATRIBUICAO expressao EOL
    | STRING ABRE_COL expressao FECHA_COL ATRIBUICAO expressao EOL
    ;

if_cond:
      IF cond bloco_cmd
    ;

cond:
      ABRE_PAREN STRING IGUAL INT FECHA_PAREN
    | ABRE_PAREN STRING IGUAL FLOAT FECHA_PAREN
    | ABRE_PAREN STRING MAIOR_IGUAL INT FECHA_PAREN
    | ABRE_PAREN STRING MAIOR_IGUAL FLOAT FECHA_PAREN
    | ABRE_PAREN STRING MENOR_IGUAL INT FECHA_PAREN
    | ABRE_PAREN STRING MENOR_IGUAL FLOAT FECHA_PAREN
    | ABRE_PAREN DIF fator
    ;

while:
      WHILE cond bloco_cmd
    ;

chamada:
      STRING ABRE_PAREN expressao FECHA_PAREN
    ;

comenta:
      COMENTARIO expressao

expressao:
     termo
    | expressao SOMA termo
    | expressao SUB termo
    ;

termo:
     fator
    | termo MULT fator
    | termo DIV fator
    ;

fator:
     INT
    | FLOAT
    | STRING
    | STRING ABRE_COL expressao FECHA_COL
    | ABRE_PAREN expressao FECHA_PAREN
    ;

retorna:
     RETURN expressao EOL
    ;

printa:
     PRINT ABRE_PAREN expressao FECHA_PAREN EOL
    ;

%%

int yyerror(char *s) {
    printf("ERRO SINTATICO: linha %s\n", s);
    return 0;
}

int main() {
    yyparse();
    return 0;
}