From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 May 2011 15:56:27 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: MMCIF on mackerel can also be a
Message-Id: <Pine.LNX.4.64.1105051752490.29735@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Remember to also check for the CONFIG_MMC_SH_MMCIF_MODULE option
for the case of a modular MMCIF driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-mackerel.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 53fe219..8fe1f00 100644
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
@@ -940,7 +940,7 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&fsi_ak4643_device,
 	&fsi_hdmi_device,
 	&sdhi0_device,
-#if !defined(CONFIG_MMC_SH_MMCIF)
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	&sdhi1_device,
 #endif
 	&sdhi2_device,
@@ -1140,7 +1140,7 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID0_1, NULL);
 	gpio_request(GPIO_FN_SDHID0_0, NULL);
 
-#if !defined(CONFIG_MMC_SH_MMCIF)
+#if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	/* enable SDHI1 */
 	gpio_request(GPIO_FN_SDHICMD1, NULL);
 	gpio_request(GPIO_FN_SDHICLK1, NULL);
-- 
1.7.2.5

