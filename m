From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Mar 2020 16:26:28 +0000
Subject: [PATCH 05/10] sh: move the ioremap implementation out of line
Message-Id: <20200324162633.754714-6-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200324162633.754714-1-hch@lst.de>
In-Reply-To: <20200324162633.754714-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Move the internal implementation details of ioremap out of line, no need
to expose any of this to drivers for a slow path API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/io.h | 101 ++++++---------------------------------
 arch/sh/mm/ioremap.c     |  57 ++++++++++++++++++++++
 2 files changed, 72 insertions(+), 86 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 59d53b06d461..282ec476c06e 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -246,109 +246,38 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 #define phys_to_virt(address)	(__va(address))
 #endif
 
-/*
- * On 32-bit SH, we traditionally have the whole physical address space
- * mapped at all times (as MIPS does), so "ioremap()" and "iounmap()" do
- * not need to do anything but place the address in the proper segment.
- * This is true for P1 and P2 addresses, as well as some P3 ones.
- * However, most of the P3 addresses and newer cores using extended
- * addressing need to map through page tables, so the ioremap()
- * implementation becomes a bit more complicated.
- *
- * See arch/sh/mm/ioremap.c for additional notes on this.
- *
- * We cheat a bit and always return uncachable areas until we've fixed
- * the drivers to handle caching properly.
- *
- * On the SH-5 the concept of segmentation in the 1:1 PXSEG sense simply
- * doesn't exist, so everything must go through page tables.
- */
 #ifdef CONFIG_MMU
+void iounmap(void __iomem *addr);
 void __iomem *__ioremap_caller(phys_addr_t offset, unsigned long size,
 			       pgprot_t prot, void *caller);
-void iounmap(void __iomem *addr);
-
-static inline void __iomem *
-__ioremap(phys_addr_t offset, unsigned long size, pgprot_t prot)
-{
-	return __ioremap_caller(offset, size, prot, __builtin_return_address(0));
-}
-
-static inline void __iomem *
-__ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
-{
-#ifdef CONFIG_29BIT
-	phys_addr_t last_addr = offset + size - 1;
-
-	/*
-	 * For P1 and P2 space this is trivial, as everything is already
-	 * mapped. Uncached access for P1 addresses are done through P2.
-	 * In the P3 case or for addresses outside of the 29-bit space,
-	 * mapping must be done by the PMB or by using page tables.
-	 */
-	if (likely(PXSEG(offset) < P3SEG && PXSEG(last_addr) < P3SEG)) {
-		u64 flags = pgprot_val(prot);
-
-		/*
-		 * Anything using the legacy PTEA space attributes needs
-		 * to be kicked down to page table mappings.
-		 */
-		if (unlikely(flags & _PAGE_PCC_MASK))
-			return NULL;
-		if (unlikely(flags & _PAGE_CACHABLE))
-			return (void __iomem *)P1SEGADDR(offset);
-
-		return (void __iomem *)P2SEGADDR(offset);
-	}
-
-	/* P4 above the store queues are always mapped. */
-	if (unlikely(offset >= P3_ADDR_MAX))
-		return (void __iomem *)P4SEGADDR(offset);
-#endif
-
-	return NULL;
-}
-
-static inline void __iomem *
-__ioremap_mode(phys_addr_t offset, unsigned long size, pgprot_t prot)
-{
-	void __iomem *ret;
-
-	ret = __ioremap_trapped(offset, size);
-	if (ret)
-		return ret;
-
-	ret = __ioremap_29bit(offset, size, prot);
-	if (ret)
-		return ret;
-
-	return __ioremap(offset, size, prot);
-}
-#else
-#define __ioremap(offset, size, prot)		((void __iomem *)(offset))
-#define __ioremap_mode(offset, size, prot)	((void __iomem *)(offset))
-#define iounmap(addr)				do { } while (0)
-#endif /* CONFIG_MMU */
 
 static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
 {
-	return __ioremap_mode(offset, size, PAGE_KERNEL_NOCACHE);
+	return __ioremap_caller(offset, size, PAGE_KERNEL_NOCACHE,
+			__builtin_return_address(0));
 }
 
 static inline void __iomem *
 ioremap_cache(phys_addr_t offset, unsigned long size)
 {
-	return __ioremap_mode(offset, size, PAGE_KERNEL);
+	return __ioremap_caller(offset, size, PAGE_KERNEL,
+			__builtin_return_address(0));
 }
 #define ioremap_cache ioremap_cache
 
 #ifdef CONFIG_HAVE_IOREMAP_PROT
