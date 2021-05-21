data segment
    str1 db "num of alphabet :$"
    str2 db "num of number :$"
    str3 db "num of others :$"
    alph db 0
    num db 0
    others db 0
ends

code segment
    assume cs:code,ds:data
    
start:
    mov ax,data
    mov ds,ax
    mov bx,0
    mov si,offset alph
        
input:
    mov ah,01h
    int 21h
    cmp al,0dh
    je print
    cmp al,30h
    jb  addothers
    cmp al,3ah
    jb  addnum
    cmp al,41h
    jb addothers
    cmp al,5bh
    jb addalph
     cmp al,61h
    jb addothers
     cmp al,7bh
    jb addalph
    jmp addothers
loop input

print:    
    call calf 
    lea dx,str1
    mov ah,09h
    int 21h
    call print1
    inc si    
    call calf

    lea dx,str2
    mov ah,09h
    int 21h
    call print1
    inc si 
    call calf
    lea dx,str3
    mov ah,09h
    int 21h
    call print1 
    mov ax,00h
    int 21h
        
print1:
    mov cx,0
    mov dx,0
    mov di,0ah
    mov al,[si]
    mov ah,00h
ToTen:
    div di
    push dx
    inc cx
    cmp ax,0
    je next1
    cwd
    jmp ToTen
next1:
    pop dx
    add dl,30h
    mov ah,02h
    int 21h
loop next1

ret


addalph:
    mov dl,[si]
    inc dl
    mov [si],dl
    jmp input

addnum:
    mov dl,[si+1]
    inc dl
    mov [si+1],dl
    jmp input

addothers:
    mov dl,[si+2]
    inc dl
    mov [si+2],dl
    jmp input
    
calf:
    mov dl,0ah
    mov ah,02h
    int 21h
    mov dl,0dh
    mov ah,02h
    int 21h
ret

ends    
end start
