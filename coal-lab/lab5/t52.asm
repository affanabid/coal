.model small
.stack 100h
.386

.data

str1 db 10, 13, "Enter a string: $"
str2 db 10, 13, "You Enter: $"
str3 db 50 dup("$")

.code
	main proc
	mov ax, @data
	mov ds, ax

	lea dx, str1
	mov ah, 09h
	int 21h

	mov si, offset str3
	
input:	
	mov ah, 01h
	int 21h

	cmp al, 13
	je input_taken

	mov  [si], al
	inc si
	jmp input


input_taken:
	mov si, offset str3
	mov cl, 0
	
	lea dx, str2
	mov ah, 09h
	int 21h
	
aa:	mov bl, [si]
	
	cmp bl, '$'
	je cc		
	
	push bx
	inc cl
	inc si

	cmp bl, 20h
	je bb

	jmp aa
	
bb:
	pop bx
	mov dl, bl

	mov ah, 02h
	int 21h
	
	dec cl
	jnz bb
	
	jmp aa
cc:	
	pop bx
	mov dl, bl

	mov ah, 02h
	int 21h
	dec cl
	jnz cc
	
exit:
	mov al, 02h
mov ah, 4ch
int 21h
main endp
end main