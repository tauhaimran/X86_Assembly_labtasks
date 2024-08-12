;--Tauha Imran - 22i1239 - coal lab G - lab9 
.386

.model flat,stdcall
.stack 4096
; Windows API function prototypes
GetStdHandle PROTO, nStdHandle:DWORD
ReadConsoleA PROTO, hConsoleInput:DWORD, lpBuffer:PTR BYTE, nNumberOfCharsToRead:DWORD, lpNumberOfCharsRead:PTR DWORD, lpReserved:DWORD
WriteConsoleA PROTO, hConsoleOutput:DWORD, lpBuffer:PTR BYTE, nNumberOfCharsToWrite:DWORD, lpNumberOfCharsWritten:PTR DWORD, lpReserved:DWORD
ExitProcess PROTO, dwExitCode:DWORD
ExitProcess PROTO, dwExitCode:DWORD
.data

; -10 input , -11 output

line db " - - - - - - - - - -  " ,0
newline db 10
prompt DB "Enter A single character: ", 0
    
    prompt1 DB "Q#1 input (enter any character) : ",0
    prompt14 DB "Q#4 input (enter any character) : ",0
    prompt2 DB "Q#2 input (enter uppercase character) : ",0
    prompt3 DB "Q#3 input (enter in 0-9) : ",0
    prompt16 DB "Q#6 input (your marks ;) : ",0

    prompt5a db "Q#5 input - first name : " , 0
    in5a db  25 Dup(0)
    prompt5b db "Q#5 input - second name : " , 0
    in5b db 25 Dup(0)
    prompt5c db " output - full name : ", 0
    in5 db " " ,0
    output5 db 25 Dup(0)

    prompt4 DB "previous character : ",0
    
    prompt6 DB "Your Grade : ",0

    prompt7a db "Q#7 - a : ",0
    prompt7b db "Q#7 - b : ",0
    prompt7 db "*****"

    finalPrompt DB "Your Entered: ", 0
    bytesRead DW ?
    bytesWritten DW ?
    nameInput DB 255 Dup(0)
    input1 db 0
    Q3 db '9','8','7','6','5','4','3','2','1','?'



.code

main proc
	
	mov al,'1'
	add al,'2'
	aaa
	OR al , 00110000b
	

 ;---Q#1
 invoke GetStdHandle, -11 ; out mssg
    mov esi, eax
     invoke WriteConsoleA, esi, ADDR prompt1, lengthof prompt1-1, ADDR bytesWritten, 0
invoke GetStdHandle, -10 ;input
    mov esi, eax
     invoke ReadConsoleA, esi, ADDR input1, lengthof nameInput, ADDR bytesRead, 0
invoke GetStdHandle, -11
    mov esi, eax
        invoke WriteConsoleA, esi, ADDR finalPrompt, lengthof finalPrompt-1, ADDR bytesWritten, 0
        invoke WriteConsoleA, esi, ADDR input1, lengthof input1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR line, lengthof line-1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0

;---Q#2

invoke GetStdHandle, -11 ; out mssg
    mov esi, eax
     invoke WriteConsoleA, esi, ADDR prompt2, lengthof prompt2-1, ADDR bytesWritten, 0
invoke GetStdHandle, -10 ;input
    mov esi, eax
     invoke ReadConsoleA, esi, ADDR input1, lengthof nameInput, ADDR bytesRead, 0
invoke GetStdHandle, -11 ; answer showing
    mov esi, eax
        invoke WriteConsoleA, esi, ADDR finalPrompt, lengthof finalPrompt-1, ADDR bytesWritten, 0
        ADD input1, 32
        invoke WriteConsoleA, esi, ADDR input1, lengthof input1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR line, lengthof line-1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
 
;---Q#3
invoke GetStdHandle, -11 ; out mssg
    mov esi, eax
     invoke WriteConsoleA, esi, ADDR prompt3, lengthof prompt3-1, ADDR bytesWritten, 0
invoke GetStdHandle, -10 ;input
    mov esi, eax
     invoke ReadConsoleA, esi, ADDR input1, lengthof nameInput, ADDR bytesRead, 0
invoke GetStdHandle, -11 ; answer showing
    mov esi, eax
        invoke WriteConsoleA, esi, ADDR finalPrompt, lengthof finalPrompt-1, ADDR bytesWritten, 0
        ;operations
        sub input1,030h
        mov ecx,0
        mov cl, input1
        mov edi, offset Q3
            getval:
                inc edi
                LOOP getval
        mov bl,0
        mov bl,[edi]
        mov input1,bl
        invoke WriteConsoleA, esi, ADDR input1, lengthof input1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR line, lengthof line-1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0

;---Q#4
invoke GetStdHandle, -11 ; out mssg
    mov esi, eax
     invoke WriteConsoleA, esi, ADDR prompt14, lengthof prompt14-1, ADDR bytesWritten, 0
invoke GetStdHandle, -10 ;input
    mov esi, eax
     invoke ReadConsoleA, esi, ADDR input1, lengthof nameInput, ADDR bytesRead, 0
