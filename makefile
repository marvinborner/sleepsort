all: asm

asm:
	@nasm -O3 -f elf64 -o sort.o sort.asm
	@nasm -O3 -f elf64 -o data.o data.asm
	@gcc -O3 -no-pie -o sort data.o sort.o

c:
	@nasm -O3 -f elf64 -o data.o data.asm
	@gcc -O3 -no-pie -c -o csort.o benchmark/sort.c -Wno-pointer-to-int-cast
	@gcc -O3 -no-pie -o csort data.o csort.o
