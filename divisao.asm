SECTION .text
global div16, div32
extern printw, printdw, getw, getdw

%define op1 WORD [EBP-2]
div16:
    enter 2,0
    call getw
    mov op1, ax
    call getw
    mov bx, ax      ; guarda segundo numero
    mov ax, op1
    cwd             ; extende sinal do ax pra 
    idiv bx         ; dx:ax / bx
    push ax         ; quocient is on ax
    call printw
    leave
    ret

%define op1 DWORD [EBP-4]
div32:
    enter 4,0
    call getdw
    mov op1, eax
    call getdw
    mov ebx, eax
    mov eax, op1
    cdq             ; sign extend eax into edx:eax
    idiv ebx        ; edx:eax / ebx
    push eax        ; quocient in on eax
    call printdw
    leave
    ret

