From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 06 Jul 2018 09:05:42 +0000
Subject: [PATCH v2 2/3] serial: sh-sci: Stop TX DMA workqueue during port shutdown
Message-Id: <20180706090543.31625-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180706090543.31625-1-geert+renesas@glider.be>
In-Reply-To: <20180706090543.31625-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The transmit DMA workqueue is never stopped, hence the work function may
be called after the port has been shut down.

Fix this race condition by cancelling queued work, if any, before DMA
release.  Don't initialize the work if DMA initialization failed, as it
won't be used anyway.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 674dc65454ae0684..939749073e7bdb11 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1293,6 +1293,7 @@ static void sci_tx_dma_release(struct sci_port *s)
 {
 	struct dma_chan *chan = s->chan_tx_saved;
 
+	cancel_work_sync(&s->work_tx);
 	s->chan_tx_saved = s->chan_tx = NULL;
 	s->cookie_tx = -EINVAL;
 	dmaengine_terminate_all(chan);
@@ -1548,10 +1549,9 @@ static void sci_request_dma(struct uart_port *port)
 				__func__, UART_XMIT_SIZE,
 				port->state->xmit.buf, &s->tx_dma_addr);
 
+			INIT_WORK(&s->work_tx, work_fn_tx);
 			s->chan_tx_saved = s->chan_tx = chan;
 		}
-
-		INIT_WORK(&s->work_tx, work_fn_tx);
 	}
 
 	chan = sci_request_dma_chan(port, DMA_DEV_TO_MEM);
-- 
2.17.1

