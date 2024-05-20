DATA SEGMENT
    STRING1 DB 'Please input a string $'    ;输入提示语
    BUFF    DB 100
            DB ?
            DB 100 DUP(?)
DATA ENDS
CODE SEGMENT
          ASSUME CS:CODE, DS:DATA
    START:
          MOV    AX,DATA
          MOV    DS,AX
          MOV    DX,OFFSET STRING1
          MOV    AH,09H
          INT    21H                  ;在显示器上输入提示语
          MOV    DX,OFFSET BUFF
          MOV    AH,0AH
          INT    21H                  ;输入一个字符串
          LEA    SI,BUFF
          INC    SI
          MOV    CL,[SI]              ;记录字符串的长度
          MOV    CH,0
          INC    SI
          MOV    BL,0                 ;BL用于保存统计结果
    LOOP_XY:MOV    AL,[SI]              ;AL寄存器用来暂存字符,方便比较
          CMP    AL,'0'
          JB     NEXT
          CMP    AL,'9'
          JA     NEXT
          INC    BL                   ;确认为数字，BL加1
    NEXT: INC    SI
          DEC    CX
          JNZ    LOOP_XY                ;继续循环
          MOV    DL,0DH               ;输出回车/换行
          MOV    AH,6
          INT    21H
          MOV    DL,0AH
          INT    21H
          CMP    BL,10                ;比较数字的结果是不是大于10，如果大于10则分高低位分别显示
          JB     CHULI
          MOV    BH,0
          MOV    AX,BX
          MOV    CL,10
          DIV    CL
          MOV    BX,AX
          MOV    DL,BL
          ADD    DL,30H
          MOV    AH,6
          INT    21H
          MOV    BL,BH
    CHULI:MOV    DL,BL
          ADD    DL,30H               ;转换为ASCII码
          MOV    AH,6
          INT    21H
          MOV    AH,4CH
          INT    21H
CODE ENDS
       END START
