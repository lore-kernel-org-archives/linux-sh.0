From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Apr 2011 03:16:32 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7367 UIO platform data V3
Message-Id: <20110428031632.25706.16078.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Export the following sh7367 multimedia hardware blocks
using UIO: VPU, VEU[0-3], VEU2H, JPU and SPU1

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V2:
 - Only export actual hardware device via UIO
 - Physically contiguous memory is excluded

 arch/arm/mach-shmobile/setup-sh7367.c |  223 +++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-sh7367.c
+++ work/arch/arm/mach-shmobile/setup-sh7367.c	2011-04-27 21:38:17.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/uio_driver.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
@@ -195,6 +196,214 @@ static struct platform_device cmt10_devi
 	.num_resources	= ARRAY_SIZE(cmt10_resources),
 };
 
+/* VPU */
+static struct uio_info vpu_platform_data = {
+	.name = "VPU5",
+	.version = "0",
+	.irq = intcs_evt2irq(0x980),
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
+/* VEU0 */
+static struct uio_info veu0_platform_data = {
+	.name = "VEU0",
+	.version = "0",
+	.irq = intcs_evt2irq(0x700),
+};
+
+static struct resource veu0_resources[] = {
+	[0] = {
+		.name	= "VEU0",
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
+/* VEU1 */
+static struct uio_info veu1_platform_data = {
+	.name = "VEU1",
+	.version = "0",
+	.irq = intcs_evt2irq(0x720),
+};
+
+static struct resource veu1_resources[] = {
+	[0] = {
+		.name	= "VEU1",
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
+/* VEU2 */
+static struct uio_info veu2_platform_data = {
+	.name = "VEU2",
+	.version = "0",
+	.irq = intcs_evt2irq(0x740),
+};
+
+static struct resource veu2_resources[] = {
+	[0] = {
+		.name	= "VEU2",
+		.start	= 0xfe928000,
+		.end	= 0xfe9280b7,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device veu2_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 3,
+	.dev = {
+		.platform_data	= &veu2_platform_data,
+	},
+	.resource	= veu2_resources,
+	.num_resources	= ARRAY_SIZE(veu2_resources),
+};
+
+/* VEU3 */
+static struct uio_info veu3_platform_data = {
+	.name = "VEU3",
+	.version = "0",
+	.irq = intcs_evt2irq(0x760),
+};
+
+static struct resource veu3_resources[] = {
+	[0] = {
+		.name	= "VEU3",
+		.start	= 0xfe92c000,
+		.end	= 0xfe92c0b7,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device veu3_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 4,
+	.dev = {
+		.platform_data	= &veu3_platform_data,
+	},
+	.resource	= veu3_resources,
+	.num_resources	= ARRAY_SIZE(veu3_resources),
+};
+
+/* VEU2H */
+static struct uio_info veu2h_platform_data = {
+	.name = "VEU2H",
+	.version = "0",
+	.irq = intcs_evt2irq(0x520),
+};
+
+static struct resource veu2h_resources[] = {
+	[0] = {
+		.name	= "VEU2H",
+		.start	= 0xfe93c000,
+		.end	= 0xfe93c27b,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device veu2h_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 5,
+	.dev = {
+		.platform_data	= &veu2h_platform_data,
+	},
+	.resource	= veu2h_resources,
+	.num_resources	= ARRAY_SIZE(veu2h_resources),
+};
+
+/* JPU */
+static struct uio_info jpu_platform_data = {
+	.name = "JPU",
+	.version = "0",
+	.irq = intcs_evt2irq(0x560),
+};
+
+static struct resource jpu_resources[] = {
+	[0] = {
+		.name	= "JPU",
+		.start	= 0xfe980000,
+		.end	= 0xfe9902d3,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device jpu_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 6,
+	.dev = {
+		.platform_data	= &jpu_platform_data,
+	},
+	.resource	= jpu_resources,
+	.num_resources	= ARRAY_SIZE(jpu_resources),
+};
+
+/* SPU1 */
+static struct uio_info spu1_platform_data = {
+	.name = "SPU1",
+	.version = "0",
+	.irq = evt2irq(0xfc0),
+};
+
+static struct resource spu1_resources[] = {
+	[0] = {
+		.name	= "SPU1",
+		.start	= 0xfe300000,
+		.end	= 0xfe3fffff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device spu1_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 7,
+	.dev = {
+		.platform_data	= &spu1_platform_data,
+	},
+	.resource	= spu1_resources,
+	.num_resources	= ARRAY_SIZE(spu1_resources),
+};
+
 static struct platform_device *sh7367_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -206,10 +415,24 @@ static struct platform_device *sh7367_ea
 	&cmt10_device,
 };
 
+static struct platform_device *sh7367_devices[] __initdata = {
+	&vpu_device,
+	&veu0_device,
+	&veu1_device,
+	&veu2_device,
+	&veu3_device,
+	&veu2h_device,
+	&jpu_device,
+	&spu1_device,
+};
+
 void __init sh7367_add_standard_devices(void)
 {
 	platform_add_devices(sh7367_early_devices,
 			     ARRAY_SIZE(sh7367_early_devices));
+
+	platform_add_devices(sh7367_devices,
+			    ARRAY_SIZE(sh7367_devices));
 }
 
 #define SYMSTPCR2 0xe6158048
