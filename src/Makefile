# $@ = target file
# $< = first dependency
# $^ = all dependencies

# First rule is the one executed when no parameters are fed to the Makefile
all: run

kernel.bin: kernel_entry.o kernel.o
	x86_64-elf-ld -m elf_i386 -o kernel.bin -Ttext 0x10000 --oformat binary kernel.o kernel_entry.o --entry main 

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	x86_64-elf-gcc -m32 -ffreestanding -c kernel.c -o kernel.o

mbr.bin: mbr.asm
	nasm $< -f bin -o $@

os-image.bin: mbr.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-x86_64 -s -S -fda $<

clean:
	$(RM) *.bin *.o *.dis
