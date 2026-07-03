.section .text
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
.equ TCB_SIZE, 264
.equ NUM_TASKS, 3

.section .bss
.align 3
boot_tcb:
    .space TCB_SIZE

.global tcb_table
tcb_table:
    .space TCB_SIZE * NUM_TASKS

.global current_task
current_task:
    .space 8

.section .text
.global sched_init
sched_init:
    la t0, tcb_table
    la t1, task0_entry
    sd t1, TCB_MEPC(t0)
    la t1, task0_stack_top
    sd t1, TCB_SP(t0)
    li t1, 0x1880
    sd t1, TCB_MSTATUS(t0)
    li t2, TCB_SIZE
    add t0, t0, t2
    la t1, task1_entry
    sd t1, TCB_MEPC(t0)
    la t1, task1_stack_top
    sd t1, TCB_SP(t0)
    li t1, 0x1880
    sd t1, TCB_MSTATUS(t0)
    add t0, t0, t2
    la t1, task2_entry
    sd t1, TCB_MEPC(t0)
    la t1, task2_stack_top
    sd t1, TCB_SP(t0)
    li t1, 0x1880
    sd t1, TCB_MSTATUS(t0)
    la t0, current_task
    li t1, NUM_TASKS - 1
    sd t1, 0(t0)
    la t0, boot_tcb
    csrw mscratch, t0
    ret

.global sched_next
sched_next:
    la t0, current_task
    ld t1, 0(t0)
    addi t1, t1, 1
    li t2, NUM_TASKS
    remu t1, t1, t2
    sd t1, 0(t0)
    la t0, tcb_table
    slli t2, t1, 8
    slli t3, t1, 3
    add t2, t2, t3
    add a0, t0, t2
    csrw mscratch, a0
    ret
