.model small
.stack 100h

.data
str1 db 50 dup(?)
str2 db "Enter a String:$"

.code
main proc
	mov ax, @data
	mov ds, ax

;prompt
	mov dx, offset str2
	mov ah, 09h
	int 21h
;start
	mov si, offset str1

	mov bl, 0 
ee:	
	inc bl

aa:	

;input
	mov ah, 01h
	int 21h

;exit on enter	
	cmp al, 13
	je bb

	mov [si], al
	inc si

	cmp al, 'a'
	je ee
	cmp al, 'e'
	je ee
	cmp al, 'i'
	je ee
	cmp al, 'o'
	je ee
	cmp al, 'u'
	je ee

	jmp aa

bb:	

;convert from ascii to digit
	dec bl
	add bl, 30h

;print digit
	mov dl, bl
	mov ah, 02h
	int 21h

mov ah, 4ch
int 21h

main endp
end main

	