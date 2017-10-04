From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 04 Oct 2017 15:00:45 +0000
Subject: [PATCH] mm, arch: remove empty_bad_page*
Message-Id: <20171004150045.30755-1-mhocko@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>, Jeff Dike <jdike@addtoit.com>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Richard Weinberger <richard@nod.at>, Rich Felker <dalias@libc.org>, uclinux-h8-devel@lists.sourceforge.jp, Yoshinori Sato <ysato@users.sourceforge.jp>

From: Michal Hocko <mhocko@suse.com>

empty_bad_page and empty_bad_pte_table seems to be a relict from old
days which is not used by any code for a long time. I have tried to find
when exactly but this is not really all that straightforward due to many
code movements - traces disappear around 2.4 times.

Anyway no code really references neither empty_bad_page nor
empty_bad_pte_table. We only allocate the storage which is not used by
anybody so remove them.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Rich Felker <dalias@libc.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: <uclinux-h8-devel@lists.sourceforge.jp>
Cc: <linux-mips@linux-mips.org>
Cc: <linux-sh@vger.kernel.org>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
Hi,
Pasha Tatashin made me look closer at
include/linux/page-flags.h
  * PG_reserved is set for special pages, which can never be swapped out. Some
  * of them might not even exist (eg empty_bad_page)...
in http://lkml.kernel.org/r/691dba28-718c-e9a9-d006-88505eb5cd7e@oracle.com
because it was the first time I have heard about empty_bad_page. It
seems that this is no longer needed but there are some relicts in
arch code. Please note that I have no ways to test this other than
run it through my compile (cross arch) test battery and there were no
failures.

 arch/frv/mm/init.c                 | 14 --------------
 arch/h8300/mm/init.c               | 13 -------------
 arch/mips/include/asm/pgtable-64.h |  8 +-------
 arch/mn10300/kernel/head.S         |  8 --------
 arch/sh/kernel/head_64.S           |  8 --------
 arch/um/kernel/mem.c               |  3 ---
 include/linux/page-flags.h         |  2 +-
 7 files changed, 2 insertions(+), 54 deletions(-)

diff --git a/arch/frv/mm/init.c b/arch/frv/mm/init.c
index 328f0a292316..cf464100e838 100644
--- a/arch/frv/mm/init.c
+++ b/arch/frv/mm/init.c
@@ -42,21 +42,9 @@
 #undef DEBUG
 
 /*
- * BAD_PAGE is the page that is used for page faults when linux
- * is out-of-memory. Older versions of linux just did a
- * do_exit(), but using this instead means there is less risk
- * for a process dying in kernel mode, possibly leaving a inode
- * unused etc..
- *
- * BAD_PAGETABLE is the accompanying page-table: it is initialized
- * to point to BAD_PAGE entries.
- *
  * ZERO_PAGE is a special page that is used for zero-initialized
  * data and COW.
  */
-static unsigned long empty_bad_page_table;
-static unsigned long empty_bad_page;
-
 unsigned long empty_zero_page;
 EXPORT_SYMBOL(empty_zero_page);
 
@@ -72,8 +60,6 @@ void __init paging_init(void)
 	unsigned long zones_size[MAX_NR_ZONES] = {0, };
 
 	/* allocate some pages for kernel housekeeping tasks */
