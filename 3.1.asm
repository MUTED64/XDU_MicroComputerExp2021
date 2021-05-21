data segment
    string1 db 'number a:$'
    string2 db 'number b:$'
    string3 db 'number c:$'
    string4 db 'number d:$'
    string5 db 'a+(b-c)*d=$'
    a dw 0
    b dw 0
    c dw 0
    d dw 0
    e dw 0  ;结果存在e
data ends

code segment
    main proc 
        assume cs:code,ds:data
start: 
     mov ax,data
     mov ds,ax  
     lea dx,string1
     mov ah,9h
     int 21h 
     call input ;输入a 
     mov a,bx   
     lea dx,string2  
     mov ah,9h
     int 21h
     call input ;输入b 
     mov b,bx  
     lea dx,string3 
     mov ah,9h
     int 21h
     call input ;输入c 
     mov c,bx
     lea dx,string4 
     mov ah,9h
     int 21h
     call input ;输入d 
     mov d,bx
     lea dx,string5 
     mov ah,9h
     int 21h    ;输出结果
     ;计算过程 
     mov ax,b 
     sub ax,c
     mov bx,ax
     mov ax,d  
    ;计算（b-c）*d
     imul bx   ;这里是16位，8位乘以8位,其中一个乘数默认放在AL寄存器中,乘法的结果放在AX寄存器之中
     adc ax,a
     mov  e,ax
     ;输出结果 
     test ax,8000h
     jz  printe2   ;正数
     jnz printe1   ;负数
    printe1: 
            mov  dl,'-'
            mov ah,02h    ;显示输出。入口参数：AH=02H;功能号 DL=要显示的字符
            int 21h         
            mov ax,e
            neg ax 
            mov bl,0ah
            div bl 
            mov bh,ah
            mov dl,al
            add dl,30H
            mov ah,02h    ;显示输出。入口参数：AH=02H;功能号 DL=要显示的字符
            int 21h
            mov dl,bh
            add dl,30H
            mov ah,02h    ;显示输出。入口参数：AH=02H;功能号 DL=要显示的字符
            int 21h 
         MOV AX,4C00H               ;程序中止
		 INT 21H
      printe2:  
            mov ax,e 
            mov bl,0xah
            div bl 
            mov bh,ah
            mov dl,al
            add  dl,30H
            mov ah,02h    ;显示输出。入口参数：AH=02H;功能号 DL=要显示的字符
            int 21h
            mov dl,bh
             add  dl,30H
            mov ah,02h   ;显示输出。入口参数：AH=02H;功能号 DL=要显示的字符
            int 21h
       MOV AX,4C00H                  ;程序中止
		INT 21H
main endp 
;call 子程序    
input proc  
    mov ah,01h;输入一个字符，AL等于输入的字符
    int 21h
    sub al,30h     ;转换为十进制 
    mov bl,al     ;将al转移到bl中
    and bx,00FFh  ;将bx高位清零
    jmp exit
exit:
    call newline
    ret
input endp 
;换行操作
newline proc 
    mov dl,0ah;换行
    mov ah,2h
    int 21h
    ;显示输出，dl为要显示的字符
    mov dl,0dh;回车
    mov ah,2h
    int 21h     
    ret
newline endp    
code ends
   end start
