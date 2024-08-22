.model small
.stack 100h
.data
str1 db 50 dup('$')

.code
main proc
	mov ax, @data
	mov ds, ax
;prompt
	mov si, offset str1
	mov cx, 0

;input
aa:	mov ah, 01h
	int 21h

	inc cx

;exit on enter
	cmp al, 13
	je bb

	mov [si], al
	
	inc si
	jmp aa
	
bb:	
;adjust pointers
	dec si
	dec cx

cc:	
;printing characters(reverse)
	mov dl, [si]
	mov ah, 02h
	int 21h

	dec si
	dec cx
	jne cc

mov ah, 4ch
int 21h

main endp
end main

	