From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 04 Mar 2009 09:00:42 +0000
Subject: [PATCH v2] sh: Add support 32-bit physical addressing by other method
Message-Id: <49AE433A.30503@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There doesn't manage PMB in the kernel. The boot loader should set up PMB.
P1/P2 area is handled like a 29-bit physical addressing, and local bus
device are assinged P3 area.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 changes v2:
  - clean up arch/sh/boot/Makefile
  - fix wrong value for CONFIG_32BIT in arch/sh/kernel/vmlinux_32.lds.S
  - fix typo in arch/sh/mm/Kconfig

 arch/sh/boot/Makefile           |   20 ++++++++++-------
 arch/sh/include/asm/addrspace.h |    4 +-
 arch/sh/include/asm/io.h        |    4 +-
 arch/sh/include/asm/page.h      |    7 +++++-
 arch/sh/kernel/vmlinux_32.lds.S |    5 +++-
 arch/sh/mm/Kconfig              |   30 +++++++++++++++++++++++++-
 arch/sh/mm/Makefile_32          |    1 +
 arch/sh/mm/fixed_pmb.c          |   45 +++++++++++++++++++++++++++++++++++++++
 arch/sh/mm/ioremap_32.c         |    6 +++-
 9 files changed, 105 insertions(+), 17 deletions(-)
 create mode 100644 arch/sh/mm/fixed_pmb.c

diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index c16ccd4..2338435 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -33,20 +33,24 @@ $(obj)/zImage: $(obj)/compressed/vmlinux FORCE
 $(obj)/compressed/vmlinux: FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@

-ifeq ($(CONFIG_32BIT),y)
-KERNEL_LOAD	:= $(shell /bin/bash -c 'printf "0x%08x" \
-		     $$[$(CONFIG_PAGE_OFFSET)  + \
-			$(CONFIG_ZERO_PAGE_OFFSET)]')
-else
+KERNEL_MEMORY := 0x00000000
+ifeq ($(CONFIG_FIXED_PMB),y)
+KERNEL_MEMORY := $(shell /bin/bash -c 'printf "0x%08x" \
+		     $$[$(CONFIG_MEMORY_START) & 0x1fffffff]')
+endif
+ifeq ($(CONFIG_29BIT),y)
+KERNEL_MEMORY := $(shell /bin/bash -c 'printf "0x%08x" \
+		     $$[$(CONFIG_MEMORY_START)]')
+endif
+
 KERNEL_LOAD	:= $(shell /bin/bash -c 'printf "0x%08x" \
 		     $$[$(CONFIG_PAGE_OFFSET)  + \
-			$(CONFIG_MEMORY_START) + \
+			$(KERNEL_MEMORY) + \
 			$(CONFIG_ZERO_PAGE_OFFSET)]')
-endif

 KERNEL_ENTRY	:= $(shell /bin/bash -c 'printf "0x%08x" \
 		     $$[$(CONFIG_PAGE_OFFSET)  + \
-			$(CONFIG_MEMORY_START) + \
+			$(KERNEL_MEMORY) + \
 			$(CONFIG_ZERO_PAGE_OFFSET) + $(CONFIG_ENTRY_OFFSET)]')

 quiet_cmd_uimage = UIMAGE  $@
diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index 36736c7..33fafe4 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -31,7 +31,7 @@
 /* Returns the physical address of a PnSEG (n=1,2) address   */
 #define PHYSADDR(a)	(((unsigned long)(a)) & 0x1fffffff)

-#ifdef CONFIG_29BIT
+#if defined(CONFIG_29BIT) || defined(CONFIG_FIXED_PMB)
 /*
  * Map an address to a certain privileged segment
  */
@@ -43,7 +43,7 @@
 	((__typeof__(a))(((unsigned long)(a) & 0x1fffffff) | P3SEG))
 #define P4SEGADDR(a)	\
 	((__typeof__(a))(((unsigned long)(a) & 0x1fffffff) | P4SEG))
