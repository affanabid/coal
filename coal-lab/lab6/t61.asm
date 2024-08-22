.model small
.stack 100h
.386
.data
	prompt1 db 10, 13, 'Enter operand 1: $'
	prompt2 db 10, 13, 'Enter operand 2: $'
	operator db 'Enter Operator: $'
	ans db 10, 13, 'Answer is: $'
	
.code
main proc
	mov ax, @data
	mov ds, ax

restart:
	lea dx, prompt1
	mov ah, 09h
	int 21h
	
	call decimal_input
	cmp cl, 'x'
	je exitt
	push bx
	
	lea dx, prompt2
	mov ah, 09h
	int 21h
	
	call decimal_input
	push bx

	lea dx, operator
	mov ah, 9
	int 21h
	mov ah, 1
	int 21h

	cmp al, '+'
	je addition
	cmp al, '-'
	je subtraction
	cmp al, '*'
	je multiplication
	cmp al, '/'
	je division
addition:
	pop bx
	pop ax
	add ax, bx
	push ax
	jmp final
subtraction:
	pop bx
	pop ax
	sub ax, bx
	push ax
	jmp final
	
multiplication:
	pop bx
	pop ax
	mul bx
	push ax
	jmp final

division:
	pop bx
	pop ax
	mov dx, 0
	div bx
	push dx
	jmp final
		
final:	lea dx, ans
	mov ah, 09h
	int 21h
	pop ax
	call decimal_output	
	jmp restart

exitt:	mov ah, 4Ch
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

decimal_output proc
	mov cx, 0
	mov bx, 10
again:
	mov dx, 0
	div bx
	push dx
	inc cx
	cmp al, 0
	jne again
	
print:
	pop dx
	add dl, 48
	mov ah, 02h
	int 21h
	dec cl
	jnz print
	ret
decimal_output endp
end main
