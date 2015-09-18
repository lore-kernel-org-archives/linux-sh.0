From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 18 Sep 2015 11:08:30 +0000
Subject: [PATCH v4 07/10] serial: sh-sci: Call dma_async_issue_pending when transaction completes
Message-Id: <1442574513-20648-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1442574513-20648-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Muhammad Hamza Farooq <mfarooq@visteon.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>, Koji Matsuoka <koji.matsuoka.xm@renesas.com>, Wolfram Sang <wsa@the-dreams.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

dmaengine_submit() will not start the DMA operation, it merely adds
it to the pending queue.  If the queue is no longer running, it won't be
restarted until dma_async_issue_pending() is called.

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
[geert: Add more description]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - New.
---
 drivers/tty/serial/sh-sci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 5dcd8b382e9053f4..84c15152e111b084 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1104,6 +1104,7 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 static void sci_dma_rx_complete(void *arg)
 {
 	struct sci_port *s = arg;
+	struct dma_chan *chan = s->chan_rx;
 	struct uart_port *port = &s->port;
 	struct dma_async_tx_descriptor *desc;
 	unsigned long flags;
@@ -1137,6 +1138,8 @@ static void sci_dma_rx_complete(void *arg)
 
 	s->active_rx = s->cookie_rx[!active];
 
+	dma_async_issue_pending(chan);
+
 	dev_dbg(port->dev, "%s: cookie %d #%d, new active cookie %d\n",
 		__func__, s->cookie_rx[active], active, s->active_rx);
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
1.9.1

