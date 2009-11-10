From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 10 Nov 2009 21:06:02 +0000
Subject: [PATCH v2] sh: Add fixed ioremap support
Message-Id: <1257887162-2721-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Some devices need to be ioremap'd and accessed very early in the boot
process. It is not possible to use the standard ioremap() function in
this case because that requires kmalloc()'ing some virtual address space
and kmalloc() may not be available so early in boot.

This patch provides fixmap mappings that allow physical address ranges
to be remapped into the kernel address space during the early boot
stages.

Changes in v2:
	- Generalize set_pte_phys() to do the TLB updating for us.
	- Call paging_init() earlier, so that it sets up the page tables
	  for us instead of setting them up manually in
	  ioremap_fixed_init().

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/fixmap.h |   17 ++++-
 arch/sh/include/asm/io.h     |    4 +
 arch/sh/kernel/setup.c       |    6 +-
 arch/sh/mm/Makefile          |    3 +-
 arch/sh/mm/init.c            |   13 +++-
 arch/sh/mm/ioremap_fixed.c   |  141 ++++++++++++++++++++++++++++++++++++++++++
 arch/sh/mm/nommu.c           |    3 +-
 7 files changed, 176 insertions(+), 11 deletions(-)
 create mode 100644 arch/sh/mm/ioremap_fixed.c

diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index 76c5a30..0038881 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -54,19 +54,30 @@ enum fixed_addresses {
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
+	/*
+	 * FIX_IOREMAP entries are useful for mapping physical address
+	 * space before ioremap() is useable, e.g. really early in boot
+	 * before kmalloc() is working.
+	 */
+#define FIX_N_IOREMAPS	32
+	FIX_IOREMAP_BEGIN,
+	FIX_IOREMAP_END = FIX_IOREMAP_BEGIN + FIX_N_IOREMAPS,
 	__end_of_fixed_addresses
 };
 
+#define FIXMAP_UPDATE_TLB	0x0001	/* Load the fixmap's pte into TLB */
+#define FIXMAP_CLEAR		0x0002	/* Clear (zero) the pte for fixmap */
+
 extern void __set_fixmap(enum fixed_addresses idx,
-			 unsigned long phys, pgprot_t flags);
+			 unsigned long phys, pgprot_t prot, int flags);
 
 #define set_fixmap(idx, phys) \
-		__set_fixmap(idx, phys, PAGE_KERNEL)
+		__set_fixmap(idx, phys, PAGE_KERNEL, 0)
 /*
  * Some hardware wants to get fixmapped without caching.
  */
 #define set_fixmap_nocache(idx, phys) \
-		__set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE)
+		__set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE, 0)
 /*
  * used by vmalloc.c.
  *
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 0cf2a57..1f11da7 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -294,6 +294,10 @@ __ioremap_mode(unsigned long offset, unsigned long size, unsigned long flags)
 #define iounmap(addr)					\
 	__iounmap((addr))
 
+extern void __iomem *ioremap_fixed(resource_size_t, unsigned long, pgprot_t);
+extern void iounmap_fixed(void __iomem *);
+extern void ioremap_fixed_init(void);
+
 #define maybebadio(port) \
 	printk(KERN_ERR "bad PC-like io %s:%u for port 0x%lx at 0x%08x\n", \
 	       __func__, __LINE__, (port), (u32)__builtin_return_address(0))
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 5a947a2..dd0c86a 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -443,6 +443,10 @@ void __init setup_arch(char **cmdline_p)
 	setup_memory();
 	sparse_init();
 
+	paging_init();
+
+	ioremap_fixed_init();
+
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
@@ -451,8 +455,6 @@ void __init setup_arch(char **cmdline_p)
 	if (likely(sh_mv.mv_setup))
 		sh_mv.mv_setup(cmdline_p);
 
-	paging_init();
-
 #ifdef CONFIG_PMB_ENABLE
 	pmb_init();
 #endif
diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index 8a70535..f554730 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -15,7 +15,8 @@ obj-y			+= $(cacheops-y)
 
 mmu-y			:= nommu.o extable_32.o
 mmu-$(CONFIG_MMU)	:= extable_$(BITS).o fault_$(BITS).o \
-			   ioremap_$(BITS).o kmap.o tlbflush_$(BITS).o
+			   ioremap_$(BITS).o ioremap_fixed.o kmap.o \
+			   tlbflush_$(BITS).o
 
 obj-y			+= $(mmu-y)
 obj-$(CONFIG_DEBUG_FS)	+= asids-debugfs.o
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 432acd0..513fa39 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -39,7 +39,8 @@ unsigned long cached_to_uncached = P2SEG - P1SEG;
 #endif
 
 #ifdef CONFIG_MMU
-static void set_pte_phys(unsigned long addr, unsigned long phys, pgprot_t prot)
+static void set_pte_phys(unsigned long addr, unsigned long phys,
+			 pgprot_t prot, int flags)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -65,13 +66,16 @@ static void set_pte_phys(unsigned long addr, unsigned long phys, pgprot_t prot)
 	}
 
 	pte = pte_offset_kernel(pmd, addr);
-	if (!pte_none(*pte)) {
+	if ((flags & FIXMAP_CLEAR) && !pte_none(*pte)) {
 		pte_ERROR(*pte);
 		return;
 	}
 
 	set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, prot));
 	local_flush_tlb_one(get_asid(), addr);
+
+	if (flags & FIXMAP_UPDATE_TLB)
+		__update_tlb(NULL, addr, *pte);
 }
 
 /*
@@ -89,7 +93,8 @@ static void set_pte_phys(unsigned long addr, unsigned long phys, pgprot_t prot)
  *
  *					 -- PFM.
  */
