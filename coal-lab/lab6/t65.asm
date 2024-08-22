.model small
.stack 100h
.386
.data
	n1 db 'Enter numerator of first fraction: $'
	d1 db 'Enter denominator of first fraction: $'
	n2 db 'Enter numerator of second fraction: $'
	d2 db 'Enter denominator of second fraction: $'
	ans db 'The result is: $'
	
.code
main proc
	mov ax, @data
	mov ds, ax

	lea dx, n1
	mov ah, 9
	int 21h

	call decimal_input

	push bx

	
	lea dx, d1
	mov ah, 9
	int 21h

	call decimal_input

	push bx


	lea dx, n2
	mov ah, 9
	int 21h

	call decimal_input

	push bx


	lea dx, d2
	mov ah, 9
	int 21h

	call decimal_input

	push bx

;n2Xd1
	pop ax
	pop bx
	pop cx
	push ax

	mov ax, cx
	mul bx
;d2Xn1
	pop dx
	pop bx
;d1 saved
	push cx
	push ax
	mov ax, bx
;d2 saved
	push dx
	mul dx

	
;(n2Xd1)+(n1Xd2)
	pop cx
	pop bx
	push cx
	add ax, bx
	pop dx
	pop cx
	push ax

	mov ax, dx
	mul cx
	pop bx
	push ax
	mov ax, bx
	
	call decimal_output	
	
	mov dl, '/'
	mov ah,2
	int 21h

	pop ax

	call decimal_output

exit:	mov ah, 4Ch
	int 21h
	
main endp
decimal_input proc
	mov bx, 0
again:
	mov ah, 01h
	int 21h
	cmp al, 'x'
	je quit
	cmp al, 13
	je exit

	and ax, 000fh
	push ax
	mov ax, 10
	mul bx
	pop bx
	add bx, ax
	jmp again  
quit:	mov cl, 'x'
	ret
	
exit:
	ret
decimal_input endp
decimal_output proc
	mov cx, 0
	mov bx, 10
again:
	mov dx, 0
	div bx
	push dx
	inc cx
	cmp al, 0
	jne again
	
print:
	pop dx
	add dl, 48
	mov ah, 02h
	int 21h
	dec cl
	jnz print
	ret
decimal_output endp
end main
