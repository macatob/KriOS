; kri-os
; Tab=4

    ORG 0x7c00

; 以下为标准FAT12专用code

    JMP entry
    DB 0x90
    DB "HELLOKRI"
    DW 512
    DB 1
    DW 1
    DB 2
    DW 224
    DW 2880
    DB 0xf0
    DW 9
    DW 18
    DW 2
    DD 0
    DD 2880
    DB 0,0,0X29
    DD 0xffffffff
    DB "KRIOSBOOT  "
    DB "FAT12   "
    RESB 18

; 程序核心

entry:
    MOV AX,0
    MOV SS,AX
    MOV SP,0x7c00
    MOV DS,AX
    MOV ES,AX

    MOV SI,meg
putloop:
    MOV AL,[SI]
    ADD SI,1
    CMP AL,0

    JE fin
    MOV AH,0x0e
    MOV BX,15
    INT 0x10
    JMP putloop
fin:
    HLT
    JMP fin

msg:
    DB 0x0A, 0x0a
    DB "Hello,world"
    DB 0x0a
    DB 0