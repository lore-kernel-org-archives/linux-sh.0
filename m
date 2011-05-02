From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 02 May 2011 15:10:24 +0000
Subject: [PATCH 03/04] mmc: sdhi: print out something useful
Message-Id: <20110502151024.21327.66767.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Instead of printing out useless information such
as the virtual base address and one of 4 interrupts,
convert the SDHI probe() to print out physical base
address together with clock rate.

We do have a struct device so make use of dev_info().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/sh_mobile_sdhi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 0003/drivers/mmc/host/sh_mobile_sdhi.c
+++ work/drivers/mmc/host/sh_mobile_sdhi.c	2011-05-02 23:31:22.000000000 +0900
@@ -124,8 +124,10 @@ static int __devinit sh_mobile_sdhi_prob
 	if (ret)
 		goto eirq;
 
-	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
-		(unsigned long)host->ctl, irq);
+	dev_info(&pdev->dev, "%s base at 0x%08lx clock rate %u MHz\n",
+		 mmc_hostname(host->mmc), (unsigned long)
+		 (platform_get_resource(pdev,IORESOURCE_MEM, 0)->start),
+		 mmc_data->hclk / 1000000);
 
 	return ret;
 
