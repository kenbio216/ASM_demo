DATA SEGMENT
    DIGIT_MSG  DB 'DIGIT$'
    CHAR_MSG   DB 'CHAR$'
    OTHER_MSG  DB 'OTHER$'
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA   ; 告诉汇编器代码段和数据段的寄存器

START:
    ; 初始化数据段
    MOV AX, DATA
    MOV DS, AX

    ; 从键盘读取一个字符
    MOV AH, 01h
    INT 21h           ; AL现在包含输入的字符

    ; 检查字符是否为数字 (0-9)
    CMP AL, '0'
    JL NotDigit
    CMP AL, '9'
    JG NotDigit
    LEA DX, DIGIT_MSG
    JMP DisplayMessage

NotDigit:
    ; 检查字符是否为英文字母 (A-Z, a-z)
    CMP AL, 'A'
    JL NotChar
    CMP AL, 'Z'
    JG CheckLower
    LEA DX, CHAR_MSG
    JMP DisplayMessage

CheckLower:
    CMP AL, 'a'
    JL NotChar
    CMP AL, 'z'
    JG NotChar
    LEA DX, CHAR_MSG
    JMP DisplayMessage

NotChar:
    ; 如果既不是数字也不是字母
    LEA DX, OTHER_MSG

DisplayMessage:
    ; 使用DOS中断来显示消息
    MOV AH, 09h
    INT 21h

    ; 结束程序
    MOV AH, 4Ch
    INT 21h

CODE ENDS
    END START
