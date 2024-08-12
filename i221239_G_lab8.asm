.386
.model flat, stdcall
.stack 4096
;--i221239G lab 8 ---

ExitProcess PROTO, dwExitCode:DWORD

.data
;Q1-data
    task1 db 0
;Q2-data
    task2 db 0
;Q4-data
    task4 db 0
.code

main PROC
mov edi,offset task1
mov eax,0
mov ebx,0 

;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;Q -- 1. 
mov ax, 65535
    
    question1:
        shr ax,1
        inc task1
    cmp ax,0
    jnz question1
    ;task1 holds count of iterations

;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;Q -- 2. 
mov eax,0
mov ax, 1
    
    question2:
        shl ax,1
        inc task2
    cmp ax,65535
        jge question2
    ;task2 holds count of iterations
    

    
;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;Q -- 3.
;using imul and storing stuff in ax
 ; here we have existing value in al which in turn gets
    ; ax = al* immediatValue --> via 'imul' instruction

    ;a. -21 * 64
    mov eax,0
    mov al,64
    imul ax,-21 ; ans = 64192 or -1344 , ax = 0540h , NO OVERFLOW
    imul ax,-1 ;reverses the 2's compliment to see answer i n all +ve

    ;b. -4 * 52
    mov eax,0
    mov ax,-4
    imul ax,52 ; ans = 65532 or -208 ,ax = FF30 , ax = FF30, NO OVERFLOW
    imul ax,-1 ;reverses the 2's compliment to see answer i n all +ve

    ;c. -7796 * 2352
    mov eax,0
    mov eax,2352
    imul ax, -7796; ans = -51648 or 13888 , eax = 00003640 , NO OVERFLOW
    imul ax,-1 ;reverses the 2's compliment to see answer i n all +ve

    ;d. -2254 * -121S1 -- taking svalue w/out the 'S' in 121S1
    mov eax,0
    mov eax,2254
    imul ax,1211 ; ans = 42,618  or -22918 . ax = A67A , NO OVERFLOW
    imul ax,-1 ;reverses the 2's compliment to see answer i n all +ve

;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;Q -- 4.
;using idiv and storing stuff in ax

    ;a. -13 / 3
        MOV task4, -13
        mov al,task4 ; lower half of dividend
        cbw ; extend AL into AH , AX = FFF3
        mov bl,+3 ; divisor
        idiv bl ; AL(solution) = -4, AH(remainder) = 1
        ;to see real un-complimented values
        imul ax,-1

    ;b. -36 / 2
        MOV task4, -36
        mov al,task4 ; lower half of dividend
        cbw ; extend AL into AH , AX = FFDC
        mov bl,+2 ; divisor
        idiv bl ; AL(solution) = -18, AH(remainder) = 0
        ;to see real un-complimented values
        imul ax,-1

    ;c. 107 / -2
         MOV task4, -107
        mov al,task4 ; lower half of dividend
        cbw ; extend AL into AH , AX = FF95
        mov bl,+2 ; divisor
        idiv bl ; AL(solution) = -53, AH(remainder) = 1
        ;to see real un-complimented values
        imul ax,-1

    ;d. 134 / -14
         MOV task4, 134
        mov al,task4 ; lower half of dividend
        cbw ; extend AL into AH , AX = FF86
        mov bl,-14 ; divisor
        idiv bl ; AL(solution) = -8, AH(remainder) = 9
        ;to see real un-complimented values
        imul ax,-1

;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;Q5- ror and rol ops

;pt-a
mov eax,0
    mov ax, 100010001b
    rol ax,1
        ;11001000 , carry =1 , rotates left , carry added
    mov ax, 100010001b
    ror ax ,1
        ;00100011 , carry =1 , rotates right , carry added
;pt-b
mov eax,0
    mov ax, 00011000b
    rol ax,1
        ;00110000 , carry =0 , rotates left , no carry added
    mov ax, 00011000b
    ror ax,1
        ;00001100 , carry =0 , rotates right , no carry added

