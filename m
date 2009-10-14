From: Valentin R Sitsikov <valentin.sitdikov@siemens.com>
Date: Wed, 14 Oct 2009 12:51:52 +0000
Subject: [PATCH] sh: sh4a: Cache optimization if no cache alias
Message-Id: <4AD5C968.1030005@siemens.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Valentin Sitdikov <valentin.sitdikov@siemens.com>
---
 arch/sh/include/asm/system_32.h |    2 +-
 arch/sh/mm/Makefile             |    1 +
 arch/sh/mm/cache-sh4a.c         |  169 
+++++++++++++++++++++++++++++++++++++++
 arch/sh/mm/cache.c              |    6 ++
 4 files changed, 177 insertions(+), 1 deletions(-)
 create mode 100644 arch/sh/mm/cache-sh4a.c

diff --git a/arch/sh/include/asm/system_32.h 
b/arch/sh/include/asm/system_32.h
index 607d413..7fe8011 100644
--- a/arch/sh/include/asm/system_32.h
+++ b/arch/sh/include/asm/system_32.h
@@ -72,7 +72,7 @@ do {                                    \
 #define __ocbp(addr)    __asm__ __volatile__ ( "ocbp @%0\n\t" : : "r" 
(addr))
 #define __ocbi(addr)    __asm__ __volatile__ ( "ocbi @%0\n\t" : : "r" 
(addr))
 #define __ocbwb(addr)    __asm__ __volatile__ ( "ocbwb @%0\n\t" : : "r" 
(addr))
-
+#define __icbi(addr)    __asm__ __volatile__ ( "icbi @%0\n\t" : : "r" 
(addr))
 struct task_struct *__switch_to(struct task_struct *prev,
                 struct task_struct *next);
 
diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index b70024d..3a2de1d 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -10,6 +10,7 @@ cacheops-$(CONFIG_CPU_SH3)        := cache-sh3.o
 cacheops-$(CONFIG_CPU_SH4)        := cache-sh4.o flush-sh4.o
 cacheops-$(CONFIG_CPU_SH5)        := cache-sh5.o flush-sh4.o
 cacheops-$(CONFIG_SH7705_CACHE_32KB)    += cache-sh7705.o
+cacheops-$(CONFIG_CPU_SH4A)        += cache-sh4a.o
 
 obj-y            += $(cacheops-y)
 
