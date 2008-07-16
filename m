From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 16 Jul 2008 10:02:54 +0000
Subject: [PATCH] sh: Add memory chunks to SH-Mobile UIO devices
Message-Id: <20080716100254.20944.55885.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds physically contiguous memory chunks to the UIO devices.
The same strategy can be used in the future for the CEU as well.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |    8 ++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   12 ++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    8 ++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   12 ++++++++++++
 arch/sh/mm/consistent.c                |   30 ++++++++++++++++++++++++++++++
 include/asm-sh/device.h                |    5 +++++
 6 files changed, 75 insertions(+)

--- 0003/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-07-16 17:40:56.000000000 +0900
@@ -66,6 +66,9 @@ static struct resource vpu_resources[]  		.end	= 0xfe9022eb,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
 };
 
 static struct platform_device vpu_device = {
@@ -91,6 +94,9 @@ static struct resource veu_resources[]  		.end	= 0xfe9200b7,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
 };
 
 static struct platform_device veu_device = {
@@ -132,6 +138,8 @@ static struct platform_device *sh7343_de
 
 static int __init sh7343_devices_setup(void)
 {
+	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
+	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
 	return platform_add_devices(sh7343_devices,
 				    ARRAY_SIZE(sh7343_devices));
 }
--- 0006/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2008-07-16 17:41:09.000000000 +0900
@@ -48,6 +48,9 @@ static struct resource vpu_resources[]  		.end	= 0xfe902807,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
 };
 
 static struct platform_device vpu_device = {
@@ -73,6 +76,9 @@ static struct resource veu0_resources[] 
 		.end	= 0xfe9200b7,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
 };
 
 static struct platform_device veu0_device = {
@@ -98,6 +104,9 @@ static struct resource veu1_resources[] 
 		.end	= 0xfe9240b7,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
 };
 
 static struct platform_device veu1_device = {
@@ -139,6 +148,9 @@ static struct platform_device *sh7366_de
 
 static int __init sh7366_devices_setup(void)
 {
+	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
+	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
+	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
 	return platform_add_devices(sh7366_devices,
 				    ARRAY_SIZE(sh7366_devices));
 }
--- 0004/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-07-16 17:40:46.000000000 +0900
@@ -73,6 +73,9 @@ static struct resource vpu_resources[]  		.end	= 0xfe9022eb,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
 };
 
 static struct platform_device vpu_device = {
@@ -98,6 +101,9 @@ static struct resource veu_resources[]  		.end	= 0xfe9200b7,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
 };
 
 static struct platform_device veu_device = {
@@ -152,6 +158,8 @@ static struct platform_device *sh7722_de
 
 static int __init sh7722_devices_setup(void)
 {
+	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
+	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
 	return platform_add_devices(sh7722_devices,
 				    ARRAY_SIZE(sh7722_devices));
 }
--- 0005/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-07-16 17:41:34.000000000 +0900
@@ -28,6 +28,9 @@ static struct resource vpu_resources[]  		.end	= 0xfe902807,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
 };
 
 static struct platform_device vpu_device = {
@@ -53,6 +56,9 @@ static struct resource veu0_resources[] 
 		.end	= 0xfe92027b,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
 };
 
 static struct platform_device veu0_device = {
@@ -78,6 +84,9 @@ static struct resource veu1_resources[] 
 		.end	= 0xfe92427b,
 		.flags	= IORESOURCE_MEM,
 	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
 };
 
 static struct platform_device veu1_device = {
@@ -221,6 +230,9 @@ static struct platform_device *sh7723_de
 
 static int __init sh7723_devices_setup(void)
 {
+	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
+	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
+	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
 	return platform_add_devices(sh7723_devices,
 				    ARRAY_SIZE(sh7723_devices));
 }
--- 0001/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2008-07-16 16:57:06.000000000 +0900
@@ -10,6 +10,7 @@
  * for more details.
  */
 #include <linux/mm.h>
+#include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <asm/cacheflush.h>
 #include <asm/addrspace.h>
@@ -185,3 +186,32 @@ void dma_cache_sync(struct device *dev, 
 	}
 }
 EXPORT_SYMBOL(dma_cache_sync);
+
+int platform_resource_setup_memory(struct platform_device *pdev,
+				   char *name, unsigned long memsize)
+{
+	struct resource *r;
+	dma_addr_t dma_handle;
+	void *buf;
+
+	r = pdev->resource + pdev->num_resources - 1;
+	if (r->flags) {
+		pr_warning("%s: unable to find empty space for resource\n",
+			name);
+		return -EINVAL;
+	}
+
+	buf = dma_alloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
+	if (!buf) {
+		pr_warning("%s: unable to allocate memory\n", name);
+		return -ENOMEM;
+	}
+
+	memset(buf, 0, memsize);
+
+	r->flags = IORESOURCE_MEM;
+	r->start = dma_handle;
+	r->end = r->start + memsize - 1;
+	r->name = name;
+	return 0;
+}
--- 0001/include/asm-sh/device.h
+++ work/include/asm-sh/device.h	2008-07-16 16:57:06.000000000 +0900
@@ -5,3 +5,8 @@
  */
 #include <asm-generic/device.h>
 
+struct platform_device;
+/* allocate contiguous memory chunk and fill in struct resource */
+int platform_resource_setup_memory(struct platform_device *pdev,
+				   char *name, unsigned long memsize);
+
