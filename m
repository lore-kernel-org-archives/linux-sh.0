From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Oct 2009 04:29:21 +0000
Subject: [PATCH] sh: add uio device for physically contiguous memory
Message-Id: <20091006042921.20412.57494.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds a separate uio device for physically
contiguous memory. The default behaviour is that no
memory is assigned to this device. To assign memory
the kernel command line parameter memchunk.uio_memory
can be used. 

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7366.c   |    6 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c   |    6 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c   |    6 ++--
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c   |    8 ++---
 arch/sh/kernel/cpu/shmobile/Makefile     |    1 
 arch/sh/kernel/cpu/shmobile/uio_memory.c |   42 ++++++++++++++++++++++++++++++
 6 files changed, 56 insertions(+), 13 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2009-10-02 10:19:29.000000000 +0900
@@ -88,7 +88,7 @@ static struct resource vpu_resources[]  
 static struct platform_device vpu_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 0,
+	.id		= 1,
 	.dev = {
 		.platform_data	= &vpu_platform_data,
 	},
@@ -116,7 +116,7 @@ static struct resource veu0_resources[] 
 
 static struct platform_device veu0_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 1,
+	.id		= 2,
 	.dev = {
 		.platform_data	= &veu0_platform_data,
 	},
@@ -144,7 +144,7 @@ static struct resource veu1_resources[] 
 
 static struct platform_device veu1_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 2,
+	.id		= 3,
 	.dev = {
 		.platform_data	= &veu1_platform_data,
 	},
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-10-02 10:19:57.000000000 +0900
@@ -130,7 +130,7 @@ static struct resource vpu_resources[]  
 static struct platform_device vpu_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 0,
+	.id		= 1,
 	.dev = {
 		.platform_data	= &vpu_platform_data,
 	},
@@ -161,7 +161,7 @@ static struct resource veu_resources[]  
 static struct platform_device veu_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 1,
+	.id		= 2,
 	.dev = {
 		.platform_data	= &veu_platform_data,
 	},
@@ -192,7 +192,7 @@ static struct resource jpu_resources[]  
 static struct platform_device jpu_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 2,
+	.id		= 3,
 	.dev = {
 		.platform_data	= &jpu_platform_data,
 	},
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2009-10-02 10:20:41.000000000 +0900
@@ -40,7 +40,7 @@ static struct resource vpu_resources[]  
 static struct platform_device vpu_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 0,
+	.id		= 1,
 	.dev = {
 		.platform_data	= &vpu_platform_data,
 	},
@@ -71,7 +71,7 @@ static struct resource veu0_resources[] 
 
 static struct platform_device veu0_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 1,
+	.id		= 2,
 	.dev = {
 		.platform_data	= &veu0_platform_data,
 	},
@@ -102,7 +102,7 @@ static struct resource veu1_resources[] 
 
 static struct platform_device veu1_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 2,
+	.id		= 3,
 	.dev = {
 		.platform_data	= &veu1_platform_data,
 	},
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2009-10-02 10:20:20.000000000 +0900
@@ -180,7 +180,7 @@ static struct resource vpu_resources[]  
 static struct platform_device vpu_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 0,
+	.id		= 1,
 	.dev = {
 		.platform_data	= &vpu_platform_data,
 	},
@@ -212,7 +212,7 @@ static struct resource veu0_resources[] 
 
 static struct platform_device veu0_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 1,
+	.id		= 2,
 	.dev = {
 		.platform_data	= &veu0_platform_data,
 	},
@@ -244,7 +244,7 @@ static struct resource veu1_resources[] 
 
 static struct platform_device veu1_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 2,
+	.id		= 3,
 	.dev = {
 		.platform_data	= &veu1_platform_data,
 	},
@@ -512,7 +512,7 @@ static struct resource jpu_resources[]  
 static struct platform_device jpu_device = {
 	.name		= "uio_pdrv_genirq",
-	.id		= 3,
+	.id		= 4,
 	.dev = {
 		.platform_data	= &jpu_platform_data,
 	},
--- 0001/arch/sh/kernel/cpu/shmobile/Makefile
+++ work/arch/sh/kernel/cpu/shmobile/Makefile	2009-10-02 10:18:11.000000000 +0900
@@ -6,3 +6,4 @@
 obj-$(CONFIG_PM)	+= pm.o sleep.o
 obj-$(CONFIG_CPU_IDLE)	+= cpuidle.o
 obj-$(CONFIG_PM_RUNTIME)	+= pm_runtime.o
+obj-$(CONFIG_UIO_PDRV_GENIRQ)	+= uio_memory.o
--- /dev/null
+++ work/arch/sh/kernel/cpu/shmobile/uio_memory.c	2009-10-02 10:18:37.000000000 +0900
@@ -0,0 +1,42 @@
+/*
+ * Physical contiguous memory for UIO devices
+ *
+ *  Copyright (C) 2009 Magnus Damm
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/uio_driver.h>
+
+static struct uio_info mem_platform_data = {
+	.name = "uio_memory",
+	.version = "0",
+	.irq = UIO_IRQ_NONE,
+};
+
+static struct resource mem_resources[] = {
+	[0] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device mem_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &mem_platform_data,
+	},
+	.resource	= mem_resources,
+	.num_resources	= ARRAY_SIZE(mem_resources),
+};
+
+static int __init mem_devices_setup(void)
+{
+	platform_resource_setup_memory(&mem_device, "uio_memory", 0);
+
+	return platform_device_register(&mem_device);
+}
+arch_initcall(mem_devices_setup);
