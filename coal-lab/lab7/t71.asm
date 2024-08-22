.model small
.stack 100h
.386
.data
	prompt1	db 10,13,'InputString: $'
	prompt2 db 10,13,'CharToFind: $'
	prompt3 db 10,13, 'CharToReplace: $'
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

;ctf in bl
	mov bl, al

        lea dx, prompt3
	mov ah, 9
	int 21h
	mov ah, 1
	int 21h

;ctr in bh
	mov bh, al

;ctf in al
	mov al, bl

;comp
	lea di, space
	mov bl, cl
	
comp:	scasb
	je repl
	dec cl
	jnz comp

repl:	dec di
	mov [di], bh
	inc di
	dec cl	
	jnz comp
	
	lea dx, result
	mov ah, 9
	int 21h
	lea si, space
outp:	
	mov dl, [si]
	mov ah, 2
	int 21h
	dec bl
	jnz outp

exit:	
	lea dx, space
	mov ah, 9
	int 21h
	mov ah, 4Ch
	int 21h
	
main endp
end main
