From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 25 Nov 2008 12:57:29 +0000
Subject: [PATCH] sh: P4 ioremap pass-through
Message-Id: <20081125125729.8565.28530.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds a pass-through case when ioremapping P4 addresses.

Addresses passed to ioremap() should be physical addresses, so the
best option is usually to convert the virtual address to a physical
address before calling ioremap. This will give you a virtual address
in P2 which matches the physical address and this works well for
most internal hardware blocks on the SuperH architecture.

However, some hardware blocks must be accessed through P4. Converting
the P4 address to a physical and then back to a P2 does not work. One
example of this is the sh7722 TMU block, it must be accessed through P4.

Without this patch P4 addresses will be mapped using PTEs which
requires the page allocator to be up and running.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/addrspace.h |   11 +++++++++++
 arch/sh/include/asm/io.h        |    4 ++++
 arch/sh/mm/fault_32.c           |   11 -----------
 arch/sh/mm/ioremap_32.c         |    3 ++-
 4 files changed, 17 insertions(+), 12 deletions(-)

--- 0001/arch/sh/include/asm/addrspace.h
+++ work/arch/sh/include/asm/addrspace.h	2008-11-25 19:55:39.000000000 +0900
@@ -49,5 +49,16 @@
 /* Check if an address can be reached in 29 bits */
 #define IS_29BIT(a)	(((unsigned long)(a)) < 0x20000000)
 
+#ifdef CONFIG_SH_STORE_QUEUES
+/*
+ * This is a special case for the SH-4 store queues, as pages for this
+ * space still need to be faulted in before it's possible to flush the
+ * store queue cache for writeout to the remapped region.
+ */
+#define P3_ADDR_MAX		(P4SEG_STORE_QUE + 0x04000000)
+#else
+#define P3_ADDR_MAX		P4SEG
+#endif
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_ADDRSPACE_H */
--- 0001/arch/sh/include/asm/io.h
+++ work/arch/sh/include/asm/io.h	2008-11-25 19:55:39.000000000 +0900
@@ -260,6 +260,10 @@ __ioremap_mode(unsigned long offset, uns
 
 		return (void __iomem *)P2SEGADDR(offset);
 	}
+
+	/* P4 above the store queues are always mapped. */
+	if (unlikely(offset >= P3_ADDR_MAX))
+		return (void __iomem *)P4SEGADDR(offset);
 #endif
 
 	return __ioremap(offset, size, flags);
--- 0001/arch/sh/mm/fault_32.c
+++ work/arch/sh/mm/fault_32.c	2008-11-25 19:55:39.000000000 +0900
@@ -265,17 +265,6 @@ static inline int notify_page_fault(stru
 	return ret;
 }
 
-#ifdef CONFIG_SH_STORE_QUEUES
-/*
- * This is a special case for the SH-4 store queues, as pages for this
- * space still need to be faulted in before it's possible to flush the
- * store queue cache for writeout to the remapped region.
- */
-#define P3_ADDR_MAX		(P4SEG_STORE_QUE + 0x04000000)
-#else
-#define P3_ADDR_MAX		P4SEG
-#endif
-
 /*
  * Called with interrupts disabled.
  */
--- 0001/arch/sh/mm/ioremap_32.c
+++ work/arch/sh/mm/ioremap_32.c	2008-11-25 19:56:06.000000000 +0900
@@ -116,9 +116,10 @@ EXPORT_SYMBOL(__ioremap);
 void __iounmap(void __iomem *addr)
 {
 	unsigned long vaddr = (unsigned long __force)addr;
+	unsigned long seg = PXSEG(vaddr);
 	struct vm_struct *p;
 
-	if (PXSEG(vaddr) < P3SEG || is_pci_memaddr(vaddr))
+	if (seg < P3SEG || seg >= P3_ADDR_MAX || is_pci_memaddr(vaddr))
 		return;
 
 #ifdef CONFIG_32BIT
