.model small
.stack 100h
.386
.data

str1 db 10, 13, "Enter a binary number up to 16 digits: $"
str2 db 10, 13, "Its HEX is $"
str3 db 10, 13, "Wrong input$"
.code
	main proc
	mov ax, @data
	mov ds, ax

	
	
again:
	mov bx, 0
	lea dx, str1
	mov ah, 09h
	int 21h
		
input:	mov ah, 01h
	int 21h
	cmp al, '1'
	ja wrong

	cmp al, 13
	je input_taken

	sub al, 30h
	shl bx, 1
	or bl, al
	jmp input
	
wrong:
	lea dx, str3
	mov ah, 09h
	int 21h
	jmp again
 
input_taken:
	mov cl, 4

	lea dx, str2
	mov ah, 09h
	int 21h

bb:	rol bx, 4
	mov dl, bl
	and dl, 0fh

	cmp dl, 9
	jbe aa
	add dl, 07h

aa:	add dl, 30h
	mov ah, 02h
	int 21h
	dec cl
	jnz bb

mov ah, 4ch
int 21h
 	 
main endp
end main