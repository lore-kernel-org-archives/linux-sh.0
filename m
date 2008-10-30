From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 30 Oct 2008 05:49:03 +0000
Subject: [PATCH] Add support usb setting on sh 7366
Message-Id: <u4p2u4o83.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


This patch add usb setting for sh 7366

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index 6851dba..62a5c35 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -36,6 +36,32 @@ static struct platform_device iic_device = {
 	.resource       = iic_resources,
 };
 
+static struct resource sh7366_usb_host_resources[] = {
+	[0] = {
+		.name   = "r8a66597_hcd",
+		.start  = 0xa4d80000,
+		.end    = 0xa4d800ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.name   = "r8a66597_hcd",
+		.start  = 65,
+		.end    = 65,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sh7366_usb_host_device = {
+	.name	= "r8a66597_hcd",
+	.id	= -1,
+	.dev = {
+		.dma_mask		= NULL,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(sh7366_usb_host_resources),
+	.resource	= sh7366_usb_host_resources,
+};
+
 static struct uio_info vpu_platform_data = {
 	.name = "VPU5",
 	.version = "0",
@@ -142,6 +168,7 @@ static struct platform_device sci_device = {
 static struct platform_device *sh7366_devices[] __initdata = {
 	&iic_device,
 	&sci_device,
+	&sh7366_usb_host_device,
 	&vpu_device,
 	&veu0_device,
 	&veu1_device,
@@ -158,6 +185,7 @@ static int __init sh7366_devices_setup(void)
 	clk_always_enable("mstp022"); /* INTC */
 	clk_always_enable("mstp020"); /* SuperHyway */
 	clk_always_enable("mstp109"); /* I2C */
+	clk_always_enable("mstp211"); /* USB */
 	clk_always_enable("mstp207"); /* VEU-2 */
 	clk_always_enable("mstp202"); /* VEU-1 */
 	clk_always_enable("mstp201"); /* VPU */
-- 
1.5.4.3

