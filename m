From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 19 Jun 2012 02:24:11 +0000
Subject: [PATCH 4/4] ARM: shmobile: kzm9g: enable MicroSD
Message-Id: <877gv4t4xk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enable MicroSD on CN20

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   55 ++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index ade2d6f..43bb42f 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -398,6 +398,50 @@ static struct platform_device sdhi0_device = {
 	},
 };
 
+/* Micro SD */
+static struct sh_mobile_sdhi_info sdhi2_info = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
+			  TMIO_MMC_USE_GPIO_CD |
+			  TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
+	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
+	.cd_gpio	= GPIO_PORT13,
+};
+
+static struct resource sdhi2_resources[] = {
+	[0] = {
+		.name	= "SDHI2",
+		.start	= 0xee140000,
+		.end	= 0xee1400ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
+		.start	= gic_spi(103),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
+		.start	= gic_spi(104),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[3] = {
+		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
+		.start	= gic_spi(105),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi2_device = {
+	.name		= "sh_mobile_sdhi",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(sdhi2_resources),
+	.resource	= sdhi2_resources,
+	.dev	= {
+		.platform_data	= &sdhi2_info,
+	},
+};
+
 /* KEY */
 #define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
 
@@ -511,6 +555,7 @@ static struct platform_device *kzm_devices[] __initdata = {
 	&lcdc_device,
 	&mmc_device,
 	&sdhi0_device,
+	&sdhi2_device,
 	&gpio_keys_device,
 	&fsi_device,
 	&fsi_ak4648_device,
@@ -648,6 +693,16 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_PORT15, NULL);
 	gpio_direction_output(GPIO_PORT15, 1); /* power */
 
+	/* enable Micro SD */
+	gpio_request(GPIO_FN_SDHID2_0,		NULL);
+	gpio_request(GPIO_FN_SDHID2_1,		NULL);
+	gpio_request(GPIO_FN_SDHID2_2,		NULL);
+	gpio_request(GPIO_FN_SDHID2_3,		NULL);
+	gpio_request(GPIO_FN_SDHICMD2,		NULL);
+	gpio_request(GPIO_FN_SDHICLK2,		NULL);
+	gpio_request(GPIO_PORT14, NULL);
+	gpio_direction_output(GPIO_PORT14, 1); /* power */
+
 	/* I2C 3 */
 	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
 	gpio_request(GPIO_FN_PORT28_I2C_SDA3, NULL);
-- 
1.7.5.4