diff --git a/arch/sh/mm/cache-sh4a.c b/arch/sh/mm/cache-sh4a.c
new file mode 100644
index 0000000..147f0e3
--- /dev/null
+++ b/arch/sh/mm/cache-sh4a.c
@@ -0,0 +1,169 @@
+/*
+ * arch/sh/mm/cache-sh4a.c
+ *
+ * Copyright (C) 1999, 2000, 2002  Niibe Yutaka
+ * Copyright (C) 2001 - 2009  Paul Mundt
+ * Copyright (C) 2003  Richard Curnow
+ * Copyright (c) 2007 STMicroelectronics (R&D) Ltd.
+ * Copyright (c) 2009 Valentin Sitdikov
+ *
+ * This file is subject to the terms and conditions of the GNU General 
Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/mutex.h>
+#include <linux/fs.h>
+#include <linux/highmem.h>
+#include <linux/pagemap.h>
+#include <asm/pgtable.h>
+#include <asm/mmu_context.h>
+#include <asm/cacheflush.h>
+
+/*
+ * The maximum number of pages we support up to when doing ranged dcache
+ * flushing. Anything exceeding this will simply flush the dcache in its
+ * entirety.
+ */
+#define MAX_ICACHE_PAGES    32
+
+
+static void sh4a_invalidate_icache(void *start, int size)
+{
+    reg_size_t aligned_start, v, cnt, end;
+
+    aligned_start = register_align(start);
+    v = aligned_start & ~(L1_CACHE_BYTES-1);
+    end = (aligned_start + size + L1_CACHE_BYTES-1)
+        & ~(L1_CACHE_BYTES-1);
+    cnt = (end - v) / L1_CACHE_BYTES;
+
+    while (cnt >= 8) {
+        __icbi(v); v += L1_CACHE_BYTES;
+        __icbi(v); v += L1_CACHE_BYTES;
+        __icbi(v); v += L1_CACHE_BYTES;
+        __icbi(v); v += L1_CACHE_BYTES;
+        __icbi(v); v += L1_CACHE_BYTES;
+        __icbi(v); v += L1_CACHE_BYTES;
+        __icbi(v); v += L1_CACHE_BYTES;
+        __icbi(v); v += L1_CACHE_BYTES;
+        cnt -= 8;
+    }
+
+    while (cnt) {
+        __icbi(v); v += L1_CACHE_BYTES;
+        cnt--;
+    }
+}
+
+/*
+ * Write back the dirty D-caches and invalidate them.
+ *
+ * START: Virtual Address (U0, P1, or P3)
+ * SIZE: Size of the region.
+ */
+static void sh4a_purge_dcache(void *start, int size)
+{
+    reg_size_t aligned_start, v, cnt, end;
+
+    aligned_start = register_align(start);
+    v = aligned_start & ~(L1_CACHE_BYTES-1);
+    end = (aligned_start + size + L1_CACHE_BYTES-1)
+        & ~(L1_CACHE_BYTES-1);
+    cnt = (end - v) / L1_CACHE_BYTES;
+
+    while (cnt >= 8) {
+        __ocbp(v); v += L1_CACHE_BYTES;
+        __ocbp(v); v += L1_CACHE_BYTES;
+        __ocbp(v); v += L1_CACHE_BYTES;
+        __ocbp(v); v += L1_CACHE_BYTES;
+        __ocbp(v); v += L1_CACHE_BYTES;
+        __ocbp(v); v += L1_CACHE_BYTES;
+        __ocbp(v); v += L1_CACHE_BYTES;
+        __ocbp(v); v += L1_CACHE_BYTES;
+        cnt -= 8;
+    }
+    while (cnt) {
+        __ocbp(v); v += L1_CACHE_BYTES;
+        cnt--;
+    }
+}
+
+/*
+ * Write back the range of D-cache, and purge the I-cache.
+ *
+ * Called from kernel/module.c:sys_init_module and routine for a.out 
format,
+ * signal handler code and kprobes code
+ */
+static void __uses_jump_to_uncached sh4a_flush_icache_range(void *args)
+{
+    struct flusher_data *data = args;
+    unsigned long start, end;
+    unsigned long flags, v;
+
+    start = data->addr1;
+    end = data->addr2;
+
+    /* If there are too many pages then just blow away the caches */
+    if (((end - start) >> PAGE_SHIFT) >= MAX_ICACHE_PAGES) {
+        local_flush_cache_all(NULL);
+        return;
+    }
+
+    /*
+     * Selectively flush d-cache then invalidate the i-cache.
+     * This is inefficient, so only use this for small ranges.
+     */
+    start &= ~(L1_CACHE_BYTES-1);
+    end += L1_CACHE_BYTES-1;
+    end &= ~(L1_CACHE_BYTES-1);
+
+    local_irq_save(flags);
+    jump_to_uncached();
+
+    for (v = start; v < end; v += L1_CACHE_BYTES) {
+        __ocbwb(v);
+        __icbi(v);
+    }
+
+    back_to_cached();
+    local_irq_restore(flags);
+}
+
+/*
+ * Write back & invalidate the D-cache of the page.
+ * (To avoid "alias" issues)
+ */
+static void sh4a_flush_dcache_page(void *arg)
+{
+    struct page *page = arg;
+    struct address_space *mapping = page_mapping(page);
+
+#ifndef CONFIG_SMP
+    if (mapping && !mapping_mapped(mapping))
+        set_bit(PG_dcache_dirty, &page->flags);
+    else
+#endif
+    {
+        sh4a_purge_dcache(page_address(page), PAGE_SIZE);
+        sh4a_invalidate_icache(page_address(page), PAGE_SIZE);
+    }
+}
+
+
+/*
+ * SH-4 has virtually indexed and physically tagged cache.
+ */
+void __init sh4a_cache_init(void)
+{
+    printk("SH4A cache optimization\n");
+
+    local_flush_icache_range    = sh4a_flush_icache_range;
+    /* Not sure about alias cases - not checked yet */
+    if (boot_cpu_data.dcache.n_aliases = 0) {
+        local_flush_dcache_page        = sh4a_flush_dcache_page;
+    }
+
+}
diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index 4aa9260..72904d9 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -310,6 +310,12 @@ void __init cpu_cache_init(void)
         extern void __weak sh4_cache_init(void);
 
         sh4_cache_init();
+
+        if(boot_cpu_data.family = CPU_FAMILY_SH4A) {
+            extern void __weak sh4a_cache_init(void);
+
+            sh4a_cache_init();
+        }
     }
 
     if (boot_cpu_data.family = CPU_FAMILY_SH5) {
-- 
1.6.3.3

