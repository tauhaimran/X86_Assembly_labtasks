
; 22i-1239-G - Question # 3 - coal lab final

.386
.model flat,stdcall
.stack 4096

include irvine32.inc
include macros.inc

.data
		
	arr1 word 10,20,30,40,50,60,70,80,90,55
	arr2 word 55,60,72,30,50,60,17,18,09,55

	GreaterThanCount db 0
	LessThanCount db 0

	evo db 0 

		
.code

main proc

mWrite "22i1239_G"
call Crlf
mWrite "QUESTION 2) arrays and stuff..."
call Crlf
call Crlf

	mov esi,offset arr1
	mov edi,offset arr2
mov ebx,0
mov eax,0
mov ecx,0
	mov ecx,10

		myloop:
				MOV AX, WORD PTR [ESI]
				MOV BX, WORD PTR [EDI]

				;case - b & c
				cmp ax,bx
				jg incx
				jl decx

				OR AX,1
				mov word ptr [esi],ax
				jmp case_a

				incx:
					inc GreaterThanCount
				jmp case_a
				decx:
					inc LessThanCount
				;-------------------
					case_a:
					add ax,bx
					cmp ax,100
					jle contn
					AND AX,0111111111111111b
					mov word ptr [esi],ax

				contn:
				call Crlf
				mWrite "----------------------------------------------"
				call Crlf
				call Crlf
				call showx
				
			inc esi
			inc edi
				inc esi
				inc edi
			mov eax,0
			mov ebx,0
		loop myloop

				call Crlf
				mWrite "----------------------------------------------"
				call Crlf
exit
main endp

;-----------
showx proc

	mov esi,offset arr1
	mov edi,offset arr2
mov ebx,0
mov eax,0
mov edx,0
mov edx,ecx
	mov ecx,10

	mWrite "arr1  { "
		l1:
			MOV AX, WORD PTR [ESI]
				
				call WriteDec
				mWrite ","

				AND AX,1000000000000000b
				cmp ax,1
				jne cnx1

				inc evo

		cnx1:
			inc esi
			inc esi
			mov eax,0
		loop l1

	mWrite" }"
	call crlf

mov ecx,10
	mWrite "arr2  { "
		l2:
			MOV BX, WORD PTR [EDI]
				
				mov eax,ebx
				call WriteDec
				mWrite ","

				AND BX,1000000000000000b
				cmp bx,1
				jne cnx2

				inc evo

		cnx2:
			inc edi
			inc edi
			mov ebx,0
			mov eax,0
		loop l2

	mWrite" }"
	call crlf

mWrite" GreaterThanCount : "
	mov eax,0
	mov al,GreaterThanCount
call WriteDec
call crlf
	
	
	mWrite" LessThanCount :"
	mov eax,0
	mov al,LessThanCount
call WriteDec
call crlf

mov eax,0
mov al,evo
and ax,1
cmp ax,1
jne show_even

	mWrite " ODD PARITY DETECTECTED "
jmp go_home

show_even:
	mWrite " EVEN PARITY DETECTECTED "
go_home:
mov ecx,edx
call crlf
ret
showx endp

end main