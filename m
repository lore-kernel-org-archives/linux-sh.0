From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 24 Jan 2012 12:01:38 +0000
Subject: [PATCH 09/11] mmc: sh_mobile_sdhi: do not manage PM clocks manually
Message-Id: <1327406500-7233-10-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On sh-mobile platforms the MMC clock frequency for the TMIO MMC unit is
obtained from the same clock, as the one, that runtime power-manages the
controller. The SDHI glue code has to access that clock directly,
bypassing the runtime PM framework, to get its frequency, but it
shouldn't enable or disable it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index cb279b4..f91c3aa 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -117,8 +117,6 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		goto eclkget;
 	}
 
-	clk_enable(priv->clk);
-
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->get_cd = sh_mobile_sdhi_get_cd;
@@ -233,7 +231,6 @@ eirq_sdio:
 eirq_card_detect:
 	tmio_mmc_host_remove(host);
 eprobe:
-	clk_disable(priv->clk);
 	clk_put(priv->clk);
 eclkget:
 	kfree(priv);
@@ -259,7 +256,6 @@ static int sh_mobile_sdhi_remove(struct platform_device *pdev)
 		free_irq(irq, host);
 	}
 
-	clk_disable(priv->clk);
 	clk_put(priv->clk);
 	kfree(priv);
 
-- 
1.7.2.5

