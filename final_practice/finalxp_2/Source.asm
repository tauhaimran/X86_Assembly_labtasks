
; 22i-1239-G - Question # 2 - coal lab final

.386
.model flat,stdcall
.stack 4096

include irvine32.inc
include macros.inc

.data
		
		;words
		w1 db "coal",0
		w2 db "help",0
		w3 db "fail",0

		writeable db 0,0,0,0

		score db 4 ;to get
		pscr db 0  ;your score
		missed db 0;errors
		input db 0
		game dword 0 ; handle to word chosen


		
.code

main proc

mWrite "22i1239_G"
call Crlf
mWrite "QUESTION 2) HANGNMAN"
call Crlf
call Crlf

call cwrd

mov edx,game
call WriteString

	gamex:
		mWrite "enter a lowercase letter to guess: "
			mov eax,0
			mov ecx,0
				mov edx,offset input
			mov ecx,2
				call ReadString
			mov al,input
		
			call Check

		cmp input,61h
		jl wrong_input
		cmp input,7Ah
		jg wrong_input

		call draw_hm

		mov eax,0
		mov al,pscr
		cmp pscr,4
		je win

		mov eax,0
		cmp missed,5
		je looser

	jmp gamex

wrong_input:
call Crlf
mWrite " INVALIDE CHARACTER! "
call Crlf
jmp gamex

looser:
call Crlf
mWrite " YOU LOST , HE DIED... "
call Crlf
jmp show_word

win:
call Crlf
mWrite " CONGRATULATIONS YOU WON! "
call Crlf

show_word:
call Crlf
mWrite "the word was : "
mov edx,game
call WriteString
call Crlf

exit

main endp

;-----------

cwrd proc

mov ecx,0
mov eax,3
call RandomRange
inc eax

cmp eax,1
je wrd1
cmp eax,2
je wrd2
cmp eax,3
je wrd3


wrd1:
	mov game, offset w1
	mov score , sizeof w1

jmp ret_cwrd

wrd2:
	mov game, offset w2
	mov score , sizeof w2

jmp ret_cwrd


wrd3:
	mov game, offset w3
	mov score , sizeof w3

jmp ret_cwrd


ret_cwrd:
sub score,1
ret
cwrd endp

;-----------------------

check proc

	mov edi,game
	mov ecx,0
	mov cl,score
	L1:
		mov ebx,0
		mov bl, byte ptr [edi]

		cmp al,bl
		je add_score

	inc edi
	loop L1

	inc missed
		mWrite ">> wrong answer!"
		call Crlf
jmp ret_check

invalid:
	mWrite "INVALID ENTRY - LOWER CASE ONLY"
	call Crlf
jmp ret_check

add_score:
mov esi,offset writeable
	add esi,4
	sub esi,ecx
	mov eax,0
	mov al,byte ptr [esi]
	cmp al,1
	je repeated
		inc score
		inc pscr
		mWrite ">> correct answer!"
		call Crlf
		mov esi,offset writeable
		add esi,4
		sub esi,ecx
	    mov byte ptr [esi],1
jmp ret_check

repeated:
		mWrite ">> already entered!"
		call Crlf

ret_check:
ret
check endp

;-------

draw_hm proc


cmp missed ,1
je d1
cmp missed ,2
je d2
cmp missed ,3
je d4
cmp missed ,5
je d5


call Crlf
mWrite "    ^--------   "
call Crlf
mWrite "    |        |  "
call Crlf
mWrite "  (-.-)      |  "
call Crlf
mWrite "             |  "
call Crlf
mWrite "             |  "
call Crlf
mWrite "             |  "
call Crlf
mWrite "             |  "
call Crlf
mWrite " ______________ "
call Crlf
jmp endx


d1:
call Crlf
mWrite "    ^--------   "
call Crlf
mWrite "    |        |  "
call Crlf
mWrite "  (-.-)      |  "
call Crlf
mWrite "    |        |  "
call Crlf
mWrite "    |        |  "
call Crlf
mWrite "             |  "
call Crlf
mWrite "             |  "
call Crlf
mWrite " ______________ "
call Crlf
jmp endx

d2:
call Crlf
mWrite "    ^--------   "
call Crlf
mWrite "    |        |  "
call Crlf
mWrite "  (-.-)      |  "
call Crlf
mWrite "   /|        |  "
call Crlf
mWrite "  / |        |  "
call Crlf
mWrite "             |  "
call Crlf
mWrite "             |  "
call Crlf
mWrite " ______________ "
call Crlf
jmp endx

d3:
call Crlf
mWrite "    ^--------   "
call Crlf
mWrite "    |        |  "
call Crlf
mWrite "  (-.-)      |  "
call Crlf
mWrite "   /|\       |  "
call Crlf
mWrite "  / |  \     |  "
call Crlf
mWrite "             |  "
call Crlf
mWrite "             |  "
call Crlf
mWrite " ______________ "
call Crlf
jmp endx

d4:
call Crlf
mWrite "    ^--------   "
call Crlf
mWrite "    |        |  "
call Crlf
mWrite "  (-.-)      |  "
call Crlf
mWrite "   /|\       |  "
call Crlf
mWrite "  / | \      |  "
call Crlf
mWrite "     \       |  "
call Crlf
mWrite "      \      |  "
call Crlf
mWrite " ______________ "
call Crlf
jmp endx

d5:
call Crlf
mWrite "    ^--------   "
call Crlf
mWrite "    |        |  "
call Crlf
mWrite "  (-.-)      |  "
call Crlf
mWrite "   /|\       |  "
call Crlf
mWrite "  / | \      |  "
call Crlf
mWrite "   / \       |  "
call Crlf
mWrite "  /   \      |  "
call Crlf
mWrite " ______________ "
call Crlf
jmp endx

endx:
ret
draw_hm endp

end main