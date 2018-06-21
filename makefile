G=g++ -g

SCANNER_OUT=bin/scanner

$(SCANNER_OUT): out/scanner.c
	$(G) -o $(SCANNER_OUT) out/scanner.c -lfl

out/scanner.c: scanner.l
	flex -oscanner.c scanner.l 
	mv scanner.c out

