FLEX=flex
BISON=bison
CC=gcc

PROGRAM=compiler
LEX=compiler.l
PARSER = compiler.y

$(PROGRAM): $(LEX) $(PARSER)
	$(FLEX) $(LEX)
	$(BISON) -d -t $(PARSER)
	$(CC) $(CFLAGS) *.c -ll
