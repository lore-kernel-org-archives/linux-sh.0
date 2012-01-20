From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 20 Jan 2012 23:41:28 +0000
Subject: [PATCH] mmc: sh_mmcif: fix late delayed work initialisation
Message-Id: <Pine.LNX.4.64.1201210038550.28312@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>

If the driver is loaded with a card in the slot, mmc_add_host() will
schedule an immediate card-detection work, which will start IO and wait
for command completion. Usually the kernel first returns to the sh_mmcif
probe function, lets it finish and only then schedules the rescan work.
But sometimes, expecially under heavy system load, the work will be
scheduled immediately before returning to the probe method. In this case
it is important for the driver to be fully prepared for IO. For sh_mmcif
this means, that also the timeout work has to be initialised before
calling mmc_add_host(). It is also better to prepare interrupts
beforehand. Besides, since mmc_add_host() does card-detection itself,
there is no need to do it again immediately afterwards.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Tested to work on top of my other recently posted patches, that probably 
will only go into 3.4, but this one actually fixes a bug in 3.3-rc1 and 
should apply and work there too.

 drivers/mmc/host/sh_mmcif.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index fa6592f..8532bf1 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1342,7 +1342,7 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto clean_up2;
 
-	mmc_add_host(mmc);
+	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
 
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
 
@@ -1353,22 +1353,24 @@ static int __devinit sh_mmcif_probe(struct platform_device *pdev)
 	}
 	ret = request_threaded_irq(irq[1], sh_mmcif_intr, sh_mmcif_irqt, 0, "sh_mmc:int", host);
 	if (ret) {
-		free_irq(irq[0], host);
 		dev_err(&pdev->dev, "request_irq error (sh_mmc:int)\n");
-		goto clean_up3;
+		goto clean_up4;
 	}
 
-	INIT_DELAYED_WORK(&host->timeout_work, mmcif_timeout_work);
-
-	mmc_detect_change(host->mmc, 0);
+	ret = mmc_add_host(mmc);
+	if (ret < 0)
+		goto clean_up5;
 
 	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
 	dev_dbg(&pdev->dev, "chip ver H'%04x\n",
 		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
 	return ret;
 
+clean_up5:
+	free_irq(irq[1], host);
+clean_up4:
+	free_irq(irq[0], host);
 clean_up3:
-	mmc_remove_host(mmc);
 	pm_runtime_suspend(&pdev->dev);
 clean_up2:
 	pm_runtime_disable(&pdev->dev);
-- 
1.7.2.5

