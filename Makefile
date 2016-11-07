MAIN := kernel.elf
ISO := kernel.iso

LINKFLAGS := -nostdlib -m32 -Wl,-T,$(shell pwd)/src/link.ld,--build-id=none
QEMU := qemu-system-i386
QEMUFLAGS := -no-reboot -no-shutdown -m 4096

$(MAIN): $(shell find src | grep .cr) Makefile src/link.ld
	@echo Creating $@...
	@crystal build src/main.cr --target=i386 --prelude=empty --link-flags "$(LINKFLAGS)" -o $@

.PHONY: clean
clean:
	@rm -rf $(MAIN) $(ISO) iso

.PHONY: run
run: $(MAIN)
	@$(QEMU) $(QEMUFLAGS) -kernel $(MAIN)

.PHONY: runiso
runiso: $(iso)
	@$(QEMU) $(QEMUFLAGS) -cdrom $(ISO)

.PHONY: iso
iso: $(ISO)

$(ISO): $(MAIN) Makefile
	@mkdir -p iso/boot/grub
	@cp $(MAIN) iso/boot/
	@echo "set timeout=0" > iso/boot/grub/grub.cfg
	@echo "menuentry \"crystal kernel\" {" >> iso/boot/grub/grub.cfg
	@echo "  multiboot /boot/$(MAIN)" >> iso/boot/grub/grub.cfg
	@echo "}" >> iso/boot/grub/grub.cfg
	@grub2-mkrescue iso -o $@
