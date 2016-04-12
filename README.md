# Kernel code, made with [Crystal](https://github.com/crystal-lang/crystal)

This is just a *proof of concept*, it doesn't actually do anything aside from booting.
Run with `make run` to build a kernel.elf and execute it in QEMU.

You can also do `make iso` to produce a ISO image that can boot on real hardware.

As a last option, take the `kernel.elf` produced, put it in your `/boot` directory
and change grub configuration to offer it as an option in your boot menu. It works.
