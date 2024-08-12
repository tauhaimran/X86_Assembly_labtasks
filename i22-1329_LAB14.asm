; Tauha Imran 22i-1239 - G COAL lab  - lab# 14
Include irvine32.inc
Include macros.inc

;.Q1, all done, works completely fine for all use cases
;.Q2, all done, works completely fine for all use cases
;.Q3, all done, works completely fine for all use cases

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
 
;//make data variables here...

student STRUCT
id db 255 dup(?)
namex db 255 dup(?)
age db 0
grade db 0
student ends

stdx student <>

askid    db "q1.1) enter student id :",0
askname  db "q1.2) enter student name:",0
askgrade db "q1.2) enter student grade:",0
askage  db "q1.2) enter student age:",0

q2pmt    db "q2) enter num (1-255) :",0
number db 0

q3pmt    db "q3) 1-100 values:",10,0
fizz db "Fizz",0
buzz db "Buzz",0
.code

main proc

;main proc calls and simulatations...

call q1
call Crlf
call Crlf

call q2

call Crlf
call Crlf

call q3

call Crlf
call Crlf

invoke ExitProcess, 0
main endp

;make functions/proc implementations here...
q1 proc
 
mov eax,0
mov edx, offset askid
mov ecx,255
call WriteString
mov eax,0
mov edx, offset stdx.namex
mov ecx,255
call ReadString

mov eax,0
mov edx, offset askname
mov ecx,255
call WriteString
mov edx, offset stdx.namex
call ReadString

mov eax,0
mov edx, offset askage
mov ecx,255
call WriteString
mov eax,0
call Readint
mov stdx.age , al

mov eax,0
mov edx, offset askgrade
mov ecx,255
call WriteString
mov edx, offset stdx.grade
call ReadString


mov eax,0
mov edx, offset askid
add edx,12
mov ecx,255
call WriteString
mov eax,0
mov edx, offset stdx.namex
mov ecx,255
call WriteString
	call Crlf
mov eax,0
mov edx, offset askname
add edx,12
mov ecx,255
call WriteString
mov edx, offset stdx.namex
call WriteString
	call Crlf
mov eax,0
mov edx, offset askage
add edx,12
mov ecx,255
call WriteString
mov eax,0
mov al,stdx.age
call WriteDec
	call Crlf
mov eax,0
mov edx, offset askgrade
add edx,12
mov ecx,255
call WriteString
mov edx, offset stdx.grade
call WriteString
	call Crlf
ret
q1 endp




q2 proc

mov edx,offset q2pmt
mov ecx,255
call WriteString
call ReadInt
mov number,al

mov ecx,0
mov cl,2
dec al
count = 2

    .while cl < number
	mov al,number
	mov bl,cl
	div bl
	cmp ah,0
	je notprime
	inc ecx
	mov eax,0
	mov ebx,0
    .endw

	jmp prime 

notprime:
mWrite "Number was not prime",0
jmp endq2

prime:
mWrite "Number was prime",0
jmp endq2

endq2:
ret
q2 endp


q3 proc


mov edx,offset q3pmt
mov ecx,255
call WriteString
mov number,0
mov number,101

mov ecx,0
mov cl,1
val1 = 0

    .while cl < number
	mov al,cl
	call WriteDec
	mov al, ','
	call WriteChar
	mov al,cl
	mov bl,3
	div bl
	

	.if ah == 0
        mov edx, OFFSET fizz
        call WriteString
	.endif

	mov eax,0
	mov ebx,0
	mov al,cl
	mov bl,5
	div bl
	
	
	.if ah == 0
        mov edx, OFFSET buzz
        call WriteString
	.endif

	inc ecx
	mov eax,0
	mov ebx,0
	call Crlf
	call Crlf
    .endw


ret
q3 endp

end main
