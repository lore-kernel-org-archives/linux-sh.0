From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Jul 2008 12:55:03 +0000
Subject: [PATCH] sh: Export sh7366 VPU, VEU(1), VEU(2) using uio_pdrv_genirq
Message-Id: <20080715125503.10223.81593.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch exports the VPU, VEU(1) and VEU(2) blocks of the sh7366
to user space using the uio_pdrv_genirq platform driver.

While at it, fix up the VEU(2) interrupt vector.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   81 +++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2008-07-15 21:21:17.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/uio_driver.h>
 
 static struct resource iic_resources[] = {
 	[0] = {
@@ -34,6 +35,81 @@ static struct platform_device iic_device
 	.resource       = iic_resources,
 };
 
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
+		.name	= "VEU(1)",
+		.start	= 0xfe920000,
+		.end	= 0xfe9200b7,
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
+		.name	= "VEU(2)",
+		.start	= 0xfe924000,
+		.end	= 0xfe9240b7,
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
 		.mapbase	= 0xffe00000,
@@ -56,6 +132,9 @@ static struct platform_device sci_device
 static struct platform_device *sh7366_devices[] __initdata = {
 	&iic_device,
 	&sci_device,
+	&vpu_device,
+	&veu0_device,
+	&veu1_device,
 };
 
 static int __init sh7366_devices_setup(void)
@@ -118,7 +197,7 @@ static struct intc_vect vectors[] __init
 	INTC_VECT(SIU, 0xf80),
 	INTC_VECT(TMU0, 0x400), INTC_VECT(TMU1, 0x420),
 	INTC_VECT(TMU2, 0x440),
-	INTC_VECT(VEU2, 0x580), INTC_VECT(LCDC, 0x580),
+	INTC_VECT(VEU2, 0x560), INTC_VECT(LCDC, 0x580),
 };
 
 static struct intc_group groups[] __initdata = {
