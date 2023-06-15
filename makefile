SRC = sort.asm
OBJ = sort.o

all:
	@nasm -f elf64 -o $(OBJ) $(SRC)
	@gcc -no-pie -o sort $(OBJ)
