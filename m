From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 07 Jan 2019 16:23:19 +0000
Subject: [PATCH v5 3/4] serial: sh-sci: Fix fallback to PIO in sci_dma_rx_complete()
Message-Id: <20190107162320.15530-4-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20190107162320.15530-1-geert+renesas@glider.be>
In-Reply-To: <20190107162320.15530-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms@verge.net.au>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

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
v5:
  - Call new helpers sci_dma_rx_chan_invalidate() and
    sci_dma_rx_reenable_irq() instead of open-coding,

v4:
  - No changes,

v3:
  - Add missing definition of "u16 scr",
  - Move call to dmaengine_terminate_async() inside the spinlock, for
    symmetry with sci_submit_rx(),
  - Split in multiple patches.
---
 drivers/tty/serial/sh-sci.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4d814c30c4189b56..891833315698b953 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1337,8 +1337,9 @@ static void sci_dma_rx_complete(void *arg)
 	dev_warn(port->dev, "Failed submitting Rx DMA descriptor\n");
 	/* Switch to PIO */
 	spin_lock_irqsave(&port->lock, flags);
-	s->chan_rx = NULL;
-	sci_start_rx(port);
+	dmaengine_terminate_async(chan);
+	sci_dma_rx_chan_invalidate(s);
+	sci_dma_rx_reenable_irq(s);
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
-- 
2.17.1
