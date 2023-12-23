SECTION .text
global sub

%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]
sub:
    enter 8,0 ;two 32-bit variables
    push ebx
    mov op1, 100
    mov op2, 10
    mov eax, op1
    mov ebx, op2
    sub eax, ebx
    pop ebx
    leave
    ret