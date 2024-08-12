
; Tauha Imran - 22i1239 - G _ lab04
.386
.model flat,stdcall
.stack 4096
ExitProcess  PROTO, dExitCode:DWORD

.data

	Arr dd  011000011h
	muul word 0

.code
main PROC

;--- Q8 ---	
mov edi , offset Arr

mov ax,0000b
mov bx,0000b

mov ax , word PTR Arr+0
mov bx , word PTR Arr+3 

mul bx

mov muul ,ax

INVOKE ExitProcess,0
main endp
END main

