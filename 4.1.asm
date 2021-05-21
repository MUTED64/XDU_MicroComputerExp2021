start: 
    mov dx,0001h
    mov bx,0002h
next1:
    mov al,bl
    inc bl
    mul bl
    add dx,ax
    cmp ax,00c8h          ; 200
    jna next1
                
    sub dx,ax           ; 减掉多出来的大于200的数
    mov ax,dx
    mov dx,0000h
    mov di,0ah
    mov cx,0
    ToTen:                       
    DIV DI
    PUSH DX
    INC CX
    CMP AX,0
    JE NEXT
    CWD
    JMP ToTen
NEXT:                        
    POP DX
    ADD DL,30H
    MOV AH,2H      
    INT 21H
    LOOP NEXT
end start
