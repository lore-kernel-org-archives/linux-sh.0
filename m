From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 10:14:35 +0000
Subject: [PATCH v2 1/3] DMA: shdma: Fix warnings due to improper casts and printk formats
Message-Id: <1385547275-13572-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use the %zu printk specifier to print size_t variables, and cast
pointers to uintptr_t instead of unsigned int where applicable. This
fixes warnings on platforms where pointers and/or dma_addr_t have a
different size than int.

Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/shdma-base.c | 10 +++++-----
 drivers/dma/sh/shdma-of.c   |  3 ++-
 drivers/dma/sh/sudmac.c     |  4 ++--
 3 files changed, 9 insertions(+), 8 deletions(-)

Changes compared to v1:

- Cast to uintptr_t instead of unsigned long

Patches 2/3 and 3/3 haven't been changed.

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 2e7b394..fec301e 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -227,7 +227,7 @@ bool shdma_chan_filter(struct dma_chan *chan, void *arg)
 	struct shdma_chan *schan = to_shdma_chan(chan);
 	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
 	const struct shdma_ops *ops = sdev->ops;
-	int match = (int)arg;
+	int match = (long)arg;
 	int ret;
 
 	if (match < 0)
@@ -491,9 +491,9 @@ static struct shdma_desc *shdma_add_desc(struct shdma_chan *schan,
 	}
 
 	dev_dbg(schan->dev,
-		"chaining (%u/%u)@%x -> %x with %p, cookie %d\n",
-		copy_size, *len, *src, *dst, &new->async_tx,
-		new->async_tx.cookie);
+		"chaining (%zu/%zu)@%lx -> %lx with %p, cookie %d\n",
+		copy_size, *len, (uintptr_t)*src, (uintptr_t)*dst,
+		&new->async_tx, new->async_tx.cookie);
 
 	new->mark = DESC_PREPARED;
 	new->async_tx.flags = flags;
@@ -555,7 +555,7 @@ static struct dma_async_tx_descriptor *shdma_prep_sg(struct shdma_chan *schan,
 			goto err_get_desc;
 
 		do {
-			dev_dbg(schan->dev, "Add SG #%d@%p[%d], dma %llx\n",
+			dev_dbg(schan->dev, "Add SG #%d@%p[%zu], dma %llx\n",
 				i, sg, len, (unsigned long long)sg_addr);
 
 			if (direction = DMA_DEV_TO_MEM)
diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index 06473a0..b4ff9d3 100644
--- a/drivers/dma/sh/shdma-of.c
+++ b/drivers/dma/sh/shdma-of.c
@@ -33,7 +33,8 @@ static struct dma_chan *shdma_of_xlate(struct of_phandle_args *dma_spec,
 	/* Only slave DMA channels can be allocated via DT */
 	dma_cap_set(DMA_SLAVE, mask);
 
-	chan = dma_request_channel(mask, shdma_chan_filter, (void *)id);
+	chan = dma_request_channel(mask, shdma_chan_filter,
+				   (void *)(uintptr_t)id);
 	if (chan)
 		to_shdma_chan(chan)->hw_req = id;
 
diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
index c7e9cdf..66c5d66 100644
--- a/drivers/dma/sh/sudmac.c
+++ b/drivers/dma/sh/sudmac.c
@@ -178,8 +178,8 @@ static int sudmac_desc_setup(struct shdma_chan *schan,
 	struct sudmac_chan *sc = to_chan(schan);
 	struct sudmac_desc *sd = to_desc(sdesc);
 
-	dev_dbg(sc->shdma_chan.dev, "%s: src=%x, dst=%x, len=%d\n",
-		__func__, src, dst, *len);
+	dev_dbg(sc->shdma_chan.dev, "%s: src=%lx, dst=%lx, len=%zu\n",
+		__func__, (uintptr_t)src, (uintptr_t)dst, *len);
 
 	if (*len > schan->max_xfer_len)
 		*len = schan->max_xfer_len;
-- 
1.8.3.2

