.section .text

.equ UART_BASE, 0x10000000
.equ UART_THR, 0x00
.equ UART_LSR, 0x05
.equ UART_LSR_THRE, 0x20

.global uart_putc
.global uart_puts
.global uart_getc

#write character function, a0 input
uart_putc:
	li t0, UART_BASE
wait_thre:
	lb t1, UART_LSR(t0)
	andi t1, t1, UART_LSR_THRE
	beqz t1, wait_thre
send_byte:
	beqz a0, putc_done
	sb a0, UART_THR(t0)
putc_done:
	ret

#write string function, a0 input.
uart_puts:
    addi sp, sp, -16
    sd ra, 0(sp)

    mv a1, a0

loop:
    lb a0, 0(a1)
    beqz a0, done
    call uart_putc
    addi a1, a1, 1
    j loop

done:
    ld ra, 0(sp)
    addi sp, sp, 16
    ret

#moves character in serial line to a0
uart_getc:
	li t0, UART_BASE
wait_dr:
	lb t1, UART_LSR(t0) 
	andi t1, t1, 0x01
	beqz t1, wait_dr
read_byte:
	lb a0, UART_THR(t0)
	ret
