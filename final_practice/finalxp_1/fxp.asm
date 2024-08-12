;//include libraries here...

.386
.model flat,stdcall 
.stack 4096

;Windows API function prototypes
GetStdHandle PROTO , nStdHandle: DWORD ; -10 -> input , -11 -> output

ReadConsoleA PROTO , hConsoleInput:DWORD , lpBuffer:PTR BYTE , nNumberofCharsToRead:DWORD , lpNumberofCharsRead:PTR DWORD , lpReserved:DWORD

WriteConsoleA PROTO , hConsoleInput:DWORD , lpBuffer:PTR BYTE , nNumberofCharsToWrite:DWORD , lpNumberofCharsWritten:PTR DWORD , lpReserved:DWORD

ExitProcess PROTO , dwExitCode: DWORD

.data
	;>> initialize variables here...
	inputbuffer  db     255 dup(?)
	outputbuffer db     255 dup(?)
	bytesRead    dword ?
	bytesWritten dword ?
	prompt       db    "write stuff please ->  : " ,0
	xlabel       db    "the stuff you wrote->  : " ,0
	newline db 10,">>",10,10,0
	;lab6&7 variables

.code	
	;>> set values and call proc.s here...
main proc 
call egx
	call WIN_write_console
	call WIN_read_console
	call WIN_write_input
call WIN_new_line

call egx
	call WIN_write_console
	call WIN_read_console
	call WIN_write_input
call WIN_new_line

invoke ExitProcess , 0

main endp
	;>> ...define proc.s here...
egx proc
 mov eax,0
 mov ebx,0
 mov ecx,0
 mov edx,0
ret 
egx endp

;//--input_from_user...
WIN_read_console proc

	;get standard input handle (keyboard)
	invoke GetStdHandle , -10 ;passing constant
	mov edi , eax ;store the handle in edi

	;write input from the user
	invoke ReadConsoleA , edi , ADDR inputBuffer , lengthof inputBuffer , ADDR bytesRead ,0

ret
WIN_read_console endp





;//--display_on_screen...
WIN_write_console proc

	;get standard output handle (keyboard)
	invoke GetStdHandle , -11 ;passing constant
	mov esi , eax ;store the handle in esi

	;Read input from the user
	invoke WriteConsoleA , esi , ADDR prompt , lengthof prompt-1 , ADDR bytesWritten ,0


ret
WIN_write_console endp

;//--display_prev_input_on_screen...
WIN_write_input proc

	;get standard output handle (keyboard)
	invoke GetStdHandle , -11 ;passing constant
	mov esi , eax ;store the handle in esi

	;Read input from the user
	invoke WriteConsoleA , esi , ADDR xlabel , lengthof xlabel-1 , ADDR bytesWritten ,0
	invoke WriteConsoleA , esi , ADDR inputbuffer , lengthof inputBuffer , ADDR bytesWritten ,0


ret
WIN_write_input endp

;//--new_line_on_screen...
WIN_new_line proc

	;get standard output handle (keyboard)
	invoke GetStdHandle , -11 ;passing constant
	mov esi , eax ;store the handle in esi

	;Read input from the user
	invoke WriteConsoleA , esi , ADDR newline , lengthof newline-1 , ADDR bytesWritten ,0

ret
WIN_new_line endp

;............................................................................................
;............................................................................................
	;>> it ends here...
end main

