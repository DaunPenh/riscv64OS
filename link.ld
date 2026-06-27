ENTRY(_start)
SECTIONS {
    . = 0x80000000;
    .text : { *(.text.boot) *(.text*) }
    .rodata : { *(.rodata*) }
    .data : { *(.data*) }
    .bss : { *(.bss*) }
    . = . + 0x8000;
    _stack_top = .;
}
