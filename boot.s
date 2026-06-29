.section .text

.global _start
.global system_hang

_start:
	la sp, _stack_top
	la t6, trap_handler
	csrw mtvec, t6

	la t0, _bss_start
	la t1, _bss_end
	
zero_bss:
	bge t0, t1, zero_bss_done
	sd zero, 0(t0)
	addi t0, t0, 8
	j zero_bss
	
zero_bss_done:

	call clint_init
	call clint_enable
	call task_init

	la sp, _task0_stack_top
	j task0_loop

call_loop: 
 	call uart_getc 
 	call uart_putc 
 	j call_loop

system_hang:
	j system_hang
