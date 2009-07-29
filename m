From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Jul 2009 12:49:42 +0000
Subject: [PATCH] sh: romImage support
Message-Id: <20090729124942.3344.84856.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds support for the romImage build target.

The resulting romImage file should be burned to rom
or flash and could be used as small boot loader.

Board code should keep their setup code in the file
romimage.h located in their mach include directory.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Makefile                       |    2 +-
 arch/sh/boot/Makefile                  |   11 +++++++++--
 arch/sh/boot/romimage/Makefile         |   31 +++++++++++++++++++++++++++++++
 arch/sh/boot/romimage/head_32.S        |   18 ++++++++++++++++++
 arch/sh/boot/romimage/head_64.S        |   11 +++++++++++
 arch/sh/include/mach-common/romimage.h |    1 +
 6 files changed, 71 insertions(+), 3 deletions(-)

--- 0001/arch/sh/Makefile
+++ work/arch/sh/Makefile	2009-07-29 20:36:36.000000000 +0900
@@ -195,7 +195,7 @@ libs-$(CONFIG_SUPERH32)		:= arch/sh/lib/
 libs-$(CONFIG_SUPERH64)		:= arch/sh/lib64/ $(libs-y)
 
 BOOT_TARGETS = uImage uImage.bz2 uImage.gz uImage.lzma uImage.srec \
-	       zImage vmlinux.srec
+	       zImage vmlinux.srec romImage
 PHONY += maketools $(BOOT_TARGETS) FORCE
 
 maketools:  include/linux/version.h FORCE
--- 0001/arch/sh/boot/Makefile
+++ work/arch/sh/boot/Makefile	2009-07-29 20:36:36.000000000 +0900
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
+$(obj)/romimage/vmlinux: $(obj)/compressed/vmlinux FORCE
+	$(Q)$(MAKE) $(build)=$(obj)/romimage $@
+
 KERNEL_MEMORY := 0x00000000
 ifeq ($(CONFIG_PMB_FIXED),y)
 KERNEL_MEMORY := $(shell /bin/bash -c 'printf "0x%08x" \
--- /dev/null
+++ work/arch/sh/boot/romimage/Makefile	2009-07-29 20:36:36.000000000 +0900
@@ -0,0 +1,31 @@
+#
+# linux/arch/sh/boot/romimage/Makefile
+#
+# create an image suitable for burning to flash from zImage
+#
+
+targets		:= vmlinux head_$(BITS).o
+
+OBJECTS = $(obj)/head_$(BITS).o
+
+#
+# IMAGE_OFFSET is the load offset of the compression loader
+#
+IMAGE_OFFSET	:= $(shell /bin/bash -c 'printf "0x%08x" \
+		     $$[$(CONFIG_PAGE_OFFSET)  + \
+			$(KERNEL_MEMORY) + \
+			$(CONFIG_BOOT_LINK_OFFSET)]')
+
+LIBGCC	:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
+
+ifeq ($(CONFIG_MCOUNT),y)
+ORIG_CFLAGS := $(KBUILD_CFLAGS)
+KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
+endif
+
+LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e romstart \
+		   -T $(obj)/../../kernel/vmlinux.lds
+
+$(obj)/vmlinux: $(OBJECTS) arch/sh/boot/compressed/vmlinux $(LIBGCC) FORCE
+	$(call if_changed,ld)
+	@:
--- /dev/null
+++ work/arch/sh/boot/romimage/head_32.S	2009-07-29 20:45:52.000000000 +0900
@@ -0,0 +1,18 @@
+/*
+ *  linux/arch/sh/boot/romimage/head_32.S
+ *
+ * Board specific setup code, executed before zImage loader
+ */
+
+.text
+	.global	romstart
+romstart:
+#include <romimage.h>
+	mov.l	startup_addr, r0
+	jmp	@r0
+	 nop
+
+	.align 2
+startup_addr:
+	.long	startup
+	.align 0
--- /dev/null
+++ work/arch/sh/boot/romimage/head_64.S	2009-07-29 20:46:55.000000000 +0900
@@ -0,0 +1,11 @@
+/*
+ *  linux/arch/sh/boot/romimage/head_64.S
+ *
+ * Board specific setup code, executed before zImage loader
+ */
+
+.text
+	.global	romstart
+romstart:
+#include <romimage.h>
+#warning "64-bit implementation needs more work"
--- /dev/null
+++ work/arch/sh/include/mach-common/romimage.h	2009-07-29 20:36:36.000000000 +0900
@@ -0,0 +1 @@
+/* do nothing here by default */
