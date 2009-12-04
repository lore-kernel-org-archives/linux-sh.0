From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 04 Dec 2009 06:42:35 +0000
Subject: [PATCH] sh: include empty zero page in romImage
Message-Id: <20091204064235.7674.79539.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the romImage code to include the
empty_zero_page contents from vmlinux. Without this
patch the empty zero page is lef uninitialized.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Compiles and looks fine through objdump, but not
 runtime tested due to lack of hardware debugger.

 arch/sh/boot/romimage/Makefile |   12 +++++++++---
 arch/sh/boot/romimage/head.S   |   38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 3 deletions(-)

--- 0001/arch/sh/boot/romimage/Makefile
+++ work/arch/sh/boot/romimage/Makefile	2009-12-04 15:14:05.000000000 +0900
@@ -4,16 +4,22 @@
 # create an image suitable for burning to flash from zImage
 #
 
-targets		:= vmlinux head.o
+targets		:= vmlinux head.o zeropage.bin piggy.o
 
 OBJECTS = $(obj)/head.o
-LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext 0 -e romstart
+LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext 0 -e romstart \
+		   -T $(obj)/../../kernel/vmlinux.lds
 
 $(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o FORCE
 	$(call if_changed,ld)
 	@:
 
+OBJCOPYFLAGS += -j .empty_zero_page
+
+$(obj)/zeropage.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+
 LDFLAGS_piggy.o := -r --format binary --oformat $(ld-bfd) -T
 
-$(obj)/piggy.o: $(obj)/vmlinux.scr arch/sh/boot/zImage FORCE
+$(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/zeropage.bin arch/sh/boot/zImage FORCE
 	$(call if_changed,ld)
--- 0001/arch/sh/boot/romimage/head.S
+++ work/arch/sh/boot/romimage/head.S	2009-12-04 15:21:49.000000000 +0900
@@ -5,6 +5,44 @@
  */
 
 .text
+	#include <asm/page.h>
+
 	.global	romstart
 romstart:
+	/* include board specific setup code */
 #include <mach/romimage.h>
+
+	/* copy the empty_zero_page contents to where vmlinux expects it */
+	mova	empty_zero_page_src, r0
+	mov.l	empty_zero_page_dst, r1
+	mov	#(PAGE_SHIFT - 4), r4
+	mov	#1, r3
+	shld	r4, r3 /* r3 = PAGE_SIZE / 16 */
+
+1:
+	mov.l	@r0, r4
+	mov.l	@(4, r0), r5
+	mov.l	@(8, r0), r6
+	mov.l	@(12, r0), r7
+	add	#16,r0
+	mov.l	r4, @r1
+	mov.l	r5, @(4, r1)
+	mov.l	r6, @(8, r1)
+	mov.l	r7, @(12, r1)
+	dt	r3
+	add	#16,r1
+	bf	1b
+
+	/* jump to the zImage entry point located after the zero page data */
+	mov	#PAGE_SHIFT, r4
+	mov	#1, r1
+	shld	r4, r1
+	mova	empty_zero_page_src, r0
+	add	r1, r0
+	jmp	@r0
+	 nop
+
+	.align 2
+empty_zero_page_dst:
+	.long	_text
+empty_zero_page_src:
