%option yylineno
%{
#include "fonte.tab.h"
extern char *strdup(const char *);
%}

%%

"if" { return IF; }
"else" { return ELSE; }
"while" { return WHILE; }
"for" { return FOR; }
"return" { return RETURN; }
"print" { return PRINT; }
[a-zA-Z][a-zA-Z0-9]* { yylval.strval = strdup(yytext); return IDENTIFIER; }
[0-9]+ { yylval.intval = atoi(yytext); return NUMBER; }
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULTIPLY; }
"/" { return DIVIDE; }
"=" { return ASSIGN; }
"(" { return LPAREN; }
")" { return RPAREN; }
"{" { return LBRACE; }
"}" { return RBRACE; }
";" { return SEMICOLON; }
"," { return COMMA; }
[ \t\n] ;
. { printf("Caractere não reconhecido: %s\n", yytext); exit(1); }

%%
