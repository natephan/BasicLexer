%{

#include <string.h>
#include "util.h"
#include "errormsg.h"
#include "tokens.h"

// keep track of current character number
int charPos = 1;

int yywrap(void) {
  charPos = 1;
  return 1;
}

// keep track of position of last successful token for error messages
void adjust(void) {
  EM_tokPos = charPos;
  charPos += yyleng;
}

%}

%%

" "                      { adjust(); continue; }
"\t"                     { adjust(); continue; }
"\n"                     { adjust(); EM_newline(); continue; }
"\r"                     { adjust(); continue; }
":"                      { adjust(); return COLON; }
";"                      { adjust(); return SEMICOLON; }
"["                      { adjust(); return LBRACK; }
"]"                      { adjust(); return RBRACK; }
"+"                      { adjust(); return PLUS; }
"-"                      { adjust(); return MINUS; }
"*"                      { adjust(); return TIMES; }
"/"                      { adjust(); return DIVIDE; }
"=="                     { adjust(); return EQ; }
"<>"                     { adjust(); return NEQ; }
"<"                      { adjust(); return LT; }
"<="                     { adjust(); return LE; }
">"                      { adjust(); return GT; }
">="                     { adjust(); return GE; }
"&&"                     { adjust(); return AND; }
"||"                     { adjust(); return OR; }
"="                      { adjust(); return ASSIGN; }

"while"                  { adjust(); return WHILE; }
"for"                    { adjust(); return FOR; }
"array"                  { adjust(); return ARRAY; }
"if"                     { adjust(); return IF; }
"then"                   { adjust(); return THEN; }
"else"                   { adjust(); return ELSE; }
"do"                     { adjust(); return DO; }
"int"                    { adjust(); return INTTY; }
"string"                 { adjust(); return STRINGTY; }

"fun"                    { adjust(); return FUN; }
"returns"                { adjust(); return RETURNS; }
"("                      { adjust(); return LPAREN; }
")"                      { adjust(); return RPAREN; }
","                      { adjust(); return COMMA; }
"{"                      { adjust(); return LBRACE; }
"}"                      { adjust(); return RBRACE; }
"return"                 { adjust(); return RETURN; }
['/']['/'](.)*['\n']     { adjust(); EM_newline(); }


[0-9]+                      { adjust(); yylval.ival = atoi(yytext); return INT; }
[a-zA-Z]([a-zA-Z0-9]|_)*    { adjust(); yylval.sval = String(yytext); return ID; }


 /* Write two things that are identifiers according to this definition:
    1. hello
    2. identIFIer_
  
    Write two things that are *not* identifiers:
    1. 2ids
    2. _i-d
  */

.                        { adjust(); EM_error(EM_tokPos, "illegal token"); }
