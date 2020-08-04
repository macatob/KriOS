; asmlib
; tab=4

[FORMAT "WCOFF"]
[BITS 32]

[FILE "asmlib.nas"]     ;file name
    GLOBAL _io_hlt      ;method name

[SECTION .text]

_io_hlt:    ;void io_hlt(void)
    hlt
    ret
