From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 10 Jun 2009 05:04:32 +0000
Subject: [PATCH] sh7724: Add JPU support
Message-Id: <utz2o3cin.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 000f3b8..13816ea 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -451,6 +451,35 @@ static struct platform_device tmu5_device = {
 	.num_resources	= ARRAY_SIZE(tmu5_resources),
 };
 
+/* JPU */
+static struct uio_info jpu_platform_data = {
+	.name = "JPU",
+	.version = "0",
+	.irq = 27,
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
+	.id		= 3,
+	.dev = {
+		.platform_data	= &jpu_platform_data,
+	},
+	.resource	= jpu_resources,
+	.num_resources	= ARRAY_SIZE(jpu_resources),
+};
+
 static struct platform_device *sh7724_devices[] __initdata = {
 	&cmt_device,
 	&tmu0_device,
@@ -466,6 +495,7 @@ static struct platform_device *sh7724_devices[] __initdata = {
 	&vpu_device,
 	&veu0_device,
 	&veu1_device,
+	&jpu_device,
 };
 
 static int __init sh7724_devices_setup(void)
@@ -473,6 +503,7 @@ static int __init sh7724_devices_setup(void)
 	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
 	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
 	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
+	platform_resource_setup_memory(&jpu_device,  "jpu",  2 << 20);
 
 	return platform_add_devices(sh7724_devices,
 				    ARRAY_SIZE(sh7724_devices));
-- 
1.6.0.4

