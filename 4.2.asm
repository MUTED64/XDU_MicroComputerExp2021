data segment
    str1 db "N should <=8&&>0!$"
    data1 db 0
data ends
start:
    mov cx,0
    mov ax,data
    mov ds,ax
    mov si,offset data1

input:    
    mov ah,01h
    int 21h
    inc cx
    cmp al,38h
    ja error
    mov [si],al
    inc si
    cmp al,0dh
    jne input
    cmp cx,02h
    je  next
     
error:
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    MOV DL,0DH
    MOV AH,02H
    INT 21H
    
    lea dx,str1 
    mov ah,09h
    int 21h
    
    mov ah,00h
    int 21h
    
    
next:
    mov al,[si-2]
    cmp al,30h
    je error    
    sub al,30h
    MOV ah,00H
    MOV bx,ax
    
    MOV DL,0AH
    MOV AH,02H
    INT 21H
    
    MOV DL,0DH
    MOV AH,02H
    INT 21H

    mov ax,bx

next1:
    cmp bx,0001h
    je next2
    dec bx
    mul bx
    cmp bx,0001h
    ja next1
    jmp next2
next2:
    mov cx,0
    mov dx,0000h
    mov di,0ah
ToTen:            
        div di
        push dx
        inc cx
        cmp ax,0
        je print
        cwd
        jmp ToTen
        
print:            
        pop dx
        add dl,30h
        mov ah,2h
        int 21h
        loop print
        mov ah,00h
        int 21h  

end start
