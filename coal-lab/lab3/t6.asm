.model small
.stack 100h

.data
str1 db 50 dup('$')
str2 db 10, 13, "Enter a string: $"
str3 db 10, 13, "New string is: $" 

.code
main proc
    	mov ax, @data
    	mov ds, ax

    	lea dx, str2
    	mov ah, 09h
    	int 21h

    	mov si, offset str1

input_loop:
    	mov ah, 01h
    	int 21h

    	cmp al, 13  
    	je input_taken

    	mov [si], al
    	inc si
    	jmp input_loop

input_taken:
    	lea dx, str3
    	mov ah, 09h
    	int 21h

    	mov si, offset str1
    	mov cx, 0  
    
print_loop:
    	mov al, [si]

    	cmp al, '$'   
    	je print_word

   	cmp al, ' '   
   	je print_word
	
    	inc si
    	inc cx
   	jmp print_loop

print_word:

    	mov di, si
	dec di

print_char_loop:

    	mov dx, [di]
   	mov ah, 02h
    	int 21h

    	dec di

    	dec cx
    	jnz print_char_loop

   	mov al, [si]
    	cmp al, '$'
    	je exit

   	mov dx, ' '
   	mov ah, 02h
    	int 21h

    	inc si
    	jmp print_loop

exit:
    	mov ah, 4ch
    	int 21h

main endp
end main
