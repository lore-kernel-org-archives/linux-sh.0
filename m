From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jul 2015 11:59:11 +0000
Subject: [PATCH/RFC 1/3] dmaengine: shdmac: Use generic residue handling
Message-Id: <1436529553-30571-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Convert the existing support for partial DMA transfers to use the
generic dmaengine residual data framework.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Notes:
  - Untested, as this mostly affects legacy (non-DT) drivers on more or
    less legacy platforms,
  - This cannot be applied yet, as drivers/tty/serial/sh-sci.c still
    uses shdma_desc.partial!
---
 drivers/dma/sh/rcar-hpbdma.c | 10 +++++-----
 drivers/dma/sh/shdma-base.c  | 12 ++++++++----
 drivers/dma/sh/shdmac.c      | 13 +++++--------
 drivers/dma/sh/sudmac.c      | 10 +++++-----
 include/linux/shdma-base.h   |  4 ++--
 5 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
index 749f26ecd3b32b0a..2e21c1197769d0c8 100644
--- a/drivers/dma/sh/rcar-hpbdma.c
+++ b/drivers/dma/sh/rcar-hpbdma.c
@@ -374,15 +374,15 @@ static int hpb_dmae_desc_setup(struct shdma_chan *schan,
 	return 0;
 }
 
-static size_t hpb_dmae_get_partial(struct shdma_chan *schan,
-				   struct shdma_desc *sdesc)
+static u32 hpb_dmae_get_residue(struct shdma_chan *schan,
+				struct shdma_desc *sdesc)
 {
 	struct hpb_desc *desc = to_desc(sdesc);
 	struct hpb_dmae_chan *chan = to_chan(schan);
 	u32 tcr = ch_reg_read(chan, desc->plane_idx ?
 			      HPB_DMAE_DTCR1 : HPB_DMAE_DTCR0);
 
-	return (desc->hw.tcr - tcr) << chan->xmit_shift;
+	return tcr << chan->xmit_shift;
 }
 
 static bool hpb_dmae_channel_busy(struct shdma_chan *schan)
@@ -497,7 +497,7 @@ static const struct shdma_ops hpb_dmae_ops = {
 	.start_xfer = hpb_dmae_start_xfer,
 	.embedded_desc = hpb_dmae_embedded_desc,
 	.chan_irq = hpb_dmae_chan_irq,
-	.get_partial = hpb_dmae_get_partial,
+	.get_residue = hpb_dmae_get_residue,
 };
 
 static int hpb_dmae_chan_probe(struct hpb_dmae_device *hpbdev, int id)
@@ -600,7 +600,7 @@ static int hpb_dmae_probe(struct platform_device *pdev)
 	dma_dev->src_addr_widths = widths;
 	dma_dev->dst_addr_widths = widths;
 	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
-	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
 	hpbdev->shdma_dev.ops = &hpb_dmae_ops;
 	hpbdev->shdma_dev.desc_size = sizeof(struct hpb_desc);
diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 10fcabad80f3c65c..370b6c6895f3d48e 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -539,7 +539,7 @@ static struct shdma_desc *shdma_add_desc(struct shdma_chan *schan,
 	new->mark = DESC_PREPARED;
 	new->async_tx.flags = flags;
 	new->direction = direction;
-	new->partial = 0;
+	new->residue = *len;
 
 	*len -= copy_size;
 	if (direction = DMA_MEM_TO_MEM || direction = DMA_MEM_TO_DEV)
@@ -763,11 +763,11 @@ static int shdma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&schan->chan_lock, flags);
 	ops->halt_channel(schan);
 
-	if (ops->get_partial && !list_empty(&schan->ld_queue)) {
-		/* Record partial transfer */
+	if (ops->get_residue && !list_empty(&schan->ld_queue)) {
+		/* Record residual transfer */
 		struct shdma_desc *desc = list_first_entry(&schan->ld_queue,
 							   struct shdma_desc, node);
-		desc->partial = ops->get_partial(schan, desc);
+		desc->residue = ops->get_residue(schan, desc);
 	}
 
 	spin_unlock_irqrestore(&schan->chan_lock, flags);
@@ -825,6 +825,7 @@ static enum dma_status shdma_tx_status(struct dma_chan *chan,
 	struct shdma_chan *schan = to_shdma_chan(chan);
 	enum dma_status status;
 	unsigned long flags;
+	u32 residue = 0;
 
 	shdma_chan_ld_cleanup(schan, false);
 
@@ -842,12 +843,15 @@ static enum dma_status shdma_tx_status(struct dma_chan *chan,
 		list_for_each_entry(sdesc, &schan->ld_queue, node)
 			if (sdesc->cookie = cookie) {
 				status = DMA_IN_PROGRESS;
+				residue = sdesc->residue;
 				break;
 			}
 	}
 
 	spin_unlock_irqrestore(&schan->chan_lock, flags);
 
+	dma_set_residue(txstate, residue);
+
 	return status;
 }
 
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 11707df1a6894497..c9489ae6c0fa7f47 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -416,15 +416,12 @@ static bool sh_dmae_chan_irq(struct shdma_chan *schan, int irq)
 	return true;
 }
 
