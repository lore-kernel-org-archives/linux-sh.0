From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:15:58 +0000
Subject: [PATCH 01/08] sh: Add new memblock reservation code for mem_init
Message-Id: <20110106101558.1617.51316.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add a shmobile_memchunk_setup() function to the
SH architecture. This function is basically a new
version of platform_resource_setup_memory() that
makes use of memblock and excludes the memory
areas from the regular system memory.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/device.h |    2 ++
 arch/sh/mm/consistent.c      |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

--- 0001/arch/sh/include/asm/device.h
+++ work/arch/sh/include/asm/device.h	2011-01-06 16:43:48.000000000 +0900
@@ -11,6 +11,8 @@ struct platform_device;
 /* allocate contiguous memory chunk and fill in struct resource */
 int platform_resource_setup_memory(struct platform_device *pdev,
 				   char *name, unsigned long memsize);
+int shmobile_memchunk_setup(struct platform_device *pdev,
+			    char *name, unsigned long memsize);
 
 void plat_early_device_setup(void);
 
--- 0001/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2011-01-06 16:43:07.000000000 +0900
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/gfp.h>
+#include <linux/memblock.h>
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
 
@@ -155,3 +156,37 @@ int __init platform_resource_setup_memor
 	r->name = name;
 	return 0;
 }
+
+int __init shmobile_memchunk_setup(struct platform_device *pdev,
+				   char *name, unsigned long memsize)
+{
+	struct resource *r;
+	u64 addr;
+
+	r = pdev->resource + pdev->num_resources - 1;
+	if (r->flags) {
+		pr_warning("%s: unable to find empty space for resource\n",
+			name);
+		return -EINVAL;
+	}
+
+	memchunk_cmdline_override(name, &memsize);
+	if (!memsize)
+		return 0;
+
+	addr = memblock_alloc(memsize, PAGE_SIZE);
+	if (addr = ~(u64)0) {
+		pr_warning("%s: unable to allocate memory\n", name);
+		return -ENOMEM;
+	}
+	memblock_free(addr, memsize);
+	memblock_remove(addr, memsize);
+
+	r->flags = IORESOURCE_MEM;
+	r->start = addr;
+	r->end = r->start + memsize - 1;
+	r->name = name;
+	return 0;
+}
+
+
