From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Dec 2009 12:26:19 +0000
Subject: [PATCH] sh: include empty zero page in zImage
Message-Id: <20091203122619.9975.58412.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Include the empty zero page data in the zImage.
Without this patch the empty zero page may be
uninitialized.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 I suppose we should have a fallback option to
 allow boot loaders passing data in the zero page.
 Or perhaps doing it the other way around is better.

 arch/sh/boot/compressed/Makefile |    2 --
 arch/sh/boot/compressed/misc.c   |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

--- 0001/arch/sh/boot/compressed/Makefile
+++ work/arch/sh/boot/compressed/Makefile	2009-12-03 21:06:02.000000000 +0900
@@ -48,8 +48,6 @@ $(obj)/vmlinux.bin.bz2: $(vmlinux.bin.al
 $(obj)/vmlinux.bin.lzma: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lzma)
 
-OBJCOPYFLAGS += -R .empty_zero_page
-
 LDFLAGS_piggy.o := -r --format binary --oformat $(ld-bfd) -T
 
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix-y) FORCE
--- 0001/arch/sh/boot/compressed/misc.c
+++ work/arch/sh/boot/compressed/misc.c	2009-12-03 21:05:58.000000000 +0900
@@ -131,7 +131,7 @@ void decompress_kernel(void)
 #ifdef CONFIG_SUPERH64
 	output_addr = (CONFIG_MEMORY_START + 0x2000);
 #else
-	output_addr = __pa((unsigned long)&_text+PAGE_SIZE);
+	output_addr = __pa((unsigned long)&_text);
 #ifdef CONFIG_29BIT
 	output_addr |= P2SEG;
 #endif
