; Copyright (c) 2023 Marvin Borner

global  main
extern  printf

bits    64

main:
	push    rbp
	mov     ecx, size

print:
	mov     rdi, format
	mov     rsi, [array + (ecx - 1) * 4]
	xor     rax, rax
	push    rcx
	call    printf WRT ..plt
	pop     rcx
	dec     ecx
	jnz     print

end:
	pop     rbp
	mov     rax, 0
	ret

array: dd 1, 5, 3, 7, 2, 6
size: equ ($-array)/4
format: db "%d", 10, 0
