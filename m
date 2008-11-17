From: Michael Trimarchi <trimarchimichael@yahoo.it>
Date: Mon, 17 Nov 2008 09:57:58 +0000
Subject: [RFC PATCH] SH4 PTEA register update description
Message-Id: <20081117095758.GA9951@gandalf.sssup.it>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Better description of PTEA register update.

Signed-off-by: Michael Trimarchi <trimarchimichael@yahoo.it>
---
 arch/sh/include/asm/pgtable_32.h          |    8 ++++++++
 arch/sh/include/cpu-sh4/cpu/mmu_context.h |    3 ++-
 arch/sh/mm/tlb-sh4.c                      |    9 ++++++---
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index 72ea209..f83a02b 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -86,6 +86,14 @@
 #define _PAGE_PCC_ATR8	0x60000000	/* Attribute Memory space, 8 bit bus */
 #define _PAGE_PCC_ATR16	0x60000001	/* Attribute Memory space, 6 bit bus */
 
+#ifndef CONFIG_X2TLB
+/* copy the ptea attributes */
+static inline unsigned long copy_ptea_attributes(unsigned long x)
+{
+	return	((x >> 28) & 0xe) | (x & 0x1);
+}
+#endif
+
 /* Mask which drops unused bits from the PTEL value */
 #if defined(CONFIG_CPU_SH3)
 #define _PAGE_CLEAR_FLAGS	(_PAGE_PROTNONE | _PAGE_ACCESSED| \
diff --git a/arch/sh/include/cpu-sh4/cpu/mmu_context.h b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
index 9ea8eb2..9b0d1c4 100644
--- a/arch/sh/include/cpu-sh4/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
@@ -14,7 +14,8 @@
 #define MMU_PTEL	0xFF000004	/* Page table entry register LOW */
 #define MMU_TTB		0xFF000008	/* Translation table base register */
 #define MMU_TEA		0xFF00000C	/* TLB Exception Address */
-#define MMU_PTEA	0xFF000034	/* Page table entry assistance register */
+#define MMU_PTEA	0xFF000034	/* Page table entry assistance
+					 * register */
 
 #define MMUCR		0xFF000010	/* MMU Control Register */
 
diff --git a/arch/sh/mm/tlb-sh4.c b/arch/sh/mm/tlb-sh4.c
index f0c7b73..fd0d11f 100644
--- a/arch/sh/mm/tlb-sh4.c
+++ b/arch/sh/mm/tlb-sh4.c
@@ -61,9 +61,12 @@ void update_mmu_cache(struct vm_area_struct * vma,
 	 */
 	ctrl_outl(pte.pte_high, MMU_PTEA);
 #else
-	if (cpu_data->flags & CPU_HAS_PTEA)
-		/* TODO: make this look less hacky */
-		ctrl_outl(((pteval >> 28) & 0xe) | (pteval & 0x1), MMU_PTEA);
+	if (cpu_data->flags & CPU_HAS_PTEA) {
+		/* The last 3 bits and the first one of pteval contains
+		 * the PTEA timing control and space attribute bits
+		 */
+		ctrl_outl(copy_ptea_attributes(pteval), MMU_PTEA);
+	}
 #endif
 
 	/* Set PTEL register */
-- 
1.5.6.5

