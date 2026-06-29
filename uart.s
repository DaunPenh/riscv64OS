.section .text

.equ UART_BASE, 0x10000000
.equ UART_THR, 0x00
.equ UART_LSR, 0x05
.equ UART_LSR_THRE, 0x20

.global uart_putc
.global uart_puts
.global uart_getc
.global uart_puthex

#write character function, a0 input
uart_putc:
    li t0, UART_BASE

wait_thre:
    lb t1, 5(t0)
    andi t1, t1, 32
    beqz t1, wait_thre

    beqz a0, putc_done
    sb a0, 0(t0)

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

#writes hex value
uart_puthex:
    addi sp, sp, -24
    sd ra, 0(sp)
    sd s0, 8(sp)
    sd s1, 16(sp)

    mv s0, a0          

    li s1, 60         

hex_loop:
    srl a0, s0, s1
    andi a0, a0, 0xf

    li t0, 10
    blt a0, t0, hex_num

    addi a0, a0, 55   
    j output

hex_num:
    addi a0, a0, 48    

output:
    call uart_putc

    addi s1, s1, -4
    bgez s1, hex_loop

    ld ra, 0(sp)
    ld s0, 8(sp)
    ld s1, 16(sp)
    addi sp, sp, 24
    ret
