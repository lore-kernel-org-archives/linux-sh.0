From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 02 May 2011 15:14:54 +0000
Subject: [PATCH 04/04] mmc: sdhi: support up to 4 interrupt sources
Message-Id: <20110502151454.21337.94615.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the SDHI code to support more than a single
interrupt source. Needed to support hardware that
uses GIC instead of INTC as interrupt controller.

Will also allow us to remove the irq forwarding
workaround from the INTC code in the future.

Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 This is based on this patch from Simon Horman:
 "[PATCH 1/2] mmc: tmio: Allow SDHI MMC to use multiple IRQ vectors"

 drivers/mmc/host/sh_mobile_sdhi.c |   36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

--- 0004/drivers/mmc/host/sh_mobile_sdhi.c
+++ work/drivers/mmc/host/sh_mobile_sdhi.c	2011-05-02 23:49:25.000000000 +0900
@@ -62,7 +62,7 @@ static int __devinit sh_mobile_sdhi_prob
 	struct sh_mobile_sdhi_info *p = pdev->dev.platform_data;
 	struct tmio_mmc_host *host;
 	char clk_name[8];
-	int irq, ret;
+	int i, irq, ret;
 
 	priv = kzalloc(sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
 	if (priv = NULL) {
@@ -116,13 +116,25 @@ static int __devinit sh_mobile_sdhi_prob
 	if (ret < 0)
 		goto eprobe;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		goto eirq;
-
-	ret = request_irq(irq, tmio_mmc_irq, 0, dev_name(&pdev->dev), host);
-	if (ret)
-		goto eirq;
+	for (i = 0; i < 3; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			if (i)
+				continue;
+			else
+				goto eirq;
+		}
+		ret = request_irq(irq, tmio_mmc_irq, 0,
+				  dev_name(&pdev->dev), host);
+		if (ret) {
+			while (--i > 0) {
+				irq = platform_get_irq(pdev, i);
+				if (irq >= 0)
+					free_irq(irq, host);
+			}
+			goto eirq;
+		}
+	}
 
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
@@ -147,8 +159,14 @@ static int sh_mobile_sdhi_remove(struct 
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+	int i, irq;
+
+	for (i = 0; i < 3; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq >= 0)
+			free_irq(irq, host);
+	}
 
-	free_irq(platform_get_irq(pdev, 0), host);
 	tmio_mmc_host_remove(host);
 	clk_disable(priv->clk);
 	clk_put(priv->clk);
