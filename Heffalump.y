%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;
int yylex();
void yyerror(const char *s) {
        fprintf(stderr, "Error: (line %d) %s\n", yylineno, s);
        exit(1);
    }
%}

%locations
%define parse.error verbose

%union {
    int int_val;
    float float_val;
    char *string_val;
}

%type   program funcdecls

%token  <int_val>       tINTVAL
%token  <float_val>     tFLOATVAL
%token  <string_val>    tIDENTIFIER
%token  <string_val>    tSTRINGVAL
%token                  tIF
                        tELSE
                        tFUN
                        tARROW
                        tEXP
                        tVAR
                        tOUTPUT
                        tRETURN
                        tEQ
                        tGEQ
                        tLEQ
                        tSTRING
                        tINT
                        tFLOAT
                        tVOID

%start program

%%
program:        funcdecls
        ;

exp:            exp '+' term
        |       exp '-' term
        |       term
                // No mention of conditions/bools?
        |       exp '>' term
        |       exp '<' term
        |       exp tEQ term
        |       exp tGEQ term
        |       exp tLEQ term
        ;

term:           term '*' term2
        |       term '/' term2
        |       term2
        ;

term2:          term3 tEXP term2
        |       term3
        ;

term3:          '-' term3
        |       factor
        ;

factor:         funccall
        |       '<' type '>' '(' exp ')'
        |       tIDENTIFIER
        |       tSTRINGVAL
        |       tFLOATVAL
        |       tINTVAL
        |       '(' exp ')'
        ;

explist:        exp
        |       explist ',' exp
        ;

type:           tSTRING
        |       tINT
        |       tFLOAT
        ;

typelist:       type
        |       typelist ',' type
        ;

rettype:        typelist
        |       tVOID
        ;

funccall:       tIDENTIFIER '(' explist ')'
        ;

decl:           tVAR explist tARROW type ';'
        |       tVAR explist tARROW type '=' explist ';'
        ;

decls:          %empty
        |       decls decl
        ;

stmt:           explist '=' explist ';' //Assignments
        |       funccall ';'
        |       tRETURN ';'
        |       tRETURN explist ';'
        |       blk // Block statement
        |       ifs
        |       output ';'
        ;

stmts:          %empty
        |       stmts stmt
        ;

ifs:            tIF exp blk tELSE blk
        |       tIF exp blk
        ;

blk:            '{' decls stmts '}'
        ;

param:          tIDENTIFIER tARROW type
        ;

params:         param
        |       params ',' param
                ;

funcdecl:       tFUN tIDENTIFIER '(' params ')' ':' rettype blk
        |       tFUN tIDENTIFIER '(' ')' ':' rettype blk
                ;

funcdecls:      %empty
        |       funcdecls funcdecl
        ;

output:         tOUTPUT '(' explist ')'
        ;
%%
// Below is for testing
int main() {
    yyparse();
    printf("Valid program!\n");
    return 0;
}
