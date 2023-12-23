SECTION .text
global div

%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]
div:
    enter 8,0 ;two 32-bit variables
    push ebx
    mov op1, 30
    mov op2, 7

    cmp op1, 0
    jl fst_neg

    cmp op2, 0
    jl snd_neg

    mov eax, op1
    mov ebx, op2 
    idiv ebx

    jmp fim

fst_neg:
    mov ebx, -1
    mov eax, op1
    imul ebx
    mov op1, eax

    cmp op2, 0
    jl both_neg

    mov eax, op1
    mov ebx, op2
    
    idiv ebx
    mov ebx, -1
    imul ebx
    jmp fim

snd_neg:
    mov ebx, -1
    mov eax, op2
    imul ebx
    mov op2, eax
    
    mov eax, op1
    mov ebx, op2
    
    idiv ebx
    mov ebx, -1
    imul ebx
    jmp fim

both_neg:
    mov ebx, -1
    mov eax, op2
    imul ebx
    mov op2, eax
    mov eax, op1
    mov ebx, op2 
    idiv ebx
    jmp fim 

div_continue:
    mov eax, op1
    mov ebx, op2 
    idiv ebx
    ret

fim:   
    pop ebx
    leave
    ret