-	empty_bad_page_table	= (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
-	empty_bad_page		= (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
 	empty_zero_page		= (unsigned long) alloc_bootmem_pages(PAGE_SIZE);
 
 	memset((void *) empty_zero_page, 0, PAGE_SIZE);
diff --git a/arch/h8300/mm/init.c b/arch/h8300/mm/init.c
index 495a3d6b539b..85c51cf782a5 100644
--- a/arch/h8300/mm/init.c
+++ b/arch/h8300/mm/init.c
@@ -39,20 +39,9 @@
 #include <asm/sections.h>
 
 /*
- * BAD_PAGE is the page that is used for page faults when linux
- * is out-of-memory. Older versions of linux just did a
- * do_exit(), but using this instead means there is less risk
- * for a process dying in kernel mode, possibly leaving a inode
- * unused etc..
- *
- * BAD_PAGETABLE is the accompanying page-table: it is initialized
- * to point to BAD_PAGE entries.
- *
  * ZERO_PAGE is a special page that is used for zero-initialized
  * data and COW.
  */
-static unsigned long empty_bad_page_table;
-static unsigned long empty_bad_page;
 unsigned long empty_zero_page;
 
 /*
@@ -77,8 +66,6 @@ void __init paging_init(void)
 	 * Initialize the bad page table and bad page to point
 	 * to a couple of allocated pages.
 	 */
-	empty_bad_page_table = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
-	empty_bad_page = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
 	empty_zero_page = (unsigned long)alloc_bootmem_pages(PAGE_SIZE);
 	memset((void *)empty_zero_page, 0, PAGE_SIZE);
 
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 67fe6dc5211c..0036ea0c7173 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -31,12 +31,7 @@
  * tables. Each page table is also a single 4K page, giving 512 (=
  * PTRS_PER_PTE) 8 byte ptes. Each pud entry is initialized to point to
  * invalid_pmd_table, each pmd entry is initialized to point to
- * invalid_pte_table, each pte is initialized to 0. When memory is low,
- * and a pmd table or a page table allocation fails, empty_bad_pmd_table
- * and empty_bad_page_table is returned back to higher layer code, so
- * that the failure is recognized later on. Linux does not seem to
- * handle these failures very well though. The empty_bad_page_table has
- * invalid pte entries in it, to force page faults.
+ * invalid_pte_table, each pte is initialized to 0.
  *
  * Kernel mappings: kernel mappings are held in the swapper_pg_table.
  * The layout is identical to userspace except it's indexed with the
@@ -175,7 +170,6 @@
 	printk("%s:%d: bad pgd %016lx.\n", __FILE__, __LINE__, pgd_val(e))
 
 extern pte_t invalid_pte_table[PTRS_PER_PTE];
-extern pte_t empty_bad_page_table[PTRS_PER_PTE];
 
 #ifndef __PAGETABLE_PUD_FOLDED
 /*
diff --git a/arch/mn10300/kernel/head.S b/arch/mn10300/kernel/head.S
index 73e00fc78072..0b15f759e0d2 100644
--- a/arch/mn10300/kernel/head.S
+++ b/arch/mn10300/kernel/head.S
@@ -433,14 +433,6 @@ ENTRY(swapper_pg_dir)
 ENTRY(empty_zero_page)
 	.space PAGE_SIZE
 
-	.balign PAGE_SIZE
-ENTRY(empty_bad_page)
-	.space PAGE_SIZE
-
-	.balign PAGE_SIZE
-ENTRY(empty_bad_pte_table)
-	.space PAGE_SIZE
-
 	.balign PAGE_SIZE
 ENTRY(large_page_table)
 	.space PAGE_SIZE
diff --git a/arch/sh/kernel/head_64.S b/arch/sh/kernel/head_64.S
index defd851abefa..cca491397a28 100644
--- a/arch/sh/kernel/head_64.S
+++ b/arch/sh/kernel/head_64.S
@@ -101,14 +101,6 @@
 mmu_pdtp_cache:
 	.space PAGE_SIZE, 0
 
-	.global empty_bad_page
-empty_bad_page:
-	.space PAGE_SIZE, 0
-
-	.global empty_bad_pte_table
-empty_bad_pte_table:
-	.space PAGE_SIZE, 0
-
 	.global	fpu_in_use
 fpu_in_use:	.quad	0
 
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index e7437ec62710..3c0e470ea646 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -22,8 +22,6 @@
 /* allocated in paging_init, zeroed in mem_init, and unchanged thereafter */
 unsigned long *empty_zero_page = NULL;
 EXPORT_SYMBOL(empty_zero_page);
-/* allocated in paging_init and unchanged thereafter */
-static unsigned long *empty_bad_page = NULL;
 
 /*
  * Initialized during boot, and readonly for initializing page tables
@@ -146,7 +144,6 @@ void __init paging_init(void)
 	int i;
 
 	empty_zero_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
-	empty_bad_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
 	for (i = 0; i < ARRAY_SIZE(zones_size); i++)
 		zones_size[i] = 0;
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index ba2d470d2d0a..048b763e939d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -17,7 +17,7 @@
  * Various page->flags bits:
  *
  * PG_reserved is set for special pages, which can never be swapped out. Some
- * of them might not even exist (eg empty_bad_page)...
+ * of them might not even exist...
  *
  * The PG_private bitflag is set on pagecache pages if they contain filesystem
  * specific data (which is normally at page->private). It can be used by
-- 
2.14.2

