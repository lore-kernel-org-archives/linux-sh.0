From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 04 Nov 2009 10:34:25 +0000
Subject: [PATCH] sh: sh7724: Add SPU2 support
Message-Id: <upr7yfuj2.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   68 ++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index ac1505a..9c3cc8f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -525,6 +525,70 @@ static struct platform_device jpu_device = {
 	},
 };
 
+/* SPU2DSP0 */
+static struct uio_info spu0_platform_data = {
+	.name = "SPU2DSP0",
+	.version = "0",
+	.irq = 86,
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
+	.id		= 4,
+	.dev = {
+		.platform_data	= &spu0_platform_data,
+	},
+	.resource	= spu0_resources,
+	.num_resources	= ARRAY_SIZE(spu0_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_SPU,
+	},
+};
+
+/* SPU2DSP1 */
+static struct uio_info spu1_platform_data = {
+	.name = "SPU2DSP1",
+	.version = "0",
+	.irq = 87,
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
+	.id		= 5,
+	.dev = {
+		.platform_data	= &spu1_platform_data,
+	},
+	.resource	= spu1_resources,
+	.num_resources	= ARRAY_SIZE(spu1_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_SPU,
+	},
+};
+
 static struct platform_device *sh7724_devices[] __initdata = {
 	&cmt_device,
 	&tmu0_device,
@@ -541,6 +605,8 @@ static struct platform_device *sh7724_devices[] __initdata = {
 	&veu0_device,
 	&veu1_device,
 	&jpu_device,
+	&spu0_device,
+	&spu1_device,
 };
 
 static int __init sh7724_devices_setup(void)
@@ -549,6 +615,8 @@ static int __init sh7724_devices_setup(void)
 	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
 	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
 	platform_resource_setup_memory(&jpu_device,  "jpu",  2 << 20);
+	platform_resource_setup_memory(&spu0_device, "spu0", 2 << 20);
+	platform_resource_setup_memory(&spu1_device, "spu1", 2 << 20);
 
 	return platform_add_devices(sh7724_devices,
 				    ARRAY_SIZE(sh7724_devices));
-- 
1.6.3.3