-void __set_fixmap(enum fixed_addresses idx, unsigned long phys, pgprot_t prot)
+void __set_fixmap(enum fixed_addresses idx, unsigned long phys,
+		  pgprot_t prot, int flags)
 {
 	unsigned long address = __fix_to_virt(idx);
 
@@ -98,7 +103,7 @@ void __set_fixmap(enum fixed_addresses idx, unsigned long phys, pgprot_t prot)
 		return;
 	}
 
-	set_pte_phys(address, phys, prot);
+	set_pte_phys(address, phys, prot, flags);
 }
 
 void __init page_table_range_init(unsigned long start, unsigned long end,
diff --git a/arch/sh/mm/ioremap_fixed.c b/arch/sh/mm/ioremap_fixed.c
new file mode 100644
index 0000000..2f4800e
--- /dev/null
+++ b/arch/sh/mm/ioremap_fixed.c
@@ -0,0 +1,141 @@
+/*
+ * Re-map IO memory to kernel address space so that we can access it.
+ *
+ * These functions should only be used when it is necessary to map a
+ * physical address space into the kernel address space before ioremap()
+ * can be used, e.g. early in boot before paging_init().
+ *
+ * Copyright (C) 2009  Matt Fleming
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/bootmem.h>
+#include <linux/proc_fs.h>
+#include <linux/slab.h>
+#include <asm/fixmap.h>
+#include <asm/page.h>
+#include <asm/pgalloc.h>
+#include <asm/addrspace.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm/mmu.h>
+#include <asm/mmu_context.h>
+
+struct ioremap_map {
+	void __iomem *addr;
+	unsigned long size;
+	unsigned long fixmap_addr;
+};
+
+static struct ioremap_map ioremap_maps[FIX_N_IOREMAPS];
+
+void __init ioremap_fixed_init(void)
+{
+	struct ioremap_map *map;
+	int i;
+
+	for (i = 0; i < FIX_N_IOREMAPS; i++) {
+		map = &ioremap_maps[i];
+		map->fixmap_addr = __fix_to_virt(FIX_IOREMAP_BEGIN + i);
+	}
+}
+
+void __init __iomem *
+ioremap_fixed(resource_size_t phys_addr, unsigned long size, pgprot_t prot)
+{
+	enum fixed_addresses idx0, idx;
+	resource_size_t last_addr;
+	struct ioremap_map *map;
+	unsigned long offset;
+	unsigned int nrpages;
+	int i, slot;
+
+	slot = -1;
+	for (i = 0; i < FIX_N_IOREMAPS; i++) {
+		map = &ioremap_maps[i];
+		if (!map->addr) {
+			map->size = size;
+			slot = i;
+			break;
+		}
+	}
+
+	if (slot < 0)
+		return NULL;
+
+	/* Don't allow wraparound or zero size */
+	last_addr = phys_addr + size - 1;
+	if (!size || last_addr < phys_addr)
+		return NULL;
+
+	/*
+	 * Fixmap mappings have to be page-aligned
+	 */
+	offset = phys_addr & ~PAGE_MASK;
+	phys_addr &= PAGE_MASK;
+	size = PAGE_ALIGN(last_addr + 1) - phys_addr;
+
+	/*
+	 * Mappings have to fit in the FIX_IOREMAP area.
+	 */
+	nrpages = size >> PAGE_SHIFT;
+	if (nrpages > FIX_N_IOREMAPS)
+		return NULL;
+
+	/*
+	 * Ok, go for it..
+	 */
+	idx0 = FIX_IOREMAP_BEGIN + slot;
+	idx = idx0;
+	while (nrpages > 0) {
+
+		__set_fixmap(idx, phys_addr, prot, FIXMAP_TLB_LOAD);
+		phys_addr += PAGE_SIZE;
+		idx++;
+		--nrpages;
+	}
+
+	map->addr = (void __iomem *)(offset + map->fixmap_addr);
+	return map->addr;
+}
+
+void __init iounmap_fixed(void __iomem *addr)
+{
+	enum fixed_addresses idx;
+	unsigned long virt_addr;
+	struct ioremap_map *map;
+	unsigned long offset;
+	unsigned int nrpages;
+	int i, slot;
+
+	slot = -1;
+	for (i = 0; i < FIX_N_IOREMAPS; i++) {
+		map = &ioremap_maps[i];
+		if (map->addr = addr) {
+			slot = i;
+			break;
+		}
+	}
+
+	if (slot < 0)
+		return;
+
+	virt_addr = (unsigned long)addr;
+
+	offset = virt_addr & ~PAGE_MASK;
+	nrpages = PAGE_ALIGN(offset + map->size - 1) >> PAGE_SHIFT;
+
+	idx = FIX_IOREMAP_BEGIN + slot;
+	while (nrpages > 0) {
+		__set_fixmap(idx, 0, __pgprot(0), 0);
+		idx++;
+		--nrpages;
+	}
+
+	map->size = 0;
+	map->addr = NULL;
+}
diff --git a/arch/sh/mm/nommu.c b/arch/sh/mm/nommu.c
index ac16c05..4b4eb50 100644
--- a/arch/sh/mm/nommu.c
+++ b/arch/sh/mm/nommu.c
@@ -91,6 +91,7 @@ void __init page_table_range_init(unsigned long start, unsigned long end,
 {
 }
 
-void __set_fixmap(enum fixed_addresses idx, unsigned long phys, pgprot_t prot)
+void __set_fixmap(enum fixed_addresses idx, unsigned long phys,
+		  pgprot_t prot, int flags)
 {
 }
-- 
1.6.2.5

