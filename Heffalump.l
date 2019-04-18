%{
#include <stdio.h>
#include <string.h>

#include "Heffalump.tab.h"
#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;
%}

%option yylineno
%option noinput
%option nounput

%%
[ \t\n\r]+
#.*
"+"      return '+';
"-"      return '-';
"*"      return '*';
"/"      return '/';
"("      return '(';
")"      return ')';
":"      return ':';
";"      return ';';
","      return ',';
"<"      return '<';
">"      return '>';
"="      return '=';
"{"      return '{';
"}"      return '}';
"=="     return tEQ;
">="     return tGEQ;
"<="     return tLEQ;
"**"     return tEXP;
"fun"    return tFUN;
"->"     return tARROW;
"var"    return tVAR;
"output" return tOUTPUT;
"if"     return tIF;
"else"   return tELSE;
"return" return tRETURN;
"string" return tSTRING;
"int"    return tINT;
"float"  return tFLOAT;
"void"   return tVOID;

\"([ a-zA-Z0-9])*\" {
    yylval.string_val = strdup(yytext);
    return tSTRINGVAL;
}

0|([1-9][0-9]*) {
    yylval.int_val = atoi(yytext);
    return tINTVAL;
}

0\.[0-9]+|([1-9][0-9]*\.[0-9]+) {
    yylval.float_val = atof(yytext);
    return tFLOATVAL;
}

[a-zA-Z_][a-zA-z0-9_]* {
    yylval.string_val = strdup(yytext);
    return tIDENTIFIER;
}

. {
    fprintf(stderr, "Error: (line %d) unexpected character '%s'\n", yylineno, yytext);
    exit(1);
}
%%
