all: phase2
phase2.tab.c phase2.tab.h:	phase2.y
	bison -t -v -d phase2.y
lex.yy.c: phase2.lex phase2.tab.h
	flex phase2.lex 
phase2: lex.yy.c phase2.tab.c phase2.tab.h
	gcc -o phase2 phase2.tab.c lex.yy.c -lfl
clean:
	rm phase2 phase2.tab.c lex.yy.c phase2.tab.h phase2.output
