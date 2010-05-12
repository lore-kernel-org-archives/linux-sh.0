From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 May 2010 08:35:15 +0000
Subject: [PATCH 04/05] ARM: mach-shmobile: UIO platform data for sh7377
Message-Id: <20100512083515.9395.1158.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Export the following sh7377 multimedia hardware blocks
using UIO: VPU, VEU[0-3], JPU and SPU2DSP[0-1]

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7377.c |  257 +++++++++++++++++++++++++++++++++
 1 file changed, 257 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-sh7377.c
+++ work/arch/arm/mach-shmobile/setup-sh7377.c	2010-05-12 16:55:13.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/uio_driver.h>
 #include <linux/delay.h>
 #include <linux/input.h>
 #include <linux/io.h>
@@ -29,6 +30,7 @@
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
+#include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -184,6 +186,238 @@ static struct platform_device cmt10_devi
 	.num_resources	= ARRAY_SIZE(cmt10_resources),
 };
 
+/* VPU */
+static struct uio_info vpu_platform_data = {
+	.name = "VPU5HG",
+	.version = "0",
+	.irq = intcs_evt2irq(0x980),
+};
+
+static struct resource vpu_resources[] = {
+	[0] = {
+		.name	= "VPU",
+		.start	= 0xfe900000,
+		.end	= 0xfe900157,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* place holder for contiguous memory */
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
+		.end	= 0xfe9200cb,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* place holder for contiguous memory */
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
+		.end	= 0xfe9240cb,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* place holder for contiguous memory */
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
+		.end	= 0xfe928307,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* place holder for contiguous memory */
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
+		.end	= 0xfe92c307,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* place holder for contiguous memory */
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
+	[1] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device jpu_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 5,
+	.dev = {
+		.platform_data	= &jpu_platform_data,
+	},
+	.resource	= jpu_resources,
+	.num_resources	= ARRAY_SIZE(jpu_resources),
+};
+
+/* SPU2DSP0 */
+static struct uio_info spu0_platform_data = {
+	.name = "SPU2DSP0",
+	.version = "0",
+	.irq = evt2irq(0x1800),
+};
+
+static struct resource spu0_resources[] = {
+	[0] = {
+		.name	= "SPU2DSP0",
+		.start	= 0xFE200000,
+		.end	= 0xFE2FFFFF,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device spu0_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 6,
+	.dev = {
+		.platform_data	= &spu0_platform_data,
+	},
+	.resource	= spu0_resources,
+	.num_resources	= ARRAY_SIZE(spu0_resources),
+};
+
+/* SPU2DSP1 */
+static struct uio_info spu1_platform_data = {
+	.name = "SPU2DSP1",
+	.version = "0",
+	.irq = evt2irq(0x1820),
+};
+
+static struct resource spu1_resources[] = {
+	[0] = {
+		.name	= "SPU2DSP1",
+		.start	= 0xFE300000,
+		.end	= 0xFE3FFFFF,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* place holder for contiguous memory */
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
 static struct platform_device *sh7377_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -196,10 +430,33 @@ static struct platform_device *sh7377_ea
 	&cmt10_device,
 };
 
+static struct platform_device *sh7377_devices[] __initdata = {
+	&vpu_device,
+	&veu0_device,
+	&veu1_device,
+	&veu2_device,
+	&veu3_device,
+	&jpu_device,
+	&spu0_device,
+	&spu1_device,
+};
+
 void __init sh7377_add_standard_devices(void)
 {
 	platform_add_devices(sh7377_early_devices,
 			    ARRAY_SIZE(sh7377_early_devices));
+
+	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
+	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
+	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
+	platform_resource_setup_memory(&veu2_device, "veu2", 2 << 20);
+	platform_resource_setup_memory(&veu3_device, "veu3", 2 << 20);
+	platform_resource_setup_memory(&jpu_device, "jpu", 2 << 20);
+	platform_resource_setup_memory(&spu0_device, "spu0", 2 << 20);
+	platform_resource_setup_memory(&spu1_device, "spu1", 2 << 20);
+
+	platform_add_devices(sh7377_devices,
+			    ARRAY_SIZE(sh7377_devices));
 }
 
 #define SMSTPCR3 0xe615013c
