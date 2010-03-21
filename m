From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 21 Mar 2010 19:51:43 +0000
Subject: [PATCH 1/2] sh: Flush ITLB too in PTEAEX's flush_tlb_page()
Message-Id: <1269201103-28283-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

flush_tlb_page() can be used to flush TLB entries that map executable
pages. Therefore, we need to ensure that the ITLB is also flushed in
local_flush_tlb_page().

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/cpu-sh4/cpu/mmu_context.h |    2 ++
 arch/sh/mm/tlb-pteaex.c                   |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/mmu_context.h b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
index 03ea75c..310ec92 100644
--- a/arch/sh/include/cpu-sh4/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
@@ -19,6 +19,8 @@
 
 #define MMUCR		0xFF000010	/* MMU Control Register */
 
+#define MMU_ITLB_ADDRESS_ARRAY  0xF2000000
+#define MMU_ITLB_ADDRESS_ARRAY2	0xF2800000
 #define MMU_UTLB_ADDRESS_ARRAY	0xF6000000
 #define MMU_UTLB_ADDRESS_ARRAY2	0xF6800000
 #define MMU_PAGE_ASSOC_BIT	0x80
diff --git a/arch/sh/mm/tlb-pteaex.c b/arch/sh/mm/tlb-pteaex.c
index 32dc674..bdd0982 100644
--- a/arch/sh/mm/tlb-pteaex.c
+++ b/arch/sh/mm/tlb-pteaex.c
@@ -73,5 +73,7 @@ void local_flush_tlb_one(unsigned long asid, unsigned long page)
 	jump_to_uncached();
 	__raw_writel(page, MMU_UTLB_ADDRESS_ARRAY | MMU_PAGE_ASSOC_BIT);
 	__raw_writel(asid, MMU_UTLB_ADDRESS_ARRAY2 | MMU_PAGE_ASSOC_BIT);
+	__raw_writel(page, MMU_ITLB_ADDRESS_ARRAY | MMU_PAGE_ASSOC_BIT);
+	__raw_writel(asid, MMU_ITLB_ADDRESS_ARRAY2 | MMU_PAGE_ASSOC_BIT);
 	back_to_cached();
 }
-- 
1.6.4.rc0

