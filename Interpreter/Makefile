FLEX=flex
BISON=bison
CC=gcc

PROGRAM = assignment7
LEX = assignment7.l
PARSER = assignment7.y

$(PROGRAM): $(LEX) $(PARSER)
	$(FLEX) $(LEX)
	$(BISON) -d -t $(PARSER)
	$(CC) $(CFLAGS) *.c -ll