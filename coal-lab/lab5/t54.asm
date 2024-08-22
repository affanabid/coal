.model small
.stack 100h
.386
.data
	prompt db 'Input String: $'
	positive db 'Output: String is a palindrome. $'
	negative db 'Output: String is not a palindrome. $'
	space db 100 dup('$')
	tes db 'nitin$'
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

load_stack:
	mov Bl, [si]
	
	CMP Bl, '$'
	JE stack_loaded
	
	PUSH Bx
	
	inc si
	JMP load_stack

stack_loaded:
	lea si, space
	
check:
	mov Bl, [si]

	POP Ax
	
	CMP Bl, '$'
	JE pos

	CMP Bl, Al
	JNE negg	

	inc si
	JMP check

;output
;not a palindrome
negg:	lea dx, negative
	mov ah, 9
	int 21h

	JMP exit

;palindrome
pos:	lea dx, positive
	mov ah, 9
	int 21h

exit:	mov ah, 4Ch
	int 21h
	
main endp
end main
