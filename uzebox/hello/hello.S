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

    ; set a font tile at (1, 1)
    ldi r24, 1   ; X position
    ldi r22, 1   ; Y position
    ldi r20, 'a' ; character
    call SetFont

loop:
    rjmp loop

font:
    .skip 32 * 6 * 8
    .incbin "font.bin"
