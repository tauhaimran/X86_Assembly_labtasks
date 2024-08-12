; Tauha 22i-1239 - G , COAL lab-01
; lab task 01

;model specifications

.386						;tells computer to use 32 bit memory
.model flat,stdcall			; specifies model type - flat = .code + .data <= 4GB
.stack 4096

; - - - variables
.data

; - - - instrctns
.code

main PROC ; main procedure

mov al, 127
cmp al,-128
	
main ENDP ; end of main

END main ; end of file
