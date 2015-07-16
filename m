From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:35 +0000
Subject: [PATCH/RFC v2 04/29] serial: sh-sci: Use correct device for DMA mapping with IOMMU
Message-Id: <1437070920-28069-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To function correctly in the presence of an IOMMU, the DMA buffers must
be managed using the DMA channel's device instead of the platform
device's device.

Make sure to free the DMA memory before releasing the channel, and avoid
freeing it twice (when DMA initialization succeeded before, but failed
partially on next open).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Acked-by.
---
 drivers/tty/serial/sh-sci.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index dc8d1b6a82684c17..6431b1fb9c162e77 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1372,10 +1372,13 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 
 	s->chan_rx = NULL;
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
+	if (sg_dma_address(&s->sg_rx[0])) {
+		dma_free_coherent(chan->device->dev, s->buf_len_rx * 2,
+				  sg_virt(&s->sg_rx[0]),
+				  sg_dma_address(&s->sg_rx[0]));
+		sg_dma_address(&s->sg_rx[0]) = 0;
+	}
 	dma_release_channel(chan);
-	if (sg_dma_address(&s->sg_rx[0]))
-		dma_free_coherent(port->dev, s->buf_len_rx * 2,
-				  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
 	if (enable_pio)
 		sci_start_rx(port);
 }
@@ -1706,7 +1709,8 @@ static void sci_request_dma(struct uart_port *port)
 		sg_set_page(&s->sg_tx, virt_to_page(port->state->xmit.buf),
 			    UART_XMIT_SIZE,
 			    (uintptr_t)port->state->xmit.buf & ~PAGE_MASK);
-		nent = dma_map_sg(port->dev, &s->sg_tx, 1, DMA_TO_DEVICE);
+		nent = dma_map_sg(chan->device->dev, &s->sg_tx, 1,
+				  DMA_TO_DEVICE);
 		if (!nent)
 			sci_tx_dma_release(s, false);
 		else
@@ -1735,8 +1739,9 @@ static void sci_request_dma(struct uart_port *port)
 		s->chan_rx = chan;
 
 		s->buf_len_rx = 2 * max(16, (int)port->fifosize);
-		buf[0] = dma_alloc_coherent(port->dev, s->buf_len_rx * 2,
-					    &dma[0], GFP_KERNEL);
+		buf[0] = dma_alloc_coherent(chan->device->dev,
+					    s->buf_len_rx * 2, &dma[0],
+					    GFP_KERNEL);
 
 		if (!buf[0]) {
 			dev_warn(port->dev,
-- 
1.9.1

