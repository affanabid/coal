.model small
.stack 100h
.386
.data
	prompt1	db 10,13,'MyStr: $'
	prompt2 db 10,13,'ch: $'
	result db 10,13,'ModifiedString: $'
	space db 100 dup('$')
.code
main proc
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	lea si, space
	mov cl, 0

	lea dx, prompt1
	mov ah, 9
	int 21h
	
inp:	mov ah, 1
	int 21h

	cmp al, 13
	je input_taken
	
	mov [si], al
	inc si
	inc cl
	jmp inp

input_taken:
	lea dx, prompt2
	mov ah, 9
	int 21h
	mov ah, 1
	int 21h
	mov bh, al

;comp
	lea di, space
	lea dx, result
	mov ah, 9
	int 21h
	
comp:	mov al, bh
	scasb
	jne printing

	dec cl
	jnz comp

	jmp exit
	

printing:
	dec di
	mov dl, [di]
	mov ah, 2
	int 21h
	
	inc di
	dec cl
	jnz comp
	
exit:	
	
	mov ah, 4Ch
	int 21h
	
main endp
end main
