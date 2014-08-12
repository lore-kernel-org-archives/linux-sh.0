From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Aug 2014 12:29:50 +0000
Subject: Re: rcar-dmac: DMAOR initialization failed
Message-Id: <alpine.DEB.2.02.1408121429010.21943@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUbJ2DyL2wpV6SDDyxmoBiQEycUYiBpN8BigWTh5jiEyQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUbJ2DyL2wpV6SDDyxmoBiQEycUYiBpN8BigWTh5jiEyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 12 Aug 2014, Geert Uytterhoeven wrote:
> I tried a few things to fix this, but I'm not so sure what's the best solution:
> 
> Works:
>   - Calling clk_enable(dmac->clk)/clk_disable(dmac->clk) before resp.
>     after the call to rcar_dmac_init(). This also needs rcar_dmac.clk setup,
>     cfr. the first version of the rcar-dmac driver.

It never hurts to send an actual patch...

From 6f3288de9fe8f107896e65203d3c098989966870 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 Aug 2014 14:24:45 +0200
Subject: [PATCH] [RFC] dmaengine: rcar-dmac: Fix reinitialization on resume

When resuming from s2ram on Koelsch ("echo mem > /sys/power/state" to
suspend, and press any of the SW3x to resume), DMAOR initialization fails:

rcar-dmac e6700000.dma-controller: DMAOR initialization failed.
dpm_run_callback(): platform_pm_resume+0x0/0x54 returns -5
PM: Device e6700000.dma-controller failed to resume: error -5
rcar-dmac e6720000.dma-controller: DMAOR initialization failed.
dpm_run_callback(): platform_pm_resume+0x0/0x54 returns -5
PM: Device e6720000.dma-controller failed to resume: error -5

(note that DMA still works after this)

This is due to rcar_dmac_resume() calling rcar_dmac_init() while the
device's clock is disabled.

Explicitly enable the clock before calling rcar_dmac_init() to fix this,
and disable the clock again afterwards.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 0997322b70f8..334ddd3a37c0 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -10,6 +10,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
@@ -155,6 +156,7 @@ struct rcar_dmac {
 	struct dma_device engine;
 	struct device *dev;
 	void __iomem *iomem;
+	struct clk *clk;
 	char *irqname;
 
 	unsigned int n_channels;
@@ -1282,8 +1284,16 @@ static int rcar_dmac_suspend(struct device *dev)
 static int rcar_dmac_resume(struct device *dev)
 {
 	struct rcar_dmac *dmac = dev_get_drvdata(dev);
+	int ret;
 
-	return rcar_dmac_init(dmac);
+	ret = clk_enable(dmac->clk);
+	if (ret < 0)
+		return ret;
+
+	ret = rcar_dmac_init(dmac);
+
+	clk_disable(dmac->clk);
+	return ret;
 }
 #endif
 
@@ -1336,6 +1346,12 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 		return ret;
 	}
 
+	dmac->clk = clk_get(&pdev->dev, "fck");
+	if (IS_ERR(dmac->clk)) {
+		dev_err(&pdev->dev, "unable to get fck clock\n");
+		return PTR_ERR(dmac->clk);
+	}
+
 	/*
 	 * Initialize the DMA engine channel and add it to the DMA engine
 	 * channels list.
-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
