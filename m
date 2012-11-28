From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 28 Nov 2012 09:24:13 +0000
Subject: [PATCH] mmc: sh_mobile_sdhi: fix clock frequency printing
Message-Id: <Pine.LNX.4.64.1211281023310.1710@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>

During its probing the SDHI driver prints out the clock frequency, but
does it wrongly, always reporting 0Hz. Use the MMC host frequency value
to fix this issue.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 22ac8e7..d6ff853 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -248,7 +248,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
 		 mmc_hostname(host->mmc), (unsigned long)
 		 (platform_get_resource(pdev, IORESOURCE_MEM, 0)->start),
-		 mmc_data->hclk / 1000000);
+		 host->mmc->f_max / 1000000);
 
 	return ret;
 
-- 
1.7.2.5

