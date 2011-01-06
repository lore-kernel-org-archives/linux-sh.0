From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:16:50 +0000
Subject: [PATCH 07/08] sh: Remove old physically contiguous reservation code
Message-Id: <20110106101650.1617.74425.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Remove old unused platform_resource_setup_memory().
shmobile_memchunk_setup() should be used instead.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/device.h |    2 --
 arch/sh/mm/consistent.c      |   33 ---------------------------------
 2 files changed, 35 deletions(-)

--- 0002/arch/sh/include/asm/device.h
+++ work/arch/sh/include/asm/device.h	2011-01-06 18:40:47.000000000 +0900
@@ -9,8 +9,6 @@ struct dev_archdata {
 
 struct platform_device;
 /* allocate contiguous memory chunk and fill in struct resource */
-int platform_resource_setup_memory(struct platform_device *pdev,
-				   char *name, unsigned long memsize);
 int shmobile_memchunk_setup(struct platform_device *pdev,
 			    char *name, unsigned long memsize);
 
--- 0002/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2011-01-06 18:40:27.000000000 +0900
@@ -124,39 +124,6 @@ static void __init memchunk_cmdline_over
 	}
 }
 
-int __init platform_resource_setup_memory(struct platform_device *pdev,
-					  char *name, unsigned long memsize)
-{
-	struct resource *r;
-	dma_addr_t dma_handle;
-	void *buf;
-
-	r = pdev->resource + pdev->num_resources - 1;
-	if (r->flags) {
-		pr_warning("%s: unable to find empty space for resource\n",
-			name);
-		return -EINVAL;
-	}
-
-	memchunk_cmdline_override(name, &memsize);
-	if (!memsize)
-		return 0;
-
-	buf = dma_alloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
-	if (!buf) {
-		pr_warning("%s: unable to allocate memory\n", name);
-		return -ENOMEM;
-	}
-
-	memset(buf, 0, memsize);
-
-	r->flags = IORESOURCE_MEM;
-	r->start = dma_handle;
-	r->end = r->start + memsize - 1;
-	r->name = name;
-	return 0;
-}
-
 int __init shmobile_memchunk_setup(struct platform_device *pdev,
 				   char *name, unsigned long memsize)
 {
