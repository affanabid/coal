.model small
.stack 100h

.data

m1 db 10,13,"Enter string1: $"
m2 db 10,13,"Enter string2: $"
m3 db 10,13,"Enter integer: $"
m4 db 10,13,"New String is : $"
str1 db 50 dup('$')
str2 db 50 dup('$')
str3 db 50 dup('$')
var db 0
length1 dw 0
length2 dw 0

.code


main proc

	mov ax , @data
	mov ds , ax
	mov es , ax
	
	cld
	
	lea di , str1

	lea dx, m1
	mov ah , 09h
	int 21h
input:
	mov ah , 01h
	int 21h
	
	cmp al , 13
	je input02
	
	stosb
	inc length1
	jmp input
	
input02:
	lea dx, m2
	mov ah , 09h
	int 21h
	lea di , str2
	
input2:
	mov ah , 01h
	int 21h
	
	cmp al , 13
	je integerr
	
	stosb
	inc length2
	jmp input2

integerr :
	lea dx, m3
	mov ah , 09h
	int 21h
	mov ah , 01h
	int 21h
	
	sub al , 30h
	
	mov var , al
	
	lea si , str1
	lea di , str3
	
	mov cx , 0
	mov cl , var
	
first:	
	mov ax, [si]
	mov [di], ax
	inc di
	inc si
	dec cx
	jnz first
	
	lea si , str2
	mov cx , length2
	
second:	
	mov ax, [si]
	mov [di], ax
	inc di
	inc si
	dec cx
	jnz second
	
	lea si , str1
	xor ax , ax
	mov al , var
	add si , ax
	mov cx , length1
	sub cx , ax
	
third:	
	mov ax, [si]
	mov [di], ax
	inc di
	inc si
	dec cx
	jnz third
	
	lea dx, m4
	mov ah , 09h
	int 21h
	
	lea dx, str3
	mov ah , 09h
	int 21h

mov ah , 4ch
int 21h

main endp
end main
