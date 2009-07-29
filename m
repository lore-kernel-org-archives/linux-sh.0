From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Jul 2009 15:04:05 +0000
Subject: [PATCH] sh: romImage support V2
Message-Id: <20090729150405.4599.87883.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch contains support for the romImage build target V2.

The resulting romImage file should be burned to rom
or flash and could be used as small boot loader.

Board code should keep their setup code in the file
romimage.h located in their mach include directory.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Makefile                       |    2 +-
 arch/sh/boot/Makefile                  |   11 +++++++++--
 arch/sh/boot/romimage/Makefile         |   19 +++++++++++++++++++
 arch/sh/boot/romimage/head.S           |   10 ++++++++++
 arch/sh/boot/romimage/vmlinux.scr      |    6 ++++++
 arch/sh/include/mach-common/romimage.h |    1 +
 6 files changed, 46 insertions(+), 3 deletions(-)

--- 0001/arch/sh/Makefile
+++ work/arch/sh/Makefile	2009-07-29 22:59:44.000000000 +0900
@@ -195,7 +195,7 @@ libs-$(CONFIG_SUPERH32)		:= arch/sh/lib/
 libs-$(CONFIG_SUPERH64)		:= arch/sh/lib64/ $(libs-y)
 
 BOOT_TARGETS = uImage uImage.bz2 uImage.gz uImage.lzma uImage.srec \
-	       zImage vmlinux.srec
+	       zImage vmlinux.srec romImage
 PHONY += maketools $(BOOT_TARGETS) FORCE
 
 maketools:  include/linux/version.h FORCE
--- 0001/arch/sh/boot/Makefile
+++ work/arch/sh/boot/Makefile	2009-07-29 23:45:42.000000000 +0900
@@ -24,9 +24,9 @@ suffix-$(CONFIG_KERNEL_GZIP)  := gz
 suffix-$(CONFIG_KERNEL_BZIP2) := bz2
 suffix-$(CONFIG_KERNEL_LZMA)  := lzma
 
-targets := zImage vmlinux.srec uImage uImage.srec uImage.gz uImage.bz2 uImage.lzma
+targets := zImage vmlinux.srec romImage uImage uImage.srec uImage.gz uImage.bz2 uImage.lzma
 extra-y += vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma
-subdir- := compressed
+subdir- := compressed romimage
 
 $(obj)/zImage: $(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
@@ -35,6 +35,13 @@ $(obj)/zImage: $(obj)/compressed/vmlinux
 $(obj)/compressed/vmlinux: FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
+$(obj)/romImage: $(obj)/romimage/vmlinux FORCE
+	$(call if_changed,objcopy)
+	@echo '  Kernel: $@ is ready'
+
+$(obj)/romimage/vmlinux: $(obj)/zImage FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/romimage $@
+
 KERNEL_MEMORY := 0x00000000
 ifeq ($(CONFIG_PMB_FIXED),y)
 KERNEL_MEMORY := $(shell /bin/bash -c 'printf "0x%08x" \
--- /dev/null
+++ work/arch/sh/boot/romimage/Makefile	2009-07-29 23:45:42.000000000 +0900
@@ -0,0 +1,19 @@
+#
+# linux/arch/sh/boot/romimage/Makefile
+#
+# create an image suitable for burning to flash from zImage
+#
+
+targets		:= vmlinux head.o
+
+OBJECTS = $(obj)/head.o
+LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext 0 -e romstart
+
+$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
+	$(call if_changed,ld)
+	@:
+
+LDFLAGS_piggy.o := -r --format binary --oformat $(ld-bfd) -T
+
+$(obj)/piggy.o: $(obj)/vmlinux.scr arch/sh/boot/zImage FORCE
+	$(call if_changed,ld)
--- /dev/null
+++ work/arch/sh/boot/romimage/head.S	2009-07-29 22:59:44.000000000 +0900
@@ -0,0 +1,10 @@
+/*
+ *  linux/arch/sh/boot/romimage/head.S
+ *
+ * Board specific setup code, executed before zImage loader
+ */
+
+.text
+	.global	romstart
+romstart:
+#include <romimage.h>
--- /dev/null
+++ work/arch/sh/boot/romimage/vmlinux.scr	2009-07-29 23:45:42.000000000 +0900
@@ -0,0 +1,6 @@
+SECTIONS
+{
+  .text : {
+	*(.data)
+	}
+}
--- /dev/null
+++ work/arch/sh/include/mach-common/romimage.h	2009-07-29 22:59:44.000000000 +0900
@@ -0,0 +1 @@
+/* do nothing here by default */
