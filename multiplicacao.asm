SECTION .text
extern overflow, printstr, printw, printdw, getw, getdw
global mult16, mult32

%define op1 WORD [EBP-2]
mult16:
    enter 4,0
    call getw
    mov op1, ax
    call getw
    imul op1
    jo overflow_occurred
    push ax
    call printw
    leave
    ret

%define op1 DWORD [EBP-4]
mult32:
    enter 4,0
    call getdw
    mov op1, eax
    call getdw
    imul op1
    jo overflow_occurred
    push eax
    call printdw
    leave
    ret

overflow_occurred:
    push overflow
    call printstr
    
    ; exit
    mov eax, 1
    mov ebx, 0
    int 80h
