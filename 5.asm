CODE SEGMENT
    ASSUME CS:CODE
START:
    MOV AX,1000H
    MOV DS,AX ;�������ݶε�ַ
    MOV AL,1
    MOV BX,0000H
    MOV CX,1000H ;ѭ������
    MOV [BX],AL
    JMP M1 
    ;1��8ѭ��д��10000H-10FFFH
ZERO:
    MOV AL,1	
M1:
	MOV [BX],AL  
	INC BX
    INC AL
    CMP AL,8
    JA ZERO
    LOOP M1   ;ѭ������CX��ֵ
    ;��9д��11000H-12FFFH
    MOV AL,09H
    MOV CX,2000H   
    MOV BX,1000H ;ƫ�Ƶ�ַ1000H
M2: 
    MOV [BX],AL
    INC BX
    LOOP M2    
    ;��11000H-12FFFH�����Ƶ�14000H-15FFFH
    MOV BX,1000H
    MOV CX,2000H
TRANS:
    MOV AL,[BX] ;����
    ADD BX,3000H
    MOV [BX],AL
    SUB BX,3000H   
    INC BX
    LOOP TRANS 
    HLT
CODE ENDS
    END START