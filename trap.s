.section .text
.global trap_handler

.equ FRAME_SIZE, 256

trap_handler:
	addi sp, sp, -FRAME_SIZE
 
    sd ra, 0(sp)
    sd t0, 8(sp)
    sd t1, 16(sp)
    sd t2, 24(sp)
    sd s0, 32(sp)
    sd s1, 40(sp)
    sd a0, 48(sp)
    sd a1, 56(sp)
    sd a2, 64(sp)
    sd a3, 72(sp)
    sd a4, 80(sp)
    sd a5, 88(sp)
    sd a6, 96(sp)
    sd a7, 104(sp)
    sd s2, 112(sp)
    sd s3, 120(sp)
    sd s4, 128(sp)
    sd s5, 136(sp)
    sd s6, 144(sp)
    sd s7, 152(sp)
    sd s8, 160(sp)
    sd s9, 168(sp)
    sd s10, 176(sp)
    sd s11, 184(sp)
    sd t3, 192(sp)
    sd t4, 200(sp)
    sd t5, 208(sp)
    sd t6, 216(sp)
	
    csrr t6, mcause

	li t1, 2
	beq t6, t1, handle_illegal

	li t1, 11
	beq t6, t1, handle_ecall

	li t1, 0x8000000000000007
	beq t6, t1, handle_timer

	j handle_unknown


handle_unknown:
	la a0, msg
	call uart_puts

    csrr a0, mcause
    call uart_puthex

    la a0, newline
    call uart_puts

    csrr a0, mepc
    call uart_puthex

    la a0, newline
    call uart_puts

    csrr a0, mtval
    call uart_puthex

    la a0, newline
    call uart_puts

    la a0, ct_label
    call uart_puts
    la t0, current_task
    ld a0, 0(t0)
    call uart_puthex

    j system_hang

handle_illegal: 
	la a0, illegal
	call uart_puts
	j system_hang

handle_timer:
	la a0, timer
	call uart_puts
	call clint_init

	la t0, current_task
	ld t1, 0(t0)
	mv s0, t1 

	li t2, 264
	mul t1, t1, t2
	la t3, task0_state
	add t3, t3, t1

	ld t4, 0(sp)
    sd t4, 0(t3)
    ld t4, 8(sp)
    sd t4, 8(t3)
    ld t4, 16(sp)
    sd t4, 16(t3)
    ld t4, 24(sp)
    sd t4, 24(t3)
    ld t4, 32(sp)
    sd t4, 32(t3)
    ld t4, 40(sp)
    sd t4, 40(t3)
    ld t4, 48(sp)
    sd t4, 48(t3)
    ld t4, 56(sp)
    sd t4, 56(t3)
    ld t4, 64(sp)
    sd t4, 64(t3)
    ld t4, 72(sp)
    sd t4, 72(t3)
    ld t4, 80(sp)
    sd t4, 80(t3)
    ld t4, 88(sp)
    sd t4, 88(t3)
    ld t4, 96(sp)
    sd t4, 96(t3)
    ld t4, 104(sp)
    sd t4, 104(t3)
    ld t4, 112(sp)
    sd t4, 112(t3)
    ld t4, 120(sp)
    sd t4, 120(t3)
    ld t4, 128(sp)
    sd t4, 128(t3)
    ld t4, 136(sp)
    sd t4, 136(t3)
    ld t4, 144(sp)
    sd t4, 144(t3)
    ld t4, 152(sp)
    sd t4, 152(t3)
    ld t4, 160(sp)
    sd t4, 160(t3)
    ld t4, 168(sp)
    sd t4, 168(t3)
    ld t4, 176(sp)
    sd t4, 176(t3)
    ld t4, 184(sp)
    sd t4, 184(t3)
    ld t4, 192(sp)
    sd t4, 192(t3)
    ld t4, 200(sp)
    sd t4, 200(t3)
    ld t4, 208(sp)
    sd t4, 208(t3)
    ld t4, 216(sp)
    sd t4, 216(t3)

	mv t4, sp
	addi t4, t4, 256
	sd t4, 224(t3)

	csrr t4, mepc
	sd t4, 232(t3)

