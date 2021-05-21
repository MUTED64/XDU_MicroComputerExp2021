ASSUME CS:CODE, DS:DATA, SS:STACK

data segment
    msg db "this is first ASM program-Liu Youran$"     
ends

stack segment
    dw   128  dup(0)
ends

code segment     
start:
MOV AX, data
MOV ES, AX 
MOV AX, 1000H
MOV DS, AX
MOV BX, 0000H
MOV CX,40 

move:
   MOV AH,ES:[BX] 
   MOV [BX],AH   
   MOV AH,[BX]
   MOV [BX+0100H],AH  
   ADD BX, 01H
loop move
MOV AH, 9
INT 21H
MOV AH, 4CH
INT 21H
ends
end start
