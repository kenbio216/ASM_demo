DATA SEGMENT
    SCORE    DB 75            ; 定义一个字节的变量SCORE，假设考试分数为75
    PASS_MSG DB 'PASS$'       ; 定义PASS消息
    FAIL_MSG DB 'FAILURE$'    ; 定义FAILURE消息
DATA ENDS

CODE SEGMENT
             ASSUME CS:CODE, DS:DATA    ; 告诉汇编器代码段和数据段的寄存器

    START:   
    ; 初始化数据段
             MOV    AX, DATA
             MOV    DS, AX

    ; 加载分数到寄存器AL
             MOV    AL, SCORE

    ; 检查分数是否>=60
             CMP    AL, 60
             JGE    PASSCODE            ; 如果大于等于60, 跳转到PASSCODE

    ; 如果分数小于60
             LEA    DX, FAIL_MSG        ; 加载FAILURE消息的地址到DX
             JMP    DISPLAY             ; 跳转到显示消息的代码部分

    PASSCODE:
             LEA    DX, PASS_MSG        ; 加载PASS消息的地址到DX

    DISPLAY: 
    ; 使用DOS中断来显示消息
             MOV    AH, 09h
             INT    21h

    ; 结束程序
             MOV    AH, 4Ch
             INT    21h

CODE ENDS
    END START
