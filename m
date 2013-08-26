From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 26 Aug 2013 12:27:51 +0000
Subject: [PATCH] DMA: shdma: fix a bad merge - remove free_irq()
Message-Id: <Pine.LNX.4.64.1308261426320.1767@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

A bad merge resulted in a left-over free_irq() call. This patch removes it.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

Against today's dma-slave next branch.

 drivers/dma/sh/shdmac.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index c7faded..8f1683d 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -894,14 +894,9 @@ static int sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
 	struct dma_device *dma_dev = &shdev->shdma_dev.dma_dev;
-	struct resource *res;
-	int errirq = platform_get_irq(pdev, 0);
 
 	dma_async_device_unregister(dma_dev);
 
-	if (errirq > 0)
-		free_irq(errirq, shdev);
-
 	spin_lock_irq(&sh_dmae_lock);
 	list_del_rcu(&shdev->node);
 	spin_unlock_irq(&sh_dmae_lock);
-- 
1.7.2.5

