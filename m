From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 22 Mar 2013 10:01:53 +0000
Subject: [PATCH v2] ARM: shmobile: streamline mackerel SD and MMC devices
Message-Id: <Pine.LNX.4.64.1303221056550.12375@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes the following issues with SD and MMC interfaces on mackerel:
1. replace custom card-detection functions with standard GPIO CD API
2. resources don't have to be numbered
3. add SDHI interrupt names
4. remove OCR masks, where regulators are used
5. don't specify SDHI CD interrupts. The pin is only present on SDHI0, and 
   even there we use it in GPIO mode to save power when no card is in the 
   slot
6. don't instantiate an MMCIF device and initialise MMCIF pins if SDHI1 is
   selected

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: updated to the current shmobile tree: remove redundant gpio_request() 
calls, replaced GPIO_PORTx macros with plain GPIO numbers. Also 
additionally remove SDHI0 native card detection interrupt

 arch/arm/mach-shmobile/board-mackerel.c |  111 +++++++++++--------------------
 1 files changed, 40 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 1a9c753..5b452e1 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -963,15 +963,6 @@ static struct platform_device nand_flash_device = {
 	},
 };
 
-/*
- * The card detect pin of the top SD/MMC slot (CN7) is active low and is
- * connected to GPIO A22 of SH7372 (GPIO 41).
- */
-static int slot_cn7_get_cd(struct platform_device *pdev)
-{
-	return !gpio_get_value(41);
-}
-
 /* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
@@ -982,21 +973,17 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 };
 
 static struct resource sdhi0_resources[] = {
-	[0] = {
+	{
 		.name	= "SDHI0",
 		.start	= 0xe6850000,
 		.end	= 0xe68500ff,
 		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= evt2irq(0x0e00) /* SDHI0_SDHI0I0 */,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
+	}, {
+		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x0e20) /* SDHI0_SDHI0I1 */,
 		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
+	}, {
+		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x0e40) /* SDHI0_SDHI0I2 */,
 		.flags	= IORESOURCE_IRQ,
 	},
