From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Jul 2008 12:51:39 +0000
Subject: [PATCH] sh: Export sh7343 VPU and VEU using uio_pdrv_genirq
Message-Id: <20080715125139.10218.34702.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch exports the VPU and VEU blocks of the sh7343 to user space
using the uio_pdrv_genirq platform driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Applies on top of current sh-2.6 git plus Shimoda-sans sh7343 changes.

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

--- 0002/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-07-15 21:05:44.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/uio_driver.h>
 
 static struct resource iic0_resources[] = {
 	[0] = {
@@ -52,6 +53,56 @@ static struct platform_device iic1_devic
 	.resource       = iic1_resources,
 };
 
+static struct uio_info vpu_platform_data = {
+	.name = "VPU4",
+	.version = "0",
+	.irq = 60,
+};
+
+static struct resource vpu_resources[] = {
+	[0] = {
+		.name	= "VPU",
+		.start	= 0xfe900000,
+		.end	= 0xfe9022eb,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device vpu_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &vpu_platform_data,
+	},
+	.resource	= vpu_resources,
+	.num_resources	= ARRAY_SIZE(vpu_resources),
+};
+
+static struct uio_info veu_platform_data = {
+	.name = "VEU",
+	.version = "0",
+	.irq = 54,
+};
+
+static struct resource veu_resources[] = {
+	[0] = {
+		.name	= "VEU",
+		.start	= 0xfe920000,
+		.end	= 0xfe9200b7,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device veu_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &veu_platform_data,
+	},
+	.resource	= veu_resources,
+	.num_resources	= ARRAY_SIZE(veu_resources),
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xffe00000,
@@ -75,6 +126,8 @@ static struct platform_device *sh7343_de
 	&iic0_device,
 	&iic1_device,
 	&sci_device,
+	&vpu_device,
+	&veu_device,
 };
 
 static int __init sh7343_devices_setup(void)
