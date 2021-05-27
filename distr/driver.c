#include <stdio.h>
#include <stdlib.h>
#include "errormsg.h"
#include "tokens.h"

YYSTYPE yylval;

int yylex(void); /* prototype for the lexing function */



string toknames[] = {
  "COLON", "SEMICOLON", "LBRACK", "RBRACK", "PLUS", "MINUS", "TIMES", "DIVIDE",
  "EQ", "NEQ", "LT", "LE", "GT", "GE", "AND", "OR", "ASSIGN",
  "WHILE", "FOR", "ARRAY", "IF", "THEN", "ELSE", "DO", "INTTY", "STRINGTY", "INT", "ID",
  "FUN", "RETURNS", "LPAREN", "RPAREN", "COMMA", "LBRACE", "RBRACE", "RETURN"
};

string tokname(int tok) {
  printf("%d\n", tok);
  return tok<257 || tok>292 ? "BAD_TOKEN" : toknames[tok-257];
}

int main(int argc, char **argv) {
 string fname; int tok;
 if (argc!=2) {fprintf(stderr,"usage: lextest filename\n"); exit(1);}
 fname=argv[1];
 EM_reset(fname);
 for(;;) {
   tok=yylex();
   if (tok==0) break;
   switch(tok) {
   case ID:
     printf("%10s %4d %s\n",tokname(tok),EM_tokPos,yylval.sval);
     break;
   case INT:
     printf("%10s %4d %d\n",tokname(tok),EM_tokPos,yylval.ival);
     break;
   default:
     printf("%10s %4d\n",tokname(tok),EM_tokPos);
   }
 }
 return 0;
}


