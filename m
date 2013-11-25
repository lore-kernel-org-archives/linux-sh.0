From: Mark Salter <msalter@redhat.com>
Date: Mon, 25 Nov 2013 16:14:03 +0000
Subject: [PATCH v2 09/11] sh: use generic fixmap.h
Message-Id: <1385396045-15852-10-git-send-email-msalter@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385396045-15852-1-git-send-email-msalter@redhat.com>
In-Reply-To: <1385396045-15852-1-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Mark Salter <msalter@redhat.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

Signed-off-by: Mark Salter <msalter@redhat.com>
CC: Paul Mundt <lethal@linux-sh.org>
CC: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/fixmap.h | 39 ++-------------------------------------
 1 file changed, 2 insertions(+), 37 deletions(-)

diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index cbe0186..4daf91c 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -79,13 +79,6 @@ extern void __set_fixmap(enum fixed_addresses idx,
 			 unsigned long phys, pgprot_t flags);
 extern void __clear_fixmap(enum fixed_addresses idx, pgprot_t flags);
 
-#define set_fixmap(idx, phys) \
-		__set_fixmap(idx, phys, PAGE_KERNEL)
-/*
- * Some hardware wants to get fixmapped without caching.
- */
-#define set_fixmap_nocache(idx, phys) \
-		__set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE)
 /*
  * used by vmalloc.c.
  *
@@ -101,36 +94,8 @@ extern void __clear_fixmap(enum fixed_addresses idx, pgprot_t flags);
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
-#define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
-
-extern void __this_fixmap_does_not_exist(void);
-
-/*
- * 'index to address' translation. If anyone tries to use the idx
- * directly without tranlation, we catch the bug with a NULL-deference
- * kernel oops. Illegal ranges of incoming indices are caught too.
- */
-static inline unsigned long fix_to_virt(const unsigned int idx)
-{
-	/*
-	 * this branch gets completely eliminated after inlining,
-	 * except when someone tries to use fixaddr indices in an
-	 * illegal way. (such as mixing up address types or using
-	 * out-of-range indices).
-	 *
-	 * If it doesn't get removed, the linker will complain
-	 * loudly with a reasonably clear error message..
-	 */
-	if (idx >= __end_of_fixed_addresses)
-		__this_fixmap_does_not_exist();
+#define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NOCACHE
 
-        return __fix_to_virt(idx);
-}
+#include <asm-generic/fixmap.h>
 
-static inline unsigned long virt_to_fix(const unsigned long vaddr)
-{
-	BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
-	return __virt_to_fix(vaddr);
-}
 #endif
-- 
1.8.3.1

