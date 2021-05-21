data segment
    ;���ʱ�Ӹ�ʽ��Ϣ 
    year dw 0 
    month db 0   
    day db 0
    hour db 0
    minute db 0
    second db 0               
    time1 db "0000year 00month 00day$"            
    time2 db "00:00:00$"  
    len1 equ $-time1
    len2 equ $-time2
    num db 0    
ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov es, ax  

begin:
   call  setshow1
   call  get_system_time1 
   call  setshow2 
   call  get_system_time2 
   jmp begin

 get_system_time1 proc 
  ;��ȡϵͳʱ��   
    mov ah,2ah   
    int 21h   
    mov year,cx   
    mov month,dh   
    mov day,dl       
    mov ax,0        ;ʱ����ʾ���ַ���
    mov ax,year     ;��:al,����:ah              
    mov num,100
    div num       ;al=20,ah=20 
    mov bx,ax 
    mov ah,0 
    mov num,10  
    div num
    add al,30h      
    mov time1[0],al
    add ah,30h    
    mov time1[1],ah  
    mov al,bh     
    mov ah,0  
    div num  
    add al,30h  
    mov time1[2],al  
    add ah,30h    
    mov time1[3],ah 
    mov ax,0
    mov al,month
    mov num,10
    div num
    add al,30h
    mov time1[9],al
    add ah,30h
    mov time1[10],ah     
    mov ax,0
    mov al,day
    mov num,10
    div num
    add al,30h
    mov time1[17],al
    add ah,30h
    mov time1[18],ah

 ;-���ϵͳʱ��   
    lea dx, time1
    mov ah, 9   
    int 21h   
    ret 
  get_system_time1  endp    
  get_system_time2 proc 
    
 
    mov ah,2Ch     ;ch=ʱ,cl=��,dh=��
    int 21h         ;��ȡʱ��
    mov hour,ch
    mov minute,cl
    mov second,dh  
    mov ax,0        ;ʱ����ʾ���ַ���
    mov al,hour     ;��:al,����:ah
    mov num,10
    div num
    add al,30h
    mov time2[0],al
    add ah,30h
    mov time2[1],ah 
    mov ax,0
    mov al,minute
    mov num,10
    div num
    add al,30h
    mov time2[3],al
    add ah,30h
    mov time2[4],ah
    mov ax,0
    mov al,second
    mov num,10
    div num
    add al,30h
    mov time2[6],al
    add ah,30h
    mov time2[7],ah
 ; ���ϵͳʱ��
    
    lea dx,time2
    mov ah,9
    int 21h
    ret 

  get_system_time2  endp

 setshow1 proc     ;���ù��λ�� 

    mov dh,12  ;�к�12    
    mov dl,29  ;�к�35  
    mov bh,0
    mov ah,2 
    int 10h   
    ret
 setshow1 endp  
 setshow2 proc     ;���ù��λ�� 
    mov dh,13  ;�к�12    
    mov dl,35  ;�к�35  
    mov bh,0
    mov ah,2 
    int 10h   
    ret

 setshow2 endp  
    mov ax, 4c00h
    int 21h    
ends
end start 
