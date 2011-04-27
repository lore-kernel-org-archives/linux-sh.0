From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Apr 2011 07:43:57 +0000
Subject: [PATCH 1/2] mmc: tmio: Allow SDHI MMC to use multiple IRQ vectors
Message-Id: <1303890238-8372-2-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SDHI blocks may have up to 4 IRQ vectors.
The first three are of use to us, the 4th one
relates to DRM features that I don't have documentation
for and are almost certainly tainted by licensing issues.

This patch allows multiple vectors to be used if supplied
in the platform data. Which will allow IRQ multiplexing hacks
to be removed.

I plan to do further work to split tmio_mmc_irq() into per-vector
handlers. But this patch should be useful by itself.

Cc: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    7 ++++---
 drivers/mmc/host/tmio_mmc.h       |    2 +-
 drivers/mmc/host/tmio_mmc_pio.c   |   32 ++++++++++++++++++++++----------
 3 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index cc70123..2216210 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -62,7 +62,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
 	char clk_name[8];
-	int ret;
+	int i, ret;
 
 	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
 	if (priv = NULL) {
@@ -116,8 +116,9 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto eprobe;
 
-	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
-		(unsigned long)host->ctl, host->irq);
+	for (i = 0; host->irq[i] >= 0 && i < 3; i++)
+		pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
+			(unsigned long)host->ctl, host->irq[i]);
 
 	return ret;
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 099ed49..6b240f5 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -44,7 +44,7 @@ struct tmio_mmc_host {
 	struct mmc_request      *mrq;
 	struct mmc_data         *data;
 	struct mmc_host         *mmc;
-	int                     irq;
+	int                     irq[3];
 	unsigned int		sdio_irq_enabled;
 
 	/* Callbacks for clock / power control */
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 62d37de..9d84d90 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -790,7 +790,7 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	struct tmio_mmc_host *_host;
 	struct mmc_host *mmc;
 	struct resource *res_ctl;
-	int ret;
+	int i, ret;
 	u32 irq_mask = TMIO_MASK_CMD;
 
 	res_ctl = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -837,20 +837,29 @@ int __devinit tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	tmio_mmc_clk_stop(_host);
 	tmio_mmc_reset(_host);
 
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		goto unmap_ctl;
-
-	_host->irq = ret;
+	for (i = 0; i < 3; i++) {
+		_host->irq[i] = ret = platform_get_irq(pdev, i);
+		if (ret < 0) {
+			if (i = 1)
+				break;
+			else
+				goto unmap_ctl;
+		}
+	}
 
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		tmio_mmc_enable_sdio_irq(mmc, 0);
 
-	ret = request_irq(_host->irq, tmio_mmc_irq, IRQF_DISABLED |
+	for (i = 0; _host->irq[i] >= 0 && i < 3; i++) {
+		ret = request_irq(_host->irq[i], tmio_mmc_irq, IRQF_DISABLED |
 		IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), _host);
-	if (ret)
-		goto unmap_ctl;
+		if (ret) {
+			while (--i > 0)
+				free_irq(_host->irq[i], host);
+			goto unmap_ctl;
+		}
+	}
 
 	spin_lock_init(&_host->lock);
 
@@ -885,10 +894,13 @@ EXPORT_SYMBOL(tmio_mmc_host_probe);
 
 void tmio_mmc_host_remove(struct tmio_mmc_host *host)
 {
+	int i;
+
 	mmc_remove_host(host->mmc);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
-	free_irq(host->irq, host);
+	for (i = 0; host->irq[i] >= 0 && i < 3; i++)
+		free_irq(host->irq[i], host);
 	iounmap(host->ctl);
 	mmc_free_host(host->mmc);
 }
-- 
1.7.4.1

