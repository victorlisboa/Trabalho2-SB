SECTION .text
global printstr, printw, printdw, getstr, getw, getdw

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

;  getw:
;; Args:
;;   -
;; Returns:
;;   AX = int16 read
;; Description:
;;   reads ASCII number and converts into int32
;%define dw_max_len 13
;%define val [ebp-4]
getw:
printw:
printdw:
;    enter 17, 0
;    
;    ; reads ASCII number
;    mov ebx, ebp
;    sub ebx, 17		; ebx = ebp - 17
;    push ebx		; salva ponteiro da string
;    push ebx		; passa ponteiro da string
;    push dw_max_len	; passa tamanho da string
;    call getstr		; string lida fica na pilha
;    
;    pop ebx		    ; recupera ponteiro da string
;	    
;    ; converts to binary
;    mov eax, 0	; zera valor inicial
;Getdw_loop:
;    cmp BYTE [ebx], 0	; verifica se chegou no final da string
;    je getdw_end
;    
;    ; multiplica val por 10
;    mov edx, eax
;    sal eax, 2
;    add eax, edx
;    add eax, eax	; ebx = val*10
;    
;    movsx BYTE ecx, [ebx]	; ebx = char
;    sub ecx, 0x30	        ; char -> number
;    add eax, ecx	        ; num += number
;    inc ebx	            	; ponteiro++
;    jmp getdw_loop

; getdw
; Args:
;   -
; Returns:
;   EAX = int32 read
; Description:
;   reads ASCII number and converts into int32
%define dw_max_len 13
%define ngt WORD [ebp-2]
getdw:
    enter 15, 0
    
    ; reads ASCII number
    mov ebx, ebp
    sub ebx, 15		; ebx = ebp - 17
    push ebx		; salva ponteiro da string
    push ebx		; passa ponteiro da string
    push dw_max_len	; passa tamanho da string
    call getstr		; string lida fica na pilha
 
    pop ebx		    ; recupera ponteiro da string
	
    ; check if it's negative
    mov edx, 0
    cmp BYTE [ebx], '-'
    sete dl
    mov ngt, dx 
    mov eax, 0	; zera valor inicial
    jne getdw_loop
    inc ebx

    ; converts to binary
getdw_loop:
    cmp BYTE [ebx], 0	; verifica se chegou no final da string
    je getdw_end
    
    ; multiplica val por 10
    mov edx, eax
    sal eax, 2
    add eax, edx
    add eax, eax	; ebx = val*10
    
    movsx ecx, BYTE [ebx]	; ebx = char
    sub ecx, 0x30	        ; char -> number
    add eax, ecx	        ; num += number
    inc ebx	            	; ponteiro++
    jmp getdw_loop

getdw_end:
    cmp ngt, 1
    jne getdw2_end
    neg eax

getdw2_end:
    leave
    ret

