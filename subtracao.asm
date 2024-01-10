SECTION .text
extern getw, getdw, printw, printdw
global sub16, sub32

sub16:
%define op1 WORD [EBP-2]
    enter 2,0
    call getw
    mov op1, ax
    call getw
    sub ax, op1
    push ax
    call printw
    leave
    ret

%define op1 DWORD [EBP-4]
sub32:
    enter 4,0
    call getdw
    mov op1, eax
    call getdw
    sub eax, op1
    push eax
    call printdw
    leave
    ret
