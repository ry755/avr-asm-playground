#include <avr/io.h>

    .section .text
    .global main
main:
    ; once we get here then the world has been set up for us

    ; zero the vram
    call ClearVram

    ; set the pointer to the font table
    ldi r25, hi8(font)
    ldi r24, lo8(font)
    call SetFontTable

    ; print a string at (1, 1)
    ldi r24, 1 ; X position
    ldi r22, 1 ; Y position
    ldi r21, hi8(string)
    ldi r20, lo8(string)
    call Print

loop:
    rjmp loop

font:
    .incbin "font.bin"

string: .asciz "hello uzebox world :3"
