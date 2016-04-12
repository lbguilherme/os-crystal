MAIN := kernel.elf

LINK := ld
LINKFLAGS := -melf_i386
QEMU := qemu-system-i386
QEMUFLAGS := -no-reboot -no-shutdown -m 4096

$(MAIN): main.o Makefile src/link.ld
	@echo Creating $@...
	@$(LINK) $(LINKFLAGS) -T src/link.ld main.o -o $@

main.o: $(shell find src | grep .cr) Makefile
	@echo Compiling crystal code...
	@rm -f main.o
	@crystal build src/main.cr --target=i386 --prelude=empty --cross-compile "kernel" | grep -v rdynamic | cat

.PHONY: clean
clean:
	@rm -rf $(MAIN) main.o

.PHONY: run
run: $(MAIN)
	@$(QEMU) $(QEMUFLAGS) -kernel $(MAIN)

.PHONY: iso
iso: $(MAIN)
	@mkdir -p iso/boot/grub
	@cp $(MAIN) iso/boot/
	@( \
		echo "set timeout=0" \
		echo "menuentry \"crystal kernel\" {" \
		echo "  multiboot /boot/kernel.elf" \
		echo "}" \
	) > iso/boot/grub/grub.cfg
	@grub2-mkrescue -o kernel.iso iso
