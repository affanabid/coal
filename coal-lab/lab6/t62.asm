.model small
.stack 100h
.386
.data
	prompt1 db 'Enter an odd number: $'
	prompt2 db 'Enter a three character string: $'
.code
main proc
	mov ax, @data
	mov ds, ax

	lea dx, prompt1
	mov ah, 9
	int 21h

	call decimal_input

	mov ax, bx
	mov dx, 0
	mov cx, 2
	div cx
	push ax
	
	mov ch, bl

	mov dl, 10
	mov ah, 2
	int 21h
	mov dl, 13
	mov ah, 2
	int 21h

again1:	mov cl, bl
	pop dx
	cmp cl, dl
	jne star
	mov dl, 'a'
	jmp again2
star:	mov dl, '*'
again2:	
	mov ah, 2
	int 21h
	
	dec cl
	jnz again2

	mov dl, 10
	mov ah, 2
	int 21h
	mov dl, 13
	mov ah, 2
	int 21h

	dec ch
	jnz again1

exit:	mov ah, 4Ch
	int 21h
	
main endp
decimal_input proc
	mov bx, 0
again:
	mov ah, 01h
	int 21h
	cmp al, 'x'
	je quit
	cmp al, 13
	je exit

	and ax, 000fh
	push ax
	mov ax, 10
	mul bx
	pop bx
	add bx, ax
	jmp again  
quit:	mov cl, 'x'
	ret
	
exit:
	ret
decimal_input endp
end main
