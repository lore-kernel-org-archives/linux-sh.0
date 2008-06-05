From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 05 Jun 2008 12:21:04 +0000
Subject: [PATCH] sh: add resource of USB host for SH7723
Message-Id: <4847DA30.4030608@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   26 +++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-06-05 20:26:09.000000000 +0900
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-06-05 20:48:08.000000000 +0900
@@ -73,9 +73,35 @@ static struct platform_device rtc_device
 	.resource	= rtc_resources,
 };

+static struct resource sh7723_usb_host_resources[] = {
+	[0] = {
+		.name	= "r8a66597_hcd",
+		.start	= 0xa4d80000,
+		.end	= 0xa4d800ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 65,
+		.end	= 65,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sh7723_usb_host_device = {
+	.name		= "r8a66597_hcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= NULL,         /*  not use dma */
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(sh7723_usb_host_resources),
+	.resource	= sh7723_usb_host_resources,
+};
+
 static struct platform_device *sh7723_devices[] __initdata = {
 	&sci_device,
 	&rtc_device,
+	&sh7723_usb_host_device,
 };

 static int __init sh7723_devices_setup(void)
