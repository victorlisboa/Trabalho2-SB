SECTION .text
global add16, add32

add16:
%define op1 WORD [EBP-4]
%define op2 WORD [EBP-6]
enter 4,0
jmp add

add32:
%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]
enter 8,0

add:
    push ebx
    mov op1, -10
    mov op2, 3
    mov eax, op1
    mov ebx, op2
    add eax, ebx
    pop ebx
    leave
    ret