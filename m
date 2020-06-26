From: Christoph Hellwig <hch@lst.de>
Date: Fri, 26 Jun 2020 08:07:11 +0000
Subject: [PATCH 04/10] sh: move ioremap_fixed details out of <asm/io.h>
Message-Id: <20200626080717.1999041-5-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200626080717.1999041-1-hch@lst.de>
In-Reply-To: <20200626080717.1999041-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

ioremap_fixed is an internal implementation detail and should not be
exposed to drivers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/include/asm/io.h   | 16 ----------------
 arch/sh/mm/init.c          |  1 +
 arch/sh/mm/ioremap.c       |  1 +
 arch/sh/mm/ioremap.h       | 23 +++++++++++++++++++++++
 arch/sh/mm/ioremap_fixed.c |  1 +
 5 files changed, 26 insertions(+), 16 deletions(-)
 create mode 100644 arch/sh/mm/ioremap.h

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 1fd06ef6a19454..357a7e0c86d682 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -346,22 +346,6 @@ ioremap_prot(phys_addr_t offset, unsigned long size, unsigned long flags)
 }
 #endif
 
-#ifdef CONFIG_IOREMAP_FIXED
-extern void __iomem *ioremap_fixed(phys_addr_t, unsigned long, pgprot_t);
-extern int iounmap_fixed(void __iomem *);
-extern void ioremap_fixed_init(void);
-#else
-static inline void __iomem *
-ioremap_fixed(phys_addr_t phys_addr, unsigned long size, pgprot_t prot)
-{
-	BUG();
-	return NULL;
-}
-
-static inline void ioremap_fixed_init(void) { }
-static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
-#endif
-
 #define ioremap_uc	ioremap
 
 /*
diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a70ba0fdd0b382..da7ea48f9439e2 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/cache.h>
 #include <linux/sizes.h>
+#include "ioremap.h"
 
 pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index f6d02246d665bd..d9ec85b6bb2130 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -24,6 +24,7 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu.h>
+#include "ioremap.h"
 
 /*
  * Remap an arbitrary physical address space into the kernel virtual
diff --git a/arch/sh/mm/ioremap.h b/arch/sh/mm/ioremap.h
new file mode 100644
index 00000000000000..f2544e721a3526
--- /dev/null
+++ b/arch/sh/mm/ioremap.h
@@ -0,0 +1,23 @@
+#ifndef _SH_MM_IORMEMAP_H
+#define _SH_MM_IORMEMAP_H 1
+
+#ifdef CONFIG_IOREMAP_FIXED
+void __iomem *ioremap_fixed(phys_addr_t, unsigned long, pgprot_t);
+int iounmap_fixed(void __iomem *);
+void ioremap_fixed_init(void);
+#else
+static inline void __iomem *
+ioremap_fixed(phys_addr_t phys_addr, unsigned long size, pgprot_t prot)
+{
+	BUG();
+	return NULL;
+}
+static inline void ioremap_fixed_init(void)
+{
+}
+static inline int iounmap_fixed(void __iomem *addr)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_IOREMAP_FIXED */
+#endif /* _SH_MM_IORMEMAP_H */
diff --git a/arch/sh/mm/ioremap_fixed.c b/arch/sh/mm/ioremap_fixed.c
index 07e744d75fa01b..1914b79d1c530b 100644
--- a/arch/sh/mm/ioremap_fixed.c
+++ b/arch/sh/mm/ioremap_fixed.c
@@ -24,6 +24,7 @@
 #include <asm/tlbflush.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
+#include "ioremap.h"
 
 struct ioremap_map {
 	void __iomem *addr;
-- 
2.26.2
