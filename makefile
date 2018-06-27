G=g++ -g

OUT=bin/scanner

all: $(OUT)

out/scanner.c: out scanner.l
	flex -oscanner.c scanner.l 
	mv scanner.c out

out/parser.h: out parser.y
	bison -d parser.y
	mv parser.tab.h out/parser.h
	mv parser.tab.c out/parser.c

$(OUT): bin out/parser.h out/scanner.c 
	$(G) -o $(OUT) out/parser.c out/scanner.c -lfl

out:
	mkdir out

bin:
	mkdir bin

.PHONY: clear

clear:
	rm out/*

