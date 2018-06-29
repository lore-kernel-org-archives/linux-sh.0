From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 Jun 2018 14:25:12 +0000
Subject: [PATCH 3/4] serial: sh-sci: Stop TX DMA workqueue during port shutdown
Message-Id: <20180629142513.20743-7-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20180629142513.20743-1-geert+renesas@glider.be>
In-Reply-To: <20180629142513.20743-1-geert+renesas@glider.be>
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
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 061660ccf9442d02..58016386558c6789 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1704,6 +1704,7 @@ static void sci_tx_dma_release(struct sci_port *s)
 	struct dma_chan *chan = s->chan_tx_saved;
 	struct uart_port *port = &s->port;
 
+	cancel_work_sync(&s->work_tx);
 dev_dbg_dma(port->dev, "%s\n", __func__);
 	s->chan_tx_saved = s->chan_tx = NULL;
 	s->cookie_tx = -EINVAL;
@@ -1978,10 +1979,9 @@ static void sci_request_dma(struct uart_port *port)
 				UART_XMIT_SIZE,
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

