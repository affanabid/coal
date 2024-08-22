.model small
.stack 100h
.data
	str1 db 10, 13,"Enter the 1st Number(0 to 9):$"
	str2 db 10, 13,"Enter the 2nd Number(0 to 9):$"
	str3 db 10, 13,"Sorry you have entered a wrong character$"
	str4 db "Do you want to exit(y) or restart(n):$"
	
.code
main proc
	mov ax,@data
	mov ds,ax
	
bb:	mov dx, offset str1
	mov ah, 09
	int 21h
	
	mov ah, 01
	int 21h
	mov cl, al	

	mov dl, '9'
	cmp cl, dl
	ja aa
	
	mov dx, offset str2
	mov ah, 09
	int 21h

	;newline
	mov DL , 10 
	MOV AH , 02H
	INT 21H
	
	mov DL , 13
	MOV AH , 02H
	INT 21H

	mov ah, 01
	int 21h
	mov bl, al
	
	mov dl, '9'
	cmp bl, dl
	ja aa
	
	jmp cc
	
aa: 	
;newline
	mov DL , 10 
	MOV AH , 02H
	INT 21H
	
	mov DL , 13
	MOV AH , 02H
	INT 21H

	mov dx, offset str3
	mov ah, 09
	int 21h
	
	jmp bb

cc: 
	

	mov DL , 10 
	mov AH , 02H
	INT 21H
	
	mov DL , 13
	mov AH , 02H
	INT 21H
	 
	mov dl, cl
	mov ah, 02h
	int 21h
	
	inc cl


	mov DL , 10 
	MOV AH , 02H
	INT 21H
	
	mov DL , 13
	MOV AH , 02H
	INT 21H


	
	cmp cl, bl
	jb cc
	
;newline
	mov DL , 10 
	MOV AH , 02H
	INT 21H
	
	mov DL , 13
	MOV AH , 02H
	INT 21H
	
	mov dx, offset str4
	mov ah, 09h
	int 21h
	
	mov ah, 01h
	int 21h
	cmp al, 'n'
	je bb
	
mov ah, 4ch
int 21h
main endp
end main
