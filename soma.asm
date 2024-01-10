SECTION .text
extern getw, getdw, printw, printdw
global add16, add32

add16:
%define op1 WORD [EBP-2]
    enter 2,0
    call getw
    mov op1, ax
    call getw
    add ax, op1
    push ax
    call printw
    leave
    ret

%define op1 DWORD [EBP-4]
add32:
    enter 4,0
    call getdw
    mov op1, eax
    call getdw
    add eax, op1
    push eax
    call printdw
    leave
    ret
