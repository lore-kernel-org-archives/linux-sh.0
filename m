From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Apr 2009 14:44:28 +0000
Subject: [PATCH] sh: pass through ioremap() for non-mmu processors V2
Message-Id: <20090429144428.15872.69452.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20090428075934.16285.38017.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090428075934.16285.38017.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This is V2 of the CONFIG_MMU=n pass through ioremap() patch.

All 32-bit SuperH processors currently go through __ioremap_mode()
and check for IO_TRAPPED and directly mapped segments. With this
patch we simplify the MMU less case with a pass through version of
 __ioremap_mode() which just returns the physical address.

The effects of this is change are:
 - fix non-MMU ioremap() of high address hardware blocks (sh7203 CMT)
 - make sure IO_TRAPPED is not selected

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V1:
 - rework Kconfig bits

 arch/sh/boards/Kconfig   |    6 +++---
 arch/sh/include/asm/io.h |   13 +++++++------
 2 files changed, 10 insertions(+), 9 deletions(-)

--- 0001/arch/sh/boards/Kconfig
+++ work/arch/sh/boards/Kconfig	2009-04-28 18:07:39.000000000 +0900
@@ -121,7 +121,7 @@ config SH_RTS7751R2D
 	bool "RTS7751R2D"
 	depends on CPU_SUBTYPE_SH7751R
 	select SYS_SUPPORTS_PCI
-	select IO_TRAPPED
+	select IO_TRAPPED if MMU
 	help
 	  Select RTS7751R2D if configuring for a Renesas Technology
 	  Sales SH-Graphics board.
@@ -145,13 +145,13 @@ config SH_HIGHLANDER
 	bool "Highlander"
 	depends on CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785
 	select SYS_SUPPORTS_PCI
-	select IO_TRAPPED
+	select IO_TRAPPED if MMU
 
 config SH_SH7785LCR
 	bool "SH7785LCR"
 	depends on CPU_SUBTYPE_SH7785
 	select SYS_SUPPORTS_PCI
-	select IO_TRAPPED
+	select IO_TRAPPED if MMU
 
 config SH_SH7785LCR_29BIT_PHYSMAPS
 	bool "SH7785LCR 29bit physmaps"
--- 0001/arch/sh/include/asm/io.h
+++ work/arch/sh/include/asm/io.h	2009-04-28 12:40:43.000000000 +0900
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
