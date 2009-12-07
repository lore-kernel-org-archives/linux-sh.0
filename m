From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Dec 2009 14:16:07 +0000
Subject: [PATCH] sh: NUMA lmb fixes
Message-Id: <20091207141607.6696.57181.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the NUMA version of setup_memory()
with UMA code changes and also modifies the last argument
to lmb_alloc_base() to use an address instead of pfn.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/mm/numa.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- 0004/arch/sh/mm/numa.c
+++ work/arch/sh/mm/numa.c	2009-12-07 21:16:54.000000000 +0900
@@ -38,6 +38,15 @@ void __init setup_memory(void)
 		    (__MEMORY_START + CONFIG_ZERO_PAGE_OFFSET));
 
 	/*
+	 * Reserve physical pages below CONFIG_ZERO_PAGE_OFFSET.
+	 */
+	if (CONFIG_ZERO_PAGE_OFFSET != 0)
+		lmb_reserve(__MEMORY_START, CONFIG_ZERO_PAGE_OFFSET);
+
+	lmb_analyze();
+	lmb_dump_all();
+
+	/*
 	 * Node 0 sets up its pgdat at the first available pfn,
 	 * and bumps it up before setting up the bootmem allocator.
 	 */
@@ -71,7 +80,7 @@ void __init setup_bootmem_node(int nid, 
 
 	/* Node-local pgdat */
 	NODE_DATA(nid) = __va(lmb_alloc_base(sizeof(struct pglist_data),
-					     SMP_CACHE_BYTES, end_pfn));
+					     SMP_CACHE_BYTES, end));
 	memset(NODE_DATA(nid), 0, sizeof(struct pglist_data));
 
 	NODE_DATA(nid)->bdata = &bootmem_node_data[nid];
@@ -81,7 +90,7 @@ void __init setup_bootmem_node(int nid, 
 	/* Node-local bootmap */
 	bootmap_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
 	bootmem_paddr = lmb_alloc_base(bootmap_pages << PAGE_SHIFT,
-				       PAGE_SIZE, end_pfn);
+				       PAGE_SIZE, end);
 	init_bootmem_node(NODE_DATA(nid), bootmem_paddr >> PAGE_SHIFT,
 			  start_pfn, end_pfn);
 
