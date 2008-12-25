From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Dec 2008 09:55:26 +0000
Subject: [PATCH] sh: export the sh7343 JPU to user space
Message-Id: <20081225095526.32515.83316.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch exports the sh7343 JPU to user space using uio_pdrv_genirq,
very similar to the sh7722 JPU patch by Hayama-san.

While at it fix up the end of the sh7722 JPU iomem resource.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   31 +++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-12-25 18:45:26.000000000 +0900
@@ -112,6 +112,34 @@ static struct platform_device veu_device
 	.num_resources	= ARRAY_SIZE(veu_resources),
 };
 
+static struct uio_info jpu_platform_data = {
+	.name = "JPU",
+	.version = "0",
+	.irq = 27,
+};
+
+static struct resource jpu_resources[] = {
+	[0] = {
+		.name	= "JPU",
+		.start	= 0xfea00000,
+		.end	= 0xfea102d3,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device jpu_device = {
+	.name		= "uio_pdrv_genirq",
+	.id		= 2,
+	.dev = {
+		.platform_data	= &jpu_platform_data,
+	},
+	.resource	= jpu_resources,
+	.num_resources	= ARRAY_SIZE(jpu_resources),
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xffe00000,
@@ -152,6 +180,7 @@ static struct platform_device *sh7343_de
 	&sci_device,
 	&vpu_device,
 	&veu_device,
+	&jpu_device,
 };
 
 static int __init sh7343_devices_setup(void)
@@ -160,9 +189,11 @@ static int __init sh7343_devices_setup(v
 	clk_always_enable("xymem0"); /* XYMEM */
 	clk_always_enable("veu0"); /* VEU */
 	clk_always_enable("vpu0"); /* VPU */
+	clk_always_enable("jpu0"); /* JPU */
 
 	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
 	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
+	platform_resource_setup_memory(&jpu_device, "jpu", 2 << 20);
 
 	return platform_add_devices(sh7343_devices,
 				    ARRAY_SIZE(sh7343_devices));
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-12-25 18:40:08.000000000 +0900
@@ -158,7 +158,7 @@ static struct resource jpu_resources[]  	[0] = {
 		.name	= "JPU",
 		.start	= 0xfea00000,
-		.end	= 0xfea102d0,
+		.end	= 0xfea102d3,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
