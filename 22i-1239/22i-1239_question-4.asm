
; 22i-1239-G - Question # 4 - coal lab final

.386
.model flat,stdcall
.stack 4096

include irvine32.inc
include macros.inc

.data
	
	; string will be too long for visual studio...

	para db "A book can be defined as collection of stories ,incients ,and facts in written of image format. ... A person's development depends on the kind of books he reads.",0
	filehandle dword ?
	filename db "text.txt",0
	replace db 0
	vc word 0

.code

main proc

mWrite "22i1239_G"
call Crlf
mWrite "QUESTION 4) pragraph in file"
call Crlf
call Crlf

mov edx, offset filename
call CreateOutputFile
mov filehandle,eax

mov edx, offset para
mov ecx, sizeof para
call WriteToFile

mov eax,filehandle
call closefile

mWrite "Paragraph inserted into file (text.txt) : " 
call crlf
mov edx, offset para
call WriteString

call CRLF
call CRLF
call CRLF

mWrite " ENTER A CHARACTER TO REPLACE VOWELS : "
mov ecx,0
mov edx, offset replace
inc ecx
inc ecx
call ReadString

call CRLF
call CRLF

;///////////////////////////////////////////////////
mov ecx,0
mov ecx,sizeof para
mov edi , offset para
		rl1:
			mov al, byte ptr [edi]

			cmp  al,'A'
			je vowel
			cmp  al,'E'
			je vowel
			cmp  al,'I'
			je vowel
			cmp  al,'O'
			je vowel
			cmp  al,'U'
			je vowel
			cmp  al,'a'
			je vowel
			cmp  al,'e'
			je vowel
			cmp  al,'i'
			je vowel
			cmp  al,'o'
			je vowel
			cmp  al,'u'
			je vowel

		jmp not_vowel
		vowel:
		mov al,replace
		mov byte ptr [edi],al
		inc vc

		not_vowel:
		inc edi
		loop rl1
;///////////////////////////////////////////////////

mov eax,0
mov ax,vc
mWrite " VOWEL COUNT : "
call WriteDec

call crlf
call crlf

mov edx, offset filename
call CreateOutputFile
mov filehandle,eax

mov edx, offset para
mov ecx, sizeof para
call WriteToFile

mov eax,filehandle
call closefile


mWrite "NEW Paragraph inserted into file (text.txt) : " 
call crlf
mov edx, offset para
call WriteString


call crlf
call crlf

exit
main endp

;-----------

end main