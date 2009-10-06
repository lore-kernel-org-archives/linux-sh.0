From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:28 +0000
Subject: [PATCH 08/14] sh: Make most PMB functions static
Message-Id: <46a9d1e2f3461c917c9f43e512bd25eced531695.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There's no need to export the internal PMB functions for allocating,
freeing and modifying PMB entries, etc. This way we can restrict the
interface for PMB.

Also remove the static from pmb_init() so that we have more freedom in
setting up the initial PMB entries and turning on MMU 32bit mode.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/mmu.h |    8 +-------
 arch/sh/kernel/setup.c    |    4 ++++
 arch/sh/mm/pmb.c          |   17 ++++++++---------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
index 5025e12..9c84b45 100644
--- a/arch/sh/include/asm/mmu.h
+++ b/arch/sh/include/asm/mmu.h
@@ -64,16 +64,10 @@ struct pmb_entry {
 };
 
 /* arch/sh/mm/pmb.c */
-int __set_pmb_entry(unsigned long vpn, unsigned long ppn,
-		    unsigned long flags, int *entry);
-int set_pmb_entry(struct pmb_entry *pmbe);
-void clear_pmb_entry(struct pmb_entry *pmbe);
-struct pmb_entry *pmb_alloc(unsigned long vpn, unsigned long ppn,
-			    unsigned long flags);
-void pmb_free(struct pmb_entry *pmbe);
 long pmb_remap(unsigned long virt, unsigned long phys,
 	       unsigned long size, unsigned long flags);
 void pmb_unmap(unsigned long addr);
+int pmb_init(void);
 #endif /* __ASSEMBLY__ */
 
 #endif /* __MMU_H */
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index f9d44f8..8fdd03a 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -453,6 +453,10 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 
+#ifdef CONFIG_PMB
+	pmb_init();
+#endif
+
 #ifdef CONFIG_SMP
 	plat_smp_setup();
 #endif
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index a510c8b..5321f82 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -115,8 +115,8 @@ repeat:
 	return pos;
 }
 
-struct pmb_entry *pmb_alloc(unsigned long vpn, unsigned long ppn,
-			    unsigned long flags)
+static struct pmb_entry *pmb_alloc(unsigned long vpn, unsigned long ppn,
+				   unsigned long flags)
 {
 	struct pmb_entry *pmbe;
 	int pos;
@@ -141,7 +141,7 @@ struct pmb_entry *pmb_alloc(unsigned long vpn, unsigned long ppn,
 	return pmbe;
 }
 
-void pmb_free(struct pmb_entry *pmbe)
+static void pmb_free(struct pmb_entry *pmbe)
 {
 	spin_lock_irq(&pmb_list_lock);
 	pmb_list_del(pmbe);
@@ -153,8 +153,8 @@ void pmb_free(struct pmb_entry *pmbe)
 /*
  * Must be in P2 for __set_pmb_entry()
  */
-void __set_pmb_entry(unsigned long vpn, unsigned long ppn,
-		    unsigned long flags, int pos)
+static void __set_pmb_entry(unsigned long vpn, unsigned long ppn,
+			    unsigned long flags, int pos)
 {
 	ctrl_outl(vpn | PMB_V, mk_pmb_addr(pos));
 
@@ -171,14 +171,14 @@ void __set_pmb_entry(unsigned long vpn, unsigned long ppn,
 	ctrl_outl(ppn | flags | PMB_V, mk_pmb_data(pos));
 }
 
-void __uses_jump_to_uncached set_pmb_entry(struct pmb_entry *pmbe)
+static void __uses_jump_to_uncached set_pmb_entry(struct pmb_entry *pmbe)
 {
 	jump_to_uncached();
 	__set_pmb_entry(pmbe->vpn, pmbe->ppn, pmbe->flags, pmbe->entry);
 	back_to_cached();
 }
 
-void __uses_jump_to_uncached clear_pmb_entry(struct pmb_entry *pmbe)
+static void __uses_jump_to_uncached clear_pmb_entry(struct pmb_entry *pmbe)
 {
 	unsigned int entry = pmbe->entry;
 	unsigned long addr;
@@ -320,7 +320,7 @@ static void pmb_cache_ctor(void *pmb)
 	memset(pmb, 0, sizeof(struct pmb_entry));
 }
 
-static int __uses_jump_to_uncached pmb_init(void)
+int __uses_jump_to_uncached pmb_init(void)
 {
 	unsigned int nr_entries = ARRAY_SIZE(pmb_init_map);
 	unsigned int entry, i;
@@ -357,7 +357,6 @@ static int __uses_jump_to_uncached pmb_init(void)
 
 	return 0;
 }
-arch_initcall(pmb_init);
 
 static int pmb_seq_show(struct seq_file *file, void *iter)
 {
-- 
1.6.3.3

