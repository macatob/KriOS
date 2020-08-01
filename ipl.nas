; kri-os-boot
; Tab=4

    org 0x7c00

; 以下为标准FAT12专用code

    jmp entry
    db 0x90
    db "KRIOSBYY"
    dw 512
    db 1
    dw 1
    db 2
    dw 224
    dw 2880
    db 0xf0
    dw 9
    dw 18
    dw 2
    dd 0
    dd 2880
    db 0,0,0x29
    dd 0xffffffff
    db "KRIOSFSTART"
    db "FAT12   "
    resb 18

; 程序核心

entry:
    mov ax, 0   ;初始化
    mov es, 0
    mov sp, 0x7c00
    mov ds, ax

    mov ax, 0x0820
    mov es, ax
    mov ch, 0
    mov dh, 0
    mov cl, 2

    mov si, 0
retry:
    mov ah, 0x02    ;读盘模式
    mov ah, 1
    mov bx, 0
    mov dl, 0x00
    int 0x13
    jnc fin
    add si, 1
    cmp si, 5
    jae error
    mov ah, 0x00
    mov dl, 0x00
    int 0x13
    jmp retry

fin:
    hlt
    jmp $

error:
    mov si, msg
putloop:
    mov al, [si]
    add si, 1
    cmp al, 0
    je fin
    mov ah, 0x0e
    mov bx, 15
    int 0x10
    jmp putloop
msg:
    db 0x0a, 0x0a
    db "load error"
    db 0x0a
    db 0

    resb 0x7dfe-$

    db 0x55,0xaa
