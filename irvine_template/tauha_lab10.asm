
; Tauha imran - 22i1239_ G _ coal lab task # 10
; -> Q#1 ) fully done...
; -> Q#2 ) fully done...
; -> Q#3 ) ... partially working...
; -> Q#4 ) fully done...
; -> Q#5 ) ... partially working...
; -> Q#7a ) ... not done...
; -> Q#7b ) ... partially working...
; -> Q#7a ) ... not done...
; -> Q#7c ) ... not done...

Include irvine32.inc

.386
.model flat, stdcall
.stack 4096

ExitProcess PROTO, dwExitCode:DWORD

.data

line db "- - - - - - - - - - - - - - ",0
q1 db "-- q#1 -- ",0
 q2 db "-- q#2 -- ",0
 q3 db "-- q#3 -- ",0
 q4 db "-- q#4 -- ",0
 q5 db "-- q#5 -- ",0
 q6 db "-- q#6 -- ",0
 q7a db "-- q#7a -- ",0
 q7b db "-- q#7b -- ",0

; ---Q1-data...
    prompt1 DB "Enter UpperCase Letter: ", 0
    result1 DB "LowerCase letter is: ", 0
    

; ---Q2-data...
    prompt2 DB "Enter # 1-9: ", 0
    result2 DB "Value at array{#}: ", 0


; ---Q3-data...
    prompt3 DB "Array Values : ", 0
    result3 DB "Sum of Values : ", 0
    sum db 5 dup(0)

; ---Q4-data...
    prompt4 DB "Enter Letter : ", 0
    result4 DB "previous letter : ", 0
    
; ---Q5-data...
    prompt5a DB "Enter number : ", 0
    prompt5b DB "Enter power : ", 0
    result5 DB "YOUR ANSWER : ", 0
    num word 0
    power word 0
    
; ---Q6-data...
    prompt6 DB "Enter # 1-9: ", 0
    result6 DB "Value at array{#}: ", 0
    
; ---Q7-data...
    prompt7 DB "Enter num: ", 0
   
;---all input values
input1 db 0  
letter DB 1 Dup (0)
   number DB 1 Dup (0)
  SUMq3 dw  ?
  result dw 0
   ary db 'A','B','C','D','E','F','G','H','I','J',0
   myStar DB "*", 0
   temp DD 0

.code

main proc

call Qs1
call Qs2
call Qs3
call Qs4
call Qs6
call Qs7b
call Qs5

invoke ExitProcess, 0

main endp

Qs1 proc
; ---Q1...
    mov edx, offset q1   ; mov string offset in edx
    call writestring    ; writestring will print content in edx
    call crlf

    mov edx, offset prompt1  
    call writestring  

    mov edx, offset letter
    mov ecx, 2
    call readstring

    ;converting into lowercase
    add letter,32

    mov edx, offset result1  
    call writestring  

    mov edx, offset letter 
    call writestring  

;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-
    call crlf
    mov edx, offset line 
    call writestring  
    call crlf
;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*

Qs1 endp

Qs2 proc
; ---Q2...
    mov edx, offset q2   ; mov string offset in edx
    call writestring    ; writestring will print content in edx
    call crlf

    mov edx, offset prompt2
    call writestring  

    mov edx, offset letter
    mov ecx, 2
    call readstring

    ;converting into unpacked dec.
    sub letter,30h

    mov edi, offset ary

    add edi, dword ptr letter
    
    mov al ,byte ptr [edi] 
    mov letter,al

    mov edx, offset result2 
    call writestring  

    mov edx, offset letter
    call writestring  

;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-
    call crlf
    mov edx, offset line 
    call writestring  
    call crlf
;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-

Qs2 endp

Qs3 proc
; ---Q3...
    mov edx, offset q3   ; mov string offset in edx
    call writestring    ; writestring will print content in edx
    call crlf

    mov ecx,0
    mov cx,5
    mov bx,cx
    mov edi,offset sum

    loop3 :
        mov bx,cx
            mov edx, offset prompt3
            call writestring  

            mov edx, offset letter
            mov ecx, 2
            call readint

        ;stroign in sum
        mov al, letter ;store number
        mov [edi] ,ax
        inc edi
        mov eax,0

    mov cx,bx

    LOOP loop3


    mov edx, offset result3  
    call writestring  

    mov ecx,0
    mov ecx,4
    mov eax,0
    mov ebx,0
    
    mov edi, offset sum
    mov al, [edi]
    inc edi
    
    sum3:
        
        mov bl,[edi]
        add al,bl   
    LOOP sum3

    OR ax,30h
    mov SUMq3, ax

    mov edx, offset SUM
    call writestring  


;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-
    call crlf
    mov edx, offset line 
    call writestring  
    call crlf 
;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-
Qs3 endp

Qs4 proc
; ---Q4...
    mov edx, offset q4   ; mov string offset in edx
    call writestring    ; writestring will print content in edx
    call crlf

    mov edx, offset prompt4  
    call writestring  

    mov edx, offset letter
    mov ecx, 2
    call readstring

    ;making prev char
    dec letter

    mov edx, offset result4  
    call writestring  

    mov edx, offset letter 
    call writestring  


;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-
    call crlf
    mov edx, offset line 
    call writestring  
    call crlf 
;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-

Qs4 endp


Qs6 proc
    
    mov edx, offset q6   ; mov string offset in edx
    call writestring    ; writestring will print content in edx
    call crlf

    mov edx, offset prompt6
    call writestring  

    mov edx, offset input1
    mov ecx, 2
    call readstring

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

    mov edx, offset result6
    call writestring  

    mov edx, offset input1
    call writestring  

;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-
    call crlf
    mov edx, offset line 
    call writestring  
    call crlf 
;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-

Qs6 endp

Qs7b proc


     mov edx, offset q7b   ; mov string offset in edx
    call writestring    ; writestring will print content in edx
    call crlf

    mov edx, offset prompt7  
    call writestring  

    mov edx, offset number
    mov ecx, 2
    call readint

    
    mov cx, word ptr number
    mov temp ,ecx

    mov edx, offset myStar

    outerLoop:
        mov temp, ecx
        innerLoop:
            call writestring
            loop innerLoop
            mov ecx, temp
            call crlf
        loop outerLoop

;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-
    call crlf
    mov edx, offset line 
    call writestring  
    call crlf 
;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-

Qs7b endp

Qs5 proc
; ---Q4...
    mov edx, offset q5   ; mov string offset in edx
    call writestring    ; writestring will print content in edx
    call crlf

    mov edx, offset prompt5a  
    call writestring  

    ;getting inputs

    mov edx, offset num
    mov ecx, 2
    call readint
    
    
    mov edx, offset power
    mov ecx, 2
    call readint


    mov ecx,0
    mov ebx,0
    mov cx,power
    mov result,0
    mov eax,0
    mov ax,num
    
    outer5:
    mov bx,cx
    mov ecx,0
    mov cx,num
        inner5:
            add ax,num
            loop inner5
    mov cx,bx
    loop outer5
         
    
    OR ax, 3030h
    mov result,ax

    mov edx, offset result5 
    call writestring  

    mov edx, offset result
    call writestring  


;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-
    call crlf
    mov edx, offset line 
    call writestring  
    call crlf 
;-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-

Qs5 endp

end main

