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
    e dw 0  ;�������e
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
     call input ;����a 
     mov a,bx   
     lea dx,string2  
     mov ah,9h
     int 21h
     call input ;����b 
     mov b,bx  
     lea dx,string3 
     mov ah,9h
     int 21h
     call input ;����c 
     mov c,bx
     lea dx,string4 
     mov ah,9h
     int 21h
     call input ;����d 
     mov d,bx
     lea dx,string5 
     mov ah,9h
     int 21h    ;������
     ;������� 
     mov ax,b 
     sub ax,c
     mov bx,ax
     mov ax,d  
    ;���㣨b-c��*d
     imul bx   ;������16λ��8λ����8λ,����һ������Ĭ�Ϸ���AL�Ĵ�����,�˷��Ľ������AX�Ĵ���֮��
     adc ax,a
     mov  e,ax
     ;������ 
     test ax,8000h
     jz  printe2   ;����
     jnz printe1   ;����
    printe1: 
            mov  dl,'-'
            mov ah,02h    ;��ʾ�������ڲ�����AH=02H;���ܺ� DL=Ҫ��ʾ���ַ�
            int 21h         
            mov ax,e
            neg ax 
            mov bl,0ah
            div bl 
            mov bh,ah
            mov dl,al
            add dl,30H
            mov ah,02h    ;��ʾ�������ڲ�����AH=02H;���ܺ� DL=Ҫ��ʾ���ַ�
            int 21h
            mov dl,bh
            add dl,30H
            mov ah,02h    ;��ʾ�������ڲ�����AH=02H;���ܺ� DL=Ҫ��ʾ���ַ�
            int 21h 
         MOV AX,4C00H               ;������ֹ
		 INT 21H
      printe2:  
            mov ax,e 
            mov bl,0xah
            div bl 
            mov bh,ah
            mov dl,al
            add  dl,30H
            mov ah,02h    ;��ʾ�������ڲ�����AH=02H;���ܺ� DL=Ҫ��ʾ���ַ�
            int 21h
            mov dl,bh
             add  dl,30H
            mov ah,02h   ;��ʾ�������ڲ�����AH=02H;���ܺ� DL=Ҫ��ʾ���ַ�
            int 21h
       MOV AX,4C00H                  ;������ֹ
		INT 21H
main endp 
;call �ӳ���    
input proc  
    mov ah,01h;����һ���ַ���AL����������ַ�
    int 21h
    sub al,30h     ;ת��Ϊʮ���� 
    mov bl,al     ;��alת�Ƶ�bl��
    and bx,00FFh  ;��bx��λ����
    jmp exit
exit:
    call newline
    ret
input endp 
;���в���
newline proc 
    mov dl,0ah;����
    mov ah,2h
    int 21h
    ;��ʾ�����dlΪҪ��ʾ���ַ�
    mov dl,0dh;�س�
    mov ah,2h
    int 21h     
    ret
newline endp    
code ends
   end start
