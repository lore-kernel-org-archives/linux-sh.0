From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Jun 2018 14:25:09 +0000
Subject: [PATCH 3/3] serial: sh-sci: Stop using deprecated dmaengine_terminate_all()
Message-Id: <20180629142513.20743-4-geert+renesas@glider.be>
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
 drivers/tty/serial/sh-sci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1e0b6fe6865dcff6..5c870ab80b98e25b 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1221,7 +1221,7 @@ static void sci_rx_dma_release(struct sci_port *s)
 
 	s->chan_rx_saved = s->chan_rx = NULL;
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
-	dmaengine_terminate_all(chan);
+	dmaengine_terminate_sync(chan);
 	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
 			  sg_dma_address(&s->sg_rx[0]));
 	dma_release_channel(chan);
@@ -1298,7 +1298,7 @@ static void sci_tx_dma_release(struct sci_port *s)
 	cancel_work_sync(&s->work_tx);
 	s->chan_tx_saved = s->chan_tx = NULL;
 	s->cookie_tx = -EINVAL;
-	dmaengine_terminate_all(chan);
+	dmaengine_terminate_sync(chan);
 	dma_unmap_single(chan->device->dev, s->tx_dma_addr, UART_XMIT_SIZE,
 			 DMA_TO_DEVICE);
 	dma_release_channel(chan);
@@ -1336,7 +1336,7 @@ static void sci_submit_rx(struct sci_port *s)
 
 fail:
 	if (i)
-		dmaengine_terminate_all(chan);
+		dmaengine_terminate_async(chan);
 	for (i = 0; i < 2; i++)
 		s->cookie_rx[i] = -EINVAL;
 	s->active_rx = -EINVAL;
@@ -1454,7 +1454,7 @@ static enum hrtimer_restart rx_timer_fn(struct hrtimer *t)
 	}
 
 	/* Handle incomplete DMA receive */
-	dmaengine_terminate_all(s->chan_rx);
+	dmaengine_terminate_async(s->chan_rx);
 	read = sg_dma_len(&s->sg_rx[active]) - state.residue;
 
 	if (read) {
-- 
2.17.1

