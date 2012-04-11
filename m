From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Apr 2012 03:58:10 +0000
Subject: [PATCH 4/6] ARM: mach-shmobile: kzm9g: add external USB Host support
Message-Id: <878vi23ooh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch uses r8a66597_hcd driver,
since renesas_usbhs driver doesn't support external R8A66597 chip.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index a46aec1..f48db23 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -21,6 +21,7 @@
 #include <linux/irq.h>
 #include <linux/platform_device.h>
 #include <linux/smsc911x.h>
+#include <linux/usb/r8a66597.h>
 #include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
@@ -58,8 +59,38 @@ static struct platform_device smsc_device = {
 	.num_resources	= ARRAY_SIZE(smsc9221_resources),
 };
 
+/* USB external chip */
+static struct r8a66597_platdata usb_host_data = {
+	.on_chip	= 0,
+	.xtal		= R8A66597_PLATDATA_XTAL_48MHZ,
+};
+
+static struct resource usb_resources[] = {
+	[0] = {
+		.start	= 0x10010000,
+		.end	= 0x1001ffff - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x220), /* IRQ1 */
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb_host_device = {
+	.name	= "r8a66597_hcd",
+	.dev = {
+		.platform_data		= &usb_host_data,
+		.dma_mask		= NULL,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(usb_resources),
+	.resource	= usb_resources,
+};
+
 static struct platform_device *kzm_devices[] __initdata = {
 	&smsc_device,
+	&usb_host_device,
 };
 
 static void __init kzm_init(void)
-- 
1.7.5.4

