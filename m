From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 14 Feb 2012 10:37:21 +0000
Subject: [PATCH 2/2 v3] usb: fix renesas_usbhs to not schedule in atomic context
Message-Id: <Pine.LNX.4.64.1202141134580.443@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The current renesas_usbhs driver triggers

BUG: scheduling while atomic: ksoftirqd/0/3/0x00000102

with enabled CONFIG_DEBUG_ATOMIC_SLEEP, by submitting DMA transfers from
an atomic (tasklet) context, which is not supported by the shdma dmaengine
driver. Fix it by switching to a work.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: remove unrelated code, thanks to Felipe for reporting

 drivers/usb/renesas_usbhs/fifo.c |   18 ++++++------------
 drivers/usb/renesas_usbhs/fifo.h |    3 ++-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 5d543e3..c0d2a5b 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -761,9 +761,9 @@ static int __usbhsf_dma_map_ctrl(struct usbhs_pkt *pkt, int map)
 }
 
 static void usbhsf_dma_complete(void *arg);
-static void usbhsf_dma_prepare_tasklet(unsigned long data)
+static void xfer_work(struct work_struct *work)
 {
-	struct usbhs_pkt *pkt = (struct usbhs_pkt *)data;
+	struct usbhs_pkt *pkt = container_of(work, struct usbhs_pkt, work);
 	struct usbhs_pipe *pipe = pkt->pipe;
 	struct usbhs_fifo *fifo = usbhs_pipe_to_fifo(pipe);
 	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
@@ -843,11 +843,8 @@ static int usbhsf_dma_prepare_push(struct usbhs_pkt *pkt, int *is_done)
 
 	pkt->trans = len;
 
-	tasklet_init(&fifo->tasklet,
-		     usbhsf_dma_prepare_tasklet,
-		     (unsigned long)pkt);
-
-	tasklet_schedule(&fifo->tasklet);
+	INIT_WORK(&pkt->work, xfer_work);
+	schedule_work(&pkt->work);
 
 	return 0;
 
@@ -937,11 +934,8 @@ static int usbhsf_dma_try_pop(struct usbhs_pkt *pkt, int *is_done)
 
 	pkt->trans = len;
 
-	tasklet_init(&fifo->tasklet,
-		     usbhsf_dma_prepare_tasklet,
-		     (unsigned long)pkt);
-
-	tasklet_schedule(&fifo->tasklet);
+	INIT_WORK(&pkt->work, xfer_work);
+	schedule_work(&pkt->work);
 
 	return 0;
 
diff --git a/drivers/usb/renesas_usbhs/fifo.h b/drivers/usb/renesas_usbhs/fifo.h
index f68609c..c31731a 100644
--- a/drivers/usb/renesas_usbhs/fifo.h
+++ b/drivers/usb/renesas_usbhs/fifo.h
@@ -19,6 +19,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/sh_dma.h>
+#include <linux/workqueue.h>
 #include <asm/dma.h>
 #include "pipe.h"
 
@@ -31,7 +32,6 @@ struct usbhs_fifo {
 	u32 ctr;	/* xFIFOCTR */
 
 	struct usbhs_pipe	*pipe;
-	struct tasklet_struct	tasklet;
 
 	struct dma_chan		*tx_chan;
 	struct dma_chan		*rx_chan;
@@ -53,6 +53,7 @@ struct usbhs_pkt {
 	struct usbhs_pkt_handle *handler;
 	void (*done)(struct usbhs_priv *priv,
 		     struct usbhs_pkt *pkt);
+	struct work_struct work;
 	dma_addr_t dma;
 	void *buf;
 	int length;
-- 
1.7.2.5

