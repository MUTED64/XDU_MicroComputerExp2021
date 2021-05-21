DATA SEGMENT
    NUMBER DB 40H,79H,24H,30H,19H,12H,02H,78H,00H,10H
    MIN1 DB 0
    MIN2 DB 0
    SEC1 DB 0
    SEC2 DB 0
    CIR DW 800
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX, DATA
    MOV DS, AX
    MOV AL, 89H
    MOV DX, 206H  ;��ʼ��
    OUT DX, AL    ;A,B�����C����
    MOV BX, 0H  
    LEA SI, NUMBER
    
OUTPUT: 
    MOV AL, 00000001B
    MOV DX, 200H    ;ѡ�е�4�������
    OUT DX, AL    
    MOV BL, SEC2    ;���SEC2
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S4:
    LOOP S4
    
    MOV AL, 00000010B
    MOV DX, 200H    ;ѡ�е�3�������
    OUT DX, AL              
    MOV BL, SEC1
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S3:
    LOOP S3
    
    MOV AL, 00000100B
    MOV DX, 200H    ;ѡ�е�2�������
    OUT DX, AL              
    MOV BL, MIN2
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S2:
    LOOP S2
    
    MOV AL, 00001000B
    MOV DX, 200H    ;ѡ�е�3�������
    OUT DX, AL              
    MOV BL, MIN1
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S1:
    LOOP S1      
    ;�ĸ��������ʾ�������ж�C�˿�״̬
    MOV DX, 204H
    IN AL, DX
    CMP AL, 06H
    JE STOP    ;STOP��ͣ��ʱ
    CMP AL, 03H 
    JE TAIL1   ;CLEAR�����ʱ
   
    ;û�а��������߰���STRAT�������������ж��Ƿ��λ
    INC SEC2                            
    CMP SEC2, 10
    JNZ OUTPUT
    
    ;SEC2 = 10,��λ
    MOV SEC2, 0H
    INC SEC1
    CMP SEC1, 10
    JNZ OUTPUT
    
    ;SEC1 = 10,��λ
    MOV SEC1, 0H
    INC MIN2
    CMP MIN2, 10
    JNZ OUTPUT
    
    ;MIN2 = 10, ��λ
    MOV MIN2, 0H
    INC MIN1
    CMP MIN1, 10
    JNZ OUTPUT
    
    ;MIN1 = 10,����
    MOV MIN1, 0H
    JMP OUTPUT

STOP:
    MOV AL, 00000001B
    MOV DX, 200H    ;ѡ�е�4�������
    OUT DX, AL          
    MOV BL, SEC2
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S8:
    LOOP S8
    
    MOV AL, 00000010B
    MOV DX, 200H    ;ѡ�е�3�������
    OUT DX, AL          
    MOV BL, SEC1
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S7:
    LOOP S7
    
    MOV AL, 00000100B
    MOV DX, 200H    ;ѡ�е�2�������
    OUT DX, AL          
    MOV BL, MIN2
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S6:
    LOOP S6
    
    MOV AL, 00001000B
    MOV DX, 200H    ;ѡ�е�1�������
    OUT DX, AL          
    MOV BL, MIN1
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S5:
    LOOP S5 
    ; �ж��Ǽ�����ʱ����ͣ��������
    MOV DX, 204H
    IN AL, DX
    CMP AL, 05H ;START��������
    JE  OUTPUT
    CMP AL, 03H ;CLEAR��������
    JE TAIL2
    JMP STOP

TAIL1:
    CALL ZERO
    JMP OUTPUT     
TAIL2:
    CALL ZERO
    JMP STOP    
ZERO PROC
    MOV SEC2, 0H
    MOV SEC1, 0H
    MOV MIN1, 0H
    MOV MIN2, 0H
    RET
ZERO ENDP
CODE ENDS
END START