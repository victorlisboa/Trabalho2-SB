SECTION .text
extern overflow, printstr
global mult16, mult32

mult16:
%define op1 WORD [EBP-4]
%define op2 WORD [EBP-6]
enter 4,0
jmp mult

mult32:
%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]
enter 8,0

mult:
    push ebx
    mov op1, 100
    mov op2, 100
    mov eax, op1
    mov ebx, op2
    imul ebx

    jo overflow_occurred

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