#include "util.h"

typedef union  {
	int pos;
	int ival;
	string sval;
	} YYSTYPE;
extern YYSTYPE yylval;

enum tokens { COLON=257, SEMICOLON, LBRACK, RBRACK, PLUS, MINUS, TIMES, DIVIDE,
  EQ, NEQ, LT, LE, GT, GE, AND, OR, ASSIGN,
  WHILE, FOR, ARRAY, IF, THEN, ELSE, DO, INTTY, STRINGTY, INT, ID,
  FUN, RETURNS, LPAREN, RPAREN, COMMA, LBRACE, RBRACE, RETURN };
  