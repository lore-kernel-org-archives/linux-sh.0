From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Apr 2008 11:56:44 +0000
Subject: [PATCH] sh: add memory resources to /proc/iomem
Message-Id: <20080423115644.3899.43399.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add physical memory resources such as System RAM, Kernel code/data/bss
and reserved crash dump area to /proc/iomem. Same strategy as on x86.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/setup.c  |   38 +++++++++++++++++++++++++++++++++++++-
 arch/sh/mm/numa.c       |    2 +-
 include/asm-sh/mmzone.h |    2 ++
 3 files changed, 40 insertions(+), 2 deletions(-)

--- 0004/arch/sh/kernel/setup.c
+++ work/arch/sh/kernel/setup.c	2008-04-22 17:57:37.000000000 +0900
@@ -86,6 +86,8 @@ EXPORT_SYMBOL(memory_start);
 unsigned long memory_end = 0;
 EXPORT_SYMBOL(memory_end);
 
+static struct resource mem_resources[MAX_NUMNODES];
+
 int l1i_cache_shape, l1d_cache_shape, l2_cache_shape;
 
 static int __init early_parse_mem(char *p)
@@ -174,6 +176,40 @@ static inline void __init reserve_crashk
 {}
 #endif
 
+void __init __add_active_range(unsigned int nid, unsigned long start_pfn,
+						unsigned long end_pfn)
+{
+	struct resource *res = &mem_resources[nid];
+
+	WARN_ON(res->name); /* max one active range per node for now */
+
+	res->name = "System RAM";
+	res->start = start_pfn << PAGE_SHIFT;
+	res->end = (end_pfn << PAGE_SHIFT) - 1;
+	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	if (request_resource(&iomem_resource, res)) {
+		pr_err("unable to request memory_resource 0x%lx 0x%lx\n",
+		       start_pfn, end_pfn);
+		return;
+	}
+
+	/*
+	 *  We don't know which RAM region contains kernel data,
+	 *  so we try it repeatedly and let the resource manager
+	 *  test it.
+	 */
+	request_resource(res, &code_resource);
+	request_resource(res, &data_resource);
+	request_resource(res, &bss_resource);
+
+#ifdef CONFIG_KEXEC
+	if (crashk_res.start != crashk_res.end)
+		request_resource(res, &crashk_res);
+#endif
+
+	add_active_range(nid, start_pfn, end_pfn);
+}
+
 void __init setup_bootmem_allocator(unsigned long free_pfn)
 {
 	unsigned long bootmap_size;
@@ -186,7 +222,7 @@ void __init setup_bootmem_allocator(unsi
 	bootmap_size = init_bootmem_node(NODE_DATA(0), free_pfn,
 					 min_low_pfn, max_low_pfn);
 
-	add_active_range(0, min_low_pfn, max_low_pfn);
+	__add_active_range(0, min_low_pfn, max_low_pfn);
 	register_bootmem_low_pages();
 
 	node_set_online(0);
--- 0001/arch/sh/mm/numa.c
+++ work/arch/sh/mm/numa.c	2008-04-22 17:57:37.000000000 +0900
@@ -59,7 +59,7 @@ void __init setup_bootmem_node(int nid, 
 	free_pfn = start_pfn = start >> PAGE_SHIFT;
 	end_pfn = end >> PAGE_SHIFT;
 
-	add_active_range(nid, start_pfn, end_pfn);
+	__add_active_range(nid, start_pfn, end_pfn);
 
 	/* Node-local pgdat */
 	NODE_DATA(nid) = pfn_to_kaddr(free_pfn);
--- 0001/include/asm-sh/mmzone.h
+++ work/include/asm-sh/mmzone.h	2008-04-22 17:57:37.000000000 +0900
@@ -41,6 +41,8 @@ void __init plat_mem_setup(void);
 
 /* arch/sh/kernel/setup.c */
 void __init setup_bootmem_allocator(unsigned long start_pfn);
+void __init __add_active_range(unsigned int nid, unsigned long start_pfn,
+			       unsigned long end_pfn);
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_MMZONE_H */
