From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Apr 2009 07:59:34 +0000
Subject: [PATCH] sh: pass through ioremap() for non-mmu processors
Message-Id: <20090428075934.16285.38017.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch modifies the ioremap() handling for CONFIG_MMU=n.

All 32-bit SuperH processors currently go through __ioremap_mode()
and check for IO_TRAPPED and directly mapped segments. With this
patch we simplify the MMU less case with a pass through version of
 __ioremap_mode() which just returns the physical address.

The effects of this is change are:
 - fix non-MMU ioremap() of high address hardware blocks (sh7203 CMT)
 - IO_TRAPPED is never checked for

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig          |    1 +
 arch/sh/include/asm/io.h |   13 +++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-04-21 15:54:59.000000000 +0900
@@ -136,6 +136,7 @@ config ARCH_HAS_DEFAULT_IDLE
 
 config IO_TRAPPED
 	bool
+	depends on MMU
 
 source "init/Kconfig"
 
--- 0001/arch/sh/include/asm/io.h
+++ work/arch/sh/include/asm/io.h	2009-04-21 15:18:02.000000000 +0900
@@ -228,12 +228,6 @@ void __iounmap(void __iomem *addr);
 unsigned long onchip_remap(unsigned long addr, unsigned long size,
 			   const char *name);
 extern void onchip_unmap(unsigned long vaddr);
-#else
-#define __ioremap(offset, size, flags)	((void __iomem *)(offset))
-#define __iounmap(addr)			do { } while (0)
-#define onchip_remap(addr, size, name)	(addr)
-#define onchip_unmap(addr)		do { } while (0)
-#endif /* CONFIG_MMU */
 
 static inline void __iomem *
 __ioremap_mode(unsigned long offset, unsigned long size, unsigned long flags)
@@ -269,6 +263,13 @@ __ioremap_mode(unsigned long offset, uns
 	return __ioremap(offset, size, flags);
 }
 
+#else
+#define onchip_remap(addr, size, name)	(addr)
+#define onchip_unmap(addr)		do { } while (0)
+#define __ioremap_mode(offset, size, flags) (void __iomem *)(offset)
+#define __iounmap(addr)			do { } while (0)
+#endif /* CONFIG_MMU */
+
 #define ioremap(offset, size)				\
 	__ioremap_mode((offset), (size), 0)
 #define ioremap_nocache(offset, size)			\
