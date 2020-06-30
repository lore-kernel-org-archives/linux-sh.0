From: Peter Xu <peterx@redhat.com>
Date: Tue, 30 Jun 2020 20:45:51 +0000
Subject: [PATCH v4 19/26] mm/sh: Use general page fault accounting
Message-Id: <20200630204551.39391-1-peterx@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com, John Hubbard <jhubbard@nvidia.com>, Michael Ellerman <mpe@ellerman.id.au>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: Yoshinori Sato <ysato@users.sourceforge.jp>
CC: Rich Felker <dalias@libc.org>
CC: linux-sh@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/sh/mm/fault.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 3c0a11827f7e..482668a2f6d3 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -482,22 +482,13 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 
 	if (unlikely(fault & (VM_FAULT_RETRY | VM_FAULT_ERROR)))
 		if (mm_fault_error(regs, error_code, address, fault))
 			return;
 
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			flags |= FAULT_FLAG_TRIED;
 
-- 
2.26.2