@@ -1012,36 +999,30 @@ static struct platform_device sdhi0_device = {
 	},
 };
 
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+#if !IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 /* SDHI1 */
+
+/* GPIO 41 can trigger IRQ8, but it is used by USBHS1, we have to poll */
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI1_RX,
-	.tmio_ocr_mask	= MMC_VDD_165_195,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
-	.get_cd		= slot_cn7_get_cd,
+	.cd_gpio	= 41,
 };
 
 static struct resource sdhi1_resources[] = {
-	[0] = {
+	{
 		.name	= "SDHI1",
 		.start	= 0xe6860000,
 		.end	= 0xe68600ff,
 		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
-		.start	= evt2irq(0x0e80), /* SDHI1_SDHI1I0 */
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
+	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x0ea0), /* SDHI1_SDHI1I1 */
 		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
+	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x0ec0), /* SDHI1_SDHI1I2 */
 		.flags	= IORESOURCE_IRQ,
@@ -1059,43 +1040,32 @@ static struct platform_device sdhi1_device = {
 };
 #endif
 
+/* SDHI2 */
+
 /*
  * The card detect pin of the top SD/MMC slot (CN23) is active low and is
- * connected to GPIO SCIFB_SCK of SH7372 (162).
+ * connected to GPIO SCIFB_SCK of SH7372 (GPIO 162).
  */
-static int slot_cn23_get_cd(struct platform_device *pdev)
-{
-	return !gpio_get_value(162);
-}
-
-/* SDHI2 */
 static struct sh_mobile_sdhi_info sdhi2_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
-	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
+	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_NEEDS_POLL,
-	.get_cd		= slot_cn23_get_cd,
+	.cd_gpio	= 162,
 };
 
 static struct resource sdhi2_resources[] = {
-	[0] = {
+	{
 		.name	= "SDHI2",
 		.start	= 0xe6870000,
 		.end	= 0xe68700ff,
 		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.name	= SH_MOBILE_SDHI_IRQ_CARD_DETECT,
-		.start	= evt2irq(0x1200), /* SDHI2_SDHI2I0 */
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
+	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_SDCARD,
 		.start	= evt2irq(0x1220), /* SDHI2_SDHI2I1 */
 		.flags	= IORESOURCE_IRQ,
-	},
-	[3] = {
+	}, {
 		.name	= SH_MOBILE_SDHI_IRQ_SDIO,
 		.start	= evt2irq(0x1240), /* SDHI2_SDHI2I2 */
 		.flags	= IORESOURCE_IRQ,
@@ -1113,6 +1083,7 @@ static struct platform_device sdhi2_device = {
 };
 
 /* SH_MMCIF */
+#if IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 static struct resource sh_mmcif_resources[] = {
 	[0] = {
 		.name	= "MMCIF",
@@ -1134,16 +1105,17 @@ static struct resource sh_mmcif_resources[] = {
 
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
-	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
-	.get_cd		= slot_cn7_get_cd,
+	.use_cd_gpio	= true,
+	/* card detect pin for SD/MMC slot (CN7) */
+	.cd_gpio	= 41,
 	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
 	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
 
-static struct platform_device sh_mmcif_device __maybe_unused = {
+static struct platform_device sh_mmcif_device = {
 	.name		= "sh_mmcif",
 	.id		= 0,
 	.dev		= {
@@ -1154,7 +1126,7 @@ static struct platform_device sh_mmcif_device __maybe_unused = {
 	.num_resources	= ARRAY_SIZE(sh_mmcif_resources),
 	.resource	= sh_mmcif_resources,
 };
-
+#endif
 
 static int mackerel_camera_add(struct soc_camera_device *icd);
 static void mackerel_camera_del(struct soc_camera_device *icd);
@@ -1261,11 +1233,12 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&fsi_hdmi_device,
 	&nand_flash_device,
 	&sdhi0_device,
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+#if !IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 	&sdhi1_device,
+#else
+	&sh_mmcif_device,
 #endif
 	&sdhi2_device,
-	&sh_mmcif_device,
 	&ceu_device,
 	&mackerel_camera,
 	&hdmi_device,
@@ -1330,11 +1303,6 @@ static struct i2c_board_info i2c1_devices[] = {
 };
 
 static const struct pinctrl_map mackerel_pinctrl_map[] = {
-	/* MMCIF */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
-				  "mmc0_data8_0", "mmc0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
-				  "mmc0_ctrl_0", "mmc0"),
 	/* SDHI0 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_data4", "sdhi0"),
@@ -1343,11 +1311,17 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-sh7372",
 				  "sdhi0_wp", "sdhi0"),
 	/* SDHI1 */
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+#if !IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh7372",
 				  "sdhi1_data4", "sdhi1"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-sh7372",
 				  "sdhi1_ctrl", "sdhi1"),
+#else
+	/* MMCIF */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
+				  "mmc0_data8_0", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-sh7372",
+				  "mmc0_ctrl_0", "mmc0"),
 #endif
 	/* SDHI2 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-sh7372",
@@ -1372,10 +1346,11 @@ static void __init mackerel_init(void)
 		{ "A3SP", &usbhs0_device, },
 		{ "A3SP", &usbhs1_device, },
 		{ "A3SP", &nand_flash_device, },
-		{ "A3SP", &sh_mmcif_device, },
 		{ "A3SP", &sdhi0_device, },
-#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
+#if !IS_ENABLED(CONFIG_MMC_SH_MMCIF)
 		{ "A3SP", &sdhi1_device, },
+#else
+		{ "A3SP", &sh_mmcif_device, },
 #endif
 		{ "A3SP", &sdhi2_device, },
 		{ "A4R", &ceu_device, },
@@ -1486,12 +1461,6 @@ static void __init mackerel_init(void)
 	/* SDHI0 PORT172 card-detect IRQ26 */
 	gpio_request(GPIO_FN_IRQ26_172, NULL);
 
-	/* card detect pin for MMC slot (CN7) */
-	gpio_request_one(41, GPIOF_IN, NULL);
-
-	/* card detect pin for microSD slot (CN23) */
-	gpio_request_one(162, GPIOF_IN, NULL);
-
 	/* FLCTL */
 	gpio_request(GPIO_FN_D0_NAF0, NULL);
 	gpio_request(GPIO_FN_D1_NAF1, NULL);
-- 
1.7.2.5

