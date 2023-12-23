SECTION .text
global div

%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]

div:
    enter 8,0 ;two 32-bit variables
    push ebx
    mov op1, -12
    mov op2, -3
    mov eax, op1
    cdq ; sign extend eax into edx:eax
    mov ebx, op2 
    idiv ebx

    test eax, eax      ; check if quotient is negative
    jge fim           ; jump if quotient is greater than or equal to zero
    cmp edx, 0         ; check if remainder is non-zero
    jz fim            ; jump if remainder is zero
    dec eax            ; decrement the quotient for negative remainder

fim:
    pop ebx
    leave
    ret  
    