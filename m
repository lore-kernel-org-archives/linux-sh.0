From: Takanari Hayama <taki@igel.co.jp>
Date: Fri, 07 Nov 2008 09:04:35 +0000
Subject: [PATCH] Added support for 2DG and BEU for sh7722.
Message-Id: <491404A3.4050205@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds BEU and 2DG supports in SH7722. 

Signed-off-by: Takanari Hayama <taki@igel.co.jp>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   42 ++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index ef77ee1..d052d79 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -179,6 +179,44 @@ static struct platform_device sci_device = {
 	},
 };
 
+static struct resource twodg_resources[] = {
+	[0] = {
+		.name	= "2DG",
+		.start	= 0xfd000000,
+		.end	= 0xfd0010bf,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 109,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device twodg_device = {
+	.name		= "2dg",
+	.num_resources	= ARRAY_SIZE(twodg_resources),
+	.resource	= twodg_resources,
+};
+
+static struct resource beu_resources[] = {
+	[0] = {
+		.name	= "BEU",
+		.start	= 0xfe930000,
+		.end	= 0xfe9333ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 53,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device beu_device = {
+	.name		= "beu",
+	.num_resources	= ARRAY_SIZE(beu_resources),
+	.resource	= beu_resources,
+};
+
 static struct platform_device *sh7722_devices[] __initdata = {
 	&rtc_device,
 	&usbf_device,
@@ -186,6 +224,8 @@ static struct platform_device *sh7722_devices[] __initdata = {
 	&sci_device,
 	&vpu_device,
 	&veu_device,
+	&twodg_device,
+	&beu_device,
 };
 
 static int __init sh7722_devices_setup(void)
@@ -201,6 +241,8 @@ static int __init sh7722_devices_setup(void)
 	clk_always_enable("mstp211"); /* USB */
 	clk_always_enable("mstp202"); /* VEU */
 	clk_always_enable("mstp201"); /* VPU */
+	clk_always_enable("mstp209"); /* 2DG */
+	clk_always_enable("mstp204"); /* BEU */
 
 	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
 	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
-- 
1.5.6.5

