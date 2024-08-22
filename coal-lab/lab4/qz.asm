.model small
.stack 100h
.data
	prompt db 'Enter the string: $'
	output db 'New string is: $'
	space db 100 dup('$')
.code
main proc
	
	mov ax, @data
	mov ds, ax

	lea dx, prompt
	mov ah, 9
	int 21h
	
	lea si, space
	
again:	mov Ah, 01
	int 21h

	CMP Al, 13
	JE exit

	XOR Al, 20h
	
	mov [si], Al
	inc si
	JMP again
	
exit:	
	lea dx, output
	mov ah, 09
	int 21h

	lea dx, space
	mov ah, 09
	int 21h
	
	mov ah, 4Ch
	int 21h
	
main endp
end main
	