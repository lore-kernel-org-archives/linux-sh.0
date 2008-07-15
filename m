From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Jul 2008 12:53:33 +0000
Subject: [PATCH] sh: Export sh7723 VPU, VEU2H0, VEU2H1 using uio_pdrv_genirq
Message-Id: <20080715125333.10220.40672.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch exports the VPU, VEU2H0 and VEU2H1 blocks of the sh7723
to user space using the uio_pdrv_genirq platform driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   79 ++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-07-15 21:14:10.000000000 +0900
@@ -12,8 +12,84 @@
 #include <linux/serial.h>
 #include <linux/mm.h>
 #include <linux/serial_sci.h>
+#include <linux/uio_driver.h>
 #include <asm/mmzone.h>
 
+static struct uio_info vpu_platform_data = {
+	.name = "VPU5",
+	.version = "0",
+	.irq = 60,
+};
+
+static struct resource vpu_resources[] = {
+	[0] = {
+		.name	= "VPU",
+		.start	= 0xfe900000,
+		.end	= 0xfe902807,
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
+static struct uio_info veu0_platform_data = {
+	.name = "VEU",
+	.version = "0",
+	.irq = 54,
+};
+
+static struct resource veu0_resources[] = {
+	[0] = {
+		.name	= "VEU2H0",
+		.start	= 0xfe920000,
+		.end	= 0xfe92027b,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device veu0_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &veu0_platform_data,
+	},
+	.resource	= veu0_resources,
+	.num_resources	= ARRAY_SIZE(veu0_resources),
+};
+
+static struct uio_info veu1_platform_data = {
+	.name = "VEU",
+	.version = "0",
+	.irq = 27,
+};
+
+static struct resource veu1_resources[] = {
+	[0] = {
+		.name	= "VEU2H1",
+		.start	= 0xfe924000,
+		.end	= 0xfe92427b,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device veu1_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 2,
+	.dev = {
+		.platform_data	= &veu1_platform_data,
+	},
+	.resource	= veu1_resources,
+	.num_resources	= ARRAY_SIZE(veu1_resources),
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase        = 0xffe00000,
@@ -138,6 +214,9 @@ static struct platform_device *sh7723_de
 	&rtc_device,
 	&iic_device,
 	&sh7723_usb_host_device,
+	&vpu_device,
+	&veu0_device,
+	&veu1_device,
 };
 
 static int __init sh7723_devices_setup(void)
