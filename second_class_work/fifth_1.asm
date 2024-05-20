DATA SEGMENT
    BUF  DB  32H,78H,54H,0,0F8H,87H,37H,89H,28H,0F1H
    LEN  EQU $-BUF
DATA ENDS
CODE SEGMENT
             ASSUME CS:CODE,DS:DATA
    START:   
             MOV    AX,DATA
             MOV    DS,AX
             MOV    CX,LEN
             LEA    BX,BUF
             DEC    CX
    LOOP_XY1:PUSH   CX
             MOV    SI,BX
    LOOP_XY2:MOV    AL,[SI]
             CMP    AL,[SI+1]
             JBE    NEXT
             XCHG   AL,[SI+1]
             MOV    [SI],AL
    NEXT:    INC    SI
             LOOP   CY2
             POP    CX
             LOOP   LOOP_XY1
             MOV    AH,4CH
             INT    LOOP_XY2
CODE ENDS
    END START