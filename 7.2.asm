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
    MOV DX, 206H  ;初始化
    OUT DX, AL    ;A,B输出，C输入
    MOV BX, 0H  
    LEA SI, NUMBER
    
OUTPUT: 
    MOV AL, 00000001B
    MOV DX, 200H    ;选中第4个数码管
    OUT DX, AL    
    MOV BL, SEC2    ;输出SEC2
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S4:
    LOOP S4
    
    MOV AL, 00000010B
    MOV DX, 200H    ;选中第3个数码管
    OUT DX, AL              
    MOV BL, SEC1
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S3:
    LOOP S3
    
    MOV AL, 00000100B
    MOV DX, 200H    ;选中第2个数码管
    OUT DX, AL              
    MOV BL, MIN2
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S2:
    LOOP S2
    
    MOV AL, 00001000B
    MOV DX, 200H    ;选中第3个数码管
    OUT DX, AL              
    MOV BL, MIN1
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S1:
    LOOP S1      
    ;四个数码管显示结束，判断C端口状态
    MOV DX, 204H
    IN AL, DX
    CMP AL, 06H
    JE STOP    ;STOP暂停计时
    CMP AL, 03H 
    JE TAIL1   ;CLEAR清零计时
   
    ;没有按按键或者按了STRAT，增加秒数并判断是否进位
    INC SEC2                            
    CMP SEC2, 10
    JNZ OUTPUT
    
    ;SEC2 = 10,进位
    MOV SEC2, 0H
    INC SEC1
    CMP SEC1, 10
    JNZ OUTPUT
    
    ;SEC1 = 10,进位
    MOV SEC1, 0H
    INC MIN2
    CMP MIN2, 10
    JNZ OUTPUT
    
    ;MIN2 = 10, 进位
    MOV MIN2, 0H
    INC MIN1
    CMP MIN1, 10
    JNZ OUTPUT
    
    ;MIN1 = 10,清零
    MOV MIN1, 0H
    JMP OUTPUT

STOP:
    MOV AL, 00000001B
    MOV DX, 200H    ;选中第4个数码管
    OUT DX, AL          
    MOV BL, SEC2
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S8:
    LOOP S8
    
    MOV AL, 00000010B
    MOV DX, 200H    ;选中第3个数码管
    OUT DX, AL          
    MOV BL, SEC1
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S7:
    LOOP S7
    
    MOV AL, 00000100B
    MOV DX, 200H    ;选中第2个数码管
    OUT DX, AL          
    MOV BL, MIN2
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S6:
    LOOP S6
    
    MOV AL, 00001000B
    MOV DX, 200H    ;选中第1个数码管
    OUT DX, AL          
    MOV BL, MIN1
    MOV AL, [SI+BX]
    MOV DX, 202H
    OUT DX, AL
    MOV CX, CIR
S5:
    LOOP S5 
    ; 判断是继续计时、暂停还是清零
    MOV DX, 204H
    IN AL, DX
    CMP AL, 05H ;START按键按下
    JE  OUTPUT
    CMP AL, 03H ;CLEAR按键按下
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