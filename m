From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 13 Dec 2018 18:44:44 +0000
Subject: [PATCH v4 4/4] serial: sh-sci: Fix fallback to PIO in sci_dma_rx_complete()
Message-Id: <20181213184444.21904-5-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213184444.21904-1-geert+renesas@glider.be>
In-Reply-To: <20181213184444.21904-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

When submitting a DMA request fails in sci_dma_rx_complete(), the driver
tries to fall back to PIO, but that does not work: no more data will be
received, or the kernel will even crash.

Fix this similar as in (but not identical to) sci_submit_rx():
  - On SCIF, PIO cannot take over if any DMA transactions are pending,
    hence they must be terminated first.
  - All active cookies must be invalidated, else rx_timer_fn() may
    trigger a NULL pointer dereference.
  - Restarting the port is not needed, as it is already running, but
    serial port interrupts must be directed back from the DMA engine to
    the CPU.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - No changes,

v3:
  - Add missing definition of "u16 scr",
  - Move call to dmaengine_terminate_async() inside the spinlock, for
    symmetry with sci_submit_rx(),
  - Split in multiple patches.
---
 drivers/tty/serial/sh-sci.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8df0fd8245203f8b..44c29ce3fcc5d894 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1272,6 +1272,8 @@ static void sci_dma_rx_complete(void *arg)
 	struct dma_async_tx_descriptor *desc;
 	unsigned long flags;
 	int active, count = 0;
+	unsigned int i;
+	u16 scr;
 
 	dev_dbg(port->dev, "%s(%d) active cookie %d\n", __func__, port->line,
 		s->active_rx);
@@ -1313,8 +1315,18 @@ static void sci_dma_rx_complete(void *arg)
 	dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
 	/* Switch to PIO */
 	spin_lock_irqsave(&port->lock, flags);
+	dmaengine_terminate_async(chan);
+	for (i = 0; i < 2; i++)
+		s->cookie_rx[i] = -EINVAL;
+	s->active_rx = 0;
 	s->chan_rx = NULL;
-	sci_start_rx(port);
+	/* Direct new serial port interrupts back to CPU */
+	scr = serial_port_in(port, SCSCR);
+	if (port->type = PORT_SCIFA || port->type = PORT_SCIFB) {
+		scr &= ~SCSCR_RDRQE;
+		enable_irq(s->irqs[SCIx_RXI_IRQ]);
+	}
+	serial_port_out(port, SCSCR, scr | SCSCR_RIE);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-- 
2.17.1
