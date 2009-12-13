From: Matt Fleming <matt@console-pimps.org>
Date: Sun, 13 Dec 2009 11:18:01 +0000
Subject: [PATCH] sh: Couple kernel and user write page perm bits for CONFIG_X2TLB
Message-Id: <1260703081-1945-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

pte_write() should check whether the permissions include either the user
or kernel write permission bits. Likewise, pte_wrprotect() needs to
remove both the kernel and user write bits.

Without this patch handle_tlbmiss() doesn't handle faulting in pages
from the P3 area (our vmalloc space) because of a write. Mappings of the
P3 space have the _PAGE_EXT_KERN_WRITE bit but not _PAGE_EXT_USER_WRITE.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/pgtable_32.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
index b354355..5003ee8 100644
--- a/arch/sh/include/asm/pgtable_32.h
+++ b/arch/sh/include/asm/pgtable_32.h
@@ -344,7 +344,8 @@ static inline void set_pte(pte_t *ptep, pte_t pte)
 #define pte_special(pte)	((pte).pte_low & _PAGE_SPECIAL)
 
 #ifdef CONFIG_X2TLB
-#define pte_write(pte)		((pte).pte_high & _PAGE_EXT_USER_WRITE)
+#define pte_write(pte) \
+	((pte).pte_high & (_PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE))
 #else
 #define pte_write(pte)		((pte).pte_low & _PAGE_RW)
 #endif
@@ -358,7 +359,7 @@ static inline pte_t pte_##fn(pte_t pte) { pte.pte_##h op; return pte; }
  * individually toggled (and user permissions are entirely decoupled from
  * kernel permissions), we attempt to couple them a bit more sanely here.
  */
-PTE_BIT_FUNC(high, wrprotect, &= ~_PAGE_EXT_USER_WRITE);
+PTE_BIT_FUNC(high, wrprotect, &= ~(_PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE));
 PTE_BIT_FUNC(high, mkwrite, |= _PAGE_EXT_USER_WRITE | _PAGE_EXT_KERN_WRITE);
 PTE_BIT_FUNC(high, mkhuge, |= _PAGE_SZHUGE);
 #else
-- 
1.6.2.5

