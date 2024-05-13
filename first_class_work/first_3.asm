DATA SEGMENT
    number DB 6    ; 定义一个字节，初始化为6
DATA ENDS

CODE SEGMENT
          ASSUME CS:CODE, DS:DATA    ; 告诉汇编器代码段和数据段的寄存器

    START:
    ; 初始化数据段
          MOV    AX, DATA
          MOV    DS, AX

    ; 获取数字
          MOV    AL, number

    ; 转换十位
          MOV    AH, 0               ; 清空AH寄存器以准备除法操作
          MOV    CL, 10              ; 设置除数为10
          DIV    CL                  ; AL = AL / 10 (商), AH = AL % 10 (余数)
          MOV    BL, AH              ; 将余数（个位）移入BL
          ADD    AL, '0'             ; 转换十位为ASCII字符
          MOV    DL, AL              ; 准备输出十位
          MOV    AH, 02h             ; 设置DOS中断的输出功能
          INT    21h                 ; 调用DOS中断来输出字符

    ; 转换个位
          MOV    DL, BL
          ADD    DL, '0'             ; 将个位转换为ASCII字符
          MOV    AH, 02h
          INT    21h                 ; 再次调用DOS中断输出字符

    ; 输出换行
          MOV    DL, 0Dh             ; 回车符
          INT    21h
          MOV    DL, 0Ah             ; 换行符
          INT    21h

    ; 结束程序
          MOV    AH, 4Ch
          INT    21h

CODE ENDS
    END START
