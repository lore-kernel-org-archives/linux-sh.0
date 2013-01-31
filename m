From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 31 Jan 2013 01:45:03 +0000
Subject: [PATCH 3/3] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <1359596703-17556-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: magnus.damm@gmail.com

Only the DU0 VGA output is currently supported. Support for the DU0 LVDS
and DU1 LVDS outputs will require information about the panels that will
be connected to those outputs.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 65 +++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index 449f928..48bbd98 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -38,6 +38,7 @@
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/pm_runtime.h>
+#include <linux/platform_data/rcar-du.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
@@ -148,6 +149,38 @@ static struct platform_device hspi_device = {
 	.num_resources	= ARRAY_SIZE(hspi_resources),
 };
 
+/* DU */
+static struct resource rcar_du_resources[] = {
+	[0] = {
+		.name	= "Display Unit",
+		.start	= 0xfff80000,
+		.end	= 0xfffb1007,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(31),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct rcar_du_platform_data rcar_du_pdata = {
+	.encoders = {
+		[0] = {
+			.encoder = RCAR_DU_ENCODER_VGA,
+		},
+	},
+};
+
+static struct platform_device rcar_du_device = {
+	.name		= "rcar-du",
+	.num_resources	= ARRAY_SIZE(rcar_du_resources),
+	.resource	= rcar_du_resources,
+	.dev	= {
+		.platform_data = &rcar_du_pdata,
+		.coherent_dma_mask = ~0,
+	},
+};
+
 /* USB PHY */
 static struct resource usb_phy_resources[] = {
 	[0] = {
@@ -174,6 +207,7 @@ static struct platform_device *marzen_devices[] __initdata = {
 	&thermal_device,
 	&hspi_device,
 	&usb_phy_device,
+	&rcar_du_device,
 };
 
 /* USB */
@@ -364,6 +398,37 @@ static void __init marzen_init(void)
 	gpio_request(GPIO_FN_HSPI_TX0,	NULL);
 	gpio_request(GPIO_FN_HSPI_RX0,	NULL);
 
+	/* Display Unit 0 (CN10: ARGB0) */
+	gpio_request(GPIO_FN_DU0_DR7, NULL);
+	gpio_request(GPIO_FN_DU0_DR6, NULL);
+	gpio_request(GPIO_FN_DU0_DR5, NULL);
+	gpio_request(GPIO_FN_DU0_DR4, NULL);
+	gpio_request(GPIO_FN_DU0_DR3, NULL);
+	gpio_request(GPIO_FN_DU0_DR2, NULL);
+	gpio_request(GPIO_FN_DU0_DR1, NULL);
+	gpio_request(GPIO_FN_DU0_DR0, NULL);
+	gpio_request(GPIO_FN_DU0_DG7, NULL);
+	gpio_request(GPIO_FN_DU0_DG6, NULL);
+	gpio_request(GPIO_FN_DU0_DG5, NULL);
+	gpio_request(GPIO_FN_DU0_DG4, NULL);
+	gpio_request(GPIO_FN_DU0_DG3, NULL);
+	gpio_request(GPIO_FN_DU0_DG2, NULL);
+	gpio_request(GPIO_FN_DU0_DG1, NULL);
+	gpio_request(GPIO_FN_DU0_DG0, NULL);
+	gpio_request(GPIO_FN_DU0_DB7, NULL);
+	gpio_request(GPIO_FN_DU0_DB6, NULL);
+	gpio_request(GPIO_FN_DU0_DB5, NULL);
+	gpio_request(GPIO_FN_DU0_DB4, NULL);
+	gpio_request(GPIO_FN_DU0_DB3, NULL);
+	gpio_request(GPIO_FN_DU0_DB2, NULL);
+	gpio_request(GPIO_FN_DU0_DB1, NULL);
+	gpio_request(GPIO_FN_DU0_DB0, NULL);
+	gpio_request(GPIO_FN_DU0_EXVSYNC_DU0_VSYNC, NULL);
+	gpio_request(GPIO_FN_DU0_EXHSYNC_DU0_HSYNC, NULL);
+	gpio_request(GPIO_FN_DU0_DOTCLKOUT0, NULL);
+	gpio_request(GPIO_FN_DU0_DOTCLKOUT1, NULL);
+	gpio_request(GPIO_FN_DU0_DISP, NULL);
+
 	/* USB (CN21) */
 	gpio_request(GPIO_FN_USB_OVC0, NULL);
 	gpio_request(GPIO_FN_USB_OVC1, NULL);
-- 
1.7.12.4

