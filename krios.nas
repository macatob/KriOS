;krios
;tab=4

;boot_info
CYLS    equ 0x0ff0  ;设定启动区
LEDS    equ 0x0ff1
VMODE   equ 0x0ff4
SCRNX   equ 0x0ff4  ;screen x
SCRNY   equ 0x0ff8  ;screen y
VRAM    equ 0x0ff8  ;图像缓冲区

    org 0xc200
    
    mov al, 0x13
    mov ah, 0x00
    int 0x10
    mov byte[VMODE], 8 ;记录画面模式
    mov word[SCRNX], 320
    mov word[SCRNY], 200
    mov dword[VRAM], 0x000a0000

;查询键盘LED灯的state
    mov ah, 0x02
    int 0x16    ;keyboard BIOS
    mov [LEDS], al
fin:
    hlt
    jmp fin