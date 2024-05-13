DATA SEGMENT
    score       DB  88          ; 假设成绩为88
    excellent   DB  'Excellent$'
    medium      DB  'Medium level$'
    pass        DB  'Pass$'
    failure     DB  'Failure$'
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA   ; 告诉汇编器代码段和数据段的寄存器

START:
    ; 初始化数据段
    MOV AX, DATA
    MOV DS, AX

    ; 加载成绩到寄存器AL
    MOV AL, score

    ; 检查是否优秀
    CMP AL, 85
    JAE IsExcellent
    CMP AL, 70
    JAE IsMedium
    CMP AL, 60
    JAE IsPass
    JMP IsFailure

IsExcellent:
    LEA DX, excellent
    JMP DisplayMessage

IsMedium:
    LEA DX, medium
    JMP DisplayMessage

IsPass:
    LEA DX, pass
    JMP DisplayMessage

IsFailure:
    LEA DX, failure

DisplayMessage:
    ; 使用DOS中断来显示消息
    MOV AH, 09h
    INT 21h

    ; 结束程序
    MOV AH, 4Ch
    INT 21h

CODE ENDS
    END START
