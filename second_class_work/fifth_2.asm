DATAS SEGMENT
    SCORES              DW 70,69,58,99,88,91,56,74,92,94
    EXCELLENT_COUNT     DW 0
    BELOW_AVERAGE_COUNT DW 0
    MSG_EXCELLENT       DB 'the excellent: $'
    MSG_AVERAGE         DB 'the everage score: $'
    MSG_BELOW_AVERAGE   DB 'below everage: $'
    AVERAGE_SCORE       DW 0
DATAS ENDS

CODE SEGMENT
                                 ASSUME CS:CODE, DS:DATAS

    START:                       
                                 MOV    AX, DATAS
                                 MOV    DS, AX
                                 MOV    CX, 10
                                 MOV    BX, 0
                                 MOV    AX, 0


    JISUAN_SCORE:                
                                 ADD    AX, SCORES[BX]
                                 ADD    BX, 2                           ;加2个字节
                                 LOOP   JISUAN_SCORE

                                 MOV    CX, 10
                                 XOR    DX, DX
                                 DIV    CX
                                 MOV    AVERAGE_SCORE, AX               ;把结果存入变量

                                 MOV    CX, 10
                                 MOV    BX, 0

    CALC_EXCELLENT_BELOW_AVERAGE:
                                 MOV    AX, SCORES[BX]
                                 CMP    AX, 90
                                 JAE    IS_EXCELLENT
                                 CMP    AX, AVERAGE_SCORE
                                 JB     IS_BELOW_AVERAGE
                                 JMP    NEXT_STUDENT

    IS_EXCELLENT:                
                                 INC    EXCELLENT_COUNT
                                 JMP    NEXT_STUDENT

    IS_BELOW_AVERAGE:            
                                 INC    BELOW_AVERAGE_COUNT

    NEXT_STUDENT:                
                                 ADD    BX, 2                           ;下一个分数
                                 LOOP   CALC_EXCELLENT_BELOW_AVERAGE    ;重新开始比较每一位学生的分数

                                 MOV    DX,OFFSET MSG_EXCELLENT         ;准备输出分数和人数
                                 MOV    AH, 9
                                 INT    21H
                                 MOV    AX, EXCELLENT_COUNT
                                 CALL   PRINT_NUM

                                 MOV    DX,OFFSET MSG_AVERAGE
                                 MOV    AH, 9
                                 INT    21H
                                 MOV    AX, AVERAGE_SCORE
                                 CALL   PRINT_NUM

                                 MOV    DX,OFFSET MSG_BELOW_AVERAGE
                                 MOV    AH, 9
                                 INT    21H
                                 MOV    AX, BELOW_AVERAGE_COUNT
                                 CALL   PRINT_NUM

                                 MOV    AH, 4CH
                                 INT    21H

PRINT_NUM PROC
                                 PUSH   AX
                                 PUSH   BX
                                 PUSH   CX
                                 PUSH   DX

                                 XOR    CX, CX
                                 MOV    BX, 10

    PRINT_NUM_LOOP:              
                                 XOR    DX, DX
                                 DIV    BX
                                 PUSH   DX
                                 INC    CX
                                 OR     AX, AX
                                 JNE    PRINT_NUM_LOOP

    PRINT_NUM_PRINT:             
                                 POP    AX
                                 ADD    AL, '0'
                                 MOV    DL, AL
                                 MOV    AH, 2
                                 INT    21H
                                 LOOP   PRINT_NUM_PRINT

                                 POP    DX
                                 POP    CX
                                 POP    BX
                                 POP    AX
                                 RET
PRINT_NUM ENDP

CODE ENDS
END START
