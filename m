From: Yang Shi <yang.shi@linaro.org>
Date: Tue, 01 Dec 2015 23:06:16 +0000
Subject: [PATCH 6/7] sh: mm/gup: add gup trace points
Message-Id: <1449011177-30686-7-git-send-email-yang.shi@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1449011177-30686-1-git-send-email-yang.shi@linaro.org>
In-Reply-To: <1449011177-30686-1-git-send-email-yang.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linaro-kernel@lists.linaro.org, yang.shi@linaro.org, linux-sh@vger.kernel.org

Cc: linux-sh@vger.kernel.org
Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/sh/mm/gup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sh/mm/gup.c b/arch/sh/mm/gup.c
index e7af6a6..6df3e97 100644
--- a/arch/sh/mm/gup.c
+++ b/arch/sh/mm/gup.c
@@ -12,6 +12,10 @@
 #include <linux/mm.h>
 #include <linux/vmstat.h>
 #include <linux/highmem.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/gup.h>
+
 #include <asm/pgtable.h>
 
 static inline pte_t gup_get_pte(pte_t *ptep)
@@ -178,6 +182,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 					(void __user *)start, len)))
 		return 0;
 
+	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
+
 	/*
 	 * This doesn't prevent pagetable teardown, but does prevent
 	 * the pagetables and pages from being freed.
@@ -231,6 +237,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	if (end < start)
 		goto slow_irqon;
 
+	trace_gup_get_user_pages_fast(start, nr_pages, write, pages);
+
 	local_irq_disable();
 	pgdp = pgd_offset(mm, addr);
 	do {
-- 
2.0.2

