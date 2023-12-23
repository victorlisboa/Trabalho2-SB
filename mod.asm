SECTION .text
global mod16, mod32

mod16:
%define op1 WORD [EBP-4]
%define op2 WORD [EBP-6]
enter 4,0
jmp mod

mod32:
%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]
enter 8,0

mod:
    push ebx
    mov op1, -22
    mov op2, -7
    mov eax, op1
    cdq ; sign extend eax into edx:eax
    mov ebx, op2 
    idiv ebx

    test eax, eax      ; check if quotient is negative
    jge fim           ; jump if quotient is greater than or equal to zero
    cmp edx, 0         ; check if remainder is non-zero
    jz fim            ; jump if remainder is zero
    dec eax     ; mod divisor to remainder for negative quotient
    
    imul eax, op2 ; eax = quocient * divisor
    mov ebx, op1 ;ebx = divident
    sub ebx, eax ; ebx = divident - quocient * divisor
    mov edx, ebx ; edx = remainer

fim:
    mov eax, edx
    pop ebx
    leave
    ret  
    