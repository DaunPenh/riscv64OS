ENTRY(_start)
SECTIONS {
    . = 0x80000000;
    .text : { *(.text.boot) *(.text*) }
    .rodata : { *(.rodata*) }
    .data : { *(.data*) }
    _bss_start = .;
    .bss : { *(.bss*) }
    _bss_end = .;
    . = . + 0x800;
    _stack_top = .;
    . = . + 0x800;
	_task0_stack_top = .;
	. = . + 0x800;
	_task1_stack_top = .;
	. = . + 0x800;
	_task2_stack_top = .;
	. = . + 0x800;
	_task3_stack_top = .;
}

