.386
.model flat,stdcall

.stack 4096
GetTickCount PROTO

ExitProcess PROTO, ; exit program
dwExitCode:DWORD ; return code

SetConsoleTextAttribute PROTO, nStdHandle:DWORD, nColor:DWORD

GetStdHandle PROTO, ; get standard handle
nStdHandle:DWORD ; type of console handle

CloseHandle PROTO, ; close file handle
handle:DWORD

GetTickCount PROTO ; get elapsed milliseconds since computer
; turned on

ReadConsoleA PROTO,
handle:DWORD, ; input handle
lpBuffer:PTR BYTE, ; pointer to buffer
nNumberOfCharsToRead:DWORD, ; number of chars to read
lpNumberOfCharsRead:PTR DWORD, ; number of chars read
lpReserved:PTR DWORD ; 0 (not used - reserved)

WriteConsoleA PROTO, ; write a buffer to the console
handle:DWORD, ; output handle
lpBuffer:PTR BYTE, ; pointer to buffer
nNumberOfCharsToWrite:DWORD, ; size of buffer
lpNumberOfCharsWritten:PTR DWORD, ; number of chars written
lpReserved:PTR DWORD ; 0 (not used)

SetConsoleTextAttribute PROTO,
nStdHandle:DWORD, ; console output handle
nColor:DWORD ; color attribute

SetConsoleCursorPosition PROTO,
handle:DWORD,
pos:DWORD

.data
seed dword 15
gamestarted byte "Game is Started",0
gameended byte "You Lost! Game is ended",0
input1 byte "Enter Row Number",0
input2 byte "Enter Column Number",0
array dword 100 dup(?)
inhandle dword ?
outhandle dword ?
buffer byte 10 dup(?),0
buffer1 byte 10 dup(?),0
nextline byte 013h,0ah,0
x dword ?
num1 dword ?
num2 dword ?
mines dword ?
minemessage byte "The number of mines are",0
;(Minesweeper title)
title1 byte "                                                                               ", 0ah, 0
title2 byte "                      _____  ______                ____  ____  _____   _____   ", 0ah, 0
title3 byte "|\      /| | |\    | |      |        |    /\    | |     |     |     | |     | ", 0ah, 0
title4 byte "| \    / | | | \   | |      |______  |   /  \   | |     |     |_____| |_____| ", 0ah, 0
title5 byte "|  \  /  | | |  \  | |-----        | |  /    \  | |---- |---- |       |\      ", 0ah, 0
title6 byte "|   \/   | | |   \ | |             | | /      \ | |     |     |       | \     ", 0ah, 0
title7 byte "|        | | |    \| |_____  _____| |/        \| |___ |____ |       |  \    ", 0ah, 0
title8 byte "                                                                               ", 0ah, 0
;(Minesweeper title)
	;(Minesweeper grid )
	grid1 byte "#|#|#|#|#|#|#|#|#|#|",0
	line1 byte "--------------------",0
	grid2 byte "#|#|#|#|#|#|#|#|#|#|",0
	line2 byte "--------------------",0
	grid3 byte "#|#|#|#|#|#|#|#|#|#|",0
	line3 byte "--------------------",0
	grid4 byte "#|#|#|#|#|#|#|#|#|#|",0
	line4 byte "--------------------",0
	grid5 byte "#|#|#|#|#|#|#|#|#|#|",0
	line5 byte "--------------------",0
	grid6 byte "#|#|#|#|#|#|#|#|#|#|",0
	line6 byte "--------------------",0
	grid7 byte "#|#|#|#|#|#|#|#|#|#|",0
	line7 byte "--------------------",0
	grid8 byte "#|#|#|#|#|#|#|#|#|#|",0
	line8 byte "--------------------",0
	grid9 byte "#|#|#|#|#|#|#|#|#|#|",0
	line9 byte "--------------------",0
	grid0 byte "#|#|#|#|#|#|#|#|#|#|",0
	line0 byte "--------------------",0
	;(Minesweeper grid end)
selection byte "Enter your choice here in row and column",0
.code
invoke GetTickCount

generaterandom proc uses ebx edx
	mov ebx, eax  ; maximum value
	mov eax, 343FDh
	imul seed
	add eax, 269EC3h
	mov seed, eax ; save the seed for the next call
	ror eax,8 ; rotate out the lowest digit
	mov edx,0
	div ebx  ; divide by max value
	mov eax, edx  ; return the remainder
	ret
generaterandom endp

createMineField PROC uses eax ecx
	mov ecx, 10
	L1: 
		mov eax, 100
		call generaterandom
		cmp array[eax], 49
		je alreadyExists
		mov array[eax], 49
		jmp cont
		alreadyExists: 
		inc ecx
		cont:
		loop L1
	ret
createMineField endp

display proc

