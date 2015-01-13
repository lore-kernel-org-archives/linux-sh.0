From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 13 Jan 2015 05:00:39 +0000
Subject: [PATCH 17/17] mmc: tmio: remove TMIO_MMC_HAVE_CTL_DMA_REG flag
Message-Id: <8761cbuvdt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

tmio_mmc_host has .enable_dma callback now.
We don't need TMIO_MMC_HAVE_CTL_DMA_REG anymore.
Let's remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    5 -----
 drivers/mmc/host/tmio_mmc_dma.c   |    3 ---
 include/linux/mfd/tmio.h          |    5 -----
 3 files changed, 13 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 7dbcb57..6906a90 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -291,11 +291,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_QUIRK;
 
-	/*
-	 * All SDHI have DMA control register
-	 */
-	mmc_data->flags |= TMIO_MMC_HAVE_CTL_DMA_REG;
-
 	if (of_id && of_id->data) {
 		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
 		mmc_data->flags |= of_data->tmio_flags;
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index aa5f4b6..331bb61 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -28,9 +28,6 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 	if (!host->chan_tx || !host->chan_rx)
 		return;
 
-	if (host->pdata->flags & TMIO_MMC_HAVE_CTL_DMA_REG)
-		sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
-
 	if (host->dma->enable)
 		host->dma->enable(host, enable);
 }
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 807ecfb..6058128 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -96,11 +96,6 @@
 #define TMIO_MMC_SDIO_STATUS_QUIRK	(1 << 8)
 
 /*
- * Some controllers have DMA enable/disable register
- */
-#define TMIO_MMC_HAVE_CTL_DMA_REG	(1 << 9)
-
-/*
  * Some controllers allows to set SDx actual clock
  */
 #define TMIO_MMC_CLK_ACTUAL		(1 << 10)
-- 
1.7.9.5

