From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:32 +0000
Subject: [PATCH 12/14] sh: Fix the offset from P1SEG/P2SEG where we map RAM
Message-Id: <ceec8c0d3e37a6042300c17491aed8f0dff9a5b9.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We need to map the gap between 0x00000000 and __MEMORY_START in the PMB,
as well as RAM.

With this change my 7785LCR board can switch to 32bit MMU mode at
runtime.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/pmb.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index f13a18c..8c39777 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -268,7 +268,7 @@ static void __pmb_unmap(struct pmb_entry *pmbe)
 int __uses_jump_to_uncached pmb_init(void)
 {
 	unsigned int i;
-	long size;
+	long size, ret;
 
 	jump_to_uncached();
 
@@ -280,12 +280,13 @@ int __uses_jump_to_uncached pmb_init(void)
 	 *	P1 - provides a cached window onto physical memory
 	 *	P2 - provides an uncached window onto physical memory
 	 */
-	size = pmb_remap(P2SEG, __MEMORY_START, __MEMORY_SIZE,
-			 PMB_WT | PMB_UB);
-	BUG_ON(size != __MEMORY_SIZE);
+	size = __MEMORY_START + __MEMORY_SIZE;
 
-	size = pmb_remap(P1SEG, __MEMORY_START, __MEMORY_SIZE, PMB_C);
-	BUG_ON(size != __MEMORY_SIZE);
+	ret = pmb_remap(P1SEG, 0x00000000, size, PMB_C);
+	BUG_ON(ret != size);
+
+	ret = pmb_remap(P2SEG, 0x00000000, size, PMB_WT | PMB_UB);
+	BUG_ON(ret != size);
 
 	ctrl_outl(0, PMB_IRMCR);
 
-- 
1.6.3.3

