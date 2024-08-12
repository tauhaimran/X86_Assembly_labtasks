
.386
.model flat,stdcall
.stack 4096

;exit main prog cmd
ExitProcess  PROTO, dExitCode:DWORD

.data

;6. values
	
	score1  WORD 10
	score2  WORD 5
	score3  WORD 15
	score4  WORD 10
	score   WORD 0
	average Db ?

;7. extra values
	;7. /6 AND *100 = SCORE RATE
	score_1 Db 10
	score_2 Db 5
	score_3 Db 15
	score_4 Db 10
	str_rate_1 WORD 0
	str_rate_2 WORD 0
	str_rate_3 WORD 0
	str_rate_4 WORD 0
	b1 Db 10
	b2 Db 10
	b3 Db 10
	b4 Db 10

;8. values
	;classroom_1_height_1-> classroom_1_height_5 
		classroom_1_height_1 Db 6
		classroom_1_height_2 Db 6
		classroom_1_height_3 Db 6
		classroom_1_height_4 Db 5
		classroom_1_height_5 Db 5

	;classroom_2_height_1->classroom_2_height_5
		classroom_2_height_1 Db 5
		classroom_2_height_2 Db 5
		classroom_2_height_3 Db 5
		classroom_2_height_4 Db 6
		classroom_2_height_5 Db 6

	;sumheight_1 and productheight_1 
		sumheight_1 Db 0
		productheight_1 Db 0
	;sumheight_2 and productheight_2 
		sumheight_2 Db 0
		productheight_2 Db 0


;9&10
	w11 Db 1
	w12 Db 1
	w13 Db 1
	w14 Db 1
	w15 Db 1
	
	w21 Db 2
	w22 Db 2
	w23 Db 2
	w24 Db 2
	w25 Db 2

	sumweight_1 Db 0
	productweight_1 Db 0

	sumweight_2 Db 0
	productweight_2 Db 0

;10 - variables
		avgweight_1 Db 0
		avgweight_2 Db 0



.code

main proc

	;1. Perform the division of 128 by 25,
		mov ax,128
		mov bl,25
		div bl

	;2. Perform the division of 138 by 14,
		mov ax,138
		mov bl,14
		div bl

	;3. Perform the division of 101000b by 111b
		mov ax,101000b
		mov bl,111b
		div bl

	;4. Perform the division of ABh by 14h,
		mov ax,0ABh
		mov bl,014h
		div bl

	;5. Perform the division of C8h by 21h,
		mov ax,0C8h
		mov bl,021h
		div bl

	;6. Declare 4 variables ... done in @.data
		mov ax,0 ; initialization
		mov bx,4 ; initialization
		;calculate the sum of all 4 scores 
			mov ax,score1
			add ax,score2
			add ax,score3
			add ax,score4
		;store it in a variable by the name of score
			mov score,ax
		;calculate the average 
			div bl
		;store it in a variable by the name of avg
			mov average,al


	;7. Declare 4 variables which store 
		;the values of scores of a batsman in 4 consecutive innings ;
			;the values of balls faced by the batsman in the respective innings;
				;strike rate in each respective innings,
					;save them in separate variables str_rate_1-4.
						;7. /6 AND *100 = SCORE RATE
		;str1
		mov al,score_1
		mov bl,100
		mul bl
		mov bl,b1
		div bl
		mov str_rate_1,ax
			;str2
			mov al,score_2
			mov bl,100
			mul bl
			mov bl,b2
			div bl
			mov str_rate_2,ax
				;str3
				mov al,score_3
				mov bl,100
				mul bl
				mov bl,b3
				div bl
				mov str_rate_3,ax
					;str4
					mov al,score_4
					mov bl,100
					mul bl
					mov bl,b4
					div bl
					mov str_rate_4,ax

	
	;8. Declare 10 variables...
		;compute the sum and product of all the values of the 5 different heights of students in classroom 1&2
				
				;sum.c1
				mov al,classroom_1_height_1
					add al,classroom_1_height_2
					add al,classroom_1_height_3
					add al,classroom_1_height_4
					add al,classroom_1_height_5
						mov sumheight_1,al
				;sum.c2
				mov al,classroom_2_height_1
					add al,classroom_2_height_2
					add al,classroom_2_height_3
					add al,classroom_2_height_4
					add al,classroom_2_height_5
						mov sumheight_2,al
			;prod.c1
			mov al,classroom_1_height_1
				mov bl,classroom_1_height_2
					mul bl
				mov bl,classroom_1_height_3
					mul bl
				mov bl,classroom_1_height_4
					mul bl
				mov bl,classroom_1_height_5
					mul bl
						mov productheight_1,al

			;prod.c2
			mov al,classroom_2_height_1
				mov bl,classroom_2_height_2
					mul bl
				mov bl,classroom_2_height_3
					mul bl
				mov bl,classroom_2_height_4
					mul bl
				mov bl,classroom_2_height_5
					mul bl
						mov productheight_2,al




		;9. Declare 10 variables
				;compute suma and product of wieghts

				
				;sum.w1
				mov al,classroom_1_height_1
					add al,w12
					add al,w13
					add al,w14
					add al,w15
						mov sumweight_1,al
				;sum.w2
				mov al,w21
					add al,w22
					add al,w23
					add al,w24
					add al,w25
						mov sumweight_2,al
			;prod.w1
			mov al,w11
				mov bl,w12
					mul bl
				mov bl,w13
					mul bl
				mov bl,w14
					mul bl
				mov bl,w15
					mul bl
						mov productweight_1,al

			;prod.w2
			mov al,w21
				mov bl,w22
					mul bl
				mov bl,w23
					mul bl
				mov bl,w24
					mul bl
				mov bl,w25
					mul bl
						mov productweight_2,al


		;10 - declare variables...
			;compute the average of all the values of the 5 different weights of students 
				
				mov bl,5

				;classroom 1, in avgweight_1 
					mov al,sumweight_1
					div bl
					mov avgweight_1,al

				;classroom 2, in avgweight_2.
					mov al,sumweight_2
					div bl
					mov avgweight_2,al


;exit main prog cmd called
INVOKE ExitProcess,0

main endp
end main