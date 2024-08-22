.model small
.stack 100h
.386
.data
	prompt db 'Enter a number: $'
	prime db 10, 13, 'Number is prime. $'
	notprime db 10, 13, 'Number is not prime. $'
.code
main proc
	mov ax, @data
	mov ds, ax

	lea dx, prompt
	mov ah, 9
	int 21h

	call decimal_input

	cmp bx, 1
	je print_prime

	cmp bx, 2
	je print_prime
	
	mov cx, 2

again:	mov ax, bx
	mov dx, 0
	div cx

	cmp dx, 0
	je print_notprime
	
	inc cx
	
	cmp cx, bx
	jne again 	

print_prime:
	lea dx, prime
	mov ah, 9
	int 21h
	jmp exit

print_notprime:
	lea dx, notprime
	mov ah, 9
	int 21h

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


end main