increment_current_task:
	addi s0, s0, 1
	li t2, 4
	beq s0, t2, wrap_to_zero
	j current_task_done
	
wrap_to_zero:
	li s0, 0
	
current_task_done:
	la t0, current_task
	sd s0, 0(t0)

restore_task:
	li t2, 264
    mul s0, s0, t2
    la t3, task0_state
    add t3, t3, s0

    ld t4, 0(t3)
    sd t4, 0(sp)
    ld t4, 8(t3)
    sd t4, 8(sp)
    ld t4, 16(t3)
    sd t4, 16(sp)
    ld t4, 24(t3)
    sd t4, 24(sp)
    ld t4, 32(t3)
    sd t4, 32(sp)
    ld t4, 40(t3)
    sd t4, 40(sp)
    ld t4, 48(t3)
    sd t4, 48(sp)
    ld t4, 56(t3)
    sd t4, 56(sp)
    ld t4, 64(t3)
    sd t4, 64(sp)
    ld t4, 72(t3)
    sd t4, 72(sp)
    ld t4, 80(t3)
    sd t4, 80(sp)
    ld t4, 88(t3)
    sd t4, 88(sp)
    ld t4, 96(t3)
    sd t4, 96(sp)
    ld t4, 104(t3)
    sd t4, 104(sp)
    ld t4, 112(t3)
    sd t4, 112(sp)
    ld t4, 120(t3)
    sd t4, 120(sp)
    ld t4, 128(t3)
    sd t4, 128(sp)
    ld t4, 136(t3)
    sd t4, 136(sp)
    ld t4, 144(t3)
    sd t4, 144(sp)
    ld t4, 152(t3)
    sd t4, 152(sp)
    ld t4, 160(t3)
    sd t4, 160(sp)
    ld t4, 168(t3)
    sd t4, 168(sp)
    ld t4, 176(t3)
    sd t4, 176(sp)
    ld t4, 184(t3)
    sd t4, 184(sp)
    ld t4, 192(t3)
    sd t4, 192(sp)
    ld t4, 200(t3)
    sd t4, 200(sp)
    ld t4, 208(t3)
    sd t4, 208(sp)
    ld t4, 216(t3)
    sd t4, 216(sp)

    ld t4, 224(t3)
    addi t4, t4, -256
    mv sp, t4

    ld t5, 232(t3)
    csrw mepc, t5

    j reload_stack

handle_ecall:
	la a0, ecall_msg
	call uart_puts
	csrr t1, mepc
	addi t1, t1, 4
	csrw mepc, t1
	j reload_stack
	
reload_stack:	
    ld ra, 0(sp)
    ld t0, 8(sp)
    ld t1, 16(sp)
    ld t2, 24(sp)
    ld s0, 32(sp)
    ld s1, 40(sp)
    ld a0, 48(sp)
    ld a1, 56(sp)
    ld a2, 64(sp)
    ld a3, 72(sp)
    ld a4, 80(sp)
    ld a5, 88(sp)
    ld a6, 96(sp)
    ld a7, 104(sp)
    ld s2, 112(sp)
    ld s3, 120(sp)
    ld s4, 128(sp)
    ld s5, 136(sp)
    ld s6, 144(sp)
    ld s7, 152(sp)
    ld s8, 160(sp)
    ld s9, 168(sp)
    ld s10, 176(sp)
    ld s11, 184(sp)
    ld t3, 192(sp)
    ld t4, 200(sp)
    ld t5, 208(sp)
    ld t6, 216(sp)
 
    addi sp, sp, FRAME_SIZE
    mret


   

.section .data
msg:
	.asciz "Something Happened.\n"

illegal: 
	.asciz "Illegal Command.\n"

ecall_msg:
	.asciz "Environment Call.\n"
timer:
	.asciz "Timer Interrupt.\n"
newline:
	.asciz "\n"
ct_label:
	.asciz "current_task at crash: "
restore_label:
	.asciz "restoring from t3="
restore_ra_label:
	.asciz "saved ra="
save_t0_label:
	.asciz "saving t0="
