From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Jul 2015 18:36:49 +0000
Subject: Issues with rcar-dmac and sh-sci
Message-Id: <alpine.DEB.2.10.1507162026200.821@ayla.of.borg>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Laurent,

While working on DMA for R-Car Gen2 using the sh-sci serial driver with
rcar-dmac, I ran into two issues:
  1. Unlike the old shdmac DMA engine driver, the new rcar-dmac DMA
     engine driver does not support resubmitting a DMA descriptor.
     I first tried the patch below, until I ran into the race condition,
     after which I changed sh-sci to not reuse DMA descriptors.

  2. rcar_dmac_chan_get_residue() has:

static unsigned int rcar_dmac_chan_get_residue(struct rcar_dmac_chan *chan,
                                               dma_cookie_t cookie)
{
        struct rcar_dmac_desc *desc = chan->desc.running;
        ...

        /*
         * If the cookie doesn't correspond to the currently running transfer
         * then the descriptor hasn't been processed yet, and the residue is
         * equal to the full descriptor size.
         */
        if (cookie != desc->async_tx.cookie)
                return desc->size;

     If the cookie doesn't correspond to the currently running transfer,
     it returns the full descriptor size of the _currently running
     transfer_, not the transfer the cookie corresponds to.

     I believe this the reason why the sh-sci driver once thought DMA
     transfered 4294967265 (= -31) bytes (for SCIF, descriptor lengths
     are either 1 or 32 bytes, and (length) 1 - (residue) 32      (transfered) -31).

Thanks for your comments!

From 589dbd908a59dba6efc2a78fca24645962235ec2 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 14 Jul 2015 11:27:14 +0200
Subject: [PATCH] [RFC] dmaengine: rcar-dmac: Allow resubmission of DMA
 descriptors

Unlike the old shdmac DMA engine driver, the new rcar-dmac DMA engine
driver does not support resubmitting a DMA descriptor.  If a DMA slave
resubmits a descriptor, the descriptor will be added to the "pending
list", while it wasn't removed from the "wait" list. This will cause
list corruption, leading to an infinite loop in
rcar_dmac_chan_reinit().

Find out if the descriptor is reused by looking at the current cookie
valie, and remove it from the other list if needed:
  - cookie is initialized to -EBUSY (by rcar-dma) for fresh and properly
    recycled descriptors,
  - cookie is set to a strict-positive value by dma_cookie_assign() (in
    core dmaengine code) on submission,
  - cookie is reset to zero by dma_cookie_complete() (in core dmaengine
    code) on completion,

Fix this by removing it from a list if the cookie is not -EBUSY.

FIXME Unfortunately this is racy: the recycled descriptors are not part
      of a list while the DMA descriptor callback is running.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/sh/rcar-dmac.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 11e5003a6cc27b40..92a8fddb025e6729 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -437,8 +437,20 @@ static dma_cookie_t rcar_dmac_tx_submit(struct dma_async_tx_descriptor *tx)
 	unsigned long flags;
 	dma_cookie_t cookie;
 
+
 	spin_lock_irqsave(&chan->lock, flags);
 
+	if (desc->async_tx.cookie != -EBUSY) {
+		/*
+		 * If the descriptor is reused, it's currently part of a list.
+		 * Hence it must be removed from that list first, before it can
+		 * be added to the list of pending requests.
+		 */
+		dev_dbg(chan->chan.device->dev, "chan%u: resubmit active desc %p\n",
+			chan->index, desc);
+		list_del(&desc->node);
+	}
+
 	cookie = dma_cookie_assign(tx);
 
 	dev_dbg(chan->chan.device->dev, "chan%u: submit #%d@%p\n",
-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
