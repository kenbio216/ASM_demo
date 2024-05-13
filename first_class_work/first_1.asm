DATAS SEGMENT
    LED   DB 3fh,06h,5bh,4fh,66h,6dh,7dh,07h,7fh,6fh
DATAS ENDS
CODES SEGMENT
          ASSUME CS:CODES, DS:DATAS
    START:
          MOV    AX,DATAS
          MOV    DS,AX
          LEA    BX,LED
          MOV    AL,3
          XLAT
          MOV    DL,AL
          MOV    AH,4CH
          INT    21H
CODES ENDS
END START