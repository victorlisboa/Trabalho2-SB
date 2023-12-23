SECTION .text
global add

%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]
add:
    enter 8,0 ;two 32-bit variables
    push ebx
    mov op1, 10000
    mov op2, 10000
    mov eax, op1
    mov ebx, op2
    add eax, ebx
    pop ebx
    leave
    ret