.PHONY: all
all: parser

.PHONY: clean
clean:
	@rm -f lex.yy.*
	@rm -f Heffalump.tab.*
	@rm -f parser

parser : lex.yy.o Heffalump.tab.o
	gcc -o parser lex.yy.o Heffalump.tab.o -lfl

lex.yy.o : lex.yy.c Heffalump.tab.o
	gcc -c -o lex.yy.o lex.yy.c

Heffalump.tab.o : Heffalump.tab.c
	gcc -c -o Heffalump.tab.o Heffalump.tab.c

Heffalump.tab.c : Heffalump.y
	bison $< -d -W

Heffalump.tab.h : Heffalump.tab.c

lex.yy.c : Heffalump.tab.h Heffalump.l
	flex Heffalump.l
