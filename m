From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 14 Mar 2013 14:35:46 +0000
Subject: [PATCH v2 3/3] ARM: shmobile: marzen: Add Display Unit support
Message-Id: <1363271746-9806-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1363271746-9806-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1363271746-9806-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>

Only the DU0 VGA output is currently supported. Support for the DU0 LVDS
and DU1 LVDS outputs will require information about the panels that will
be connected to those outputs.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/configs/marzen_defconfig     |  2 ++
 arch/arm/mach-shmobile/board-marzen.c | 65 +++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index afb17d6..76f9402 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -79,6 +79,8 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_SSB=y
+CONFIG_DRM=y
+CONFIG_DRM_RCAR_DU=y
 CONFIG_USB=y
 CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index cdcb799..0020506 100644
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
@@ -147,6 +148,38 @@ static struct platform_device hspi_device = {
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
@@ -173,6 +206,7 @@ static struct platform_device *marzen_devices[] __initdata = {
 	&thermal_device,
 	&hspi_device,
 	&usb_phy_device,
+	&rcar_du_device,
 };
 
 /* USB */
@@ -363,6 +397,37 @@ static void __init marzen_init(void)
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
1.8.1.5

