From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 16 Apr 2012 21:09:13 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO hotplug helper
Message-Id: <Pine.LNX.4.64.1204162306540.29915@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Tested-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/board-mackerel.c |   22 ++--------------------
 1 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 30fd516..627e37e 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1011,21 +1011,12 @@ static int slot_cn7_get_cd(struct platform_device *pdev)
 }
 
 /* SDHI0 */
-static irqreturn_t mackerel_sdhi0_gpio_cd(int irq, void *arg)
-{
-	struct device *dev = arg;
-	struct sh_mobile_sdhi_info *info = dev->platform_data;
-	struct tmio_mmc_data *pdata = info->pdata;
-
-	tmio_mmc_cd_wakeup(pdata);
-
-	return IRQ_HANDLED;
-}
-
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
 	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+	.tmio_flags	= TMIO_MMC_USE_GPIO_CD,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.cd_gpio	= GPIO_PORT172,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -1386,7 +1377,6 @@ static void __init mackerel_init(void)
 {
 	u32 srcr4;
 	struct clk *clk;
-	int ret;
 
 	/* External clock source */
 	clk_set_rate(&sh7372_dv_clki_clk, 27000000);
@@ -1483,7 +1473,6 @@ static void __init mackerel_init(void)
 	irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
 
 	/* enable SDHI0 */
-	gpio_request(GPIO_FN_SDHICD0, NULL);
 	gpio_request(GPIO_FN_SDHIWP0, NULL);
 	gpio_request(GPIO_FN_SDHICMD0, NULL);
 	gpio_request(GPIO_FN_SDHICLK0, NULL);
@@ -1492,13 +1481,6 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID0_1, NULL);
 	gpio_request(GPIO_FN_SDHID0_0, NULL);
 
-	ret = request_irq(evt2irq(0x3340), mackerel_sdhi0_gpio_cd,
-			  IRQF_TRIGGER_FALLING, "sdhi0 cd", &sdhi0_device.dev);
-	if (!ret)
-		sdhi0_info.tmio_flags |= TMIO_MMC_HAS_COLD_CD;
-	else
-		pr_err("Cannot get IRQ #%d: %d\n", evt2irq(0x3340), ret);
-
 #if !defined(CONFIG_MMC_SH_MMCIF) && !defined(CONFIG_MMC_SH_MMCIF_MODULE)
 	/* enable SDHI1 */
 	gpio_request(GPIO_FN_SDHICMD1, NULL);
-- 
1.7.2.5

