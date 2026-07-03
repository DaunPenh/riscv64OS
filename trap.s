.equ TCB_RA, 0
.equ TCB_SP, 8
.equ TCB_GP, 16
.equ TCB_TP, 24
.equ TCB_T0, 32
.equ TCB_T1, 40
.equ TCB_T2, 48
.equ TCB_S0, 56
.equ TCB_S1, 64
.equ TCB_A0, 72
.equ TCB_A1, 80
.equ TCB_A2, 88
.equ TCB_A3, 96
.equ TCB_A4, 104
.equ TCB_A5, 112
.equ TCB_A6, 120
.equ TCB_A7, 128
.equ TCB_S2, 136
.equ TCB_S3, 144
.equ TCB_S4, 152
.equ TCB_S5, 160
.equ TCB_S6, 168
.equ TCB_S7, 176
.equ TCB_S8, 184
.equ TCB_S9, 192
.equ TCB_S10, 200
.equ TCB_S11, 208
.equ TCB_T3, 216
.equ TCB_T4, 224
.equ TCB_T5, 232
.equ TCB_T6, 240
.equ TCB_MEPC, 248
.equ TCB_MSTATUS, 256

.section .text
.global trap_handler
.balign 4
trap_handler:
    csrrw t6, mscratch, t6
    sd ra, TCB_RA(t6)
    sd sp, TCB_SP(t6)
    sd gp, TCB_GP(t6)
    sd tp, TCB_TP(t6)
    sd t0, TCB_T0(t6)
    sd t1, TCB_T1(t6)
    sd t2, TCB_T2(t6)
    sd s0, TCB_S0(t6)
    sd s1, TCB_S1(t6)
    sd a0, TCB_A0(t6)
    sd a1, TCB_A1(t6)
    sd a2, TCB_A2(t6)
    sd a3, TCB_A3(t6)
    sd a4, TCB_A4(t6)
    sd a5, TCB_A5(t6)
    sd a6, TCB_A6(t6)
    sd a7, TCB_A7(t6)
    sd s2, TCB_S2(t6)
    sd s3, TCB_S3(t6)
    sd s4, TCB_S4(t6)
    sd s5, TCB_S5(t6)
    sd s6, TCB_S6(t6)
    sd s7, TCB_S7(t6)
    sd s8, TCB_S8(t6)
    sd s9, TCB_S9(t6)
    sd s10, TCB_S10(t6)
    sd s11, TCB_S11(t6)
    sd t3, TCB_T3(t6)
    sd t4, TCB_T4(t6)
    sd t5, TCB_T5(t6)
    csrr t0, mscratch
    sd t0, TCB_T6(t6)
    csrr t0, mepc
    sd t0, TCB_MEPC(t6)
    csrr t0, mstatus
    sd t0, TCB_MSTATUS(t6)
    la sp, _stack_top
    csrr t0, mcause
    li t1, 2
    beq t0, t1, handle_illegal
    li t1, 11
    beq t0, t1, handle_ecall
    li t1, 0x8000000000000007
    beq t0, t1, handle_timer
    j handle_unknown

handle_timer:
    la a0, timer_msg
    call uart_puts
    call clint_init
    call sched_next

restore_stack:
    mv t6, a0
    ld t0, TCB_MEPC(t6)
    csrw mepc, t0
    ld t0, TCB_MSTATUS(t6)
    csrw mstatus, t0
    ld ra, TCB_RA(t6)
    ld sp, TCB_SP(t6)
    ld gp, TCB_GP(t6)
    ld tp, TCB_TP(t6)
    ld t0, TCB_T0(t6)
    ld t1, TCB_T1(t6)
    ld t2, TCB_T2(t6)
    ld s0, TCB_S0(t6)
    ld s1, TCB_S1(t6)
    ld a0, TCB_A0(t6)
    ld a1, TCB_A1(t6)
    ld a2, TCB_A2(t6)
    ld a3, TCB_A3(t6)
    ld a4, TCB_A4(t6)
    ld a5, TCB_A5(t6)
    ld a6, TCB_A6(t6)
    ld a7, TCB_A7(t6)
    ld s2, TCB_S2(t6)
    ld s3, TCB_S3(t6)
    ld s4, TCB_S4(t6)
    ld s5, TCB_S5(t6)
    ld s6, TCB_S6(t6)
    ld s7, TCB_S7(t6)
    ld s8, TCB_S8(t6)
    ld s9, TCB_S9(t6)
    ld s10, TCB_S10(t6)
    ld s11, TCB_S11(t6)
    ld t3, TCB_T3(t6)
    ld t4, TCB_T4(t6)
    ld t5, TCB_T5(t6)
    ld t6, TCB_T6(t6)
    mret

handle_ecall:
    la a0, ecall_msg
    call uart_puts
    csrr a0, mscratch
    ld t0, TCB_MEPC(a0)
    addi t0, t0, 4
    sd t0, TCB_MEPC(a0)
    j restore_stack

handle_illegal:
    la a0, illegal_msg
    call uart_puts
    la a0, mepc_msg
    call uart_puts
    csrr a0, mepc
    call uart_puthex
    li a0, '\n'
    call uart_putc
    j system_hang

handle_unknown:
    la a0, unknown_msg
    call uart_puts
    csrr a0, mcause
    call uart_puthex
    li a0, '\n'
    call uart_putc
    j system_hang

.section .rodata
timer_msg:
    .asciz "\n[Timer Interrupt]\n"

ecall_msg:
    .asciz "[Environment Call]\n"

illegal_msg:
    .asciz "\n[Illegal Instruction]\n"

mepc_msg:
    .asciz "mepc = 0x"

unknown_msg:
    .asciz "\n[Something Happened], mecp = 0x"
