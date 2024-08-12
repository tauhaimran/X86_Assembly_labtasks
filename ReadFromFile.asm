INCLUDE Irvine32.inc
INCLUDE macros.inc
.386
.model flat,stdcall
.stack 4096
BUFFER_SIZE = 5000
.data
	buffer BYTE BUFFER_SIZE DUP(?)
	filename BYTE 80 DUP(0)
	fileHandle HANDLE ?
.code
main PROC
	; Let user input a filename.
	mWrite "Enter an input filename: "
	mov edx, OFFSET filename
	mov ecx, SIZEOF filename
	call ReadString
	
	; Open the file for input.
	mov edx,OFFSET filename
	call OpenInputFile
	mov fileHandle, eax
	
	cmp eax, INVALID_HANDLE_VALUE ; error opening file?
	jne letsOpenFile 
	
	mWrite "Cannot open file"	; prompt that we cannot open file
	jmp quit	; and quit
	
	
	letsOpenFile:
		mov edx, OFFSET buffer	; Read the file into a buffer.
		mov ecx, BUFFER_SIZE
		call ReadFromFile
		jnc check_buffer_size
	
	mWrite "Error reading file. " ;	error reading?
	call WriteWindowsMsg	 ;	yes: show error message
	jmp close_file
	
	check_buffer_size:
		cmp eax,BUFFER_SIZE
		jb buf_size_ok	; buffer large enough?
		mWrite <"Error: Buffer too small for the file",0dh,0ah>	; yes
		jmp quit	 ; and quit
	
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
		mov eax,fileHandle
		call CloseFile
	
	quit:
	exit
main ENDP
END main