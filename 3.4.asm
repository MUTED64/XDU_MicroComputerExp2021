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
    mov dl, 0ah     ;����
    int 21h
    mov dl, 0dh     ;�س�
    int 21h
    mov ax, bx      
    mov dl, 10      ;������
    div dl
    
    mov dl, al      ;����
    mov bl, ah      ;��
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
