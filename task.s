.section .bss
.global task0_state
.global task1_state
.global task2_state
.global task3_state
.global current_task

current_task:
	.skip 8
	
task0_state:
	.skip 264

task1_state:
	.skip 264

task2_state: 
	.skip 264

task3_state:
	.skip 264

.section .text
.global task0_loop
.global task_init

task_init:
    la t0, task0_state
    li t2, 0
    sd t2, 0(t0)
    sd t2, 8(t0)
    sd t2, 16(t0)
    sd t2, 24(t0)
    sd t2, 32(t0)
    sd t2, 40(t0)
    la t1, _task0_stack_top
    sd t1, 224(t0)
    la t1, task0_loop
    sd t1, 232(t0)

    la t0, task1_state
    li t2, 0
    sd t2, 0(t0)
    sd t2, 8(t0)
    sd t2, 16(t0)
    sd t2, 24(t0)
    sd t2, 32(t0)
    sd t2, 40(t0)
    la t1, _task1_stack_top
    sd t1, 224(t0)
    la t1, task1_loop
    sd t1, 232(t0)

    la t0, task2_state
    li t2, 0
    sd t2, 0(t0)
    sd t2, 8(t0)
    sd t2, 16(t0)
    sd t2, 24(t0)
    sd t2, 32(t0)
    sd t2, 40(t0)
    la t1, _task2_stack_top
    sd t1, 224(t0)
    la t1, task2_loop
    sd t1, 232(t0)

    la t0, task3_state
    li t2, 0
    sd t2, 0(t0)
    sd t2, 8(t0)
    sd t2, 16(t0)
    sd t2, 24(t0)
    sd t2, 32(t0)
    sd t2, 40(t0)
    la t1, _task3_stack_top
    sd t1, 224(t0)
    la t1, task3_loop
    sd t1, 232(t0)
    ret
	

#task0
task0_loop:
	la a0, task0_msg
	call uart_puts
	j task0_loop

#task1
task1_loop:
	la a0, task1_msg
	call uart_puts
	j task1_loop

#task2
task2_loop:
	la a0, task2_msg
	call uart_puts
	j task2_loop

#task3
task3_loop:
	la a0, task3_msg
	call uart_puts
	j task3_loop


.section .data
task0_msg:
	.asciz "Task 0's Turn.\n"
task1_msg:
	.asciz "Task 1's Turn.\n"
task2_msg:
	.asciz "Task 2's Turn.\n"
task3_msg:
	.asciz "Task 3's Turn.\n"
