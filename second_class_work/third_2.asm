DATAS SEGMENT
    STRING1 DB 'Please input a string $'
    BUFF    DB 100
            DB ?
            DB 100 DUP(?)
    NEWSTR  DB 100 DUP(?)
DATAS ENDS
CODES SEGMENT
            ASSUME CS:CODES,DS:DATAS
    START:  
            MOV    AX,DATAS
            MOV    DS,AX
            MOV    DX,OFFSET STRING1
            MOV    AH,09H               ;9号调用输出字符串
            INT    21H
            MOV    DX,OFFSET BUFF
            MOV    AH,0AH               ;10号调用输入字符串
            INT    21H
            LEA    BX,BUFF
            INC    BX
            MOV    CL,[BX]              ;把字符串的实际长度存入CL寄存器
            MOV    CH,0
            INC    BX
            MOV    DI,OFFSET NEWSTR
            MOV    DL,0DH               ;输出回车符
            MOV    AH,6
            INT    21H
            MOV    DL,0AH               ;输出一个换行符
            INT    21H
    LOOP_XY:
            MOV    AL,[BX]
            CMP    AL,'*'
            JZ     NEXT
            MOV    [DI],AL
            MOV    DL,AL
            MOV    AH,6
            INT    21H
    NEXT:   
            INC    BX                   ;BX是原字符串的指针
            DEC    CX                   ;CX是新字符串的指针
            JNZ    LOOP_XY
            MOV    AH,4CH
            INT    21H
CODES ENDS
    END START
