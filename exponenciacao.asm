SECTION .text
global exp16, exp32
extern overflow, printstr

exp16:
%define base WORD [EBP-4]
%define exponent WORD [EBP-6]
enter 4,0
jmp exp

exp32:
%define base DWORD [EBP-4]
%define exponent DWORD [EBP-8]
enter 8,0

exp:
    ; enter 8,0 ;two 32-bit variables
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
    jo overflow_occurred
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

overflow_occurred:
    push overflow
    call printstr
     ; exit
    mov eax, 1
    mov ebx, 0
    int 80h