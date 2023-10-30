#include <avr/io.h>

    .section .text
    .global main
main:
    ; set PORTA as all outputs
    ldi r16, 0b11111111
    out _SFR_IO_ADDR(DDRA), r16

    ldi r16, 0b00000001

loop:
    out _SFR_IO_ADDR(PORTA), r16

    clc
    sbrc r16, 7
    sec
    rol r16

    ldi ZH, 0x01
    ldi ZL, 0xFF
delay_outer:
    ldi r17, 0xFF
delay_inner:
    dec r17
    cpi r17, 0
    brne delay_inner
    sbiw Z, 1
    cpi ZH, 0
    brne delay_outer
    cpi ZL, 0
    brne delay_outer

    rjmp loop