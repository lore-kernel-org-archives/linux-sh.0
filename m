From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Jun 2018 14:25:11 +0000
Subject: [PATCH 2/4] serial: sh-sci: Stop using deprecated dmaengine_terminate_all()
Message-Id: <20180629142513.20743-6-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180629142513.20743-1-geert+renesas@glider.be>
In-Reply-To: <20180629142513.20743-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

As of commit b36f09c3c441a6e5 ("dmaengine: Add transfer termination
synchronization support"), dmaengine_terminate_all() is deprecated.

Replace calls to dmaengine_terminate_all() in DMA release code by calls
to dmaengine_terminate_sync(), as the latter waits until all running
completion callbacks have finished.

Replace calls to dmaengine_terminate_all() in DMA failure paths by calls
to dmaengine_terminate_async(), as these are usually done in atomic
context.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 898c1034cad23a88..061660ccf9442d02 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1613,7 +1613,7 @@ dev_dbg_dma(port->dev, "%s\n", __func__);
 	s->chan_rx_saved = s->chan_rx = NULL;
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
 WARN(!chan, "RX DMA channel already released\n");
-	dmaengine_terminate_all(chan);
+	dmaengine_terminate_sync(chan);
 	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
 			  sg_dma_address(&s->sg_rx[0]));
 	dma_release_channel(chan);
@@ -1708,7 +1708,7 @@ dev_dbg_dma(port->dev, "%s\n", __func__);
 	s->chan_tx_saved = s->chan_tx = NULL;
 	s->cookie_tx = -EINVAL;
 WARN(!chan, "TX DMA channel already released\n");
-	dmaengine_terminate_all(chan);
+	dmaengine_terminate_sync(chan);
 	dma_unmap_single(chan->device->dev, s->tx_dma_addr, UART_XMIT_SIZE,
 			 DMA_TO_DEVICE);
 	dma_release_channel(chan);
@@ -1747,7 +1747,7 @@ dev_dbg_dma(s->port.dev, "  %s\n", __func__);
 
 fail:
 	if (i)
-		dmaengine_terminate_all(chan);
+		dmaengine_terminate_async(chan);
 	// FIXME Not needed?
 	for (i = 0; i < 2; i++)
 		s->cookie_rx[i] = -EINVAL;
@@ -1877,9 +1877,9 @@ dev_dbg_dma(port->dev, "  %s active %d\n", __func__, active);
 
 	/* Handle incomplete DMA receive */
 dev_dbg_dma(port->dev, "  %s:%u dmaengine_terminate_all()\n", __func__, __LINE__);
-	dmaengine_terminate_all(s->chan_rx);
+	dmaengine_terminate_async(s->chan_rx);
 	// FIXME More data may have been transfered in between
-	// FIXME dmaengine_tx_status() and dmaengine_terminate_all()
+	// FIXME dmaengine_tx_status() and dmaengine_terminate_async()
 	// FIXME Call dmaengine_pause() first
 dev_dbg_dma(port->dev, "  %s:%u terminated\n", __func__, __LINE__);
 	read = sg_dma_len(&s->sg_rx[active]) - state.residue;
-- 
2.17.1

