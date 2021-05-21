data segment
    str1 db 'please input a number to a:$'
    str2 db 'please input a number to b:$'
    str3 db 'result c=a*b=$'
    a dw ?
    b dw ?
    c dw ?
data ends
code segment
assume cs:code,ds:data
    main proc far
    start:
        mov ax,data
        mov ds,ax
        lea dx,str1 ;ouput str1
        mov ah,9h
        int 21h
        call input  ;input a
        mov a,bx
        lea dx,str2 ;ouput str2
        mov ah,9h
        int 21h
        call input  ;input b
        mov b,bx
        lea dx,str3 ;ouput str3
        mov ah,9h
        int 21h
        mov ax,a
        aad
        mov bx,ax
        mov ax,b
        aad
        mul bx                   ;ax = a*b
        mov word ptr c,ax   ;c = a*b
        mov di,0ah             ;di = 10
        mov cx,0
    ToTen:            ;convert to decimal
        div di
        push dx
        inc cx
        cmp ax,0
        je print
        cwd
        jmp ToTen
    print:            ;output result
        pop dx
        add dl,30h
        mov ah,2h
        int 21h
    loop print
        mov ah,00h
        int 21h
    main endp
    input proc
        mov bx,0
        inputa:
        mov ah,1    ;first char
        int 21h
        sub al,30h
        mov bl,al
        mov ah,1        ;second char
        int 21h
        cmp al,0dh  ;compare if al==Enter
        je exit
        sub al,30h
        mov cl,8     ;shift operation
        rol bx,cl
        mov bl,al
        jmp exit
        exit:
            call crlf
        ret
    input endp
    ;print next line
    crlf proc near
        mov dl,0ah
        mov ah,2h
        int 21h
        mov dl,0dh
        mov ah,2h
        int 21h
        ret
    crlf endp
code ends
    end start
