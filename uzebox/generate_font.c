#include <stdio.h>

#include "font.h"

void main() {
    FILE *file = fopen("font.bin", "wb");
    fwrite(font, sizeof(char), sizeof(font), file);
    fclose(file);
}
