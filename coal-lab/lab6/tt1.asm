.model small 
.stack 100h
.386

.data

str1 db 10, 13, "Enter a Key: $"
str2 db 10, 13, "The ascii code in decimal is : $"
str3 db 10, 13, "The ascii code in Hexadecimal is : $"
str4 db 10, 13, "The ascii code in binary is : $"

.code

main proc 
	mov ax, @data
	mov ds, ax

	lea dx, str1
	mov ah, 09h
	int 21h

	mov ah, 01h
	int 21h
	
	lea dx, str2
	mov ah, 09h
	int 21h
	
	and ax, 00ffh
	push ax	

	call decimal
	
	pop ax

	lea dx, str3
	mov ah, 09h
	int 21h
	
	and ax, 00ffh
	push ax

	call hexadecimal
	
	pop ax

	lea dx, str4
	mov ah, 09h
	int 21h

	and ax, 00ffh
	push ax
	
	call binary
	 
	pop ax

mov ah, 4ch
int 21h

main endp
decimal proc
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

decimal endp

hexadecimal proc
	
	mov cx, 0
	mov bx, 16
again:
	mov dx, 0
	div bx
	push dx
	inc cx
	cmp al, 0
	jne again

print:
	pop dx
	cmp dx, 9
	jbe digit
	add dx, 07h

digit:
	add dx, 30h
	mov ah, 02h
	int 21h
	dec cl
	jnz print 
	ret 
hexadecimal endp

binary proc
	
	mov cx, 0
	mov bx, 2d
again:
	mov dx, 0
	div bx
	push dx
	inc cx
	cmp al, 0
	jne again

print:
	pop dx
	add dl, 30h
	mov ah, 02h
	int 21h
	dec cx
	jnz print
	ret
binary endp
end main