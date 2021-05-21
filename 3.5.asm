data segment 
    BUF1 db 1,2,3,4,5,6     
    BUF2 db 5,6,7,8,9
    BUF3 db 32 dup(204)
    N1     db 6
    N2     db 5
    string db 'Array merged completed!$'
data ends

code segment
    ASSUME CS:CODE,DS:DATE
    start:
        mov ax,data
        mov ds,ax
        lea si,BUF1 ;pointer of buffer1
        lea di,BUF2 ;pointer of buffer2
        lea bx,BUF3 ;pointer of buffer3
        mov ax,0
        mov cx,0
        mov dx,0
        mov ah,N1 ;number of N1
        mov al,N2 ;number of N2
        mov cl,N1
        add cl,N2 ;number of N1+N2
        mov dx,word ptr N2 ;number of N1+N2-1
        dec dx
        mov dh,0
        add dl,ah

        mov ax,word ptr N1 ;number of N1-1
        dec ax
        mov ah,0
    while:
        cmp si,ax   
        ja b2   ;´óÓÚÌø×ª
        cmp di,dx
        ja b1
        push dx
        mov dx,[di]
        cmp [si],dl
        pop dx
        ja b2        ;buf1[si] > buf2[di]
        jb b1         ;buf1[si] < buf2[di]
        push dx
        push ax
        mov dx,[si]
        mov [bx],dl    ;buf1[si] == buf2[di] 
        add dl,30h
        mov ah,2h
        int 21h
        pop ax
        pop dx
        inc si
        inc di
        inc bx
        dec cx
        jmp tail
    b2:    
        push dx
        push ax
        mov dx,[di]
        mov [bx],dl
        add dl,30h
        mov ah,2h
        int 21h
        pop ax
        pop dx
        inc bx
        inc di
        jmp tail
    b1:
        push dx
        push ax
        mov dx,[si]
        mov [bx],dl
        add dl,30h 
        mov ah,2h
        int 21h
        pop ax
        pop dx
        inc bx
        inc si
    tail:
    loop while
        call crlf
        lea dx,string
        mov ah,09h
        int 21h
        
        mov ax,4c00h
        int 21h

    crlf proc near
        push dx
        mov dl,0ah
        mov ah,2h
        int 21h
        mov dl,0dh
        mov ah,2h
        int 21h
        pop dx
        ret
    crlf endp
code ends
end start
