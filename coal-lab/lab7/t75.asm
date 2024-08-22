.model small
.stack 100h
.data
       print  db 'Enter First string:',32,'$'
       print2 db 'Enter Second string:',32,'$'
       str1   db 50 dup('$')
       str2   db 50 dup('$')
       no     db 10,13,'It is not a substring$'
       yes    db 10,13,'It is a substring$'
.code
main proc
	mov   ax,@data
        mov   ds,ax
        mov   es,ax
        lea   si,str1
        lea   di,str2
    
        mov   dx,offset print
        mov   ah,09
        int   21h
     
        mov   cx,0
again:  mov   ah,01
        int   21h

	cmp   al,13
        je    next

	mov   [si],al
        inc   si
        inc   cx
        jmp   again

next:   mov   dx,offset print2
	mov   ah,09
        int   21h

	mov   bx,0
again2: mov   ah,01
	int   21h

	cmp   al,13
        je    next2

	mov   [di],al
        inc   di
        inc   bx
        jmp   again2

next2:  sub   si,cx
	sub   di,bx
        mov   ax,0

	cld
compare:
            
	cmpsb
        je    bb
        jne   aa

       aa:     dec   di
               inc   ax
               cmp   ax,cx
               je    exit
               jne   compare
 
           

       bb:     dec   bx
               cmp   bx,0
               je    exit2
               cmpsb
               je    bb

               jne   exit

       exit2:  lea   dx, yes
               mov   ah,09
               int   21h
               jmp   last

       exit:   lea   dx, no
               mov   ah,09
               int   21h

       last:   mov   ah,4ch
               int   21h

main endp
end main