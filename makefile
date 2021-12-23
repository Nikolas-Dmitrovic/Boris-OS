# $@ = target file
# $< = first dependency
# $^ = all dependencies

# First rule is the one executed when no parameters are fed to the Makefile
all: run

# Notice how dependencies are built as needed
kernel.bin: kernel_entry.o kernel.o
#ld -o $@ -Ttext 0x1000 $^ --oformat binary
	ld -T NUL -o kernel.tmp -Ttext 0x1000 $^
#ld -r -o kernel.out -Ttext 0x1000 $^
	objcopy -O binary -j .text  kernel.tmp $@ 

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	gcc -ffreestanding -c $< -o $@

# Rule to disassemble the kernel - may be useful to debug
#kernel.dis: kernel.bin
#	ndisasm -b 32 $< > $@

bootsect.bin: bootsect.asm
	nasm $< -f bin -o $@

os-image.bin: bootsect.bin kernel.bin
	type $^ > $@

run: os-image.bin
	qemu-system-x86_64 -fda $< -L "C:\Program Files\qemu

clean:
	rm *.bin *.o *.dis
