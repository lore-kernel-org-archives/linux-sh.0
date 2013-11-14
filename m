From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Nov 2013 10:32:53 +0000
Subject: [PATCH 15/17] mmc: SDHI: updata sh_mobile_sdhi_of_data for r8a7790
Message-Id: <87vbzvxoha.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<8761rvz37d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761rvz37d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

This patch updates r8a7790 DT data to have SoC specific settings.
Latest Renesas Chip has some SDHI channels and the WP pin
availability depends on its channel or HW implementation.
Thus, this patch disables it as default,
but we can use wp-gpios property to enable it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 9cffca1..62dcb54 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -38,6 +38,7 @@
 struct sh_mobile_sdhi_of_data {
 	unsigned long tmio_flags;
 	unsigned long capabilities;
+	unsigned long capabilities2;
 };
 
 static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
@@ -51,6 +52,12 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
 };
 
+static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
+	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.capabilities2	= MMC_CAP2_NO_MULTI_READ,
+};
+
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-shmobile" },
 	{ .compatible = "renesas,sdhi-sh7372" },
@@ -59,7 +66,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7790", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
@@ -219,6 +226,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
 		mmc_data->flags |= of_data->tmio_flags;
 		mmc_data->capabilities |= of_data->capabilities;
+		mmc_data->capabilities2 |= of_data->capabilities2;
 	}
 
 	/* SD control register space size is 0x100, 0x200 for bus_shift=1 */
-- 
1.7.9.5

