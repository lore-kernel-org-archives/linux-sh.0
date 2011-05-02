From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 02 May 2011 14:59:38 +0000
Subject: [PATCH 02/04] mmc: sdhi: no need for special interrupt flags
Message-Id: <20110502150623.21319.68742.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Modify the SDHI driver to get rid of unwanted irq flags.

IRQF_DISABLED unused, see include/linux/interrupt.h
IRQF_TRIGGER_FALLING only relevant on external IRQ pins,
but since SDHI is internal in the SoC this can go away.

Needed to support SDHI on sh73a0 that comes with a GIC
that errors out with the IRQF_TRIGGER_FALLING setting.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/mmc/host/sh_mobile_sdhi.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- 0002/drivers/mmc/host/sh_mobile_sdhi.c
+++ work/drivers/mmc/host/sh_mobile_sdhi.c	2011-05-02 23:22:54.000000000 +0900
@@ -120,8 +120,7 @@ static int __devinit sh_mobile_sdhi_prob
 	if (irq < 0)
 		goto eirq;
 
-	ret = request_irq(irq, tmio_mmc_irq, IRQF_DISABLED |
-			  IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), host);
+	ret = request_irq(irq, tmio_mmc_irq, 0, dev_name(&pdev->dev), host);
 	if (ret)
 		goto eirq;
 
