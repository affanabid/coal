.model small
.stack 100h
.386
.data
	prompt db 'Input: $'
	outp db 'Output: $'
	space db 100 dup ('$')
	spacee db 100 dup ('$')
	tes db 'azxxzy$'
.code
main proc
	mov ax, @data
	mov ds, ax

	mov ax, 0
	push ax
	

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
	mov cl, 0
	
traverse:
	mov bl, [si]

	cmp bl, '$'
	je oo
	
	pop ax
	
	cmp bx, ax
	je pretraverse
	
	push ax
	push bx
	inc cl
	inc si
	jmp traverse

pretraverse:
	inc si
	dec cl
	jmp traverse

oo:	lea si, spacee
	mov ch, cl
	
ot:	pop bx
	
	mov [si], bl
	inc si
	dec cl
	jnz ot

	dec si
	
	lea dx, outp
	mov ah, 9
	int 21h

final:	mov dl, [si]
	mov ah, 02
	int 21h

	
	dec si
	dec ch
	jnz final

exit:	mov ah, 4Ch
	int 21h
	
main endp
end main
