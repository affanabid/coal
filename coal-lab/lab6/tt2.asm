.model small
.stack 100h
.386

.data

str1 db 10, 13, "Enter first Number: $"
str2 db 10, 13, "Enter second Number: $"
str3 db 10, 13, "The difference is: $"

.code

main proc
	mov ax, @data
	mov ds, ax
	
	lea dx, str1
	mov ah, 09h
	int 21h
	
	call decimal_input
	push bx
	
	lea dx, str2
	mov ah, 09h
	int 21h
	
	call decimal_input
	push bx
	
	lea dx, str3
	mov ah, 09h
	int 21h

	pop bx
	pop ax
	sub ax, bx
	
	call decimal_output	
	 
	
mov ah, 4ch
int 21h

main endp

decimal_input proc
	mov bx, 0
again:
	mov ah, 01h
	int 21h
	cmp al, 13
	je exit

	and ax, 000fh
	push ax
	mov ax, 10
	mul bx
	pop bx
	add bx, ax
	jmp again  
	
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