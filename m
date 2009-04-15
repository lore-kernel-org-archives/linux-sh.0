From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 15 Apr 2009 02:43:07 +0000
Subject: [PATCH 6/6] Add VEU support for SH7724
Message-Id: <u8wm23adg.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uvdp71ub3.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uvdp71ub3.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   64 ++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 64b7f0d..1572a21 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -197,6 +197,64 @@ static struct platform_device vpu_device = {
 	.num_resources	= ARRAY_SIZE(vpu_resources),
 };
 
+/* VEU0 */
+static struct uio_info veu0_platform_data = {
+	.name = "VEU3F0",
+	.version = "0",
+	.irq = 83,
+};
+
+static struct resource veu0_resources[] = {
+	[0] = {
+		.name	= "VEU3F0",
+		.start	= 0xfe920000,
+		.end	= 0xfe9200cb - 1,
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
+	.name = "VEU3F1",
+	.version = "0",
+	.irq = 54,
+};
+
+static struct resource veu1_resources[] = {
+	[0] = {
+		.name	= "VEU3F1",
+		.start	= 0xfe924000,
+		.end	= 0xfe9240cb - 1,
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
 static struct platform_device *sh7724_devices[] __initdata = {
 	&sci_device,
 	&rtc_device,
@@ -204,6 +262,8 @@ static struct platform_device *sh7724_devices[] __initdata = {
 	&iic0_device,
 	&iic1_device,
 	&vpu_device,
+	&veu0_device,
+	&veu1_device,
 };
 
 #define UPONCR0		0xa40501d4
@@ -219,8 +279,12 @@ static int __init sh7724_devices_setup(void)
 {
 	clk_always_enable("rtc0");   /* RTC */
 	clk_always_enable("vpu0");   /* VPU */
+	clk_always_enable("veu1");   /* VEU3F1 */
+	clk_always_enable("veu0");   /* VEU3F0 */
 
 	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
+	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
+	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
 
 	sh7724_usb_setup();
 	return platform_add_devices(sh7724_devices,
-- 
1.5.6.3

