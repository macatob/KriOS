TOOLPATH = ../z_tools/
MAKE = $(TOOLPATH)make.exe -r
NASK = $(TOOLPATH)nask.exe
EDIMG = $(TOOLPATH)edimg.exe
IMGTOL = $(TOOLPATH)imgtol.com
COPY = COPY
DEL = DEL


default:
	$(MAKE) img


ipl.bin: ipl.nas Makefile
	$(NASK) ipl.nas ipl.bin ipl.lst

krios.img: ipl.bin Makefile
	$(EDIMG) imgin:../z_tools/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0 imgout :krios.img


asm:
	$(MAKE) ipl.bin

img:
	$(MAKE) krios.img

run:
	$(MAKE) img
	$(COPY) krios.img ..\z_tools\qemu\fdimage0.bin
	$(MAKE) -C ../z_tools/qemu

install:
	$(MAKE) img
	$(IMGTOL) w a: krios.img

clean:
	-$(DEL) ipl.bin
	-$(DEL) ipl.lst

src_only:
	$(MAKE) clean
	-$(DEL) krios.img
