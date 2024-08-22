.model small
.stack 100h
.386

.data

str1 db 10, 13, "Enter a character: $"
str2 db 10, 13, "The ASCII code of  $"
str3 db "in HEX is $"

.code
	main proc
	
	mov ax, @data
	mov ds, ax

cc:
	lea dx, str1
	mov ah, 09h
	int 21h

	mov ah, 01h
	int 21h
	
	cmp al, 13
	je exit

	lea dx, str2
	mov ah, 09h
	int 21h
	
	mov ah, 02
	mov dl, al
	int 21h

	lea dx, str3
	mov ah, 09h
	int 21h

	mov bl, al
	
	mov cl, 2
	
again:	rol bl, 4
	mov dl, bl
	and dl, 0fh
	cmp dl, 9
	jbe aa
	
	add dl, 07
	
aa:
	add dl, 30h
	mov ah, 02h
	int 21h
	
	dec cl
	jnz again
	
	jmp cc
exit:
	mov al, 2

mov ah, 4ch
int 21h

main endp
end main