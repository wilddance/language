G=g++ -g
SCANNER_OUT=bin/scanner

all: $(SCANNER_OUT)

out/scanner.c: out scanner.l
	flex -oscanner.c scanner.l 
	mv scanner.c out

out/parser.h: out parser.y
	bison -d parser.y
	mv parser.tab.h out/parser.h
	mv parser.tab.c out/parser.c

$(SCANNER_OUT): bin out/scanner.c
	$(G) -o $(PARSER_OUT) $(SCANNER_OUT) out/scanner.c -lfl

out:
	mkdir out

bin:
	mkdir bin
