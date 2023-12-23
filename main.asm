SECTION .data
global overflow

msg1 db "Bem vindo. Digite seu nome: ", 0
msg2 db "Hola, ", 0
msg3 db ", bem-vindo ao programa de CALC IA-32", 10, 0
msg4 db	"Vai trabalhar com 16 ou 32 bits (digite 0 para 16, e 1 para 32): ", 0
menu1 db "ESCOLHA UMA OPÇÃO:", 10, 0
menu2 db "- 1: SOMA", 10, 0
menu3 db "- 2: SUBTRACAO", 10, 0
menu4 db "- 3: MULTIPLICACAO", 10, 0
menu5 db "- 4: DIVISAO", 10, 0
menu6 db "- 5: EXPONENCIACAO", 10, 0
menu7 db "- 6: MOD", 10, 0
menu8 db "- 7: SAIR", 10, 0
overflow db "OCORREU OVERFLOW", 10, 0

SECTION .bss
global precision

name resb 60
precision resb 2
menuOpt resb 2

SECTION .text
global _start
extern printstr, getstr, getdw, mult, add, sub, div

_start:

    push msg1
    call printstr
    
    ; get user's name
    push name
    push 60
    call getstr

    ; welcome to user
    push msg2
    call printstr
    
    push name
    call printstr

    push msg3
    call printstr

    ; asks for precision
    push msg4
    call printstr

    push precision
    push 2
    call getstr

menu:
    ; presents menu and asks for operation
    push menu1
    call printstr
    push menu2
    call printstr
    push menu3
    call printstr
    push menu4
    call printstr
    push menu5
    call printstr
    push menu6
    call printstr
    push menu7
    call printstr
    push menu8
    call printstr
    
    push menuOpt
    push 2
    call getstr

    call getdw    

    jmp menu

    ; exit
    mov eax, 1
    mov ebx, 0
    int 80h
