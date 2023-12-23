SECTION .text
global sub16, sub32

sub16:
%define op1 WORD [EBP-4]
%define op2 WORD [EBP-6]
enter 4,0
push ebx
mov op1, -100
mov op2, -10
movsx eax, op1
movsx ebx, op2
sub eax, ebx
pop ebx
leave
ret

sub32:
%define op1 DWORD [EBP-4]
%define op2 DWORD [EBP-8]
enter 8,0
push ebx
mov op1, -100
mov op2, 10
mov eax, op1
mov ebx, op2
sub eax, ebx
pop ebx
leave
ret