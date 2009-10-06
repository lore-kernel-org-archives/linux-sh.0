From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:33 +0000
Subject: [PATCH 13/14] sh: Fold fixed-PMB support into dynamic PMB support
Message-Id: <20d41a0fcf8435fd2aaaeb0c0c3975239783b55e.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The initialisation process differs for CONFIG_PMB and for
CONFIG_PMB_FIXED. For CONFIG_PMB_FIXED we need to register the PMB
entries that were allocated by the bootloader.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/mmu.h |    2 +
 arch/sh/kernel/setup.c    |    2 +-
 arch/sh/mm/Makefile       |    3 +-
 arch/sh/mm/pmb-fixed.c    |   45 -------------------------------
 arch/sh/mm/pmb.c          |   65 +++++++++++++++++++++++++++++++++++++++++---
 5 files changed, 64 insertions(+), 53 deletions(-)
 delete mode 100644 arch/sh/mm/pmb-fixed.c

diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
index 9c84b45..c7426ad 100644
--- a/arch/sh/include/asm/mmu.h
+++ b/arch/sh/include/asm/mmu.h
@@ -15,6 +15,8 @@
 #define PMB_E_MASK		0x0000000f
 #define PMB_E_SHIFT		8
 
+#define PMB_PFN_MASK		0xff000000
+
 #define PMB_SZ_16M		0x00000000
 #define PMB_SZ_64M		0x00000010
 #define PMB_SZ_128M		0x00000080
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 8fdd03a..df65fe2 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -453,7 +453,7 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 
-#ifdef CONFIG_PMB
+#ifdef CONFIG_PMB_ENABLE
 	pmb_init();
 #endif
 
diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index 3759bf8..8a70535 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -33,8 +33,7 @@ obj-y				+= $(tlb-y)
 endif
 
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
-obj-$(CONFIG_PMB)		+= pmb.o
-obj-$(CONFIG_PMB_FIXED)		+= pmb-fixed.o
+obj-$(CONFIG_PMB_ENABLE)	+= pmb.o
 obj-$(CONFIG_NUMA)		+= numa.o
 
 # Special flags for fault_64.o.  This puts restrictions on the number of
diff --git a/arch/sh/mm/pmb-fixed.c b/arch/sh/mm/pmb-fixed.c
deleted file mode 100644
index 43c8eac..0000000
--- a/arch/sh/mm/pmb-fixed.c
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * arch/sh/mm/fixed_pmb.c
- *
- * Copyright (C) 2009  Renesas Solutions Corp.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/io.h>
-#include <asm/mmu.h>
-#include <asm/mmu_context.h>
-
-static int __uses_jump_to_uncached fixed_pmb_init(void)
-{
-	int i;
-	unsigned long addr, data;
-
-	jump_to_uncached();
-
-	for (i = 0; i < PMB_ENTRY_MAX; i++) {
-		addr = PMB_DATA + (i << PMB_E_SHIFT);
-		data = ctrl_inl(addr);
-		if (!(data & PMB_V))
-			continue;
-
-		if (data & PMB_C) {
-#if defined(CONFIG_CACHE_WRITETHROUGH)
-			data |= PMB_WT;
-#elif defined(CONFIG_CACHE_WRITEBACK)
-			data &= ~PMB_WT;
-#else
-			data &= ~(PMB_C | PMB_WT);
-#endif
-		}
-		ctrl_outl(data, addr);
-	}
-
-	back_to_cached();
-
-	return 0;
-}
-arch_initcall(fixed_pmb_init);
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index 8c39777..f821c2e 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -70,14 +70,20 @@ repeat:
 }
 
 static struct pmb_entry *pmb_alloc(unsigned long vpn, unsigned long ppn,
-				   unsigned long flags)
+				   unsigned long flags, int entry)
 {
 	struct pmb_entry *pmbe;
 	int pos;
 
-	pos = pmb_alloc_entry();
-	if (pos < 0)
-		return ERR_PTR(pos);
+	if (entry = PMB_NO_ENTRY) {
+		pos = pmb_alloc_entry();
+		if (pos < 0)
+			return ERR_PTR(pos);
+	} else {
+		if (test_bit(entry, &pmb_map))
+			return ERR_PTR(-ENOSPC);
+		pos = entry;
+	}
 
 	pmbe = &pmb_entry_list[pos];
 	if (!pmbe)
@@ -187,7 +193,8 @@ again:
 		if (size < pmb_sizes[i].size)
 			continue;
 
-		pmbe = pmb_alloc(vaddr, phys, pmb_flags | pmb_sizes[i].flag);
+		pmbe = pmb_alloc(vaddr, phys, pmb_flags | pmb_sizes[i].flag,
+				 PMB_NO_ENTRY);
 		if (IS_ERR(pmbe)) {
 			err = PTR_ERR(pmbe);
 			goto out;
@@ -265,6 +272,7 @@ static void __pmb_unmap(struct pmb_entry *pmbe)
 	} while (pmbe);
 }
 
+#ifdef CONFIG_PMB
 int __uses_jump_to_uncached pmb_init(void)
 {
 	unsigned int i;
@@ -302,6 +310,53 @@ int __uses_jump_to_uncached pmb_init(void)
 
 	return 0;
 }
+#else
+int __uses_jump_to_uncached pmb_init(void)
+{
+	int i;
+	unsigned long addr, data;
+
+	jump_to_uncached();
+
+	for (i = 0; i < PMB_ENTRY_MAX; i++) {
+		struct pmb_entry *pmbe;
+		unsigned long vpn, ppn, flags;
+
+		addr = PMB_DATA + (i << PMB_E_SHIFT);
+		data = ctrl_inl(addr);
+		if (!(data & PMB_V))
+			continue;
+
+		if (data & PMB_C) {
+#if defined(CONFIG_CACHE_WRITETHROUGH)
+			data |= PMB_WT;
+#elif defined(CONFIG_CACHE_WRITEBACK)
+			data &= ~PMB_WT;
+#else
+			data &= ~(PMB_C | PMB_WT);
+#endif
+		}
+		ctrl_outl(data, addr);
+
+		ppn = data & PMB_PFN_MASK;
+
+		flags = data & (PMB_C | PMB_WT | PMB_UB);
+		flags |= data & PMB_SZ_MASK;
+
+		addr = PMB_ADDR + (i << PMB_E_SHIFT);
+		data = ctrl_inl(addr);
+
+		vpn = data & PMB_PFN_MASK;
+
+		pmbe = pmb_alloc(vpn, ppn, flags, i);
+		WARN_ON(IS_ERR(pmbe));
+	}
+
+	back_to_cached();
+
+	return 0;
+}
+#endif /* CONFIG_PMB */
 
 static int pmb_seq_show(struct seq_file *file, void *iter)
 {
-- 
1.6.3.3

