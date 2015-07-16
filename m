From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:51 +0000
Subject: [PATCH/RFC v2 20/29] serial: sh-sci: Switch to generic DMA residue handling
Message-Id: <1437070920-28069-21-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Convert the SCI driver from the SHDMAE-specific partial DMA transfer
handling to the generic dmaengine residual data framework.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig  |  2 +-
 drivers/tty/serial/sh-sci.c | 16 +++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 76e65b714471d9ee..1cd229f9fd8ce485 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -743,7 +743,7 @@ config SERIAL_SH_SCI_CONSOLE
 
 config SERIAL_SH_SCI_DMA
 	bool "DMA support"
-	depends on SERIAL_SH_SCI && SH_DMAE
+	depends on SERIAL_SH_SCI && DMA_ENGINE
 
 config SERIAL_PNX8XXX
 	bool "Enable PNX8XXX SoCs' UART Support"
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index dec59c0075bbb4bf..204f1f6ad72f6236 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1447,6 +1447,8 @@ static void work_fn_rx(struct work_struct *work)
 	struct sci_port *s = container_of(work, struct sci_port, work_rx);
 	struct uart_port *port = &s->port;
 	struct dma_async_tx_descriptor *desc;
+	struct dma_tx_state state;
+	enum dma_status status;
 	int new;
 
 	if (s->active_rx = s->cookie_rx[0]) {
@@ -1460,21 +1462,21 @@ static void work_fn_rx(struct work_struct *work)
 	}
 	desc = s->desc_rx[new];
 
-	if (dma_async_is_tx_complete(s->chan_rx, s->active_rx, NULL, NULL) !-	    DMA_COMPLETE) {
+	status = dmaengine_tx_status(s->chan_rx, s->active_rx, &state);
+	if (status != DMA_COMPLETE) {
 		/* Handle incomplete DMA receive */
 		struct dma_chan *chan = s->chan_rx;
-		struct shdma_desc *sh_desc = container_of(desc,
-					struct shdma_desc, async_tx);
 		unsigned long flags;
+		unsigned int read;
 		int count;
 
 		dmaengine_terminate_all(chan);
-		dev_dbg(port->dev, "Read %zu bytes with cookie %d\n",
-			sh_desc->partial, sh_desc->cookie);
+		read = sg_dma_len(&s->sg_rx[new]) - state.residue;
+		dev_dbg(port->dev, "Read %zu bytes with cookie %d\n", read,
+			s->active_rx);
 
 		spin_lock_irqsave(&port->lock, flags);
-		count = sci_dma_rx_push(s, sh_desc->partial);
+		count = sci_dma_rx_push(s, read);
 		spin_unlock_irqrestore(&port->lock, flags);
 
 		if (count)
-- 
1.9.1

