; https://ww1.microchip.com/downloads/en/DeviceDoc/doc8059.pdf
; see page 133 for timer registers

#include <avr/io.h>

    .section .text
    .global main
main:
    ldi r16, hi8(RAMEND)
    sts SPH, r16
    ldi r16, lo8(RAMEND)
    sts SPL, r16

    ; set PORTA as all outputs
    ldi r16, 0b11111111
    sts DDRA, r16
    ; set initial PORTA value to be toggled later
    ldi r16, 0b00000001
    sts PORTA, r16

    ; don't output timer pulse on pins, and disable waveform generation mode
    ldi r16, 0b00000000
    sts TCCR1A, r16
    ; disable noise canceler, use CTC mode, use clk/1024 from prescaler
    ldi r16, 0b00001101
    sts TCCR1B, r16
    ; enable output compare A match interrupt
    ldi r16, 0b00000010
    sts TIMSK1, r16
    ; set OCR1A to 0x02FF
    ; the high byte must be written first when writing
    ; the low byte must be read first when reading
    ; the value of TCNT1 will always be compared against this value
    ldi r16, 0x02
    sts OCR1AH, r16
    ldi r16, 0xFF
    sts OCR1AL, r16
    ; enable interrupts and hope you set the registers correctly
    sei

loop:
    ; endless loop, don't do anything outside of interrupts
    rjmp loop

    .global TIMER1_COMPA_vect
TIMER1_COMPA_vect:
    ; called when TCNT1 equals OCR1A
    ; toggle PA0 and PA1
    ldi r16, 0b00000011
    sts PINA, r16
    reti