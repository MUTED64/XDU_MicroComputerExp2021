stack segment
    dw 120 dup(0)
ends

code segment
    start:
    mov ds, ax
    mov bx, 0
    mov dl, 0
    
    input:
    mov ah, 01h
    int 21h
    cmp al, 0dh      ;
    jz write
    cmp al, 'A'
    je next
    jmp input
    
    write:
    mov ah, 2
    mov dl, 0ah     ;换行
    int 21h
    mov dl, 0dh     ;回车
    int 21h
    mov ax, bx      
    mov dl, 10      ;做除法
    div dl
    
    mov dl, al      ;余数
    mov bl, ah      ;商
    mov ah, 2
    add dl, 30h
    int 21h
    
    mov dl, bl
    mov ah, 2
    add dl, 30h
    int 21h
    mov ah, 4ch
    int 21h
    
    next:
    add bx, 1
    jmp input
