From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 08 Jul 2008 20:20:31 +0000
Subject: Re: [PATCH] SH2(A) cache update
Message-Id: <87skukp1ps.wl%ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87hcb37h0a.wl%ysato@users.sourceforge.jp>
In-Reply-To: <87hcb37h0a.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Sorry I forget flush_icache_region.
Update patch.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index 29d8e3c..a84a104 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -229,7 +229,6 @@ choice
 
 config CACHE_WRITEBACK
 	bool "Write-back"
-	depends on CPU_SH2A || CPU_SH3 || CPU_SH4 || CPU_SH5
 
 config CACHE_WRITETHROUGH
 	bool "Write-through"
diff --git a/arch/sh/mm/Makefile_32 b/arch/sh/mm/Makefile_32
index e295db6..70e0906 100644
--- a/arch/sh/mm/Makefile_32
+++ b/arch/sh/mm/Makefile_32
@@ -5,12 +5,15 @@
 obj-y			:= init.o extable_32.o consistent.o
 
 ifndef CONFIG_CACHE_OFF
-obj-$(CONFIG_CPU_SH2)		+= cache-sh2.o
-obj-$(CONFIG_CPU_SH3)		+= cache-sh3.o
-obj-$(CONFIG_CPU_SH4)		+= cache-sh4.o
-obj-$(CONFIG_SH7705_CACHE_32KB)	+= cache-sh7705.o
+cache-$(CONFIG_CPU_SH2)		:= cache-sh2.o
+cache-$(CONFIG_CPU_SH2A)	:= cache-sh2a.o
+cache-$(CONFIG_CPU_SH3)		:= cache-sh3.o
+cache-$(CONFIG_CPU_SH4)		:= cache-sh4.o
+cache-$(CONFIG_SH7705_CACHE_32KB)	+= cache-sh7705.o
 endif
 
+obj-y			+= $(cache-y)
+
 mmu-y			:= tlb-nommu.o pg-nommu.o
 mmu-$(CONFIG_MMU)	:= fault_32.o tlbflush_32.o ioremap_32.o
 
diff --git a/arch/sh/mm/cache-sh2.c b/arch/sh/mm/cache-sh2.c
index 6614033..cfa5d80 100644
--- a/arch/sh/mm/cache-sh2.c
+++ b/arch/sh/mm/cache-sh2.c
@@ -2,6 +2,7 @@
  * arch/sh/mm/cache-sh2.c
  *
  * Copyright (C) 2002 Paul Mundt
+ * Copyright (C) 2008 Yoshinori Sato
  *
  * Released under the terms of the GNU GPL v2.0.
  */
@@ -15,6 +16,74 @@
 #include <asm/cacheflush.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_CPU_SUBTYPE_SH7619
