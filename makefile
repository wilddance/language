G=g++ -g -std=c++11

OUT=bin/scanner

all: $(OUT)

out/scanner.cpp: out scanner.l parser.ypp grammars/*
	flex -oscanner.cpp scanner.l 
	mv scanner.cpp out


out/parser.hpp out/parser.ypp: out parser.ypp grammars/*
	python3 build_parser.py
	bison -d out/parser.ypp
	mv parser.tab.hpp out/parser.h
	mv parser.tab.cpp out/parser.cpp


$(OUT): bin out/parser.hpp out/scanner.cpp classes/Vars.cpp
	$(G) -o $(OUT) out/parser.cpp out/scanner.cpp -lfl

out:
	mkdir out

bin:
	mkdir bin

.PHONY: clear run

run: $(OUT)
	./bin/scanner

clear:
	rm -f out/*
	rm -f bin/*

