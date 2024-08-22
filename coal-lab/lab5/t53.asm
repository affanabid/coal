.model small
.stack 100h
.386
.data
	prompt1 db 10, 13, 'Enter an algebraic expression: $'
	prompt2 db 10, 13, 'Type Y if you want to continue: $'
	right db 10, 13, 'Too many right brackets, Begin again.$'
	left db 10, 13, 'Too many left brackets, Begin again.$'
	correct db 10, 13, 'Expression is correct. $'
	wrong db 'Expression is wrong. $'
.code
main proc
	mov ax, @data
	mov ds, ax

;default 0 at stack start	
	mov Ax, 0
	PUSH Ax

inp1:	lea dx, prompt1
	mov ah, 9
	int 21h

inp2:	mov ah, 01
	int 21h

	cmp al, 13
	je input_taken
	
	CMP al, '('
	je checker

	CMP al, ')'
	je checker

	jmp inp2

checker:
	POP Bx

	CMP Ax, Bx
	JE err

	CMP Bx, 0
	JE pusher

	mov Ax, 0
	PUSH Ax

	JMP inp2
	
pusher:	
	PUSH Ax

	JMP inp2

;identify left or right
err:	CMP Al, '('
	JE ll

	JMP rr

ll:	lea dx, left
	mov ah, 9
	int 21h

	JMP inp1

rr:	lea dx, right
	mov ah, 9
	int 21h

	JMP inp1

input_taken:
	POP Ax
	
	CMP Ax, 0
	JE corr

	JMP wrng

corr:	lea dx, correct
	mov ah, 9
	int 21h
	JMP again

wrng:	lea dx, wrong
	mov ah, 9
	int 21h

again:	lea dx, prompt2
	mov ah, 9	
	int 21h

	mov ah, 1
	int 21h

	cmp Al, 'Y'
	JE inp1
exit:	
	mov ah, 4Ch
	int 21h
	
main endp
end main