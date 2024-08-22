.model small
.stack 100h
.386

.data
str1 db 10, 13, "Binary Input: $"
str2 db 10, 13, "Hexa Decimal Output: $"
arr1 db  50 dup(0)

.code

main proc
	mov ax, @data
	mov ds, ax
	
	mov si, offset arr1
	
	mov cl, 5
	
input:	
	lea dx, str1
	mov ah, 09h
	int 21h

	call BinaryInput
	mov [si], bl
	inc si
	dec cl
	jnz input
 
	mov si, offset arr1
	
	mov cl, 5
output:	
	lea dx, str2
	mov ah, 09h
	int 21h
	
	mov bl, [si]
	call 	HexaDecimalOutput
	inc si
	dec cl
	jnz output

mov ah, 4ch
int 21h

main endp

BinaryInput proc
	xor bl, bl

aa:	mov ah, 01
	int 21h
	cmp al, 13
	je exit
	
	sub al, 30h
	shl bl, 1
	or bl, al
	jmp aa

exit:
	ret
BinaryInput endp

HexaDecimalOutput proc

	mov ch, 2
again:
	rol bl, 4
	mov dl, bl
	and dl, 0fh
	cmp dl, 9
	jbe digit

	add dl, 7
digit:
	add dl, 30h
	mov ah, 02h
	int 21h
	dec ch
	jnz again

	ret

HexaDecimalOutput endp	
end main