;pt-c
mov eax,0
    mov al, 11111011b
    rol al ,1
        ;11110111 , carry =1 , rotates left , carry added
    mov al, 11111011b
    ror al ,1
        ;11111101 , carry =1 , rotates right , carry added

;pt-d
mov eax,0
    mov al, 00000010b
    rol al ,1
        ;00000100 , carry =0 , rotates left , no carry added
    mov al, 00000010b
    ror al ,1
        ;00000001 , carry =0 , rotates right , no carry added

;pt-e
mov eax,0
    mov al, 10101010b
    rol al ,1
        ;01010101 , carry =1 , rotates left , carry added
    mov al, 10101010b
    ror al ,1
        ;01010101 , carry =0 , rotates right , no carry added

;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;Q6- sar and sal ops

;pt-a
mov eax,0
    mov al, 10101011b
    sal al,1
        ; 01010111  , carry = 1 , shifts Arithmetic left , carry added
    mov al, 10101011b
    sar al ,1
        ;11010101 , carry =1 , shifts Arithmetic right , carry added
;pt-b
mov eax,0
    mov al, 00110011b
    sal al,1
        ;01100110 , carry =0 , shifts Arithmetic left , no carry added
    mov al, 00110011b
    sar al,1
        ;10011001 , carry =1 , shifts Arithmetic right , carry added

;pt-c
mov eax,0
    mov al, 10001000b
    sal al ,1
        ;00010001 , carry = 1  , shifts Arithmetic left , carry added
    mov al, 10001000b
    sar al ,1
        ;01000100 , carry = 0 , shifts Arithmetic right , no carry added

;pt-d
mov eax,0
    mov al, 11110000b
    sal al ,1
        ;11100001 , carry =1 , shifts Arithmetic left ,  carry added
    mov al, 11110000b
    sar al ,1
        ;01111000 , carry =0 , shifts Arithmetic right , no carry added

;pt-e
mov eax,0
    mov al, 00101101b
    sal al,1
        ;01011010 , carry =0 , shifts Arithmetic left ,no carry added
    mov al, 00101101b
    sar al ,1
        ;10010110 , carry =1 , shifts Arithmetic right , carry added


;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
;Q7- rcr and rcl ops

;pt-a
mov eax,0
clc
    mov ax, 01111110b
    rcl ax,1
        ; 0 11111100 , carry = 0 -> 0 , rotates left w/ carry
    mov ax, 01111110b
clc
    rcr ax ,1
        ; 0 00111111 , carry = 0 -> 0 , rotates right w/ carry

;pt-b
mov eax,0
clc
    mov ax, 11101011b
    rcl ax,1
        ; 1 11010110 , carry = 0->1 , rotates left w/ carry
clc
   mov ax, 11101011b
    rcr ax,1
        ; 1 01101011  , carry = 0->1 , rotates right w/ carry

;pt-c
mov eax,0
clc
    mov al, 10100000b
    rcl al ,1
        ;  1 01000000 , carry =0->1 , rotates left w/ carry
clc
    mov al, 10100000b
    rcr al ,1
        ; 0 01010000 , carry =0->0 , rotates right w/ carry

;pt-d
mov eax,0
clc
    mov al, 00100011b
    rcl al ,1
        ;  0 001000110 , carry = 0->0 , rotates left w/ carry
clc
    mov al, 00100011b
    rcr al ,1
        ; 1 00100011 , carry = 0->1 , rotates right w/ carry

;pt-e
mov eax,0
clc
    mov ax, 111101111b
    rcl ax ,1
        ; 1 111011110 , carry = 0->1 , rotates left w/ carry
clc
   mov ax, 111101111b
    rcr ax ,1
        ; 1 011110111  , carry = 0->1 , rotates right w/ carry

;*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

;----end of tasks----
invoke ExitProcess, 0
main ENDP
END main