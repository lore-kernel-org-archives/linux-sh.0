From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:22 +0000
Subject: [PATCH 02/14] sh: Plug PMB alloc memory leak
Message-Id: <e07f50dbc5e9fbb9cf9fe70cdfaf9eb791fe2823.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If we fail to allocate a PMB entry in pmb_remap() we must remember to
clear and free any PMB entries that we may have previously allocated,
e.g. if we were allocating a multiple entry mapping.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/pmb.c |   30 ++++++++++++++++++++++++------
 1 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index b1a714a..58f9358 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -33,6 +33,8 @@
 
 #define NR_PMB_ENTRIES	16
 
+static void __pmb_unmap(struct pmb_entry *);
+
 static struct kmem_cache *pmb_cache;
 static unsigned long pmb_map;
 
@@ -218,9 +220,10 @@ static struct {
 long pmb_remap(unsigned long vaddr, unsigned long phys,
 	       unsigned long size, unsigned long flags)
 {
-	struct pmb_entry *pmbp;
+	struct pmb_entry *pmbp, *pmbe;
 	unsigned long wanted;
 	int pmb_flags, i;
+	long err;
 
 	/* Convert typical pgprot value to the PMB equivalent */
 	if (flags & _PAGE_CACHABLE) {
@@ -236,20 +239,22 @@ long pmb_remap(unsigned long vaddr, unsigned long phys,
 
 again:
 	for (i = 0; i < ARRAY_SIZE(pmb_sizes); i++) {
-		struct pmb_entry *pmbe;
 		int ret;
 
 		if (size < pmb_sizes[i].size)
 			continue;
 
 		pmbe = pmb_alloc(vaddr, phys, pmb_flags | pmb_sizes[i].flag);
-		if (IS_ERR(pmbe))
-			return PTR_ERR(pmbe);
+		if (IS_ERR(pmbe)) {
+			err = PTR_ERR(pmbe);
+			goto out;
+		}
 
 		ret = set_pmb_entry(pmbe);
 		if (ret != 0) {
 			pmb_free(pmbe);
-			return -EBUSY;
+			err = -EBUSY;
+			goto out;
 		}
 
 		phys	+= pmb_sizes[i].size;
@@ -270,6 +275,12 @@ again:
 		goto again;
 
 	return wanted - size;
+
+out:
+	if (pmbp)
+		__pmb_unmap(pmbp);
+
+	return err;
 }
 
 void pmb_unmap(unsigned long addr)
@@ -283,12 +294,19 @@ void pmb_unmap(unsigned long addr)
 	if (unlikely(!pmbe))
 		return;
 
+	__pmb_unmap(pmbe);
+}
+
+static void __pmb_unmap(struct pmb_entry *pmbe)
+{
 	WARN_ON(!test_bit(pmbe->entry, &pmb_map));
 
 	do {
 		struct pmb_entry *pmblink = pmbe;
 
-		clear_pmb_entry(pmbe);
+		if (pmbe->entry != PMB_NO_ENTRY)
+			clear_pmb_entry(pmbe);
+
 		pmbe = pmblink->link;
 
 		pmb_free(pmblink);
-- 
1.6.3.3

