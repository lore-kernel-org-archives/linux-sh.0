From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 26 Oct 2009 10:12:39 +0000
Subject: [PATCH] sh: add uImage.bin target
Message-Id: <20091026101239.13565.94659.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add an uImage.bin target to allow uncompressed uImages.
Useful for boards with busted u-boot decompression like
the rsk7203 on my desk.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/Makefile      |    2 +-
 arch/sh/boot/Makefile |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- 0001/arch/sh/Makefile
+++ work/arch/sh/Makefile	2009-10-26 18:54:04.000000000 +0900
@@ -199,7 +199,7 @@ endif
 libs-$(CONFIG_SUPERH32)		:= arch/sh/lib/	$(libs-y)
 libs-$(CONFIG_SUPERH64)		:= arch/sh/lib64/ $(libs-y)
 
-BOOT_TARGETS = uImage uImage.bz2 uImage.gz uImage.lzma uImage.srec \
+BOOT_TARGETS = uImage uImage.bz2 uImage.gz uImage.lzma uImage.srec uImage.bin \
 	       zImage vmlinux.srec romImage
 PHONY += maketools $(BOOT_TARGETS) FORCE
 
--- 0001/arch/sh/boot/Makefile
+++ work/arch/sh/boot/Makefile	2009-10-26 18:58:16.000000000 +0900
@@ -20,11 +20,12 @@ CONFIG_BOOT_LINK_OFFSET	?= 0x00800000
 CONFIG_ZERO_PAGE_OFFSET	?= 0x00001000
 CONFIG_ENTRY_OFFSET	?= 0x00001000
 
+suffix-y := bin
 suffix-$(CONFIG_KERNEL_GZIP)  := gz
 suffix-$(CONFIG_KERNEL_BZIP2) := bz2
 suffix-$(CONFIG_KERNEL_LZMA)  := lzma
 
-targets := zImage vmlinux.srec romImage uImage uImage.srec uImage.gz uImage.bz2 uImage.lzma
+targets := zImage vmlinux.srec romImage uImage uImage.srec uImage.gz uImage.bz2 uImage.lzma uImage.bin
 extra-y += vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma
 subdir- := compressed romimage
 
@@ -88,6 +89,9 @@ $(obj)/uImage.gz: $(obj)/vmlinux.bin.gz
 $(obj)/uImage.lzma: $(obj)/vmlinux.bin.lzma
 	$(call if_changed,uimage,lzma)
 
+$(obj)/uImage.bin: $(obj)/vmlinux.bin
+	$(call if_changed,uimage,none)
+
 OBJCOPYFLAGS_vmlinux.srec := -I binary -O srec
 $(obj)/vmlinux.srec: $(obj)/compressed/vmlinux
 	$(call if_changed,objcopy)
