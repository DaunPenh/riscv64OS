.equ SYS_YIELD, 0
.equ SYS_EXIT, 1
.equ SYS_GETPID, 2

.section .text

.global task0_entry
.global task1_entry
.global task2_entry

task0_entry:
    la a0, taskA
    call uart_puts
    li a7, SYS_YIELD
    ecall
    j task0_entry

task1_entry:
    li s0, 0

task1_body:
    la a0, taskB
    call uart_puts
    addi s0, s0, 1
    li t0, 5
    beq s0, t0, task1_done
    j task1_body

task1_done:
    li a7, SYS_EXIT
    ecall

task2_entry:
    li a7, SYS_GETPID
    ecall
    addi a0, a0, '0'
    call uart_putc
    j task2_entry

.section .bss
.align 4

.global task0_stack_top
.global task1_stack_top
.global task2_stack_top

task0_stack_bottom: .space 2048
task0_stack_top:

task1_stack_bottom: .space 2048
task1_stack_top:

task2_stack_bottom: .space 2048
task2_stack_top:

.section .rodata
taskA:
    .asciz "Task A\n"

taskB:
    .asciz "Task B\n"
newline:
	.asciz "\n"
