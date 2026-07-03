CC = riscv64-unknown-elf-gcc
QEMU = qemu-system-riscv64
CFLAGS = -nostdlib -static -no-pie -T link.ld

all: run

kernel.elf: boot.s
	$(CC) $(CFLAGS) -o kernel.elf boot.s trap.s uart.s clint.s sched.s tasks.s

run: kernel.elf
	$(QEMU) -machine virt -nographic -bios none -kernel kernel.elf

debug: kernel.elf
	$(QEMU) -machine virt -nographic -bios none -kernel kernel.elf -s -S

clean:
	rm -f kernel.elf
