From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 25 Sep 2013 22:28:37 +0000
Subject: [PATCH 1/2] rcar-hpbdma: remove shdma_free_irq() calls
Message-Id: <201309260228.37765.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, dan.j.williams@intel.com
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, horms@verge.net.au

Commit c1c63a14f4f2419d093acd7164eccdff315baa86 (DMA: shdma: switch to managed
resource allocation) got rid of shdma_free_irq() but  unfortunately got merged
later than commit c4f6c41ba790bbbfcebb4c47a709ac8ff1fe1af9 (dma: add driver for
R-Car HPB-DMAC), so that the HPB-DMAC driver retained the calls and got broken:

drivers/dma/sh/rcar-hpbdma.c: In function `hpb_dmae_alloc_chan_resources':
drivers/dma/sh/rcar-hpbdma.c:435: error: implicit declaration of function
`shdma_free_irq'

Fix this compilation error by removing the remaining shdma_free_irq() calls.

Reported-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against 'fixes-3.12' branch of Vinod Koul's 'slave-dma.git' repo.

 drivers/dma/sh/rcar-hpbdma.c |    2 --
 1 file changed, 2 deletions(-)

Index: slave-dma/drivers/dma/sh/rcar-hpbdma.c
=================================--- slave-dma.orig/drivers/dma/sh/rcar-hpbdma.c
+++ slave-dma/drivers/dma/sh/rcar-hpbdma.c
@@ -432,7 +432,6 @@ hpb_dmae_alloc_chan_resources(struct hpb
 		hpb_chan->xfer_mode = XFER_DOUBLE;
 	} else {
 		dev_err(hpb_chan->shdma_chan.dev, "DCR setting error");
-		shdma_free_irq(&hpb_chan->shdma_chan);
 		return -EINVAL;
 	}
 
@@ -614,7 +613,6 @@ static void hpb_dmae_chan_remove(struct 
 	shdma_for_each_chan(schan, &hpbdev->shdma_dev, i) {
 		BUG_ON(!schan);
 
-		shdma_free_irq(schan);
 		shdma_chan_remove(schan);
 	}
 	dma_dev->chancnt = 0;
