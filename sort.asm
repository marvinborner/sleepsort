; Copyright (c) 2023 Marvin Borner

global main
extern printf

bits 64

;;; main

main:
	push    rbp
	mov     ecx, size

loop:
	push    rcx
	call    thread
	pop     rcx
	dec     ecx
	jnz     loop

end:
	pop     rbp
	mov     rax, 0x3c
	mov     rdi, 0
	syscall ; exit

; this works sometimes (if numbers are good)
; uses busy loop
coolsleep:
	mov     rax, 0x4242424
	mov     rcx, rsi
	mul     rcx
.loop:
	dec     rax
	jnz     .loop
	ret

; this works on most normal CPUs (if numbers are good)
; uses nanosleep syscall
boringsleep:
	mov     rax, 0x424242
	mov     rcx, rsi
	mul     rcx
	push    qword rax ; ns
	push    qword 0 ; s
	mov     rax, 0x23
	mov     rdi, rsp
	xor     rsi, rsi
	syscall
	add     rsp, 16
	ret

print:
	push    rsi
	call    boringsleep ; or coolsleep
	pop     rsi
	mov     rdi, format
	xor     rax, rax
	call    printf
	ret

thread:
	lea     rax, print
	mov     esi, [array + (ecx - 1) * 4]
	call    thread_run
	ret

;;; utils

thread_run:
	push    rax
	mov     rax, 0x39
	syscall ; fork
	cmp     rax, 0
	mov     r10, rax
	pop     rax
	je      child
	mov     rax, r10
	ret

child:
	call    rax

	mov     rax, 0x3c
	mov     rdi, 0
	syscall ; exit

;;; data

section .data

array: dd 3,1,4,1,5,9,2,6,5,3,5,8,9,7,9,3
size: equ ($-array)/4
format: db "%d", 10, 0
