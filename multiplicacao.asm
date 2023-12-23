SECTION .text
global mult

%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]
mult:
    enter 8,0 ;two 32-bit variables
    push ebx
    mov op1, -2
    mov op2, 3
    mov eax, op1
    mov ebx, op2
    imul ebx
    pop ebx
    leave
    ret