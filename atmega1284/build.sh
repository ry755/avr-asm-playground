#!/bin/bash

set -e

mkdir -p build
cd build

avr-gcc -mmcu=atmega1284p -o $1.elf ../$1.S
avr-objcopy -O ihex $1.elf $1.hex
avrdude -p atmega1284p -b 115200 -c avrisp -P /dev/ttyACM0 -U flash:w:$1.hex
