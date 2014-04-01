From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 01 Apr 2014 12:01:41 +0000
Subject: [PATCH v2 1/6] mmc: sh-mmcif: update to print version and bus clock rate on probe
Message-Id: <1396353706-31864-2-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

Change the initial print to show chip version and the bus rate it is
working at instead of the driver version. This is more useful information
as we already know which driver version from the kernel it is in.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/mmc/host/sh_mmcif.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index e8713d7..738b155 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1470,16 +1470,17 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 
 	mutex_init(&host->thread_lock);
 
-	clk_disable_unprepare(host->hclk);
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
 		goto emmcaddh;
 
 	dev_pm_qos_expose_latency_limit(&pdev->dev, 100);
 
-	dev_info(&pdev->dev, "driver version %s\n", DRIVER_VERSION);
-	dev_dbg(&pdev->dev, "chip ver H'%04x\n",
-		sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0x0000ffff);
+	dev_info(&pdev->dev, "Chip version 0x%04x, clock rate %luMHz\n",
+		 sh_mmcif_readl(host->addr, MMCIF_CE_VERSION) & 0xffff,
+		 clk_get_rate(host->hclk) / 1000000UL);
+
+	clk_disable_unprepare(host->hclk);
 	return ret;
 
 emmcaddh:
-- 
1.9.0

