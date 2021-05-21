data segment
    score db 67,91,84,86,72,85,58,98,66,54,77,88,69,60,48,64,40,81,79,49,65,87,66,88,98,100,66,58,96,76,85,81,82,87,78,49,68,75,48,95 
    buffer 5 dup(0) 
str0 db " 40 scores : $"
str1 db " >=90 : $"
str2 db " 80-89 : $"
str3 db " 70-79: $"
str4 db " 60-69 : $"
str5 db " <60 : $"   
data ends

code segment
    assume CS:code,DS:data
    main:
        mov ax,data
        mov ds,ax
        mov dx,0000h
        mov bx,0000h
        mov bp,0000h
        mov cx,40           
        mov si,offset score  
        mov di,offset buffer   
        nine:
            mov al,[si]
            cmp al,90
            jc eight  
            inc dh    
            jmp stor
        eight:
            cmp al,80
            jc seven
            inc dl
            jmp stor
        seven:
            cmp al,70
            jc six
            inc bh
            jmp stor
        six:
            cmp al,60
            jc five
            inc bl
            jmp stor
        five:
            inc bp
        stor:
        inc si
        loop nine

        mov [di],dh
        mov [di+1],dl
        mov [di+2],bh
        mov [di+3],bl
        mov [di+4],bp

        lea dx,str0 
        mov ah,09h
        int 21h
        mov cx,40
        lea si,score
    show: 
        mov ax,0
        mov al,[si]
        call printf
        call space
        inc si
    loop show 
        call crlf
        lea dx,str1
        mov ah,09h
        int 21h     
        mov ax,0
        mov al,[di]
        call printf
        call crlf
        lea dx,str2
        mov ah,09h
        int 21h
        mov ax,0
        mov al,[di+1]
        call printf
        call crlf
        lea dx,str3
        mov ah,09h
        int 21h
        mov ax,0
        mov al,[di+2]
        call printf
        call crlf
        lea dx,str4
        mov ah,09h
        int 21h
        mov ax,0
        mov al,[di+3]
        call printf
        call crlf
        lea dx,str5
        mov ah,09h
        int 21h
        mov ax,0
        mov al,[di+4]
        call printf
        call crlf
        mov ax,4c00h
        int 21h

    printf proc
        push cx
        push bx
        push dx
        mov cx,0
        mov bx,10
    disp1:
        mov dx,0
        div bx
        push dx
        inc cx
        or ax,ax
        jne disp1
    disp2:
        mov ah,2
        pop  dx 
        add  dl,30H
        int 21h
        loop disp2
        
        pop dx
        pop bx
        pop cx
        ret
    printf endp
    ;»»ĞĞ
    crlf  proc near
        push ax
        push dx
        mov dl,0ah
        mov ah,2h
        int 21h
        mov dl,0dh
        mov ah,2h
        int 21h
        pop dx
        pop ax
        ret
    crlf endp

    space proc
        push ax
        push dx
        mov dl,20h
        mov ah,2h
        int 21h
        pop dx
        pop ax
        ret
    space endp
    code ends
end main