invoke getstdhandle, -11
mov outhandle, eax
invoke getstdhandle, -10
mov inhandle, eax
;(Minesweeper Game Started)
	invoke SetConsoleTextAttribute  , outhandle, 00000011b	
	invoke writeconsoleA, outhandle, offset gamestarted, lengthof gamestarted, offset x, 0
		invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0
	
;(Minesweeper Title start)
		invoke SetConsoleTextAttribute  , outhandle, 00000011b	
		invoke writeconsoleA, outhandle, offset title1, lengthof title1, offset x, 0
		
		invoke SetConsoleTextAttribute  , outhandle, 00001010b
		invoke writeconsoleA, outhandle, offset title2, lengthof title2, offset x, 0

		invoke SetConsoleTextAttribute  , outhandle, 00001001b
		invoke writeconsoleA, outhandle, offset title3, lengthof title3, offset x, 0

		invoke SetConsoleTextAttribute  , outhandle, 00000001b
		invoke writeconsoleA, outhandle, offset title4, lengthof title4, offset x, 0

		invoke SetConsoleTextAttribute  , outhandle, 00001110b
		invoke writeconsoleA, outhandle, offset title5, lengthof title5, offset x, 0

		invoke SetConsoleTextAttribute  , outhandle, 00000101b
		invoke writeconsoleA, outhandle, offset title6, lengthof title6, offset x, 0

		invoke SetConsoleTextAttribute , outhandle, 00001101b
		invoke writeconsoleA, outhandle, offset title7, lengthof title7, offset x, 0

		invoke SetConsoleTextAttribute, outhandle, 00001011b
		invoke writeconsoleA, outhandle, offset title8, lengthof title8, offset x, 0
;(Minesweeper Title end)

;(Minesweeper grid start)
	invoke writeconsoleA, outhandle, offset grid1, lengthof grid1, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0

	invoke writeconsoleA, outhandle, offset grid2, lengthof grid2, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0

	invoke writeconsoleA, outhandle, offset grid3, lengthof grid3, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0

	invoke writeconsoleA, outhandle, offset grid4, lengthof grid4, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0

	invoke writeconsoleA, outhandle, offset grid5, lengthof grid5, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0

	invoke writeconsoleA, outhandle, offset grid6, lengthof grid6, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0

	invoke writeconsoleA, outhandle, offset grid7, lengthof grid7, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0

	invoke writeconsoleA, outhandle, offset grid8, lengthof grid8, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0

	invoke writeconsoleA, outhandle, offset grid9, lengthof grid9, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0

	invoke writeconsoleA, outhandle, offset grid0, lengthof grid0, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0
;(Minesweeper grid end)

ret
display endp

readingconsole proc
;(Minesweeper input)
		invoke writeconsoleA, outhandle, offset input1, lengthof input1, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0	

;(Minesweeper readinging input)
	invoke ReadConsoleA, inhandle, offset buffer, lengthof buffer, offset x, 0
;(Minesweeper input)
		invoke writeconsoleA, outhandle, offset input2, lengthof input2, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0	

;(Minesweeper readinging input)
	invoke ReadConsoleA, inhandle, offset buffer1, lengthof buffer1, offset x, 0
	call rowmajor
ret
readingconsole endp

doingzero1 proc uses esi
	mov esi,offset buffer
	add esi,1
	mov dword ptr ecx,lengthof buffer
	dec ecx
	L1:
	mov byte ptr [esi],0
	inc esi
	loop L1
	ret
doingzero1 endp

doingzero2 proc uses esi
	mov esi,offset buffer1
	add esi,1
	mov dword ptr ecx,lengthof buffer1
	L1:
	mov byte ptr [esi],0
	inc esi
	loop L1
	ret
doingzero2 endp

readingnum1 proc
	call doingzero1
	mov esi,offset buffer
	call ToDecimal
	mov num1,ebx
	ret
readingnum1 endp

readingnum2 proc

	call doingzero2
	mov esi,offset buffer1
	call ToDecimal
	mov num2,ebx
	ret
readingnum2 endp

rowmajor proc
	call readingnum1
	call readingnum2
	mov eax,0
	mov ecx,num1
	dec ecx
	L1:
	add eax,10
	loop L1
	add eax,num2
	push eax
	call checkmine
	ret
rowmajor endp

checkmine proc

	mov esi,0
	mov eax,[esp+4]
	
	cmp array[eax],49
	jne checkup
	
		invoke SetConsoleTextAttribute, outhandle, 00001100b
		invoke writeconsoleA, outhandle, offset gameended, lengthof gameended, offset x, 0
		call minefielddisplay
