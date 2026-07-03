.section .text
.global task0_entry
.global task1_entry
.global task2_entry

task0_entry:
    la a0, taskA
    call uart_puts
    j task0_entry

task1_entry:
    la a0, taskB
    call uart_puts
    j task1_entry

task2_entry:
    la a0, taskC
    call uart_puts
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
taskC: 
	.asciz "Task C\n"
