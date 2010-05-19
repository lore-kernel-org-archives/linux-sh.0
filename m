From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 19 May 2010 18:36:08 +0000
Subject: [PATCH 2/3 v2] mfd: pass platform flags down to the tmio_mmc driver
Message-Id: <Pine.LNX.4.64.1005191818350.3099@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005191815491.3099@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005191815491.3099@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/mfd/sh_mobile_sdhi.c       |    2 ++
 include/linux/mfd/sh_mobile_sdhi.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
index dafa988..7970fe8 100644
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ b/drivers/mfd/sh_mobile_sdhi.c
@@ -106,6 +106,8 @@ static int __init sh_mobile_sdhi_probe(struct platform_device *pdev)
 	mmc_data->hclk = clk_get_rate(priv->clk);
 	mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
 	mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
+	if (p)
+		mmc_data->flags = p->tmio_flags;
 
 	if (p && p->dma_slave_tx >= 0 && p->dma_slave_rx >= 0) {
 		priv->param_tx.slave_id = p->dma_slave_tx;
diff --git a/include/linux/mfd/sh_mobile_sdhi.h b/include/linux/mfd/sh_mobile_sdhi.h
index c305461..c7b47f8 100644
--- a/include/linux/mfd/sh_mobile_sdhi.h
+++ b/include/linux/mfd/sh_mobile_sdhi.h
@@ -4,6 +4,7 @@
 struct sh_mobile_sdhi_info {
 	int dma_slave_tx;
 	int dma_slave_rx;
+	unsigned long tmio_flags;
 	void (*set_pwr)(struct platform_device *pdev, int state);
 };
 
-- 
1.6.2.4