ret


	checkup:

		mov eax,0
		mov ecx,num1
		mov ebx,num2
		sub ecx,2
		cmp ecx,0
		jle donothing
		L1:
		add eax,10
		loop L1
		add eax,ebx
		cmp array[eax],49
		je incmine
		jmp checkblow
		incmine:
		inc esi
		donothing:
		jmp checkblow
		ret


	checkblow: 
		mov eax,0
		mov ecx,num1
		mov ebx,num2
		inc ecx
		cmp ecx,0
		jle donothing1
		L2:
		add eax,10
		loop L2
		add eax,ebx
		cmp array[eax],"31"
		je incmine1
		jmp checkright
		incmine1:
		inc esi
		donothing1:
		jmp checkright
		ret


	checkright:
		mov eax,0
		mov ecx,num1
		mov ebx,num2
		dec ebx
		cmp ebx,0
		jle donothing2
		L3:
		add eax,10
		loop L3
		add eax,ebx
		cmp array[eax],49
		je incmine2
		jmp checkleft
		incmine2:
		inc esi
		donothing2:
		jmp checkleft
		ret


	checkleft: 
		mov eax,0
		mov ecx,num1
		mov ebx,num2
		inc ebx
		cmp ecx,0
		jle donothing3
		L4:
		add eax,10
		loop L4
		add eax,ebx
		cmp array[eax],49
		je incmine3
		jmp checkrightac
		incmine3:
		inc esi
		donothing3:
		jmp checkrightac
		ret


	checkrightac:
		mov eax,0
		mov ecx,num1
		mov ebx,num2
		sub ecx,2
		dec ebx
		cmp ecx,0
		jle donothing4
		L5:
		add eax,10
		loop L5
		add eax,ebx
		cmp array[eax],49
		je incmine5
		jmp checkrightbc
		incmine5:
		inc esi
		donothing4:
		jmp checkrightbc
		ret

	checkrightbc:
		mov eax,0
		mov ecx,num1
		mov ebx,num2
		inc ecx
		inc ebx
		cmp ecx,0
		jle donothing5
		L6:
		add eax,10
		loop L6
		add eax,ebx
		cmp array[eax],49
		je incmine6
		jmp checkleftac
		incmine6:
		inc esi
		donothing5:
		jmp checkleftac
		ret

	checkleftac:
		mov eax,0
		mov ecx,num1
		mov ebx,num2
		sub ecx,2
		dec ebx
		cmp ecx,0
		jle donothing6
		L7:
		add eax,10
		loop L7
		add eax,ebx
		cmp array[eax],49
		je incmine7
		jmp checkleftbc
		incmine7:
		inc esi
		donothing6:
		jmp checkleftbc
		ret

	checkleftbc:
		mov eax,0
		mov ecx,num1
		mov ebx,num2
		inc ecx
		inc ebx
		cmp ecx,0
		jle donothing7
		L8:
		add eax,10
		loop L8
		add eax,ebx
		cmp array[eax],49
		je incmine8
		incmine8:
		inc esi
		mov mines,esi
		donothing7:
		call minefielddisplay
		call readingconsole
		ret

checkmine endp

minefielddisplay proc
	mov eax,mines
	mov esi,offset mines
	call ToString
	invoke writeconsoleA, outhandle, offset minemessage, lengthof minemessage, offset x, 0
	invoke writeconsoleA, outhandle, offset mines, lengthof mines, offset x, 0
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0	
	invoke WriteConsoleA,outhandle,offset nextline,lengthof nextline,offset x,0	
	ret
minefielddisplay endp

ToDecimal PROC
	push esi
	cmp byte ptr [esi], '-'
	jne itspostive
	inc esi
	itspostive:
	mov ebx, 0			; x = 0
	mov edx,0


	L1:
		
		mov cl, [esi]	; Get a character
		cmp cl,0		; check if its a null character
		je endL1
		mov edi, 10
		mov eax, ebx
		mul edi			; 10*x
		sub cl, 48		; (s[i]-'0') 
						; the character has been converted to its corrsponding number
		movzx ecx, cl
		add eax, ecx	; x*10 + (s[i]-48) 
		mov ebx, eax    ; x = x*10 + (s[i]-48) 
		inc esi
	jmp L1
	endL1:
	mov eax, ebx
	pop esi
	cmp byte ptr[esi], '-'
	jne itwaspositive
	neg eax
	itwaspositive:
ret
ToDecimal ENDP

ToString PROC
	push eax
	mov edi, 10
	mov ecx, 0				; Ecx will have the digit count in the end
	findnumofdigits:
		cmp eax, 0
		je exitfinddigits
		mov edx, 0
		div edi
		inc ecx
	jmp findnumofdigits
	exitfinddigits:
	pop eax
	push ecx
	mov byte ptr [esi+ecx] , 0 ; null terminate the string
	savecharacters:
		mov edx, 0
		div edi
		add dl, 48
		mov [esi+ecx-1], dl
	loop savecharacters
	pop eax
ret
ToString ENDP

main proc
	call display
	call createMineField
	call readingconsole
	
main endp
end main