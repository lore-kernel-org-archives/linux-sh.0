From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 19 Mar 2009 02:51:15 +0000
Subject: [PATCH 5/6] Add VPU support for SH7724
Message-Id: <uws9n1ub6.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   33 ++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index ca625c2..64b7f0d 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -168,12 +168,42 @@ static struct platform_device iic1_device = {
 	.resource       = iic1_resources,
 };
 
+/* VPU */
+static struct uio_info vpu_platform_data = {
+	.name = "VPU5F",
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
 static struct platform_device *sh7724_devices[] __initdata = {
 	&sci_device,
 	&rtc_device,
 	&usb0_device,
 	&iic0_device,
 	&iic1_device,
+	&vpu_device,
 };
 
 #define UPONCR0		0xa40501d4
@@ -188,6 +218,9 @@ static void __init sh7724_usb_setup(void)
 static int __init sh7724_devices_setup(void)
 {
 	clk_always_enable("rtc0");   /* RTC */
+	clk_always_enable("vpu0");   /* VPU */
+
+	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
 
 	sh7724_usb_setup();
 	return platform_add_devices(sh7724_devices,
-- 
1.5.6.3

