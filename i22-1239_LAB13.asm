; Tauha Imran - 22i1239_G - lab13 
Include irvine32.inc
Include macros.inc
;Q1, all done, works completely fine for all use cases
;Q2, partially done,coded , values not showing
;Q3, partially done,coded , values not accurate

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD


BUFFER_SIZE = 9999999

.data
 
;//make data variables here...
filename BYTE "output.txt", 0
	query1   db " Hello my name is Tauha Imran. My hometown is Islambad. My roll number is 22i1239. I love assembly language and I don’t mind repeating it.",0
	input    db 255 dup(0) ;user input...
    str1 db 10,"FILE HANDLING ERROR",10,0
    q1s db 10,"Q1) Input a FILENAME.txt : ",0
    fileHandle HANDLE ?
    buffer BYTE BUFFER_SIZE DUP(?)

    query2 db "Q2) Reading Input to Show data...",10,"number of vowels :",0
    query2a db 10,"number of consonants:",0
    query2b db 10,"number of words:",0

    vowel db 0
    consonants db 0
    words db 0
    name db 25 dup(0)
    town db 25 dup(0)
    rollno db 25 dup(0)

    query3a db "Q3) Enter a number (word):",0
    query3b db "factorial:",0

    num word 0
.code

main proc

;main proc calls and simulatations...
call Q2
call crlf
call Q1
call crlf
call Q3

invoke ExitProcess, 0
main endp

;make functions/proc implementations here...

Q1 proc

    mov edx , offset q1s
    call WriteString

    mov edx, offset filename
    mov ecx,255
    call ReadString

    ; Create a new text file.
    mov edx,OFFSET filename
    call CreateOutputFile
    
    mov fileHandle, eax
   
    cmp eax, INVALID_HANDLE_VALUE   ;Check for errors.
    jne letsWriteToFile ; if error not found
   
  
    mov edx,OFFSET str1 ; display error
    ; display error
    call WriteString
    jmp quit1
    
    letsWriteToFile:

    mov eax, fileHandle
    mov edx, OFFSET query1
    mov ecx, sizeof query1
    call WriteToFile

quit1:
ret
Q1 endp

;//-------------------------------------


Q2 proc

; Let user input a filename.
	mWrite "Enter an input filename (output.txt): "
	mov edx, OFFSET filename
	mov ecx, SIZEOF filename
	call ReadString

   ; Open the file for input
	mov edx,OFFSET filename
	call OpenInputFile
	mov fileHandle, eax
	
	cmp eax, INVALID_HANDLE_VALUE ; error opening file?
	jne letsOpenFile 
	
	mWrite "Cannot open file"	; prompt that we cannot open file
	jmp quit2	; and quit
	
	
	letsOpenFile:
		mov edx, OFFSET buffer	; Read the file into a buffer.
		mov ecx, BUFFER_SIZE
		call ReadFromFile
		jnc check_buffer_size

          mov esi,edx
    mov edi,edx

    countingStuff:
        mov bl,[esi]

        cmp bl,' '
        je space
      
            cmp bl,'a'
            je vowels
            cmp bl,'e'
            je vowels
            cmp bl,'i'
            je vowels
            cmp bl,'o'
            je vowels
            cmp bl,'u'
            je vowels

            cmp bl,'A'
            je vowels
            cmp bl,'I'
            je vowels
            cmp bl,'I'
            je vowels
            cmp bl,'O'
            je vowels
            cmp bl,'U'
            je vowels

                cmp bl,'.'
                je nothing

                inc consonants
                jmp nothing

     vowels:
        inc vowel
        jmp nothing

     space:
        inc words
        jmp nothing

    nothing:
    mov al,bl
    call WriteChar
    inc esi
    LOOP countingStuff
	
    mov ecx,0
    mov cx,11
    mov esi , offset buffer
    add esi,17
    mWrite "name from file: "
    names:
    mov al,byte ptr [esi]
    call WriteChar
    inc esi
    LOOP names
    mWrite "name city from file: "
    mov cx,8
    mov esi , offset buffer
    add esi,46
    call Crlf
    city:
    mov al,byte ptr [esi]
    call WriteChar
    inc esi
    LOOP city
    call Crlf
    mWrite "Roll No.from file: "
    add esi,21
    mov cx,9
    rn:
    mov al,byte ptr [esi]
    call WriteChar
    inc esi
    LOOP rn

    jmp close_file

	mWrite "Error reading file. " ;	error reading?
	call WriteWindowsMsg	 ;	yes: show error message
	jmp close_file
	
	check_buffer_size:
		cmp eax,BUFFER_SIZE
		jb buf_size_ok	; buffer large enough?
		mWrite <"Error: Buffer too small for the file",0dh,0ah>	; yes
		jmp quit2	 ; and quit
	
	buf_size_ok:
		mov buffer[eax],0	; insert null terminator
		mWrite "File size: "
		call WriteDec	; display file size
		call Crlf
	
	; Display the buffer.
	mWrite <"Buffer:",0dh,0ah,0dh,0ah>
	mov edx,OFFSET buffer
	; display the buffer
	call WriteString
	call Crlf
	

	close_file:
    	mov edx, offset query2
    call WriteString
    mov eax,0
    mov al,vowel
    call WriteDec
        mov edx, offset query2a
        call WriteString
        mov eax,0
        mov al,consonants
        call WriteDec
            mov edx, offset query2b
            call WriteString
            mov eax,0
            inc words
            mov al,words
            call WriteDec

		mov eax,fileHandle
		call CloseFile

quit2:
ret
Q2 endp

;//-------------------------------------

Q3 proc

mov edx, offset query3a
call WriteString
mov eax,0
call Readint
mov num,ax
mov ecx,0
mov cx,ax
mov eax,0
mov ax,1

call factorial

mov edx, offset query3b
call WriteString
call WriteDec
ret
Q3 endp

factorial proc
cmp ax,0
jne continue
inc ax
push ax
    jmp backrun

    continue:
        push ax
        dec ax
        call factorial

backrun:
pop bx
imul ax,bx
ret
factorial endp

end main
