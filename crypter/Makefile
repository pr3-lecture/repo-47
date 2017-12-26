.PHONY: all clean
all: encrypt decrypt runtest

clean:
	rm -f encrypt decrypt test main.o crypto.o test.o

main.o: main.c
	cc -Wall -c main.c

crypto.o: crypto.c
	cc -Wall -c crypto.c

test.o: test.c
	cc -Wall -c test.c

encrypt: main.o crypto.o
	cc -o encrypt main.o crypto.o

decrypt: main.o crypto.o
	cc -o decrypt main.o crypto.o

runtest: test.o crypto.o
	cc -o test test.o crypto.o
	./test


