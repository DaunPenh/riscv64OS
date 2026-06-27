.section .text

.global _start
.global system_hang

_start:
	la sp, _stack_top
	la t6, trap_handler
	csrw mtvec, t6

	#intentional error
	.word 0x00000000

call_loop:
	call uart_getc
	call uart_putc
	j call_loop

system_hang:
	j system_hang
	
