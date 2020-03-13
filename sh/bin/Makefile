all: path_shortener

path_shortener:
	gcc -O3 -Ofast -march=native files/path_shortener.c -o path_shortener

.PHONY: clean
clean:
	-@rm path_shortener
