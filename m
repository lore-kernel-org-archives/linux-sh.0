From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 22 Mar 2010 22:09:58 +0000
Subject: [PATCH] sh: Fix build after dynamic PMB rework
Message-Id: <1269295798-5215-1-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

set_pmb_entry() is now only used by a function that is wrapped in #ifdef
CONFIG_PM, so wrap set_pmb_entry() in CONFIG_PM too.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/pmb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index a4662e2..dda628e 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -323,6 +323,7 @@ static void __clear_pmb_entry(struct pmb_entry *pmbe)
 	writel_uncached(data_val & ~PMB_V, data);
 }
 
+#ifdef CONFIG_PM
 static void set_pmb_entry(struct pmb_entry *pmbe)
 {
 	unsigned long flags;
@@ -331,6 +332,7 @@ static void set_pmb_entry(struct pmb_entry *pmbe)
 	__set_pmb_entry(pmbe);
 	spin_unlock_irqrestore(&pmbe->lock, flags);
 }
+#endif /* CONFIG_PM */
 
 int pmb_bolt_mapping(unsigned long vaddr, phys_addr_t phys,
 		     unsigned long size, pgprot_t prot)
-- 
1.6.4.rc0

