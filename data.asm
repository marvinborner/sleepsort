section .data

global array
global size

array: dd 3,1,4,1,5,9,2,6,5,3,5,8,9,7,9,3
size: equ ($-array)/4
