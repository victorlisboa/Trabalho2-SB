SECTION .text
global div16, div32

div16:
%define op1 WORD [EBP-4]
%define op2 WORD [EBP-6]
enter 4,0
push ebx
mov op1, -23
mov op2, 7
movsx eax, op1
cdq ; sign extend eax into edx:eax
movsx ebx, op2 
idiv ebx

test eax, eax      ; check if quotient is negative
jge fim           ; jump if quotient is greater than or equal to zero
cmp edx, 0         ; check if remainder is non-zero
jz fim            ; jump if remainder is zero
dec eax            ; decrement the quotient for negative remainder
jmp fim

div32:
%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]
enter 8,0
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
    