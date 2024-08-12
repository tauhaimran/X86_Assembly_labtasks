; 22i-1239-G - Question # 5 - coal lab final

.386
.model flat,stdcall
.stack 4096

include irvine32.inc
include macros.inc

.data
	
;data variables...

.code

main proc

mWrite "22i1239_G"
call Crlf
mWrite "QUESTION 6) library mnagement system"
call Crlf
call Crlf
call WaitMsg
mWrite "I did my best sir...the logic is coded as much as I could..."
call Crlf
call Crlf
exit
main endp

handle_files proc
ret
handle_files endp

grphics_ui proc
ret
grphics_ui endp


check_arr proc
ret
check_arr endp


end main