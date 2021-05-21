data segment
    odd db 'It is odd$'
    even db 'It is even$'
data ends 

stack segment
    dw 64 dup(0)
ends

code segment
start:
    mov ax,data
    mov ds,ax
    mov bx,0
    input1:
        mov ah,01h
        int 21h    ;键盘输入一个数 
        cmp al,0dh
        jz select   ;数据写入后进行奇数偶数判断
        sub al,30h
        mov cl,al
        mov ch,00
        mov ax,bx
        mov bx,0ah
        mul bx
        mov bx,ax
        add bx,cx
        jmp input1
    select:
        mov bx,0
        mov ah,2         
        mov dl,0ah    ;回车后进行判断
        int 21h
        mov dl,0dh
        int 21h
        
        sub ah,ah
        mov al,cl
        mov bl,2
        div bl
        cmp ah,1    ;ah存余数
        jnc next1
        
        jmp next2
    next1:               ;打印结果是奇数
          lea dx, odd
          mov ah, 9
          int 21h
          mov ah,4ch
          int 21h 
    
    next2:               ;打印结果是偶数
          lea dx, even
          mov ah, 9
          int 21h
          mov ah,4ch
          int 21h