+void __flush_wback_region(void *start, int size)
+{
+	unsigned long v;
+	unsigned long begin, end;
+
+	begin = (unsigned long)start & ~(L1_CACHE_BYTES-1);
+	end = ((unsigned long)start + size + L1_CACHE_BYTES-1)
+		& ~(L1_CACHE_BYTES-1);
+	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
+		unsigned long addr = CACHE_OC_ADDRESS_ARRAY | (v & 0x00000ff0);
+		int way;
+		for (way = 0; way < 4; way++) {
+			unsigned long data =  ctrl_inl(addr | (way << 12));
+			if ((data & CACHE_PHYSADDR_MASK) = (v & CACHE_PHYSADDR_MASK)) {
+				data &= ~SH_CACHE_UPDATED;
+				ctrl_outl(data, addr | (way << 12));
+			}
+		}
+	}
+}
+
+void __flush_purge_region(void *start, int size)
+{
+	unsigned long v;
+	unsigned long begin, end;
+
+	begin = (unsigned long)start & ~(L1_CACHE_BYTES-1);
+	end = ((unsigned long)start + size + L1_CACHE_BYTES-1)
+		& ~(L1_CACHE_BYTES-1);
+	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
+		ctrl_outl((v & CACHE_PHYSADDR_MASK), 
+			  CACHE_OC_ADDRESS_ARRAY | (v & 0x00000ff0) | 0x00000008);
+	}
+}
+
+void __flush_invalidate_region(void *start, int size)
+{
+#ifdef CONFIG_CACHE_WRITEBACK
+/*
+   SH-2 is line invalidate not support
+   All line invalidate
+*/
+	unsigned long ccr;
+	unsigned long flags;
+	local_irq_save(flags);
+	jump_to_uncached();
+
+	ccr = ctrl_inl(CCR);
+	ccr |= CCR_CACHE_INVALIDATE;
+	ctrl_outl(ccr, CCR);
+
+	back_to_cached();
+	local_irq_restore(flags);
+#else
+	unsigned long v;
+	unsigned long begin, end;
+
+	begin = (unsigned long)start & ~(L1_CACHE_BYTES-1);
+	end = ((unsigned long)start + size + L1_CACHE_BYTES-1)
+		& ~(L1_CACHE_BYTES-1);
+	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
+		ctrl_outl((v & CACHE_PHYSADDR_MASK), 
+			  CACHE_OC_ADDRESS_ARRAY | (v & 0x00000ff0) | 0x00000008);
+	}
+#endif
+}
+#else
 void __flush_wback_region(void *start, int size)
 {
 	unsigned long v;
@@ -54,4 +123,5 @@ void __flush_invalidate_region(void *start, int size)
 		ctrl_outl((v & 0x1ffffc00), (v & 0x00000ff0) | 0x00000008);
 	}
 }
+#endif
 
