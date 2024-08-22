.model small
.stack 100h
.386
.data
	prompt db 'Enter a string: $'
	outp db 'New string is: $'
	space db 100 dup('$')
.code
main proc
	mov ax, @data
	mov ds, ax
	lea dx, prompt
	mov ah, 9
	int 21h
	lea si, space

inp:	mov ah, 1
	int 21h
	cmp al, 13
	je input_taken
	mov [si], al
	inc si
	jmp inp

input_taken:
	lea si, space
	lea dx, outp
	mov ah, 9
	int 21h
	mov dx, 0
prereq:	mov bx, 0

traverse:
	mov al, [si]
	cmp al, '$'
	je last
	cmp al, ' '
	je printing
	push ax
	inc bx
	inc si
	jmp traverse

printing:
	pop dx
	mov ah, 2
	int 21h
	dec bx
	jnz printing
	mov dl, ' '
	mov ah,2 
	int 21h
	inc si
	jmp prereq

last:
	pop dx
	mov ah, 2
	int 21h
	dec bx
	jnz last		

exit:	mov ah, 4Ch
	int 21h
	
main endp
end main
