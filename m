From: "Phil Edworthy" <Phil.Edworthy@renesas.com>
Date: Wed, 28 Jul 2010 13:08:19 +0000
Subject: [PATCH] sh: Add sh7724 BEU resources
Message-Id: <AB12B32E73474741A2C5361C433A44DE01F9977A@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   68
++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 79c556e..93b2e0b 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -524,6 +524,70 @@ static struct platform_device veu1_device = {
 	},
 };
 
+/* BEU0 */
+static struct uio_info beu0_platform_data = {
+	.name = "BEU0",
+	.version = "0",
+	.irq = evt2irq(0x8A0),
+};
+
+static struct resource beu0_resources[] = {
+	[0] = {
+		.name	= "BEU0",
+		.start	= 0xfe930000,
+		.end	= 0xfe933400,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device beu0_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 6,
+	.dev = {
+		.platform_data	= &beu0_platform_data,
+	},
+	.resource	= beu0_resources,
+	.num_resources	= ARRAY_SIZE(beu0_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_BEU0,
+	},
+};
+
+/* BEU1 */
+static struct uio_info beu1_platform_data = {
+	.name = "BEU1",
+	.version = "0",
+	.irq = evt2irq(0xA00),
+};
+
+static struct resource beu1_resources[] = {
+	[0] = {
+		.name	= "BEU1",
+		.start	= 0xfe940000,
+		.end	= 0xfe943400,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device beu1_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 7,
+	.dev = {
+		.platform_data	= &beu1_platform_data,
+	},
+	.resource	= beu1_resources,
+	.num_resources	= ARRAY_SIZE(beu1_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_BEU1,
+	},
+};
+
 static struct sh_timer_config cmt_platform_data = {
 	.channel_offset = 0x60,
 	.timer_bit = 5,
@@ -857,6 +921,8 @@ static struct platform_device *sh7724_devices[]
__initdata = {
 	&vpu_device,
 	&veu0_device,
 	&veu1_device,
+	&beu0_device,
+	&beu1_device,
 	&jpu_device,
 	&spu0_device,
 	&spu1_device,
@@ -867,6 +933,8 @@ static int __init sh7724_devices_setup(void)
 	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
 	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
 	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
+	platform_resource_setup_memory(&beu0_device, "beu0", 2 << 20);
+	platform_resource_setup_memory(&beu1_device, "beu1", 2 << 20);
 	platform_resource_setup_memory(&jpu_device,  "jpu",  2 << 20);
 	platform_resource_setup_memory(&spu0_device, "spu0", 2 << 20);
 	platform_resource_setup_memory(&spu1_device, "spu1", 2 << 20);
-- 
1.7.1
