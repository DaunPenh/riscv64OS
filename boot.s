.section .text
.global _start

_start:
	la sp, _stack_top
	li t0, 0x10000000
	la t1, msg

print:
	lb t2, 0(t1)
	beqz t2, hang
	sb t2, 0(t0)
	addi t1, t1, 1
	j print

hang:
	j hang

.section .data
msg:
	.asciz "Hello!\n"
