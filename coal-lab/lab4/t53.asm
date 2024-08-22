.model small
.stack 100h
.386

.data

str1 db 10, 13, "Enter a hex number (0 to FFFF): $"
str2 db 10, 13, "Illegal hex digit, try again: $"
str3 db 10, 13, "Its binary is $"

.code
	main proc
	mov ax, @data
	mov ds, ax
	
	xor bx, bx

	lea dx, str1
	mov ah, 09h
	int 21h

again:	mov ah, 01h
	int 21h
	
	cmp al, 13
	je input_taken
	cmp al, 96
	ja again_input
	
	cmp al, '9'
	jbe digit
	sub al, 07h

digit:
	sub al, 30h
	shl bx, 4
	or bl, al
	jmp again	

again_input:
	lea dx, str2
	mov ah, 09h
	int 21h
	jmp again	

input_taken:

	lea dx, str3
	mov ah, 09h
	int 21h

	mov cl, 16

cc:	shl bx, 1
	jc aa

	mov dl, '0'
	mov ah, 02h
	int 21h
	jmp bb

aa:
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