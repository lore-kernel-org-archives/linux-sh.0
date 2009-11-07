From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 07 Nov 2009 10:55:55 +0000
Subject: [PATCH 1/3] sh: Add fixed ioremap support
Message-Id: <fddf1c79351c0d1d32fb897741f34e1b9bbd21ce.1257590789.git.matt@console-pimps.org>
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

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/fixmap.h |    8 ++
 arch/sh/include/asm/io.h     |    4 +
 arch/sh/kernel/setup.c       |    2 +
 arch/sh/mm/Makefile          |    3 +-
 arch/sh/mm/ioremap_fixed.c   |  209 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 225 insertions(+), 1 deletions(-)
 create mode 100644 arch/sh/mm/ioremap_fixed.c

diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index 76c5a30..e2da609 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -54,6 +54,14 @@ enum fixed_addresses {
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
index 5a947a2..c84a525 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -443,6 +443,8 @@ void __init setup_arch(char **cmdline_p)
 	setup_memory();
 	sparse_init();
 
+	ioremap_fixed_init();
+
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
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
diff --git a/arch/sh/mm/ioremap_fixed.c b/arch/sh/mm/ioremap_fixed.c
new file mode 100644
index 0000000..235aeef
--- /dev/null
+++ b/arch/sh/mm/ioremap_fixed.c
@@ -0,0 +1,209 @@
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
+static pte_t *fixed_pte;
+
+static inline pmd_t *__ioremap_fixed_pmd(unsigned long addr)
+{
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd)) {
+		pgd_ERROR(*pgd);
+		return NULL;
+	}
+
+	pud = pud_offset(pgd, addr);
+	if (pud_none(*pud) || pud_bad(*pud))
+		return NULL;
+
+	/*
+	 * We expected 'pmd' to be empty because we're going to hook up
+	 * 'fixed_pte' into this pmd.
+	 */
+	pmd = pmd_offset(pud, addr);
+	if (!pmd_none(*pmd) || pmd_bad(*pmd))
+		return NULL;
+
+	return pmd;
+}
+
+static void
+__ioremap_set_fixmap(enum fixed_addresses idx, unsigned long phys,
+		     pgprot_t prot, int load)
+{
+	unsigned long addr;
+	pte_t *pte;
+
+	if (idx < FIX_IOREMAP_BEGIN || idx >= FIX_IOREMAP_END)
+		return;
+
+	addr = __fix_to_virt(idx);
+	pte = &fixed_pte[pte_index(addr)];
+
+	set_pte(pte, pfn_pte(phys >> PAGE_SHIFT, prot));
+	local_flush_tlb_one(get_asid(), addr);
+
+	if (load) {
+		/*
+		 * per_cpu_trap_init() hasn't been called yet so we
+		 * haven't initialised VBR and can't fixup a data TLB
+		 * miss in software. We have to preload the TLB with the
+		 * mapping.
+		 */
+		__update_tlb(NULL, addr, *pte);
+	}
+}
+
+void __init ioremap_fixed_init(void)
+{
+	struct ioremap_map *map;
+	unsigned long addr;
+	pmd_t *pmd;
+	int i;
+
+	addr = __fix_to_virt(FIX_IOREMAP_BEGIN);
+	pmd = __ioremap_fixed_pmd(addr);
+
+	if (!pmd) {
+		printk(KERN_ERR "%s: Page tables in unexpected state\n",
+		       __func__);
+		return;
+	}
+
+	fixed_pte = (pte_t *)alloc_bootmem_low_pages(PAGE_SIZE);
+	pmd_populate_kernel(&init_mm, pmd, fixed_pte);
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
+		__ioremap_set_fixmap(idx, phys_addr, prot, 1);
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
+		__ioremap_set_fixmap(idx, 0, __pgprot(0), 0);
+		idx++;
+		--nrpages;
+	}
+
+	map->size = 0;
+	map->addr = NULL;
+}
-- 
1.6.2.5

