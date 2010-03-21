From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 21 Mar 2010 19:51:52 +0000
Subject: [PATCH 2/2] sh: Replace unsafe manipulation of MMUCR
Message-Id: <1269201112-28321-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Setting the TI in MMUCR causes all the TLB bits in MMUCR to be
cleared. Unfortunately, the TLB wired bits are also cleared when setting
the TI bit, causing any wired TLB entries to become unwired.

Use local_flush_tlb_all() which implements TLB flushing in a safer
manner by using the memory-mapped TLB registers. As each CPU has its own
PMB the modifications in pmb_init() only affect the local CPU, so only
flush the local CPU's TLB.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/pmb.c         |    2 +-
 arch/sh/mm/tlbflush_32.c |   21 +++++++++++++++------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index dda628e..3cc2193 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -804,7 +804,7 @@ void __init pmb_init(void)
 	writel_uncached(0, PMB_IRMCR);
 
 	/* Flush out the TLB */
-	__raw_writel(__raw_readl(MMUCR) | MMUCR_TI, MMUCR);
+	local_flush_tlb_all();
 	ctrl_barrier();
 }
 
diff --git a/arch/sh/mm/tlbflush_32.c b/arch/sh/mm/tlbflush_32.c
index 004bb3f..77dc5ef 100644
--- a/arch/sh/mm/tlbflush_32.c
+++ b/arch/sh/mm/tlbflush_32.c
@@ -123,18 +123,27 @@ void local_flush_tlb_mm(struct mm_struct *mm)
 void local_flush_tlb_all(void)
 {
 	unsigned long flags, status;
+	int i;
 
 	/*
 	 * Flush all the TLB.
-	 *
-	 * Write to the MMU control register's bit:
-	 *	TF-bit for SH-3, TI-bit for SH-4.
-	 *      It's same position, bit #2.
 	 */
 	local_irq_save(flags);
+	jump_to_uncached();
+
 	status = __raw_readl(MMUCR);
-	status |= 0x04;
-	__raw_writel(status, MMUCR);
+	status = ((status & MMUCR_URB) >> MMUCR_URB_SHIFT);
+
+	if (status = 0)
+		status = MMUCR_URB_NENTRIES;
+
+	for (i = 0; i < status; i++)
+		__raw_writel(0x0, MMU_UTLB_ADDRESS_ARRAY | (i << 8));
+
+	for (i = 0; i < 4; i++)
+		__raw_writel(0x0, MMU_ITLB_ADDRESS_ARRAY | (i << 8));
+
+	back_to_cached();
 	ctrl_barrier();
 	local_irq_restore(flags);
 }
-- 
1.6.4.rc0

