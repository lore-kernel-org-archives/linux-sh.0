From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Oct 2012 12:08:52 +0000
Subject: [PATCH] mmc: sh_mmcif: fix use after free
Message-Id: <Pine.LNX.4.64.1210231406080.13115@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>

A recent commit "mmc: sh_mmcif: fix clock management" has introduced a use
after free bug in sh_mmcif.c: in sh_mmcif_remove() the call to
mmc_free_host() frees private driver data, therefore using it afterwards
is a bug. Revert that hunk.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Chris, the offending patch appeared in 3.6, so, this has to go to 
3.6.stable, as well as to 3.7-rc.

 drivers/mmc/host/sh_mmcif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 11d2bc3..d25bc97 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1466,9 +1466,9 @@ static int __devexit sh_mmcif_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
+	clk_disable(host->hclk);
 	mmc_free_host(host->mmc);
 	pm_runtime_put_sync(&pdev->dev);
-	clk_disable(host->hclk);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
1.7.2.5

