From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Jun 2012 17:10:30 +0000
Subject: [PATCH 1/7 v4] mmc: tmio: don't needlessly enable interrupts during probing
Message-Id: <1340212236-647-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340212236-647-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

We don't have to force-enable MMC interrupts in our .probe() method,
mmc_add_host() will trigger card detection, that will enable all the
necessary interrupts.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 53d1de6..9069d4a 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -950,6 +950,17 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	_host->sdcard_irq_mask = sd_ctrl_read32(_host, CTL_IRQ_MASK);
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
+
+	/* Unmask the IRQs we want to know about */
+	if (!_host->chan_rx)
+		irq_mask |= TMIO_MASK_READOP;
+	if (!_host->chan_tx)
+		irq_mask |= TMIO_MASK_WRITEOP;
+	if (!_host->native_hotplug)
+		irq_mask &= ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
+
+	_host->sdcard_irq_mask &= ~irq_mask;
+
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		tmio_mmc_enable_sdio_irq(mmc, 0);
 
@@ -967,16 +978,6 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
-	/* Unmask the IRQs we want to know about */
-	if (!_host->chan_rx)
-		irq_mask |= TMIO_MASK_READOP;
-	if (!_host->chan_tx)
-		irq_mask |= TMIO_MASK_WRITEOP;
-	if (!_host->native_hotplug)
-		irq_mask &= ~(TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD_INSERT);
-
-	tmio_mmc_enable_mmc_irqs(_host, irq_mask);
-
 	if (pdata->flags & TMIO_MMC_USE_GPIO_CD) {
 		ret = mmc_cd_gpio_request(mmc, pdata->cd_gpio);
 		if (ret < 0) {
-- 
1.7.2.5

