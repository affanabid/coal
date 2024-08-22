.model small
.stack 100h
.data

str01 db "Enter first digit:$"
str02 db "Enter first digit:$"
str2 db "Error! Sum is greater than 9.$"
str3 db "Sum is $"

.code 
	main proc
	
	MOV AX , @DATA
	MOV DS , AX
	MOV DX , OFFSET str01
	MOV AH , 09H
	INT 21H

;first input
	MOV AH , 01H
	INT 21H
	
	MOV BL , AL
	sub bl, 30h

;newline
	mov DL , 10 
	MOV AH , 02H
	INT 21H
	
	mov DL , 13
	MOV AH , 02H
	INT 21H
	
;second input
	MOV DX , OFFSET str02
	MOV AH , 09H
	INT 21H

	MOV AH , 01H
	INT 21H
	
	MOV CL , AL
	sub cl, 30h
	
	ADD BL , CL
		
;newline
	mov DL , 10 
	MOV AH , 02H
	INT 21H
	
	mov DL , 13
	MOV AH , 02H
	INT 21H

	CMP BL , 9
	JB AA

	MOV DX , OFFSET str2
	MOV AH , 09H
	INT 21H
	JMP BB
	
AA: 	MOV DX , OFFSET str3
	MOV AH , 09H
	INT 21H
	
	add bl, 30h
	MOV DL , BL
	MOV AH , 02H
	INT 21H	
	
	
BB:	MOV AH , 4CH
	INT 21H

MAIN ENDP
END MAIN