From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 04:47:01 +0000
Subject: [PATCH 03/05] serial: sh-sci: Use sg_dma_len() and sg_dma_address()
Message-Id: <20100319044701.17051.77755.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert the dmaengine code in sh-sci.c from
directly accessing the struct scatterlist members
length, dma_length and dma_address to using the
macros sg_dma_len() and sg_dma_address().

Makes the code build for ARM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/serial/sh-sci.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

--- 0003/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2010-03-18 23:21:13.000000000 +0900
@@ -917,10 +917,10 @@ static void sci_dma_tx_complete(void *ar
 
 	spin_lock_irqsave(&port->lock, flags);
 
-	xmit->tail += s->sg_tx.length;
+	xmit->tail += sg_dma_len(&s->sg_tx);
 	xmit->tail &= UART_XMIT_SIZE - 1;
 
-	port->icount.tx += s->sg_tx.length;
+	port->icount.tx += sg_dma_len(&s->sg_tx);
 
 	async_tx_ack(s->desc_tx);
 	s->cookie_tx = -EINVAL;
@@ -1135,14 +1135,13 @@ static void work_fn_tx(struct work_struc
 	 */
 	spin_lock_irq(&port->lock);
 	sg->offset = xmit->tail & (UART_XMIT_SIZE - 1);
-	sg->dma_address = (sg_dma_address(sg) & ~(UART_XMIT_SIZE - 1)) +
+	sg_dma_address(sg) = (sg_dma_address(sg) & ~(UART_XMIT_SIZE - 1)) +
 		sg->offset;
-	sg->length = min((int)CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
+	sg_dma_len(sg) = min((int)CIRC_CNT(xmit->head, xmit->tail, UART_XMIT_SIZE),
 		CIRC_CNT_TO_END(xmit->head, xmit->tail, UART_XMIT_SIZE));
-	sg->dma_length = sg->length;
 	spin_unlock_irq(&port->lock);
 
-	BUG_ON(!sg->length);
+	BUG_ON(!sg_dma_len(sg));
 
 	desc = chan->device->device_prep_slave_sg(chan,
 			sg, s->sg_len_tx, DMA_TO_DEVICE,
@@ -1343,8 +1342,7 @@ static void sci_request_dma(struct uart_
 			sg_init_table(sg, 1);
 			sg_set_page(sg, virt_to_page(buf[i]), s->buf_len_rx,
 				    (int)buf[i] & ~PAGE_MASK);
-			sg->dma_address = dma[i];
-			sg->dma_length = sg->length;
+			sg_dma_address(sg) = dma[i];
 		}
 
 		INIT_WORK(&s->work_rx, work_fn_rx);