-static size_t sh_dmae_get_partial(struct shdma_chan *schan,
-				  struct shdma_desc *sdesc)
+static u32 sh_dmae_get_residue(struct shdma_chan *schan,
+			       struct shdma_desc *sdesc)
 {
 	struct sh_dmae_chan *sh_chan = container_of(schan, struct sh_dmae_chan,
 						    shdma_chan);
-	struct sh_dmae_desc *sh_desc = container_of(sdesc,
-					struct sh_dmae_desc, shdma_desc);
-	return sh_desc->hw.tcr -
-		(sh_dmae_readl(sh_chan, TCR) << sh_chan->xmit_shift);
+	return sh_dmae_readl(sh_chan, TCR) << sh_chan->xmit_shift;
 }
 
 /* Called from error IRQ or NMI */
@@ -671,7 +668,7 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 	.start_xfer = sh_dmae_start_xfer,
 	.embedded_desc = sh_dmae_embedded_desc,
 	.chan_irq = sh_dmae_chan_irq,
-	.get_partial = sh_dmae_get_partial,
+	.get_residue = sh_dmae_get_residue,
 };
 
 static const struct of_device_id sh_dmae_of_match[] = {
@@ -751,7 +748,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 	dma_dev->src_addr_widths = widths;
 	dma_dev->dst_addr_widths = widths;
 	dma_dev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
-	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
 	if (!pdata->slave_only)
 		dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
index 6da2eaa6c294e601..31e681230e1894f2 100644
--- a/drivers/dma/sh/sudmac.c
+++ b/drivers/dma/sh/sudmac.c
@@ -215,14 +215,13 @@ static bool sudmac_chan_irq(struct shdma_chan *schan, int irq)
 	return true;
 }
 
-static size_t sudmac_get_partial(struct shdma_chan *schan,
-				 struct shdma_desc *sdesc)
+static u32 sudmac_get_residue(struct shdma_chan *schan,
+			      struct shdma_desc *sdesc)
 {
 	struct sudmac_chan *sc = to_chan(schan);
-	struct sudmac_desc *sd = to_desc(sdesc);
 	u32 current_byte_count = sudmac_readl(sc, SUDMAC_CH0CBC + sc->offset);
 
-	return sd->hw.base_byte_count - current_byte_count;
+	return current_byte_count;
 }
 
 static bool sudmac_desc_completed(struct shdma_chan *schan,
@@ -327,7 +326,7 @@ static const struct shdma_ops sudmac_shdma_ops = {
 	.start_xfer = sudmac_start_xfer,
 	.embedded_desc = sudmac_embedded_desc,
 	.chan_irq = sudmac_chan_irq,
-	.get_partial = sudmac_get_partial,
+	.get_residue = sudmac_get_residue,
 };
 
 static int sudmac_probe(struct platform_device *pdev)
@@ -362,6 +361,7 @@ static int sudmac_probe(struct platform_device *pdev)
 		return PTR_ERR(su_dev->chan_reg);
 
 	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
 	su_dev->shdma_dev.ops = &sudmac_shdma_ops;
 	su_dev->shdma_dev.desc_size = sizeof(struct sudmac_desc);
diff --git a/include/linux/shdma-base.h b/include/linux/shdma-base.h
index d927647e6350324f..e0553a9761893869 100644
--- a/include/linux/shdma-base.h
+++ b/include/linux/shdma-base.h
@@ -50,7 +50,7 @@ struct shdma_desc {
 	struct list_head node;
 	struct dma_async_tx_descriptor async_tx;
 	enum dma_transfer_direction direction;
-	size_t partial;
+	u32 residue;
 	dma_cookie_t cookie;
 	int chunks;
 	int mark;
@@ -103,7 +103,7 @@ struct shdma_ops {
 	void (*start_xfer)(struct shdma_chan *, struct shdma_desc *);
 	struct shdma_desc *(*embedded_desc)(void *, int);
 	bool (*chan_irq)(struct shdma_chan *, int);
-	size_t (*get_partial)(struct shdma_chan *, struct shdma_desc *);
+	u32 (*get_residue)(struct shdma_chan *, struct shdma_desc *);
 };
 
 struct shdma_dev {
-- 
1.9.1

