From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 13 Jul 2009 11:38:04 +0000
Subject: [PATCH] sh: Restore previous behaviour on kernel fault
Message-Id: <1247485084-5175-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The last commit changed the behaviour on kernel faults when we were
doing something other than syncing the page tables. vmalloc_sync_one()
needs to return NULL if the page tables are up to date, because the
reason for the fault was not a missing/inconsitent page table entry. By
returning NULL if the page tables are sync'd we signal to the calling
function that further work must be done to resolve this fault.

Also, remove the superfluous __va() around the first argument to
vmalloc_sync_one(). The value of pgd_k is already a virtual address and
using it wth __va() causes a NULL dereference.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/fault_32.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/sh/mm/fault_32.c b/arch/sh/mm/fault_32.c
index 08d0117..dbbdeba 100644
--- a/arch/sh/mm/fault_32.c
+++ b/arch/sh/mm/fault_32.c
@@ -60,8 +60,15 @@ static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
 
 	if (!pmd_present(*pmd))
 		set_pmd(pmd, *pmd_k);
-	else
+	else {
+		/*
+		 * The page tables are fully synchronised so there must
+		 * be another reason for the fault. Return NULL here to
+		 * signal that we have not taken care of the fault.
+		 */
 		BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
+		return NULL;
+	}
 
 	return pmd_k;
 }
@@ -87,7 +94,7 @@ static noinline int vmalloc_fault(unsigned long address)
 	 * an interrupt in the middle of a task switch..
 	 */
 	pgd_k = get_TTB();
-	pmd_k = vmalloc_sync_one(__va((unsigned long)pgd_k), address);
+	pmd_k = vmalloc_sync_one(pgd_k, address);
 	if (!pmd_k)
 		return -1;
 
-- 
1.6.4.rc0

