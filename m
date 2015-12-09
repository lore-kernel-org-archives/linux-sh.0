From: Yang Shi <yang.shi@linaro.org>
Date: Wed, 09 Dec 2015 17:29:23 +0000
Subject: [PATCH v4 6/7] sh: mm/gup: add gup trace points
Message-Id: <1449682164-9933-7-git-send-email-yang.shi@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1449682164-9933-1-git-send-email-yang.shi@linaro.org>
In-Reply-To: <1449682164-9933-1-git-send-email-yang.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org, rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linaro-kernel@lists.linaro.org, yang.shi@linaro.org, linux-sh@vger.kernel.org

Cc: linux-sh@vger.kernel.org
Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/sh/mm/gup.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sh/mm/gup.c b/arch/sh/mm/gup.c
index e7af6a6..fa72aac 100644
--- a/arch/sh/mm/gup.c
+++ b/arch/sh/mm/gup.c
@@ -14,6 +14,9 @@
 #include <linux/highmem.h>
 #include <asm/pgtable.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/gup.h>
+
 static inline pte_t gup_get_pte(pte_t *ptep)
 {
 #ifndef CONFIG_X2TLB
@@ -178,6 +181,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 					(void __user *)start, len)))
 		return 0;
 
+	trace_gup_get_user_pages_fast(start, nr_pages);
+
 	/*
 	 * This doesn't prevent pagetable teardown, but does prevent
 	 * the pagetables and pages from being freed.
@@ -244,6 +249,8 @@ int get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	} while (pgdp++, addr = next, addr != end);
 	local_irq_enable();
 
+	trace_gup_get_user_pages_fast(start, nr_pages);
+
 	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
 	return nr;
 
-- 
2.0.2

