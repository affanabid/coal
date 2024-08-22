.model small
.stack 100h
.386
.data
str1 db 10, 13, "Enter a binary number up to 8 digits: $"
str2 db 10, 13, "The binary sum is $"
var1 db 5 dup(0)
.code
	main proc
	mov  ax, @data
	mov ds, ax
	
	mov cl, 2
input:	
	xor bl, bl
	mov ch, 8
	lea dx, str1
	mov ah, 09h
	int 21h

aa:	mov ah, 01h
	int 21h
	cmp al, 13
	je exit

	sub al, 30h
	shl bl, 1
	or bl, al
	dec ch
	jnz aa

exit:
	
	add var1, bl
	dec cl
	jnz input
 
	lea dx, str2
	mov ah, 09h
	int 21h

	mov cl, 10
	mov bl, [var1]
cc:
	shl bl, 1
	jc ee

	mov dl, '0'
	mov ah, 02h
	int 21h
	jmp bb
ee:
	mov dl, '1'
	mov ah, 02h
	int 21h

bb:
	dec cl
	jnz cc

mov ah, 4ch
int 21h

main endp 
end main	
			