-static inline void __iomem *
-ioremap_prot(phys_addr_t offset, unsigned long size, unsigned long flags)
+static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
+		unsigned long flags)
 {
-	return __ioremap_mode(offset, size, __pgprot(flags));
+	return __ioremap_caller(offset, size, __pgprot(flags),
+			__builtin_return_address(0));
 }
-#endif
+#endif /* CONFIG_HAVE_IOREMAP_PROT */
+
+#else /* CONFIG_MMU */
+#define iounmap(addr)		do { } while (0)
+#define ioremap(offset, size)	((void __iomem *)(unsigned long)(offset))
+#endif /* CONFIG_MMU */
 
 #define ioremap_uc	ioremap
 
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index d9ec85b6bb21..a8170fa07bc1 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -26,6 +26,55 @@
 #include <asm/mmu.h>
 #include "ioremap.h"
 
+/*
+ * On 32-bit SH, we traditionally have the whole physical address space mapped
+ * at all times (as MIPS does), so "ioremap()" and "iounmap()" do not need to do
+ * anything but place the address in the proper segment.  This is true for P1
+ * and P2 addresses, as well as some P3 ones.  However, most of the P3 addresses
+ * and newer cores using extended addressing need to map through page tables, so
+ * the ioremap() implementation becomes a bit more complicated.
+ *
+ * On the SH-5 the concept of segmentation in the 1:1 PXSEG sense simply doesn't
+ * exist, so everything must go through page tables.
+ */
+
+#ifdef CONFIG_29BIT
+static void __iomem *
+__ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
+{
+	phys_addr_t last_addr = offset + size - 1;
+
+	/*
+	 * For P1 and P2 space this is trivial, as everything is already
+	 * mapped. Uncached access for P1 addresses are done through P2.
+	 * In the P3 case or for addresses outside of the 29-bit space,
+	 * mapping must be done by the PMB or by using page tables.
+	 */
+	if (likely(PXSEG(offset) < P3SEG && PXSEG(last_addr) < P3SEG)) {
+		u64 flags = pgprot_val(prot);
+
+		/*
+		 * Anything using the legacy PTEA space attributes needs
+		 * to be kicked down to page table mappings.
+		 */
+		if (unlikely(flags & _PAGE_PCC_MASK))
+			return NULL;
+		if (unlikely(flags & _PAGE_CACHABLE))
+			return (void __iomem *)P1SEGADDR(offset);
+
+		return (void __iomem *)P2SEGADDR(offset);
+	}
+
+	/* P4 above the store queues are always mapped. */
+	if (unlikely(offset >= P3_ADDR_MAX))
+		return (void __iomem *)P4SEGADDR(offset);
+
+	return NULL;
+}
+#else
+#define __ioremap_29bit(offset, size, prot)		NULL
+#endif /* CONFIG_29BIT */
+
 /*
  * Remap an arbitrary physical address space into the kernel virtual
  * address space. Needed when the kernel wants to access high addresses
@@ -43,6 +92,14 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
 	unsigned long offset, last_addr, addr, orig_addr;
 	void __iomem *mapped;
 
+	mapped = __ioremap_trapped(phys_addr, size);
+	if (mapped)
+		return mapped;
+
+	mapped = __ioremap_29bit(phys_addr, size, pgprot);
+	if (mapped)
+		return mapped;
+
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
 	if (!size || last_addr < phys_addr)
-- 
2.25.1
