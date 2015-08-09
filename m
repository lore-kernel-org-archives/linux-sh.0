From: Alexander Kuleshov <kuleshovmail@gmail.com>
Date: Sun, 09 Aug 2015 18:28:11 +0000
Subject: [PATCH] SH: use PFN_DOWN macro
Message-Id: <1439144891-8141-1-git-send-email-kuleshovmail@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dan Carpenter <dan.carpenter@oracle.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>

Replace ((x) >> PAGE_SHIFT) with the predefined PFN_DOWN macro.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/sh/mm/init.c | 4 ++--
 arch/sh/mm/numa.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 2790b6a..17f4862 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -488,6 +488,6 @@ void free_initrd_mem(unsigned long start, unsigned long end)
 int arch_add_memory(int nid, u64 start, u64 size)
 {
 	pg_data_t *pgdat;
-	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;

@@ -517,7 +517,7 @@ EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 #ifdef CONFIG_MEMORY_HOTREMOVE
 int arch_remove_memory(u64 start, u64 size)
 {
-	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long start_pfn = PFN_DOWN(start);
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	struct zone *zone;
 	int ret;
diff --git a/arch/sh/mm/numa.c b/arch/sh/mm/numa.c
index bce52ba..05713d1 100644
--- a/arch/sh/mm/numa.c
+++ b/arch/sh/mm/numa.c
@@ -33,2 +33,2 @@ void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
 	/* Don't allow bogus node assignment */
 	BUG_ON(nid >= MAX_NUMNODES || nid <= 0);

-	start_pfn = start >> PAGE_SHIFT;
-	end_pfn = end >> PAGE_SHIFT;
+	start_pfn = PFN_DOWN(start);
+	end_pfn = PFN_DOWN(end);

 	pmb_bolt_mapping((unsigned long)__va(start), start, end - start,
 			 PAGE_KERNEL);
--
2.5.0