diff --git a/arch/sh/mm/cache-sh2a.c b/arch/sh/mm/cache-sh2a.c
new file mode 100644
index 0000000..c35fa24
--- /dev/null
+++ b/arch/sh/mm/cache-sh2a.c
@@ -0,0 +1,134 @@
+/*
+ * arch/sh/mm/cache-sh2a.c
+ *
+ * Copyright (C) 2008 Yoshinori Sato
+ *
+ * Released under the terms of the GNU GPL v2.0.
+ */
+
+#include <linux/init.h>
+#include <linux/mm.h>
+
+#include <asm/cache.h>
+#include <asm/addrspace.h>
+#include <asm/processor.h>
+#include <asm/cacheflush.h>
+#include <asm/io.h>
+
+void __flush_wback_region(void *start, int size)
+{
+	unsigned long v;
+	unsigned long begin, end;
+	unsigned long flags;
+
+	begin = (unsigned long)start & ~(L1_CACHE_BYTES-1);
+	end = ((unsigned long)start + size + L1_CACHE_BYTES-1)
+		& ~(L1_CACHE_BYTES-1);
+
+	local_irq_save(flags);
+	jump_to_uncached();
+
+	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
+		unsigned long addr = CACHE_OC_ADDRESS_ARRAY | (v & 0x000007f0);
+		int way;
+		for (way = 0; way < 4; way++) {
+			unsigned long data =  ctrl_inl(addr | (way << 11));
+			if ((data & CACHE_PHYSADDR_MASK) = (v & CACHE_PHYSADDR_MASK)) {
+				data &= ~SH_CACHE_UPDATED;
+				ctrl_outl(data, addr | (way << 11));
+			}
+		}
+	}
+
+	back_to_cached();
+	local_irq_restore(flags);
+}
+
+void __flush_purge_region(void *start, int size)
+{
+	unsigned long v;
+	unsigned long begin, end;
+	unsigned long flags;
+
+	begin = (unsigned long)start & ~(L1_CACHE_BYTES-1);
+	end = ((unsigned long)start + size + L1_CACHE_BYTES-1)
+		& ~(L1_CACHE_BYTES-1);
+
+	local_irq_save(flags);
+	jump_to_uncached();
+
+	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
+		ctrl_outl((v & CACHE_PHYSADDR_MASK),
+			  CACHE_OC_ADDRESS_ARRAY | (v & 0x000003f0) | 0x00000008);
+	}
+	back_to_cached();
+	local_irq_restore(flags);
+}
+
+void __flush_invalidate_region(void *start, int size)
+{
+	unsigned long v;
+	unsigned long begin, end;
+	unsigned long flags;
+
+	begin = (unsigned long)start & ~(L1_CACHE_BYTES-1);
+	end = ((unsigned long)start + size + L1_CACHE_BYTES-1)
+		& ~(L1_CACHE_BYTES-1);
+	local_irq_save(flags);
+	jump_to_uncached();
+
+#ifdef CONFIG_CACHE_WRITEBACK
+/*
+   SH-2A O-cache is line invalidate not support
+   All line invalidate
+*/
+	ctrl_outl(ctrl_inl(CCR) | CCR_OCACHE_INVALIDATE, CCR);
+	/* I-cache invalidate */
+	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
+		ctrl_outl((v & CACHE_PHYSADDR_MASK),
+			  CACHE_IC_ADDRESS_ARRAY | (v & 0x000003f0) | 0x00000008);
+	}
+#else
+	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
+		ctrl_outl((v & CACHE_PHYSADDR_MASK),
+			  CACHE_IC_ADDRESS_ARRAY | (v & 0x000003f0) | 0x00000008);
+		ctrl_outl((v & CACHE_PHYSADDR_MASK),
+			  CACHE_OC_ADDRESS_ARRAY | (v & 0x000003f0) | 0x00000008);
+	}
+#endif
+	back_to_cached();
+	local_irq_restore(flags);
+}
+
+/* WBack O-Cache and flush I-Cache */
+void flush_icache_range(unsigned long start, unsigned long end)
+{
+	unsigned long v;
+	unsigned long flags;
+
+	start = start & ~(L1_CACHE_BYTES-1);
+	end = (end + L1_CACHE_BYTES-1) & ~(L1_CACHE_BYTES-1);
+
+	local_irq_save(flags);
+	jump_to_uncached();
+
+	for (v = start; v < end; v+=L1_CACHE_BYTES) {
+		unsigned long addr = (v & 0x000007f0);
+		int way;
+		/* O-Cache writeback */
+		for (way = 0; way < 4; way++) {
+			unsigned long data =  ctrl_inl(CACHE_OC_ADDRESS_ARRAY | addr | (way << 11));
+			if ((data & CACHE_PHYSADDR_MASK) = (v & CACHE_PHYSADDR_MASK)) {
+				data &= ~SH_CACHE_UPDATED;
+				ctrl_outl(data, CACHE_OC_ADDRESS_ARRAY | addr | (way << 11));
+			}
+		}
+		/* I-Cache invalidate */
+		ctrl_outl(addr,
+			  CACHE_IC_ADDRESS_ARRAY | addr | 0x00000008);
+	}
+
+	back_to_cached();
+	local_irq_restore(flags);
+}
+
diff --git a/include/asm-sh/cpu-sh2/cache.h b/include/asm-sh/cpu-sh2/cache.h
index 4e0b165..673515b 100644
--- a/include/asm-sh/cpu-sh2/cache.h
+++ b/include/asm-sh/cpu-sh2/cache.h
@@ -21,11 +21,11 @@
 #define CCR		0xffffffec
 
 #define CCR_CACHE_CE	0x01	/* Cache enable */
-#define CCR_CACHE_WT	0x06    /* CCR[bit1=1,bit2=1] */
+#define CCR_CACHE_WT	0x02    /* CCR[bit1=1,bit2=1] */
 				/* 0x00000000-0x7fffffff: Write-through  */
 				/* 0x80000000-0x9fffffff: Write-back     */
                                 /* 0xc0000000-0xdfffffff: Write-through  */
