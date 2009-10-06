From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:23 +0000
Subject: [PATCH 03/14] sh: Allocate PMB entry slot earlier
Message-Id: <c7cd0d3d83d2ee710246a1a6cd15f052985912cf.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Simplify set_pmb_entry() by removing the possibility of not finding a
free slot in the PMB. Instead we now allocate a slot in pmb_alloc() so
that if there are no free slots we fail at allocation time, rather than
in set_pmb_entry().

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/pmb.c |   80 ++++++++++++++++++++++++++---------------------------
 1 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index 58f9358..a510c8b 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -99,10 +99,31 @@ static inline void pmb_list_del(struct pmb_entry *pmbe)
 		}
 }
 
+static int pmb_alloc_entry(void)
+{
+	unsigned int pos;
+
+repeat:
+	pos = find_first_zero_bit(&pmb_map, NR_PMB_ENTRIES);
+
+	if (unlikely(pos > NR_PMB_ENTRIES))
+		return -ENOSPC;
+
+	if (test_and_set_bit(pos, &pmb_map))
+		goto repeat;
+
+	return pos;
+}
+
 struct pmb_entry *pmb_alloc(unsigned long vpn, unsigned long ppn,
 			    unsigned long flags)
 {
 	struct pmb_entry *pmbe;
+	int pos;
+
+	pos = pmb_alloc_entry();
+	if (pos < 0)
+		return ERR_PTR(pos);
 
 	pmbe = kmem_cache_alloc(pmb_cache, GFP_KERNEL);
 	if (!pmbe)
@@ -111,6 +132,7 @@ struct pmb_entry *pmb_alloc(unsigned long vpn, unsigned long ppn,
 	pmbe->vpn	= vpn;
 	pmbe->ppn	= ppn;
 	pmbe->flags	= flags;
+	pmbe->entry	= pos;
 
 	spin_lock_irq(&pmb_list_lock);
 	pmb_list_add(pmbe);
@@ -131,23 +153,9 @@ void pmb_free(struct pmb_entry *pmbe)
 /*
  * Must be in P2 for __set_pmb_entry()
  */
-int __set_pmb_entry(unsigned long vpn, unsigned long ppn,
-		    unsigned long flags, int *entry)
+void __set_pmb_entry(unsigned long vpn, unsigned long ppn,
+		    unsigned long flags, int pos)
 {
-	unsigned int pos = *entry;
-
-	if (unlikely(pos = PMB_NO_ENTRY))
-		pos = find_first_zero_bit(&pmb_map, NR_PMB_ENTRIES);
-
-repeat:
-	if (unlikely(pos > NR_PMB_ENTRIES))
-		return -ENOSPC;
-
-	if (test_and_set_bit(pos, &pmb_map)) {
-		pos = find_first_zero_bit(&pmb_map, NR_PMB_ENTRIES);
-		goto repeat;
-	}
-
 	ctrl_outl(vpn | PMB_V, mk_pmb_addr(pos));
 
 #ifdef CONFIG_CACHE_WRITETHROUGH
@@ -161,21 +169,13 @@ repeat:
 #endif
 
 	ctrl_outl(ppn | flags | PMB_V, mk_pmb_data(pos));
-
-	*entry = pos;
-
-	return 0;
 }
 
-int __uses_jump_to_uncached set_pmb_entry(struct pmb_entry *pmbe)
+void __uses_jump_to_uncached set_pmb_entry(struct pmb_entry *pmbe)
 {
-	int ret;
-
 	jump_to_uncached();
-	ret = __set_pmb_entry(pmbe->vpn, pmbe->ppn, pmbe->flags, &pmbe->entry);
+	__set_pmb_entry(pmbe->vpn, pmbe->ppn, pmbe->flags, pmbe->entry);
 	back_to_cached();
-
-	return ret;
 }
 
 void __uses_jump_to_uncached clear_pmb_entry(struct pmb_entry *pmbe)
@@ -239,8 +239,6 @@ long pmb_remap(unsigned long vaddr, unsigned long phys,
 
 again:
 	for (i = 0; i < ARRAY_SIZE(pmb_sizes); i++) {
-		int ret;
-
 		if (size < pmb_sizes[i].size)
 			continue;
 
@@ -250,12 +248,7 @@ again:
 			goto out;
 		}
 
-		ret = set_pmb_entry(pmbe);
-		if (ret != 0) {
-			pmb_free(pmbe);
-			err = -EBUSY;
-			goto out;
-		}
+		set_pmb_entry(pmbe);
 
 		phys	+= pmb_sizes[i].size;
 		vaddr	+= pmb_sizes[i].size;
@@ -304,8 +297,17 @@ static void __pmb_unmap(struct pmb_entry *pmbe)
 	do {
 		struct pmb_entry *pmblink = pmbe;
 
-		if (pmbe->entry != PMB_NO_ENTRY)
-			clear_pmb_entry(pmbe);
+		/*
+		 * We may be called before this pmb_entry has been
+		 * entered into the PMB table via set_pmb_entry(), but
+		 * that's OK because we've allocated a unique slot for
+		 * this entry in pmb_alloc() (even if we haven't filled
+		 * it yet).
+		 *
+		 * Therefore, calling clear_pmb_entry() is safe as no
+		 * other mapping can be using that slot.
+		 */
+		clear_pmb_entry(pmbe);
 
 		pmbe = pmblink->link;
 
@@ -315,11 +317,7 @@ static void __pmb_unmap(struct pmb_entry *pmbe)
 
 static void pmb_cache_ctor(void *pmb)
 {
-	struct pmb_entry *pmbe = pmb;
-
 	memset(pmb, 0, sizeof(struct pmb_entry));
-
-	pmbe->entry = PMB_NO_ENTRY;
 }
 
 static int __uses_jump_to_uncached pmb_init(void)
@@ -342,7 +340,7 @@ static int __uses_jump_to_uncached pmb_init(void)
 	for (entry = 0; entry < nr_entries; entry++) {
 		struct pmb_entry *pmbe = pmb_init_map + entry;
 
-		__set_pmb_entry(pmbe->vpn, pmbe->ppn, pmbe->flags, &entry);
+		__set_pmb_entry(pmbe->vpn, pmbe->ppn, pmbe->flags, entry);
 	}
 
 	ctrl_outl(0, PMB_IRMCR);
-- 
1.6.3.3

