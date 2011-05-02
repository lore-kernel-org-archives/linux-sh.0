From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 02 May 2011 14:53:48 +0000
Subject: [PATCH 01/04] mmc: tmio / sdhi: break out interrupt request/free
Message-Id: <20110502150033.21297.26338.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Move request_irq()/free_irq() from the shared code
in tmio_mmc.c into the SDHI/tmio specific portion
in sh_mobile_sdhi.c and tmio_mmc_pio.c.

This is ground work to allow us to adjust the SDHI
code with IRQ flags and number of interupt sources.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/sh_mobile_sdhi.c |   17 +++++++++++++++--
 drivers/mmc/host/tmio_mmc.c       |   18 +++++++++++++++---
 drivers/mmc/host/tmio_mmc.h       |    2 +-
 drivers/mmc/host/tmio_mmc_pio.c   |   17 ++---------------
 4 files changed, 33 insertions(+), 21 deletions(-)

--- 0001/drivers/mmc/host/sh_mobile_sdhi.c
+++ work/drivers/mmc/host/sh_mobile_sdhi.c	2011-05-02 23:22:24.000000000 +0900
@@ -62,7 +62,7 @@ static int __devinit sh_mobile_sdhi_prob
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
 	char clk_name[8];
-	int ret;
+	int irq, ret;
 
 	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
 	if (priv = NULL) {
@@ -116,11 +116,23 @@ static int __devinit sh_mobile_sdhi_prob
 	if (ret < 0)
 		goto eprobe;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		goto eirq;
+
+	ret = request_irq(irq, tmio_mmc_irq, IRQF_DISABLED |
+			  IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), host);
+	if (ret)
+		goto eirq;
+
 	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
-		(unsigned long)host->ctl, host->irq);
+		(unsigned long)host->ctl, irq);
 
 	return ret;
 
+eirq:
+	tmio_mmc_host_remove(host);
+
 eprobe:
 	clk_disable(priv->clk);
 	clk_put(priv->clk);
@@ -135,6 +147,7 @@ static int sh_mobile_sdhi_remove(struct 
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
 
+	free_irq(platform_get_irq(pdev, 0), host);
 	tmio_mmc_host_remove(host);
 	clk_disable(priv->clk);
 	clk_put(priv->clk);
--- 0001/drivers/mmc/host/tmio_mmc.c
+++ work/drivers/mmc/host/tmio_mmc.c	2011-05-02 23:22:24.000000000 +0900
@@ -67,9 +67,10 @@ static int __devinit tmio_mmc_probe(stru
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	struct tmio_mmc_data *pdata;
 	struct tmio_mmc_host *host;
+	int irq = platform_get_irq(pdev, 0);
 	int ret = -EINVAL;
 
-	if (pdev->num_resources != 2)
+	if (pdev->num_resources != 2 || irq < 0)
 		goto out;
 
 	pdata = mfd_get_data(pdev);
@@ -87,11 +88,19 @@ static int __devinit tmio_mmc_probe(stru
 	if (ret)
 		goto cell_disable;
 
+	ret = request_irq(irq, tmio_mmc_irq, IRQF_DISABLED |
+			  IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), host);
+	if (ret)
+		goto host_remove;
+
 	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
-		(unsigned long)host->ctl, host->irq);
+		(unsigned long)host->ctl, irq);
 
 	return 0;
 
+host_remove:
+	tmio_mmc_host_remove(host);
+
 cell_disable:
 	if (cell->disable)
 		cell->disable(pdev);
@@ -103,11 +112,14 @@ static int __devexit tmio_mmc_remove(str
 {
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
+	struct tmio_mmc_host *host;
 
 	platform_set_drvdata(pdev, NULL);
 
 	if (mmc) {
-		tmio_mmc_host_remove(mmc_priv(mmc));
+		host = mmc_priv(mmc);
+		free_irq(platform_get_irq(pdev, 0), host);
+		tmio_mmc_host_remove(host);
 		if (cell->disable)
 			cell->disable(pdev);
 	}
--- 0001/drivers/mmc/host/tmio_mmc.h
+++ work/drivers/mmc/host/tmio_mmc.h	2011-05-02 23:22:24.000000000 +0900
@@ -44,7 +44,6 @@ struct tmio_mmc_host {
 	struct mmc_request      *mrq;
 	struct mmc_data         *data;
 	struct mmc_host         *mmc;
-	int                     irq;
 	unsigned int		sdio_irq_enabled;
 
 	/* Callbacks for clock / power control */
@@ -83,6 +82,7 @@ void tmio_mmc_do_data_irq(struct tmio_mm
 
 void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
 void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
+irqreturn_t tmio_mmc_irq(int irq, void *devid);
 
 static inline char *tmio_mmc_kmap_atomic(struct scatterlist *sg,
 					 unsigned long *flags)
--- 0001/drivers/mmc/host/tmio_mmc_pio.c
+++ work/drivers/mmc/host/tmio_mmc_pio.c	2011-05-02 23:40:53.000000000 +0900
@@ -554,7 +554,7 @@ out:
 	spin_unlock(&host->lock);
 }
 
-static irqreturn_t tmio_mmc_irq(int irq, void *devid)
+irqreturn_t tmio_mmc_irq(int irq, void *devid)
 {
 	struct tmio_mmc_host *host = devid;
 	struct tmio_mmc_data *pdata = host->pdata;
@@ -649,6 +649,7 @@ static irqreturn_t tmio_mmc_irq(int irq,
 out:
 	return IRQ_HANDLED;
 }
+EXPORT_SYMBOL(tmio_mmc_irq);
 
 static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	struct mmc_data *data)
@@ -837,21 +838,10 @@ int __devinit tmio_mmc_host_probe(struct
 	tmio_mmc_clk_stop(_host);
 	tmio_mmc_reset(_host);
 
-	ret = platform_get_irq(pdev, 0);
-	if (ret < 0)
-		goto unmap_ctl;
-
-	_host->irq = ret;
-
 	tmio_mmc_disable_mmc_irqs(_host, TMIO_MASK_ALL);
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		tmio_mmc_enable_sdio_irq(mmc, 0);
 
-	ret = request_irq(_host->irq, tmio_mmc_irq, IRQF_DISABLED |
-		IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), _host);
-	if (ret)
-		goto unmap_ctl;
-
 	spin_lock_init(&_host->lock);
 
 	/* Init delayed work for request timeouts */
@@ -874,8 +864,6 @@ int __devinit tmio_mmc_host_probe(struct
 
 	return 0;
 
-unmap_ctl:
-	iounmap(_host->ctl);
 host_free:
 	mmc_free_host(mmc);
 
@@ -888,7 +876,6 @@ void tmio_mmc_host_remove(struct tmio_mm
 	mmc_remove_host(host->mmc);
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
-	free_irq(host->irq, host);
 	iounmap(host->ctl);
 	mmc_free_host(host->mmc);
 }
