DATA SEGMENT
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE,DS:DATA
start:
    MOV AX,DATA    ; 将DATA段地址加载到AX
    MOV DS,AX      ; 将DS段寄存器指向DATA段

    ; 初始化寄存器值
    MOV DX,0DEF0H  ; 初始化DX为0DEF0H
    MOV AX,11B5H   ; 初始化AX为11B5H
    MOV CX,884FH   ; 初始化CX为884FH
    MOV BX,267EH   ; 初始化BX为267EH

    ; 将AX和CX相加，结果存储在AX中
    ADD AX,CX      ; AX = AX + CX
    ADC DX,BX      ; DX = DX + BX + 进位（如果有）

    ; 结束程序
    MOV AX,4C00H   ; 退出代码
    INT 21H        ; 调用DOS中断

CODE ENDS
END start
