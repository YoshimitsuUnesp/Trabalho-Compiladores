%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex(void);
extern int yylineno;
extern char *yytext;
void yyerror(char *s);
%}


%union {
    int intval;
    char *strval;
}

%token <strval> IDENTIFIER
%token <intval> NUMBER PLUS MINUS MULTIPLY DIVIDE ASSIGN LPAREN RPAREN LBRACE RBRACE SEMICOLON IF ELSE WHILE FOR RETURN PRINT LBRACKET RBRACKET COMMA

%%

program:
    /* vazio */
    | program statement
    ;

statement:
    assignment
    | declaration
    | if_statement
    | while_statement
    | for_statement
    | return_statement
    | print_statement
    ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON
    | IDENTIFIER LBRACKET expression RBRACKET ASSIGN expression SEMICOLON
    ;

declaration:
    "int" IDENTIFIER SEMICOLON
    | "double" IDENTIFIER SEMICOLON
    | "int" IDENTIFIER LBRACKET NUMBER RBRACKET SEMICOLON
    | "double" IDENTIFIER LBRACKET NUMBER RBRACKET SEMICOLON
    ;

if_statement:
    IF LPAREN condition RPAREN LBRACE program RBRACE
    | IF LPAREN condition RPAREN LBRACE program RBRACE ELSE LBRACE program RBRACE
    ;

while_statement:
    WHILE LPAREN condition RPAREN LBRACE program RBRACE
    ;

for_statement:
    FOR LPAREN assignment condition SEMICOLON assignment RPAREN LBRACE program RBRACE
    ;

return_statement:
    RETURN expression SEMICOLON
    ;

print_statement:
    PRINT LPAREN expression RPAREN SEMICOLON
    ;

condition:
    expression
    ;

expression:
    term
    | expression PLUS term
    | expression MINUS term
    | IDENTIFIER LPAREN arguments RPAREN
    ;

term:
    factor
    | term MULTIPLY factor
    | term DIVIDE factor
    ;

factor:
    NUMBER
    | IDENTIFIER
    | IDENTIFIER LBRACKET expression RBRACKET
    | LPAREN expression RPAREN
    ;

arguments:
    /* vazio */
    | argument_list
    ;

argument_list:
    expression
    | argument_list COMMA expression
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Erro: %s\n", s);
    fprintf(stderr, "Na linha %d: %s\n", yylineno, yytext);
}

int main(void) {
    yyparse();
    return 0;
}
