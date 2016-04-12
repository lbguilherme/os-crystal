ENTRY(__entry)

SECTIONS {
    . = 0x00100000;

    .stack ALIGN (0x1000): {
      . += 0x1000;  /* 4KB */
    }

    .text ALIGN (0x1000): {
        FILL(0x02B0AD1B); . += 4;
        FILL(0x03000000); . += 4;
        FILL(0xFB4F52E4); . += 4;
        FILL(0x90);
        *(.text)
    }
}
