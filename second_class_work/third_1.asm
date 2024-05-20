.MODEL SMALL
.STACK 100H
.DATA
    BUF  DB 32H, 78H, 54H, 00H, 0F8H, 87H, 37H, 89H, 28H, 0F1H
.CODE
    START:     
               MOV AX, @DATA
               MOV DS, AX
               MOV ES, AX

    ; 初始化外层循环计数器
               MOV CX, 9            ; 外循环计数器，10个数据-1

    OUTER_LOOP:
               MOV SI, 0            ; 内循环指针初始化
               MOV DI, CX           ; 内循环计数器

    INNER_LOOP:
               MOV AL, BUF[SI]      ; 取第一个数据
               MOV BL, BUF[SI+1]    ; 取第二个数据
               CMP AL, BL           ; 比较两个数据
               JBE NO_SWAP          ; 如果前一个小于等于后一个，跳转
    ; 交换两个数据
               MOV BUF[SI], BL
               MOV BUF[SI+1], AL

    NO_SWAP:   
               INC SI               ; 移动到下一个数据
               DEC DI               ; 内循环计数器减1
               JNZ INNER_LOOP       ; 如果内循环未结束，继续

               DEC CX               ; 外循环计数器减1
               JNZ OUTER_LOOP       ; 如果外循环未结束，继续

    ; 程序结束，返回到DOS
               MOV AH, 4CH
               INT 21H
END START
