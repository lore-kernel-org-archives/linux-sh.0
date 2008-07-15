From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Jul 2008 12:52:19 +0000
Subject: [PATCH] sh: Export sh7722 VPU and VEU using uio_pdrv_genirq
Message-Id: <20080715125219.10219.14074.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch exports the VPU and VEU blocks of the sh7722 to user space
using the uio_pdrv_genirq platform driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   53 ++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-07-15 21:07:13.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/mm.h>
+#include <linux/uio_driver.h>
 #include <asm/mmzone.h>
 
 static struct resource usbf_resources[] = {
@@ -59,6 +60,56 @@ static struct platform_device iic_device
 	.resource       = iic_resources,
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
@@ -95,6 +146,8 @@ static struct platform_device *sh7722_de
 	&usbf_device,
 	&iic_device,
 	&sci_device,
+	&vpu_device,
+	&veu_device,
 };
 
 static int __init sh7722_devices_setup(void)
