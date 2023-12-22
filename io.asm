SECTION .text
global printstr, getstr, getdw

; printstr
; Args:
;   pointer to string
; Returns:
;   -
; Description:
;   prints string
printstr:
    enter 0, 0
    push DWORD [ebp+8]  ; push string pointer
    call strlen
    mov edx, eax        ; size of string
    mov eax, 4          ; write syscall
    mov ecx, [ebp+8]    ; pointer to string
    mov ebx, 1          ; stdout
    int 80h
    leave
    ret 4

; strlen
; Args:
;   pointer to string
; Returns:
;   EAX = size of string
; Description:
;   returns string size it assumes the string ends with '\0'
strlen:
    enter 0, 0
    mov eax, [ebp+8]

strlen_loop:
    cmp BYTE [eax], 0   ; end of string
    je strlen_end
    inc eax
    jmp strlen_loop

strlen_end:
    sub eax, [ebp+8]    ; end - begin = size
    leave
    ret 4

; getstr
; Args:
;   pointer to string
;   size of string to read
; Returns:
;   -
; Description:
;   reads string from keyboard and stores it in pointer
getstr:
    enter 0, 0
    
    mov eax, 3
    mov ebx, 0
    mov ecx, [ebp+12]   ; pointer to string
    mov edx, [ebp+8]    ; size of string
    int 80h

    ; removes '\n'
    mov ebx, [ebp+12]
    mov BYTE [ebx+eax-1], 0

    leave
    ret 8

; getdw
; Args:
;   -
; Returns:
;   EAX = int32 read
; Description:
;   reads ASCII number and converts into int32
%define dw_max_len 11
getdw:
    enter 15, 0
    
    mov eax, ebp
    sub eax, 15		; eax = ebp - 15
    push eax		; salva ponteiro da string
    push eax		; passa ponteiro da string
    push dw_max_len	; passa tamanho da string
    call getstr		; string lida fica na pilha
    pop eax		; recupera ponteiro da string
	    
    leave
    ret
