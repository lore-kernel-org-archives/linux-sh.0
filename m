From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 15 Apr 2009 02:42:55 +0000
Subject: [PATCH 3/6] Add USB support for SH7724
Message-Id: <ud4be3ads.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   45 ++++++++++++++++++++++++++++++++
 drivers/usb/host/Kconfig               |    2 +-
 2 files changed, 46 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 71ccb25..4257713 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -99,15 +99,60 @@ static struct platform_device rtc_device = {
 	.resource	= rtc_resources,
 };
 
+/* USB0 */
+static struct resource usb0_host_resources[] = {
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
+static struct platform_device usb0_device = {
+	.name		= "r8a66597_hcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= NULL,       /*  not use dma */
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(usb0_host_resources),
+	.resource	= usb0_host_resources,
+};
+
 static struct platform_device *sh7724_devices[] __initdata = {
 	&sci_device,
 	&rtc_device,
+	&usb0_device,
 };
 
+#define UPONCR0		0xa40501d4
+#define UPONCR1		0xa4050192
+#define USBPOWERON	0x0600
+static void __init sh7724_usb_setup(void)
+{
+	/*
+	 * USB initial settings
+	 *
+	 * The following settings are necessary
+	 * for using the USB modules.
+	 *
+	 * see "USB Inital Settings" for detail
+	 */
+	__raw_writew(USBPOWERON , UPONCR0);
+	__raw_writew(USBPOWERON , UPONCR1);
+}
+
 static int __init sh7724_devices_setup(void)
 {
 	clk_always_enable("rtc0");   /* RTC */
 
+	sh7724_usb_setup();
 	return platform_add_devices(sh7724_devices,
 				    ARRAY_SIZE(sh7724_devices));
 }
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 845479f..e2b7393 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -317,7 +317,7 @@ config USB_R8A66597_HCD
 
 config SUPERH_ON_CHIP_R8A66597
 	boolean "Enable SuperH on-chip R8A66597 USB"
-	depends on USB_R8A66597_HCD && (CPU_SUBTYPE_SH7366 || CPU_SUBTYPE_SH7723)
+	depends on USB_R8A66597_HCD && (CPU_SUBTYPE_SH7366 || CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7724)
 	help
 	   This driver enables support for the on-chip R8A66597 in the
 	   SH7366 and SH7723 processors.
-- 
1.5.6.3

