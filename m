From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 31 Jul 2014 00:34:09 +0000
Subject: [PATCH 6/6] dma/sh: fix rcar-dma.c printk format warnings
Message-Id: <dff5450f372ee87b5e0b5762b3ca8944dae8bf7e.1406766014.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warnings by using size_t modifiers ('z'):

../drivers/dma/sh/rcar-dmac.c:759:4: warning: format '%u' expects argument of type 'unsigned int', but argument 9 has type 'size_t' [-Wformat=]
../drivers/dma/sh/rcar-dmac.c:759:4: warning: format '%u' expects argument of type 'unsigned int', but argument 10 has type 'size_t' [-Wformat=]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/dma/sh/rcar-dmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 45ae37e..8c21d489d 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -757,7 +757,7 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_chan *chan, struct scatterlist *sgl,
 			hwdesc->size = size;
 
 			dev_dbg(chan->chan.device->dev,
-				"chan%u: hwdesc %p/%p sgl %u@%p, %u/%u %pad -> %pad\n",
+				"chan%u: hwdesc %p/%p sgl %u@%p, %zu/%zu %pad -> %pad\n",
 				chan->index, hwdesc, desc, i, sg, size, len,
 				&hwdesc->src_addr, &hwdesc->dst_addr);
 
-- 
2.0.1

