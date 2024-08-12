; Tauha Imran - 22i1239 - G _ lab02

.386
.model flat,stdcall
.stack 4096

ExitProcess  PROTO, dExitCode:DWORD

.data
	
.code

main PROC


;--- Q1 ---	
	mov ax,4	;ax = 4
	mov bx,5	;bx = 5
	add ax,bx	;ax+bx

	mov ax,6		;ax = 6
	mov bx,9		;bx = 9
	add ax,bx	;ax+bx

	mov ax,149		;ax = 149
	mov bx,200		;bx = 200
	add ax,bx	;ax+bx

	mov ax,302		;ax = 302
	mov bx,150		;bx = 150
	add ax,bx	;ax+bx

	mov ax,3050		;ax = 3050
	mov bx,4150		;bx = 4150
	add ax,bx	;ax+bx
	

;--- Q2 ---	

	mov ax,34		;ax = 34
	mov bx,16		;bx = 16
	sub ax,bx	;ax-bx

	mov ax,40		;ax = 40
	mov bx,29		;bx = 29
	sub ax,bx	;ax-bx

	mov ax,50		;ax = 50
	mov bx,30		;bx = 30
	sub ax,bx	;ax-bx

	mov ax,84		;ax = 84
	mov bx,44		;bx = 44
	sub ax,bx	;ax-bx

	mov ax,891		;ax = 891
	mov bx,200		;bx = 200
	sub ax,bx	;ax-bx

;--- Q3.1 ---	
	mov ax,100		;ax = 100
	mov bx,50		;bx = 50
	mov cx,40		;cx = 40
	add ax,cx		;cx+ax
	sub cx,bx		;cx-bx +ax

;--- Q3.2 ---	
	mov ax,80		;ax = 80
	mov bx,45		;bx = 45
	mov cx,25		;cx = 25
	sub bx,cx		;bx-cx
	add ax,bx		;ax+bx-cx
	
;--- 4.1 ---	
	mov ax,10		;ax = 10
	mov bx,20		;bx = 20
	mov cx,140		;cx = 140
	sub cx,ax		;cx-bx
	sub cx,ax		;cx-bx-ax
	mov dx,cx	;for outputs

;--- Q4.2 ---	
	mov ax,80		;ax = 80
	mov bx,45		;bx = 45
	mov cx,25		;cx = 25
	add bx,cx		;-bx-cx
	sub ax,bx		;ax-bx-cx
	mov dx,cx	;for outputs

;--- Q5.1 ---	
	mov ax,100		;ax = 100
	mov bx,50		;bx = 50
		add ax,100
		add ax,100
		add ax,100
		add ax,100
			add bx,50
			add bx,50
	add ax,bx		;5*ax+3*bx

;--- Q5.2 ---	
	mov ax,80		;ax = 80
	mov bx,45		;bx = 45
		add ax,80
		add ax,80
		add ax,80
			add bx,45
	add ax,bx		;4*ax+2*bx	

;--- Q6.1 ---	
	mov cx,140		;cx = 140
	mov bx,40		;bx = 40
		add cx,140
		add cx,140
		add cx,140
			add bx,40

	sub cx,bx		;3*cx-2*bx

;--- Q6.2 ---	
	mov cx,25		;cx = 25
	mov bx,45		;bx = 40
		add bx,45
	add cx,bx		;cx-2*bx

;--- Q7.1 ---	
	mov ax,125		;ax = 125
	mov bx,45		;bx = 40
	mov cx,40		;cx =40
		add ax,125
		add ax,125
		add ax,125
		add ax,125
			add bx,45
			add bx,45
			add bx,45
	add ax,bx
	sub ax,cx		;5*ax+4*bx-cx

;--- Q7.1 ---	

	mov ax,150		;ax = 150
	mov bx,155		;bx = 155
	mov cx,45		;cx =45
		add ax,150
		add ax,150
		add ax,150
			add bx,155
				add cx,45
				add cx,45
	add ax,bx
	add ax,cx		;4*ax+2*bx+3*cx

INVOKE ExitProcess,0

main endp
END main