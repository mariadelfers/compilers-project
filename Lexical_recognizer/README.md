#Run
$ yacc -d yac.y
$ lex lex.l
$ gcc y.tab.c lex.yy.c -lfl -o exec
$ ./exec input.txt
