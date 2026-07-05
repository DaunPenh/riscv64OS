ENTRY(_start)
SECTIONS {
    . = 0x80000000;

    .text : {
        *(.text.boot)
        *(.text*)
    }

    .rodata : { *(.rodata*) }

    .data : { *(.data*) }

    _bss_start = .;
    .bss : {
        *(.bss*)
    }
    _bss_end = .;

    . = . + 0x8000;
    _stack_top = .;
}

