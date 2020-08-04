; asmlib
; tab=4

[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[BITS 32]

[FILE "asmlib.nas"]     ;file name
    GLOBAL _io_hlt, _io_cli, _io_sti, io_stihlt
    GLOBAL _io_in8, _io_in16, _in_in32
    GLOBAL _io_out8, _io_out16, _io_out32
    GLOBAL _io_load_eflags, _io_store_eflags

[SECTION .text]

_io_hlt:    ;void io_hlt(void)
    hlt
    ret

_io_cli:    ;void io_cli(void)
    cli
    ret
    
_io_sti:    ;void io_sti(void)
    sti
    ret

_io_stihlt:    ;void io_stihlt(void)
    sti
    hlt
    ret

_io_in8:    ;void io_in8(int port);
    mov edx, [esp+4]    ;port
    mov eax, 0
    in al, dx
    ret

_io_in16:    ;void io_in16(int port);
    mov edx, [esp+4]    ;port
    mov eax, 0
    in ax, dx
    ret

_io_in32:    ;void io_in32(int port);
    mov edx, [esp+4]    ;port
    mov eax, 0
    in eax, dx
    ret

_io_out8:    ;void io_out8(int port, int data);
    mov edx, [esp+4]    ;port
    mov eax, [esp+8]    ;data
    out dx, al
    ret

_io_out16:    ;void io_out16(int port, int data);
    mov edx, [esp+4]    ;port
    mov eax, [esp+8]    ;data
    out dx, ax
    ret

_io_out32:    ;void io_out32(int port, int data);
    mov edx, [esp+4]    ;port
    mov eax, [esp+8]    ;data
    out dx, eax
    ret

_io_load_eflags:    ;void io_load_eflags(void);
    pushfd
    pop eax
    ret
_io_store_eflags:   ;void io_store_eflgas(void);
    mov eax, [esp+4]
    push eax
    popfd
    ret
