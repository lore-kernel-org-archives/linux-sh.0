From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 18 Jul 2014 23:50:20 +0000
Subject: [PATCH v2 3/8] dmaengine: shdma: Allocate cyclic sg list dynamically
Message-Id: <1405727425-6237-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

The sg list used to prepare cyclic DMA descriptors is currently
allocated statically on the stack as an array of 32 elements. This makes
the shdma_prep_dma_cyclic() function consume a lot of stack space, as
reported by the compiler:

drivers/dma/sh/shdma-base.c: In function ‘shdma_prep_dma_cyclic’:
drivers/dma/sh/shdma-base.c:715:1: warning: the frame size of 1056 bytes
is larger than 1024 bytes [-Wframe-larger-than=]

Given the limited Linux kernel stack size, this could lead to stack
overflows. Fix the problem by allocating the sg list dynamically.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/shdma-base.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 94b6bde..e427a03 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -672,11 +672,12 @@ static struct dma_async_tx_descriptor *shdma_prep_dma_cyclic(
 {
 	struct shdma_chan *schan = to_shdma_chan(chan);
 	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
+	struct dma_async_tx_descriptor *desc;
 	const struct shdma_ops *ops = sdev->ops;
 	unsigned int sg_len = buf_len / period_len;
 	int slave_id = schan->slave_id;
 	dma_addr_t slave_addr;
-	struct scatterlist sgl[SHDMA_MAX_SG_LEN];
+	struct scatterlist *sgl;
 	int i;
 
 	if (!chan)
@@ -700,7 +701,16 @@ static struct dma_async_tx_descriptor *shdma_prep_dma_cyclic(
 
 	slave_addr = ops->slave_addr(schan);
 
+	/*
+	 * Allocate the sg list dynamically as it would consumer too much stack
+	 * space.
+	 */
+	sgl = kcalloc(sg_len, sizeof(*sgl), GFP_KERNEL);
+	if (!sgl)
+		return NULL;
+
 	sg_init_table(sgl, sg_len);
+
 	for (i = 0; i < sg_len; i++) {
 		dma_addr_t src = buf_addr + (period_len * i);
 
@@ -710,8 +720,11 @@ static struct dma_async_tx_descriptor *shdma_prep_dma_cyclic(
 		sg_dma_len(&sgl[i]) = period_len;
 	}
 
-	return shdma_prep_sg(schan, sgl, sg_len, &slave_addr,
+	desc = shdma_prep_sg(schan, sgl, sg_len, &slave_addr,
 			     direction, flags, true);
+
+	kfree(sgl);
+	return desc;
 }
 
 static int shdma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
-- 
1.8.5.5

