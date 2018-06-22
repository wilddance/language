G=g++ -g

SCANNER_OUT=bin/scanner

$(SCANNER_OUT): bin out/scanner.c
	$(G) -o $(SCANNER_OUT) out/scanner.c -lfl

out/scanner.c: out scanner.l
	flex -oscanner.c scanner.l 
	mv scanner.c out

out:
	mkdir out

bin:
	mkdir bin
