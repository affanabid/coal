.model small
.stack 100h
.386
.data
	var1 dw 5 dup(0)
.code
main proc
	mov ax, @data
	mov ds, ax

	mov Ax, 1000
	mov Cx, 4

again:	CMP Ax, 0
	JE exit

	mov Bx, 10
	mov Dx, 0
	
	DIV Bx

	ADD Dl, 48

	push ax

	mov ah,2
	int 21h

	pop ax

	deC Cx
	jnz again



exit:	mov ah, 4Ch
	int 21h
	
main endp
end main
