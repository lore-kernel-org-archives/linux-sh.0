From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:29 +0000
Subject: [PATCH 09/14] sh: Get rid of the kmem cache code
Message-Id: <74c586207600f78a4fa0bd080917bea1c5402f82.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Unfortunately, at the time during in boot when we want to be setting up
the PMB entries, the kmem subsystem hasn't been initialised.

We now match pmb_map slots with pmb_entry_list slots. When we find an
empty slot in pmb_map, we set the bit, thereby acquiring the
corresponding pmb_entry_list entry. There is a benefit in using this
static array of struct pmb_entry's; we don't need to acquire any locks
in order to traverse the list of struct pmb_entry's.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/pmb.c |   81 +++++++++++++++++------------------------------------
 1 files changed, 26 insertions(+), 55 deletions(-)

diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index 5321f82..a3c0dfa 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -35,7 +35,7 @@
 
 static void __pmb_unmap(struct pmb_entry *);
 
-static struct kmem_cache *pmb_cache;
+static struct pmb_entry pmb_entry_list[NR_PMB_ENTRIES];
 static unsigned long pmb_map;
 
 static struct pmb_entry pmb_init_map[] = {
@@ -73,32 +73,6 @@ static inline unsigned long mk_pmb_data(unsigned int entry)
 	return mk_pmb_entry(entry) | PMB_DATA;
 }
 
-static DEFINE_SPINLOCK(pmb_list_lock);
-static struct pmb_entry *pmb_list;
-
-static inline void pmb_list_add(struct pmb_entry *pmbe)
-{
-	struct pmb_entry **p, *tmp;
-
-	p = &pmb_list;
-	while ((tmp = *p) != NULL)
-		p = &tmp->next;
-
-	pmbe->next = tmp;
-	*p = pmbe;
-}
-
-static inline void pmb_list_del(struct pmb_entry *pmbe)
-{
-	struct pmb_entry **p, *tmp;
-
-	for (p = &pmb_list; (tmp = *p); p = &tmp->next)
-		if (tmp = pmbe) {
-			*p = tmp->next;
-			return;
-		}
-}
-
 static int pmb_alloc_entry(void)
 {
 	unsigned int pos;
@@ -125,7 +99,7 @@ static struct pmb_entry *pmb_alloc(unsigned long vpn, unsigned long ppn,
 	if (pos < 0)
 		return ERR_PTR(pos);
 
-	pmbe = kmem_cache_alloc(pmb_cache, GFP_KERNEL);
+	pmbe = &pmb_entry_list[pos];
 	if (!pmbe)
 		return ERR_PTR(-ENOMEM);
 
@@ -134,20 +108,19 @@ static struct pmb_entry *pmb_alloc(unsigned long vpn, unsigned long ppn,
 	pmbe->flags	= flags;
 	pmbe->entry	= pos;
 
-	spin_lock_irq(&pmb_list_lock);
-	pmb_list_add(pmbe);
-	spin_unlock_irq(&pmb_list_lock);
-
 	return pmbe;
 }
 
 static void pmb_free(struct pmb_entry *pmbe)
 {
-	spin_lock_irq(&pmb_list_lock);
-	pmb_list_del(pmbe);
-	spin_unlock_irq(&pmb_list_lock);
+	int pos = pmbe->entry;
 
-	kmem_cache_free(pmb_cache, pmbe);
+	pmbe->vpn	= 0;
+	pmbe->ppn	= 0;
+	pmbe->flags	= 0;
+	pmbe->entry	= 0;
+
+	clear_bit(pos, &pmb_map);
 }
 
 /*
@@ -202,8 +175,6 @@ static void __uses_jump_to_uncached clear_pmb_entry(struct pmb_entry *pmbe)
 	ctrl_outl(ctrl_inl(addr) & ~PMB_V, addr);
 
 	back_to_cached();
-
-	clear_bit(entry, &pmb_map);
 }
 
 
@@ -278,11 +249,16 @@ out:
 
 void pmb_unmap(unsigned long addr)
 {
-	struct pmb_entry **p, *pmbe;
+	struct pmb_entry *pmbe = NULL;
+	int i;
 
-	for (p = &pmb_list; (pmbe = *p); p = &pmbe->next)
-		if (pmbe->vpn = addr)
-			break;
+	for (i = 0; i < ARRAY_SIZE(pmb_entry_list); i++) {
+		if (test_bit(i, &pmb_map)) {
+			pmbe = &pmb_entry_list[i];
+			if (pmbe->vpn = addr)
+				break;
+		}
+	}
 
 	if (unlikely(!pmbe))
 		return;
@@ -292,7 +268,7 @@ void pmb_unmap(unsigned long addr)
 
 static void __pmb_unmap(struct pmb_entry *pmbe)
 {
-	WARN_ON(!test_bit(pmbe->entry, &pmb_map));
+	BUG_ON(!test_bit(pmbe->entry, &pmb_map));
 
 	do {
 		struct pmb_entry *pmblink = pmbe;
@@ -315,11 +291,6 @@ static void __pmb_unmap(struct pmb_entry *pmbe)
 	} while (pmbe);
 }
 
-static void pmb_cache_ctor(void *pmb)
-{
-	memset(pmb, 0, sizeof(struct pmb_entry));
-}
-
 int __uses_jump_to_uncached pmb_init(void)
 {
 	unsigned int nr_entries = ARRAY_SIZE(pmb_init_map);
@@ -327,9 +298,6 @@ int __uses_jump_to_uncached pmb_init(void)
 
 	BUG_ON(unlikely(nr_entries >= NR_PMB_ENTRIES));
 
-	pmb_cache = kmem_cache_create("pmb", sizeof(struct pmb_entry), 0,
-				      SLAB_PANIC, pmb_cache_ctor);
-
 	jump_to_uncached();
 
 	/*
@@ -424,15 +392,18 @@ postcore_initcall(pmb_debugfs_init);
 static int pmb_sysdev_suspend(struct sys_device *dev, pm_message_t state)
 {
 	static pm_message_t prev_state;
+	int i;
 
 	/* Restore the PMB after a resume from hibernation */
 	if (state.event = PM_EVENT_ON &&
 	    prev_state.event = PM_EVENT_FREEZE) {
 		struct pmb_entry *pmbe;
-		spin_lock_irq(&pmb_list_lock);
-		for (pmbe = pmb_list; pmbe; pmbe = pmbe->next)
-			set_pmb_entry(pmbe);
-		spin_unlock_irq(&pmb_list_lock);
+		for (i = 0; i < ARRAY_SIZE(pmb_entry_list); i++) {
+			if (test_bit(i, &pmb_map)) {
+				pmbe = &pmb_entry_list[i];
+				set_pmb_entry(pmbe);
+			}
+		}
 	}
 	prev_state = state;
 	return 0;
-- 
1.6.3.3

