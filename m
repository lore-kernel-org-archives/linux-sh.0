From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 18 Jan 2012 10:22:30 +0000
Subject: [PATCH 4/7] mmc: sh_mobile_sdhi: prepare for conversion to simple DMA
Message-Id: <Pine.LNX.4.64.1201181117170.28782@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201181025280.28782@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201181025280.28782@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index bf45359..1f6f67a 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -142,10 +142,10 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
 		mmc_data->cd_flags = p->cd_flags;
 
 		if (p->dma_slave_tx > 0 && p->dma_slave_rx > 0) {
-			priv->param_tx.slave_id = p->dma_slave_tx;
-			priv->param_rx.slave_id = p->dma_slave_rx;
-			priv->dma_priv.chan_priv_tx = &priv->param_tx;
-			priv->dma_priv.chan_priv_rx = &priv->param_rx;
+			priv->param_tx.simple_slave.slave_id = p->dma_slave_tx;
+			priv->param_rx.simple_slave.slave_id = p->dma_slave_rx;
+			priv->dma_priv.chan_priv_tx = &priv->param_tx.simple_slave;
+			priv->dma_priv.chan_priv_rx = &priv->param_rx.simple_slave;
 			priv->dma_priv.alignment_shift = 1; /* 2-byte alignment */
 			mmc_data->dma = &priv->dma_priv;
 		}
-- 
1.7.2.5

