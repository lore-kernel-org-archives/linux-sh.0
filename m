From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:25 +0000
Subject: [PATCH 05/14] sh: Prepare for dynamic PMB support
Message-Id: <522679ccc33da57080deaa75f23dc5d6b782dbba.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To allow the MMU to be switched between 29bit and 32bit mode at runtime
some constants need to swapped for functions that return a runtime
value.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/addrspace.h   |    6 ++++++
 arch/sh/include/asm/mmu.h         |    3 ++-
 arch/sh/include/asm/pgtable.h     |   26 ++++++++++++++++++++++----
 arch/sh/include/asm/pgtable_32.h  |    2 +-
 arch/sh/include/asm/scatterlist.h |    2 +-
 arch/sh/mm/cache-sh4.c            |    6 +++---
 arch/sh/mm/init.c                 |    8 ++++++++
 7 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index ebd6e49..99d6b3e 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -57,5 +57,11 @@
 #define P3_ADDR_MAX		P4SEG
 #endif
 
+#ifndef __ASSEMBLY__
+#ifdef CONFIG_PMB
+extern int __in_29bit_mode(void);
+#endif /* CONFIG_PMB */
+#endif /* __ASSEMBLY__ */
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_ADDRSPACE_H */
diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
index f596303..5025e12 100644
--- a/arch/sh/include/asm/mmu.h
+++ b/arch/sh/include/asm/mmu.h
@@ -7,6 +7,8 @@
 #define PMB_PASCR		0xff000070
 #define PMB_IRMCR		0xff000078
 
+#define PASCR_SE		0x80000000
+
 #define PMB_ADDR		0xf6100000
 #define PMB_DATA		0xf7100000
 #define PMB_ENTRY_MAX		16
@@ -75,4 +77,3 @@ void pmb_unmap(unsigned long addr);
 #endif /* __ASSEMBLY__ */
 
 #endif /* __MMU_H */
-
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index 4f3efa7..5dff578 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -75,13 +75,31 @@ static inline unsigned long long neff_sign_extend(unsigned long val)
 #define USER_PTRS_PER_PGD	(TASK_SIZE/PGDIR_SIZE)
 #define FIRST_USER_ADDRESS	0
 
-#ifdef CONFIG_32BIT
-#define PHYS_ADDR_MASK		0xffffffff
+#define PHYS_ADDR_MASK29		0x1fffffff
+#define PHYS_ADDR_MASK32		0xffffffff
+
+#ifdef CONFIG_PMB
+static inline unsigned long phys_addr_mask(void)
+{
+	/* Is the MMU in 29bit mode? */
+	if (__in_29bit_mode())
+		return PHYS_ADDR_MASK29;
+
+	return PHYS_ADDR_MASK32;
+}
+#elif CONFIG_32BIT
+static inline unsigned long phys_addr_mask(void)
+{
+	return PHYS_ADDR_MASK32;
+}
 #else
-#define PHYS_ADDR_MASK		0x1fffffff
+static inline unsigned long phys_addr_mask(void)
+{
+	return PHYS_ADDR_MASK29;
+}
 #endif
 
-#define PTE_PHYS_MASK		(PHYS_ADDR_MASK & PAGE_MASK)
+#define PTE_PHYS_MASK		(phys_addr_mask() & PAGE_MASK)
 #define PTE_FLAGS_MASK		(~(PTE_PHYS_MASK) << PAGE_SHIFT)
 
 #ifdef CONFIG_SUPERH32
diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index c0d359c..b354355 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -108,7 +108,7 @@ static inline unsigned long copy_ptea_attributes(unsigned long x)
 #define _PAGE_CLEAR_FLAGS	(_PAGE_PROTNONE | _PAGE_ACCESSED | _PAGE_FILE)
 #endif
 
-#define _PAGE_FLAGS_HARDWARE_MASK	(PHYS_ADDR_MASK & ~(_PAGE_CLEAR_FLAGS))
+#define _PAGE_FLAGS_HARDWARE_MASK	(phys_addr_mask() & ~(_PAGE_CLEAR_FLAGS))
 
 /* Hardware flags, page size encoding */
 #if !defined(CONFIG_MMU)
diff --git a/arch/sh/include/asm/scatterlist.h b/arch/sh/include/asm/scatterlist.h
index 327cc2e..e38d1d4 100644
--- a/arch/sh/include/asm/scatterlist.h
+++ b/arch/sh/include/asm/scatterlist.h
@@ -1,7 +1,7 @@
 #ifndef __ASM_SH_SCATTERLIST_H
 #define __ASM_SH_SCATTERLIST_H
 
-#define ISA_DMA_THRESHOLD	PHYS_ADDR_MASK
+#define ISA_DMA_THRESHOLD	phys_addr_mask()
 
 #include <asm-generic/scatterlist.h>
 
diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 2ab8cd4..5b73b37 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -95,12 +95,12 @@ static inline void flush_cache_4096(unsigned long start,
 	unsigned long flags, exec_offset = 0;
 
 	/*
-	 * All types of SH-4 require PC to be in P2 to operate on the I-cache.
-	 * Some types of SH-4 require PC to be in P2 to operate on the D-cache.
+	 * All types of SH-4 require PC to uncached to operate on the I-cache.
+	 * Some types of SH-4 require PC to uncached to operate on the D-cache.
 	 */
 	if ((boot_cpu_data.flags & CPU_HAS_P2_FLUSH_BUG) ||
 	    (start < CACHE_OC_ADDRESS_ARRAY))
-		exec_offset = 0x20000000;
+		exec_offset = cached_to_uncached;
 
 	local_irq_save(flags);
 	__flush_cache_4096(start | SH_CACHE_ASSOC,
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 8173e38..c8af6c5 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -323,4 +323,12 @@ int memory_add_physaddr_to_nid(u64 addr)
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #endif
+
 #endif /* CONFIG_MEMORY_HOTPLUG */
+
+#ifdef CONFIG_PMB
+int __in_29bit_mode(void)
+{
+	return !(ctrl_inl(PMB_PASCR) & PASCR_SE);
+}
+#endif /* CONFIG_PMB */
-- 
1.6.3.3