-#define CCR_CACHE_CB	0x00    /* CCR[bit1=0,bit2=0] */
+#define CCR_CACHE_CB	0x04    /* CCR[bit1=0,bit2=0] */
 				/* 0x00000000-0x7fffffff: Write-back     */
 				/* 0x80000000-0x9fffffff: Write-through  */
                                 /* 0xc0000000-0xdfffffff: Write-back     */
@@ -36,6 +36,8 @@
 
 #define CCR_CACHE_ENABLE	CCR_CACHE_CE
 #define CCR_CACHE_INVALIDATE	CCR_CACHE_CF
+#define CACHE_PHYSADDR_MASK	0x1ffffc00
+
 #endif
 
 #endif /* __ASM_CPU_SH2_CACHE_H */
diff --git a/include/asm-sh/cpu-sh2a/cache.h b/include/asm-sh/cpu-sh2a/cache.h
index afe228b..defb0ba 100644
--- a/include/asm-sh/cpu-sh2a/cache.h
+++ b/include/asm-sh/cpu-sh2a/cache.h
@@ -36,5 +36,8 @@
 
 #define CCR_CACHE_ENABLE	(CCR_CACHE_OCE | CCR_CACHE_ICE)
 #define CCR_CACHE_INVALIDATE	(CCR_CACHE_OCI | CCR_CACHE_ICI)
+#define CCR_ICACHE_INVALIDATE	CCR_CACHE_ICI
+#define CCR_OCACHE_INVALIDATE	CCR_CACHE_OCI
+#define CACHE_PHYSADDR_MASK	0x1ffffc00
 
 #endif /* __ASM_CPU_SH2A_CACHE_H */
diff --git a/include/asm-sh/cpu-sh2a/cacheflush.h b/include/asm-sh/cpu-sh2a/cacheflush.h
index fa3186c..ca679ff 100644
--- a/include/asm-sh/cpu-sh2a/cacheflush.h
+++ b/include/asm-sh/cpu-sh2a/cacheflush.h
@@ -1 +1,43 @@
-#include <asm/cpu-sh2/cacheflush.h>
+/*
+ * include/asm-sh/cpu-sh2a/cacheflush.h
+ *
+ * Copyright (C) 2003 Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#ifndef __ASM_CPU_SH2A_CACHEFLUSH_H
+#define __ASM_CPU_SH2A_CACHEFLUSH_H
+
+/* 
+ * Cache flushing:
+ *
+ *  - flush_cache_all() flushes entire cache
+ *  - flush_cache_mm(mm) flushes the specified mm context's cache lines
+ *  - flush_cache_dup mm(mm) handles cache flushing when forking
+ *  - flush_cache_page(mm, vmaddr, pfn) flushes a single page
+ *  - flush_cache_range(vma, start, end) flushes a range of pages
+ *
+ *  - flush_dcache_page(pg) flushes(wback&invalidates) a page for dcache
+ *  - flush_icache_range(start, end) flushes(invalidates) a range for icache
+ *  - flush_icache_page(vma, pg) flushes(invalidates) a page for icache
+ *
+ *  Caches are indexed (effectively) by physical address on SH-2, so
+ *  we don't need them.
+ */
+#define flush_cache_all()			do { } while (0)
+#define flush_cache_mm(mm)			do { } while (0)
+#define flush_cache_dup_mm(mm)			do { } while (0)
+#define flush_cache_range(vma, start, end)	do { } while (0)
+#define flush_cache_page(vma, vmaddr, pfn)	do { } while (0)
+#define flush_dcache_page(page)			do { } while (0)
+#define flush_dcache_mmap_lock(mapping)		do { } while (0)
+#define flush_dcache_mmap_unlock(mapping)	do { } while (0)
+void flush_icache_range(unsigned long start, unsigned long end);
+#define flush_icache_page(vma,pg)		do { } while (0)
+#define flush_icache_user_range(vma,pg,adr,len)	do { } while (0)
+#define flush_cache_sigtramp(vaddr)		do { } while (0)
+
+#define p3_cache_init()				do { } while (0)
+#endif /* __ASM_CPU_SH2A_CACHEFLUSH_H */

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
