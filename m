From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 01 Apr 2014 12:01:42 +0000
Subject: [PATCH v2 2/6] mmc: sh-mmcif: use devm_ for ioremap
Message-Id: <1396353706-31864-3-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

Start tidying the probe/release code by using devm_ioremap_resource() to
map the IO registers.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Fixes from v1:
	- return the PTR_ERR() from devm_ioremap
	- remove error print as it already shows an error
---
 drivers/mmc/host/sh_mmcif.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 738b155..bb8e4e6 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1379,22 +1379,15 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Get irq error\n");
 		return -ENXIO;
 	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "platform_get_resource error.\n");
-		return -ENXIO;
-	}
-	reg = ioremap(res->start, resource_size(res));
-	if (!reg) {
-		dev_err(&pdev->dev, "ioremap error.\n");
-		return -ENOMEM;
-	}
+	reg = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
 
 	mmc = mmc_alloc_host(sizeof(struct sh_mmcif_host), &pdev->dev);
-	if (!mmc) {
-		ret = -ENOMEM;
-		goto ealloch;
-	}
+	if (!mmc)
+		return -ENOMEM;
 
 	ret = mmc_of_parse(mmc);
 	if (ret < 0)
@@ -1499,8 +1492,6 @@ eclkget:
 	pm_runtime_disable(&pdev->dev);
 eofparse:
 	mmc_free_host(mmc);
-ealloch:
-	iounmap(reg);
 	return ret;
 }
 
@@ -1525,9 +1516,6 @@ static int sh_mmcif_remove(struct platform_device *pdev)
 	 */
 	cancel_delayed_work_sync(&host->timeout_work);
 
-	if (host->addr)
-		iounmap(host->addr);
-
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq(pdev, 1);
 
-- 
1.9.0

