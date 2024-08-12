; 22i-1239-G - Question # 5 - coal lab final

.386
.model flat,stdcall
.stack 4096

include irvine32.inc
include macros.inc

.data
	
	; string will be too long for visual studio...

	chrx db '#'
	x db 0
	y db 0

	x1 db 0
	y1 db 0

.code

main proc

mWrite "22i1239_G"
call Crlf
mWrite "QUESTION 5) move with AWSD keys plz (screen will clear then you play)"
call WaitMsg
call Clrscr
call Crlf
call Crlf

mov dl,0
mov dh,0
call gotoxy

mov eax,0
mov al,'#'
call writechar

	simulatex:
		mov eax,500
		call delay

		CALL readkey	
		jz dnx

		cmp y,24
		jge stay

		cmp al,'a'
		je lft

		cmp al,'w'
		je up

		cmp al,'s'
		je dn

		cmp al,'d'
		je rt
		
		cmp al,'A'
		je lft

		cmp al,'W'
		je up

		cmp al,'S'
		je dn

		cmp al,'D'
		je rt

			
			lft:
				mov eax,0
				mov al,x
				mov ecx,0
			call RandomRange
			mov x, al
			call drawx
			jmp simulatex

			rt:
				mov eax,0
				mov eax,80
				mov ebx,0
				mov bl,x
				sub al,bl
				mov ecx,0
			call RandomRange
			add x, al
			call drawx
			jmp simulatex

			up:
				mov eax,0
					mov eax,25
					mov ebx,0
				mov bl,y
				sub al,bl
					mov ecx,0
				call RandomRange
				add y, al
				call drawx
				jmp simulatex

			dn:
			mov eax,0
					mov al,y
					mov ecx,0
				call RandomRange
				add y, al
				call drawx
				jmp simulatex
			
			dnx:
			mov eax,0
			mov al,y
					.if  al < 25
					inc al
					.endif
				add y, al
				call drawx
		jmp simulatex

		stay:
		jmp simulatex
exit
main endp

;-----------
drawx proc
	mov dl,x1
	mov dh,y1
	call Gotoxy
	mov al,' '
	call writechar

mov eax,0
mov eax,16
mov ecx,0
		call RandomRange
	call settextcolor

	mov dl,x
	mov dh,y
	call Gotoxy
	mov al,'#'
	call writechar

	mov x1,dl
	mov y1,dh
ret
drawx endp
end main