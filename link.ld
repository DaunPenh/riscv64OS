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

    /* Boot / trap scratch stack (32 KB above .bss) */
    . = . + 0x8000;
    _stack_top = .;
}

