.model small
.stack 100h
.data

 message db "Enter a number (0-9) $"

.code 
	main proc
	
	MOV AX , @DATA
	MOV DS , AX
	
	MOV DX , OFFSET message
	MOV AH , 09H
	INT 21H
	
	MOV AH , 01H
	INT 21H
	
	MOV BL , AL
	MOV CL , '0'
	
	
a:	
	MOV DL , CL
	MOV AH , 02H
	INT 21H
	
	mov DL , 10 
	MOV AH , 02H
	INT 21H
	
	mov DL , 13
	MOV AH , 02H
	INT 21H
	
	INC CL

	CMP CL , BL
	JLE a
	
	
	
MOV AH , 4CH
INT 21H

MAIN ENDP
END MAIN