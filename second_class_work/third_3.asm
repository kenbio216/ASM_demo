DATAS SEGMENT
    DIGIT DB 100 DUP(?)
DATAS ENDS
CODE SEGMENT
             ASSUME CS:CODE,DS:DATAS
    START:   
             MOV    AX,DATAS
             MOV    DS,AX
             MOV    DI,0
             MOV    AX,0
             MOV    SI,4
             MOV    BX,10
             MOV    CX,101

    LOOP_XY1:                           ;得到100位数字相加的和
             ADD    AX,DI
             INC    DI
             LOOP   LOOP_XY1

    LOOP_XY2:                           ;通过除法取余，来把5050转换成字符串
             XOR    DX,DX
             DIV    BX
             ADD    DL,'0'
             MOV    DIGIT[SI], DL
             DEC    SI
             CMP    AX, 0
             JNE    LOOP_XY2

    D1:                                 ;准备输出5位数字
             MOV    SI,0
             MOV    CX,5

    OUTPUT:  
             MOV    DL,DIGIT[SI]
             MOV    AH,2
             INT    21H

    NEXT:    
             INC    SI
             LOOP   OUTPUT
             MOV    AH,4CH
             INT    21H
CODE ENDS
END START