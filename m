From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 06 May 2011 11:02:37 +0000
Subject: [PATCH 2/4] mmc: sdhi: no need for special interrupt flags
Message-Id: <Pine.LNX.4.64.1105061258430.10445@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1105061244120.10445@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1105061244120.10445@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: cjb@laptop.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, horms@verge.net.au, linux-mmc@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Modify the SDHI driver to get rid of unwanted irq flags.

IRQF_DISABLED unused, see include/linux/interrupt.h
IRQF_TRIGGER_FALLING only relevant on external IRQ pins,
but since SDHI is internal in the SoC this can go away.

Needed to support SDHI on sh73a0 that comes with a GIC
that errors out with the IRQF_TRIGGER_FALLING setting.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 9ee51ac..c489547 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -122,8 +122,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eirq;
 	}
 
-	ret = request_irq(irq, tmio_mmc_irq, IRQF_DISABLED |
-			  IRQF_TRIGGER_FALLING, dev_name(&pdev->dev), host);
+	ret = request_irq(irq, tmio_mmc_irq, 0, dev_name(&pdev->dev), host);
 	if (ret)
 		goto eirq;
 
-- 
1.7.2.5

