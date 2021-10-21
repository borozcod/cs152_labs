all: mini_l
y.tab.c y.tab.h:	mini_l.y
	bison -v -d --file-prefix=y mini_l.y
lex.yy.c: mini_l.lex y.tab.h
	flex mini_l.lex 
mini_l: lex.yy.c y.tab.c y.tab.h
	gcc -o mini_l y.tab.c lex.yy.c -lfl
clean:
	rm mini_l y.tab.c lex.yy.c y.tab.h mini_l.output
