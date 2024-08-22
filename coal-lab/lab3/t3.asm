.model small
.stack 100h
.data

str1 db "Enter two digits:$"
str2 db "ENTER OPERATION : $"
str3 db "Sum is $"
str4 db "DIFF is $"

.code 
	main proc
	
	MOV AX , @DATA
	MOV DS , AX
	MOV DX , OFFSET str1
	MOV AH , 09H
	INT 21H
	
	MOV AH , 01H
	INT 21H
	
	MOV BL , AL
	
	MOV AH , 01H
	INT 21H
	
	MOV CL , AL

	mov dl, 10
	mov ah, 2
	INT 21h
	mov dl, 13
	mov ah, 2
	INT 21h
	
	MOV DX , OFFSET str2
	MOV AH , 09H
	INT 21h
	
	MOV AH , 01H
	INT 21H
	
	MOV BH , AL
		
	CMP BH , '+'
	JE AA
	SUB BL , CL
	ADD bl, 30h
	
	mov dl, 10
	mov ah, 2
	INT 21h
	mov dl, 13
	mov ah, 2
	INT 21h

	MOV DX , OFFSET str4
	MOV AH , 09H
	INT 21H
	
	MOV DL , BL
	MOV AH , 02H
	INT 21H	
	JMP BB
	
AA: ADD BL , CL
	SUB BL , 30H
	
	mov dl, 10
	mov ah, 2
	INT 21h
	mov dl, 13
	mov ah, 2
	INT 21h

	MOV DX , OFFSET str3
	MOV AH , 09H
	INT 21H
	
	MOV DL , BL
	MOV AH , 02H
	INT 21H	
	
BB:	MOV AH , 4CH
	INT 21H

MAIN ENDP
END MAIN