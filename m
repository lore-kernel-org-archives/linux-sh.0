From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 10 Nov 2014 11:02:45 +0000
Subject: [PATCH 2/4] usb: renesas_usbhs: standardize d{0,1}fifo control
Message-Id: <1415617367-3828-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To expand DnFIFOs in the future, this patch standardizes the d{0,1}fifo
control using new macros.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c |   70 +++++++++++++++++---------------------
 drivers/usb/renesas_usbhs/fifo.h |    5 +++
 2 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 341508a..6c775b7 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -21,8 +21,6 @@
 #include "pipe.h"
 
 #define usbhsf_get_cfifo(p)	(&((p)->fifo_info.cfifo))
-#define usbhsf_get_d0fifo(p)	(&((p)->fifo_info.dfifo[0]))
-#define usbhsf_get_d1fifo(p)	(&((p)->fifo_info.dfifo[1]))
 #define usbhsf_is_cfifo(p, f)	(usbhsf_get_cfifo(p) = f)
 
 #define usbhsf_fifo_is_busy(f)	((f)->pipe) /* see usbhs_pipe_select_fifo */
@@ -761,18 +759,13 @@ static struct usbhs_fifo *usbhsf_get_dma_fifo(struct usbhs_priv *priv,
 					      struct usbhs_pkt *pkt)
 {
 	struct usbhs_fifo *fifo;
+	int i;
 
-	/* DMA :: D0FIFO */
-	fifo = usbhsf_get_d0fifo(priv);
-	if (usbhsf_dma_chan_get(fifo, pkt) &&
-	    !usbhsf_fifo_is_busy(fifo))
-		return fifo;
-
-	/* DMA :: D1FIFO */
-	fifo = usbhsf_get_d1fifo(priv);
-	if (usbhsf_dma_chan_get(fifo, pkt) &&
-	    !usbhsf_fifo_is_busy(fifo))
-		return fifo;
+	usbhs_for_each_dfifo(priv, fifo, i) {
+		if (usbhsf_dma_chan_get(fifo, pkt) &&
+		    !usbhsf_fifo_is_busy(fifo))
+			return fifo;
+	}
 
 	return NULL;
 }
@@ -1185,8 +1178,8 @@ void usbhs_fifo_init(struct usbhs_priv *priv)
 {
 	struct usbhs_mod *mod = usbhs_mod_get_current(priv);
 	struct usbhs_fifo *cfifo = usbhsf_get_cfifo(priv);
-	struct usbhs_fifo *d0fifo = usbhsf_get_d0fifo(priv);
-	struct usbhs_fifo *d1fifo = usbhsf_get_d1fifo(priv);
+	struct usbhs_fifo *dfifo;
+	int i;
 
 	mod->irq_empty		= usbhsf_irq_empty;
 	mod->irq_ready		= usbhsf_irq_ready;
@@ -1194,8 +1187,8 @@ void usbhs_fifo_init(struct usbhs_priv *priv)
 	mod->irq_brdysts	= 0;
 
 	cfifo->pipe	= NULL;
-	d0fifo->pipe	= NULL;
-	d1fifo->pipe	= NULL;
+	usbhs_for_each_dfifo(priv, dfifo, i)
+		dfifo->pipe	= NULL;
 }
 
 void usbhs_fifo_quit(struct usbhs_priv *priv)
@@ -1208,6 +1201,20 @@ void usbhs_fifo_quit(struct usbhs_priv *priv)
 	mod->irq_brdysts	= 0;
 }
 
+#define USBHS_DFIFO_INIT(priv, fifo, channel)				\
+do {									\
+	fifo = usbhsf_get_dnfifo(priv, channel);			\
+	fifo->name	= "D"#channel"FIFO";				\
+	fifo->port	= D##channel##FIFO;				\
+	fifo->sel	= D##channel##FIFOSEL;				\
+	fifo->ctr	= D##channel##FIFOCTR;				\
+	fifo->tx_slave.shdma_slave.slave_id =				\
+			usbhs_get_dparam(priv, d##channel##_tx_id);	\
+	fifo->rx_slave.shdma_slave.slave_id =				\
+			usbhs_get_dparam(priv, d##channel##_rx_id);	\
+	usbhsf_dma_init(priv, fifo);					\
+} while (0)
+
 int usbhs_fifo_probe(struct usbhs_priv *priv)
 {
 	struct usbhs_fifo *fifo;
@@ -1219,31 +1226,18 @@ int usbhs_fifo_probe(struct usbhs_priv *priv)
 	fifo->sel	= CFIFOSEL;
 	fifo->ctr	= CFIFOCTR;
 
-	/* D0FIFO */
-	fifo = usbhsf_get_d0fifo(priv);
-	fifo->name	= "D0FIFO";
-	fifo->port	= D0FIFO;
-	fifo->sel	= D0FIFOSEL;
-	fifo->ctr	= D0FIFOCTR;
-	fifo->tx_slave.shdma_slave.slave_id	= usbhs_get_dparam(priv, d0_tx_id);
-	fifo->rx_slave.shdma_slave.slave_id	= usbhs_get_dparam(priv, d0_rx_id);
-	usbhsf_dma_init(priv, fifo);
-
-	/* D1FIFO */
-	fifo = usbhsf_get_d1fifo(priv);
-	fifo->name	= "D1FIFO";
-	fifo->port	= D1FIFO;
-	fifo->sel	= D1FIFOSEL;
-	fifo->ctr	= D1FIFOCTR;
-	fifo->tx_slave.shdma_slave.slave_id	= usbhs_get_dparam(priv, d1_tx_id);
-	fifo->rx_slave.shdma_slave.slave_id	= usbhs_get_dparam(priv, d1_rx_id);
-	usbhsf_dma_init(priv, fifo);
+	/* DFIFO */
+	USBHS_DFIFO_INIT(priv, fifo, 0);
+	USBHS_DFIFO_INIT(priv, fifo, 1);
 
 	return 0;
 }
 
 void usbhs_fifo_remove(struct usbhs_priv *priv)
 {
-	usbhsf_dma_quit(priv, usbhsf_get_d0fifo(priv));
-	usbhsf_dma_quit(priv, usbhsf_get_d1fifo(priv));
+	struct usbhs_fifo *fifo;
+	int i;
+
+	usbhs_for_each_dfifo(priv, fifo, i)
+		usbhsf_dma_quit(priv, fifo);
 }
diff --git a/drivers/usb/renesas_usbhs/fifo.h b/drivers/usb/renesas_usbhs/fifo.h
index e1e51c6..899729a 100644
--- a/drivers/usb/renesas_usbhs/fifo.h
+++ b/drivers/usb/renesas_usbhs/fifo.h
@@ -43,6 +43,11 @@ struct usbhs_fifo_info {
 	struct usbhs_fifo cfifo;
 	struct usbhs_fifo dfifo[USBHS_MAX_NUM_DFIFO];
 };
+#define usbhsf_get_dnfifo(p, n)	(&((p)->fifo_info.dfifo[n]))
+#define usbhs_for_each_dfifo(priv, dfifo, i)				\
+	for ((i) = 0, dfifo = usbhsf_get_dnfifo(priv, (i));		\
+	     ((i) < USBHS_MAX_NUM_DFIFO);				\
+	     (i)++, dfifo = usbhsf_get_dnfifo(priv, (i)))
 
 struct usbhs_pkt_handle;
 struct usbhs_pkt {
-- 
1.7.9.5