-#endif /* 29BIT */
+#endif /* 29BIT || FIXED_PMB */
 #endif /* P1SEG */

 /* Check if an address can be reached in 29 bits */
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 61f6dae..79794ad 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -238,7 +238,7 @@ extern void onchip_unmap(unsigned long vaddr);
 static inline void __iomem *
 __ioremap_mode(unsigned long offset, unsigned long size, unsigned long flags)
 {
-#ifdef CONFIG_SUPERH32
+#if defined(CONFIG_SUPERH32) && !defined(CONFIG_FIXED_PMB)
 	unsigned long last_addr = offset + size - 1;
 #endif
 	void __iomem *ret;
@@ -247,7 +247,7 @@ __ioremap_mode(unsigned long offset, unsigned long size, unsigned long flags)
 	if (ret)
 		return ret;

-#ifdef CONFIG_SUPERH32
+#if defined(CONFIG_SUPERH32) && !defined(CONFIG_FIXED_PMB)
 	/*
 	 * For P1 and P2 space this is trivial, as everything is already
 	 * mapped. Uncached access for P1 addresses are done through P2.
diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index 5871d78..bcffc46 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -129,7 +129,12 @@ typedef struct page *pgtable_t;
  * is not visible (it is part of the PMB mapping) and so needs to be
  * added or subtracted as required.
  */
-#ifdef CONFIG_32BIT
+#if defined(CONFIG_FIXED_PMB)
+/* phys = virt - PAGE_OFFSET - (__MEMORY_START & 0xe0000000) */
+#define PMB_OFFSET	(PAGE_OFFSET - PXSEG(__MEMORY_START))
+#define __pa(x)	((unsigned long)(x) - PMB_OFFSET)
+#define __va(x)	((void *)((unsigned long)(x) + PMB_OFFSET))
+#elif defined(CONFIG_32BIT)
 #define __pa(x)	((unsigned long)(x)-PAGE_OFFSET+__MEMORY_START)
 #define __va(x)	((void *)((unsigned long)(x)+PAGE_OFFSET-__MEMORY_START))
 #else
diff --git a/arch/sh/kernel/vmlinux_32.lds.S b/arch/sh/kernel/vmlinux_32.lds.S
index 7b4b82b..21af1fa 100644
--- a/arch/sh/kernel/vmlinux_32.lds.S
+++ b/arch/sh/kernel/vmlinux_32.lds.S
@@ -15,7 +15,10 @@ OUTPUT_ARCH(sh)
 ENTRY(_start)
 SECTIONS
 {
-#ifdef CONFIG_32BIT
+#ifdef CONFIG_FIXED_PMB
+	. = CONFIG_PAGE_OFFSET + (CONFIG_MEMORY_START & 0x1fffffff) +
+	    CONFIG_ZERO_PAGE_OFFSET;
+#elif defined(CONFIG_32BIT)
 	. = CONFIG_PAGE_OFFSET + CONFIG_ZERO_PAGE_OFFSET;
 #else
 	. = CONFIG_PAGE_OFFSET + CONFIG_MEMORY_START + CONFIG_ZERO_PAGE_OFFSET;
diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 555ec97..3ea4fd9 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -57,7 +57,7 @@ config 32BIT
 	bool
 	default y if CPU_SH5

-config PMB
+config PMB_ENABLE
 	bool "Support 32-bit physical addressing through PMB"
 	depends on MMU && EXPERIMENTAL && (CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785)
 	select 32BIT
@@ -67,6 +67,34 @@ config PMB
 	  32-bits through the SH-4A PMB. If this is not set, legacy
 	  29-bit physical addressing will be used.

+choice
+	prompt "PMB handling type"
+	depends on PMB_ENABLE
+	default FIXED_PMB
+
+config PMB
+	bool "PMB"
+	depends on MMU && EXPERIMENTAL && (CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785)
+	select 32BIT
+	help
+	  If you say Y here, physical addressing will be extended to
+	  32-bits through the SH-4A PMB. If this is not set, legacy
+	  29-bit physical addressing will be used.
+
+config FIXED_PMB
+	bool "fixed PMB"
+	depends on MMU && EXPERIMENTAL && (CPU_SUBTYPE_SH7780 || \
+					   CPU_SUBTYPE_SH7785)
+	select 32BIT
+	help
+	  If this option is enable, PMB is fixed (extract cache type
+	  setting). You should set up PMB by boot loader beforehand.
+	  P1/P2 area is handled like a 29-bit physical addressing,
+	  and local bus devices are assigned P3 area. So you can use
+	  512Mbyte or less system memory.
+
+endchoice
+
 config X2TLB
 	bool "Enable extended TLB mode"
 	depends on (CPU_SHX2 || CPU_SHX3) && MMU && EXPERIMENTAL
diff --git a/arch/sh/mm/Makefile_32 b/arch/sh/mm/Makefile_32
index cb2f3f2..48606d9 100644
--- a/arch/sh/mm/Makefile_32
+++ b/arch/sh/mm/Makefile_32
@@ -35,6 +35,7 @@ endif

 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PMB)		+= pmb.o
+obj-$(CONFIG_FIXED_PMB)		+= fixed_pmb.o
 obj-$(CONFIG_NUMA)		+= numa.o

 EXTRA_CFLAGS += -Werror
diff --git a/arch/sh/mm/fixed_pmb.c b/arch/sh/mm/fixed_pmb.c
new file mode 100644
index 0000000..43c8eac
--- /dev/null
+++ b/arch/sh/mm/fixed_pmb.c
@@ -0,0 +1,45 @@
+/*
+ * arch/sh/mm/fixed_pmb.c
+ *
+ * Copyright (C) 2009  Renesas Solutions Corp.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <asm/mmu.h>
+#include <asm/mmu_context.h>
+
+static int __uses_jump_to_uncached fixed_pmb_init(void)
+{
+	int i;
+	unsigned long addr, data;
+
+	jump_to_uncached();
+
+	for (i = 0; i < PMB_ENTRY_MAX; i++) {
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
+	}
+
+	back_to_cached();
+
+	return 0;
+}
+arch_initcall(fixed_pmb_init);
diff --git a/arch/sh/mm/ioremap_32.c b/arch/sh/mm/ioremap_32.c
index 8dc7702..a3e4329 100644
--- a/arch/sh/mm/ioremap_32.c
+++ b/arch/sh/mm/ioremap_32.c
@@ -59,11 +59,13 @@ void __iomem *__ioremap(unsigned long phys_addr, unsigned long size,
 	if (is_pci_memaddr(phys_addr) && is_pci_memaddr(last_addr))
 		return (void __iomem *)phys_addr;

+#if !defined(CONFIG_FIXED_PMB)
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
 	if (phys_addr < virt_to_phys(high_memory))
 		return NULL;
+#endif

 	/*
 	 * Mappings have to be page-aligned
@@ -81,7 +83,7 @@ void __iomem *__ioremap(unsigned long phys_addr, unsigned long size,
 	area->phys_addr = phys_addr;
 	orig_addr = addr = (unsigned long)area->addr;

-#ifdef CONFIG_32BIT
+#ifdef CONFIG_PMB
 	/*
 	 * First try to remap through the PMB once a valid VMA has been
 	 * established. Smaller allocations (or the rest of the size
@@ -122,7 +124,7 @@ void __iounmap(void __iomem *addr)
 	if (seg < P3SEG || vaddr >= P3_ADDR_MAX || is_pci_memaddr(vaddr))
 		return;

-#ifdef CONFIG_32BIT
+#ifdef CONFIG_PMB
 	/*
 	 * Purge any PMB entries that may have been established for this
 	 * mapping, then proceed with conventional VMA teardown.
-- 
1.5.5
