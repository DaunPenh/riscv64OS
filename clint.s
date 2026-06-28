.section .text

.equ CLINT_BASE, 0x02000000
.equ MTIMECMP_OFFSET, 0x4000
.equ MTIME_OFFSET, 0xBFF8

.global clint_init
.global clint_enable

clint_init:
	li t0, CLINT_BASE
	li t2, MTIME_OFFSET
	li t3, MTIMECMP_OFFSET
	add t0, t0, t2
	ld t1, 0(t0)
	li t4, 10000000
	add t1, t1, t4
	li t0, CLINT_BASE
	add t0, t0, t3
	sd t1, 0(t0)
	ret
	
clint_enable:
	csrr t2, mie
	ori t2, t2, 0x80
	csrw mie, t2

	csrr t2, mstatus
	ori t2, t2, 0x08
	csrw mstatus, t2
	ret 
