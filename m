From: Takanari Hayama <taki@igel.co.jp>
Date: Mon, 22 Dec 2008 02:05:03 +0000
Subject: [PATCH] add UIO support for JPU.
Message-Id: <494EF5CF.1030901@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add JPU support on Migo-R via UIO. This make use of Magnus's
generic UIO platform driver. Chunk of contiguous memory to hold
intermediate image and compressed data during encode and decode.

Signed-off-by: Takanari Hayama <taki@igel.co.jp>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 9162013..50cf683 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -148,6 +148,34 @@ static struct platform_device veu_device = {
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
+		.end	= 0xfea102d0,
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
@@ -187,6 +215,7 @@ static struct platform_device *sh7722_devices[] __initdata = {
 	&sci_device,
 	&vpu_device,
 	&veu_device,
+	&jpu_device,
 };
 
 static int __init sh7722_devices_setup(void)
@@ -196,9 +225,11 @@ static int __init sh7722_devices_setup(void)
 	clk_always_enable("rtc0"); /* RTC */
 	clk_always_enable("veu0"); /* VEU */
 	clk_always_enable("vpu0"); /* VPU */
+	clk_always_enable("jpu0"); /* JPU */
 
 	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
 	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
+	platform_resource_setup_memory(&jpu_device, "jpu", 2 << 20);
 
 	return platform_add_devices(sh7722_devices,
 				    ARRAY_SIZE(sh7722_devices));
-- 
1.5.6.5

