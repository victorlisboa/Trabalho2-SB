SECTION .text
global mod

%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]

mod:
    enter 8,0 ;two 32-bit variables
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
    dec eax     ; add divisor to remainder for negative quotient
    
    imul eax, op2 ; eax = quocient * divisor
    mov ebx, op1 ;ebx = divident
    sub ebx, eax ; ebx = divident - quocient * divisor
    mov edx, ebx ; edx = remainer

fim:
    mov eax, edx
    pop ebx
    leave
    ret  
    