invoke GetStdHandle, -11 ; answer showing
    mov esi, eax
        invoke WriteConsoleA, esi, ADDR prompt4, lengthof prompt4-1, ADDR bytesWritten, 0
        ;operations
        sub input1,1
        invoke WriteConsoleA, esi, ADDR input1, lengthof input1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR line, lengthof line-1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0


;---Q#5
invoke GetStdHandle, -11 ; out mssg1
    mov esi, eax
     invoke WriteConsoleA, esi, ADDR prompt5a, lengthof prompt5a-1, ADDR bytesWritten, 0
invoke GetStdHandle, -10 ;input1
    mov esi, eax
     invoke ReadConsoleA, esi, ADDR in5a, lengthof in5a, ADDR bytesRead, 0
invoke GetStdHandle, -11 ; out mssg2
    mov esi, eax
     invoke WriteConsoleA, esi, ADDR prompt5b, lengthof prompt5b-1, ADDR bytesWritten, 0
invoke GetStdHandle, -10 ;input2
    mov esi, eax
     invoke ReadConsoleA, esi, ADDR in5b, lengthof in5b, ADDR bytesRead, 0
     

invoke GetStdHandle, -11 ; answer showing
    mov esi, eax
    invoke WriteConsoleA, esi, ADDR prompt5c, lengthof prompt5c-1, ADDR bytesWritten, 0
        invoke WriteConsoleA, esi, ADDR in5a, lengthof in5a-1, ADDR bytesWritten, 0
        ;invoke WriteConsoleA, esi, ADDR in5, lengthof in5-1, ADDR bytesWritten, 0
        invoke WriteConsoleA, esi, ADDR in5b, lengthof in5b-1, ADDR bytesWritten, 0
    
        
            

invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR line, lengthof line-1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0


;---Q6
invoke GetStdHandle, -11 ; out mssg
    mov esi, eax
     invoke WriteConsoleA, esi, ADDR prompt16, lengthof prompt16-1, ADDR bytesWritten, 0
invoke GetStdHandle, -10 ;input
    mov esi, eax
     invoke ReadConsoleA, esi, ADDR input1, lengthof nameInput, ADDR bytesRead, 0
invoke GetStdHandle, -11 ; answer showing
    mov esi, eax
        invoke WriteConsoleA, esi, ADDR prompt6, lengthof prompt6-1, ADDR bytesWritten, 0
        ;operations
        
        cmp input1, '5'
            jl Dgrade
            jge CBgrades
        Dgrade:
            mov input1,'D'
         jmp q6end
             CBgrades:
                
                cmp input1,'7'
                jge Bgrade
                mov input1,'C'
         jmp q6end
                Bgrade:
                    cmp input1,'9'
                    je Agrade
                    mov input1,'B'
                    jmp q6end
                Agrade:        
                mov input1,'A'
            

q6end:
        invoke WriteConsoleA, esi, ADDR input1, lengthof input1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR line, lengthof line-1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0

;--- Q7a

 invoke GetStdHandle, -11 ; out mssg
    mov esi, eax
     invoke WriteConsoleA, esi, ADDR prompt7a, lengthof prompt7a-1, ADDR bytesWritten, 0 ;prompt
     invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
     invoke WriteConsoleA, esi, ADDR prompt7, lengthof prompt7, ADDR bytesWritten, 0;l1
     invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
     invoke WriteConsoleA, esi, ADDR prompt7, lengthof prompt7, ADDR bytesWritten, 0;l2
     invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
     invoke WriteConsoleA, esi, ADDR prompt7, lengthof prompt7, ADDR bytesWritten, 0;l3
     invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
     invoke WriteConsoleA, esi, ADDR prompt7, lengthof prompt7, ADDR bytesWritten, 0;l4
     invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0

     invoke WriteConsoleA, esi, ADDR line, lengthof line-1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0

;--- Q7b
 invoke GetStdHandle, -11 ; out mssg
    mov esi, eax
     invoke WriteConsoleA, esi, ADDR prompt7b, lengthof prompt7b-1, ADDR bytesWritten, 0 ;prompt
     invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
     invoke WriteConsoleA, esi, ADDR prompt7, lengthof prompt7-1, ADDR bytesWritten, 0;l1
     invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
     invoke WriteConsoleA, esi, ADDR prompt7, lengthof prompt7-2, ADDR bytesWritten, 0;l2
     invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
     invoke WriteConsoleA, esi, ADDR prompt7, lengthof prompt7-3, ADDR bytesWritten, 0;l3
     invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0
     invoke WriteConsoleA, esi, ADDR prompt7, lengthof prompt7-4, ADDR bytesWritten, 0;l4
     invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0

invoke WriteConsoleA, esi, ADDR line, lengthof line-1, ADDR bytesWritten, 0
invoke WriteConsoleA, esi, ADDR newline, lengthof newline, ADDR bytesWritten, 0

; Exit the program
Invoke ExitProcess,0
main endp

;--------------my finctuons
end main