From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Date: Fri, 07 Jan 2011 09:48:36 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: Add support get_cd in CN23
Message-Id: <4D26E174.9050302@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 42f7c0d..bea5320 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -524,6 +524,15 @@ static struct platform_device sdhi1_device = {
 };
 #endif

+/*
+ * The card detect pin of the top SD/MMC slot (CN23) is active low and is
+ * connected to GPIO SCIFB_SCK of SH7372 (GPIO_PORT162).
+ */
+static int slot_cn23_get_cd(struct platform_device *pdev)
+{
+	return !gpio_get_value(GPIO_PORT162);
+}
+
 /* SDHI2 */
 static struct sh_mobile_sdhi_info sdhi2_info = {
 	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
@@ -531,6 +540,7 @@ static struct sh_mobile_sdhi_info sdhi2_info = {
 	.tmio_flags	= TMIO_MMC_WRPROTECT_DISABLE,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED |
 			  MMC_CAP_NEEDS_POLL,
+	.get_cd		= slot_cn23_get_cd,
 };

 static struct resource sdhi2_resources[] = {
@@ -904,6 +914,10 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SDHID2_1, NULL);
 	gpio_request(GPIO_FN_SDHID2_0, NULL);

+	/* card detect pin for microSD slot (CN23) */
+	gpio_request(GPIO_PORT162, NULL);
+	gpio_direction_input(GPIO_PORT162);
+
 	/* MMCIF */
 	gpio_request(GPIO_FN_MMCD0_0, NULL);
 	gpio_request(GPIO_FN_MMCD0_1, NULL);
-- 
1.5.6.5

