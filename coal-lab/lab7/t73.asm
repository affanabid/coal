.model small
.stack 100h
.386
.data
	prompt1	db 10,13,'Enter a string: $'
	result db 10,13,'String: $'
	space db 100 dup('$')
.code
main proc
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	lea si, space
	mov cl, 0
	mov ch, 0

	lea dx, prompt1
	mov ah, 9
	int 21h
	
inp:	mov ah, 1
	int 21h

	cmp al, 13
	je input_taken

	cmp al, 32
	je probable
	
cont:	mov [si], al
	mov ch, 1
	inc si
	inc cl
	jmp inp

probable:
	cmp ch, 0
	jne cont
	jmp inp
	
input_taken:
	lea dx, result
	mov ah, 9
	int 21h

	lea dx, space
	mov ah, 9
	int 21h

	jmp exit	

	lea di, space

check:	mov al, 32
	scasb 
	jne printing

	jmp check

printing:	
	dec di
	inc cl
	
outp:	mov dl, [di]	
	mov ah, 2
	int 21h
	
	inc di
	dec cl
	jnz outp		

exit:	
	mov ah, 4Ch
	int 21h
	
main endp
end main
