CODE SEGMENT
   ASSUME CS:CODE
START:        
   MOV AL,90H ;����A����C���
   MOV DX,206H
   OUT DX,AL   
RUN:   
   MOV AL, 0H
   MOV DX, 200H
   IN AL, DX ;�˿�A����
   NOT AL   
   MOV DX, 204H
   OUT DX, AL ;�˿�C���
   JMP RUN
CODE ENDS
END START