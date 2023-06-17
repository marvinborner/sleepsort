all: asm

asm:
	@nasm -f elf64 -o sort.o sort.asm
	@nasm -f elf64 -o data.o data.asm
	@gcc -no-pie -o sort data.o sort.o

c:
	@nasm -f elf64 -o data.o data.asm
	@gcc -no-pie -c -o csort.o benchmark/sort.c
	@gcc -no-pie -o csort data.o csort.o
