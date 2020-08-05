TOOLPATH = ../z_tools/
INCPATH = ../z_tools/haribote/

MAKE	 = $(TOOLPATH)make.exe -r
NASK 	 = $(TOOLPATH)nask.exe
CC1 	 = $(TOOLPATH)cc1.exe -I$(INCPATH) -Os -Wall -quiet
GAS2NASK = $(TOOLPATH)gas2nask.exe -a
OBJ2BIM  = $(TOOLPATH)obj2bim.exe
MAKEFONT = $(TOOLPATH)makefont.exe
BIN2OBJ	 = $(TOOLPATH)bin2obj.exe
BIM2HRB  = $(TOOLPATH)bim2hrb.exe
RULEFILE = $(TOOLPATH)haribote/haribote.rul
EDIMG	 = $(TOOLPATH)edimg.exe
IMGTOL 	 = $(TOOLPATH)imgtol.com
COPY 	 = copy
DEL		 = del

# 默认操作

default :
	$(MAKE) img

# 生成规则

ipl.bin : ipl.nas Makefile
	$(NASK) ipl.nas ipl.bin ipl.lst

head.bin : head.nas Makefile
	$(NASK) head.nas head.bin head.lst

asmlib.obj : asmlib.nas Makefile
	$(NASK) asmlib.nas asmlib.obj asmlib.lst

hankaku.bin : hankaku.txt Makefile
	$(MAKEFONT) hankaku.txt hankaku.bin

hankaku.obj : hankaku.bin Makefile
	$(BIN2OBJ) hankaku.bin hankaku.obj _hankaku

bootpack.gas : bootpack.c Makefile
	$(CC1) -o bootpack.gas bootpack.c

bootpack.nas : bootpack.gas Makefile
	$(GAS2NASK) bootpack.gas bootpack.nas

bootpack.obj : bootpack.nas Makefile
	$(NASK) bootpack.nas bootpack.obj bootpack.lst

bootpack.bim : bootpack.obj asmlib.obj hankaku.obj Makefile
	$(OBJ2BIM) @$(RULEFILE) out:bootpack.bim stack:3136k map:bootpack.map \
		bootpack.obj asmlib.obj hankaku.obj

bootpack.hrb : bootpack.bim Makefile
	$(BIM2HRB) bootpack.bim bootpack.hrb 0

krios.sys : head.bin bootpack.hrb Makefile
	copy /B head.bin+bootpack.hrb krios.sys

krios.img : ipl.bin krios.sys Makefile
	$(EDIMG) imgin:../z_tools/fdimg0at.tek \
		wbinimg src:ipl.bin len:512 from:0 to:0 \
		copy from:krios.sys to:@: \
		imgout:krios.img


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
	-$(DEL) *.bin
	-$(DEL) *.lst
	-$(DEL) *.gas
	-$(DEL) *.obj
	-$(DEL) bootpack.nas
	-$(DEL) bootpack.map
	-$(DEL) bootpack.bim
	-$(DEL) bootpack.hrb
	-$(DEL) krios.sys
	-$(DEL) krios.img
