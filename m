From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 29 Apr 2011 17:11:59 +0000
Subject: [PATCH] ARM: mach-shmobile: add DMA for MMCIF and fix its selection
Message-Id: <Pine.LNX.4.64.1104291911020.17813@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add DMA mode support for the MMCIF controller on mackerel, check not
only for statically built MMCIF driver, but also for modular.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 7da2ca2..008bd7f 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -705,7 +705,7 @@ static struct platform_device sdhi0_device = {
 	},
 };
 
-#if !defined(CONFIG_MMC_SH_MMCIF)
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 /* SDHI1 */
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI1_TX,
@@ -803,6 +803,15 @@ static struct resource sh_mmcif_resources[] = {
 	},
 };
 
+static struct sh_mmcif_dma sh_mmcif_dma = {
+	.chan_priv_rx	= {
+		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
+	},
+	.chan_priv_tx	= {
+		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
+	},
+};
+
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
@@ -810,6 +819,7 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
 	.get_cd		= slot_cn7_get_cd,
+	.dma		= &sh_mmcif_dma,
 };
 
 static struct platform_device sh_mmcif_device = {
@@ -940,7 +950,7 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&fsi_ak4643_device,
 	&fsi_hdmi_device,
 	&sdhi0_device,
-#if !defined(CONFIG_MMC_SH_MMCIF)
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	&sdhi1_device,
 #endif
 	&sdhi2_device,
@@ -1140,7 +1150,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID0_1, NULL);
 	gpio_request(GPIO_FN_SDHID0_0, NULL);
 
-#if !defined(CONFIG_MMC_SH_MMCIF)
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	/* enable SDHI1 */
 	gpio_request(GPIO_FN_SDHICMD1, NULL);
 	gpio_request(GPIO_FN_SDHICLK1, NULL);
-- 
1.7.2.5

