SECTION .text
global exp

%define base DWORD [EBP-4]
%define exponent DWORD [EBP-8]
exp:
    enter 8,0 ;two 32-bit variables
    push ebx
    mov base, 7
    mov exponent, 3 
    
    cmp exponent, 0
    jl result_zero
    je result_one

    mov eax, 1
    mov ebx, base
    mov ecx, exponent

exp_operation:
    imul ebx
    loop exp_operation
    jmp fim
    
result_zero:
    mov eax, 0
    jmp fim

result_one:
    mov eax, 1

fim:
    pop ebx
    leave
    ret