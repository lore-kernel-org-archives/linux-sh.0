From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 10 Nov 2014 11:02:46 +0000
Subject: [PATCH 3/4] usb: renesas_usbhs: add a new macro for extending DnFIFOs
Message-Id: <1415617367-3828-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To extend DnFIFOs in the future, this patch adds a new macro because
some SoCs don't the "port" address for DnFIFOs.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 6c775b7..bc9a050 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -1201,11 +1201,11 @@ void usbhs_fifo_quit(struct usbhs_priv *priv)
 	mod->irq_brdysts	= 0;
 }
 
-#define USBHS_DFIFO_INIT(priv, fifo, channel)				\
+#define __USBHS_DFIFO_INIT(priv, fifo, channel, fifo_port)		\
 do {									\
 	fifo = usbhsf_get_dnfifo(priv, channel);			\
 	fifo->name	= "D"#channel"FIFO";				\
-	fifo->port	= D##channel##FIFO;				\
+	fifo->port	= fifo_port;					\
 	fifo->sel	= D##channel##FIFOSEL;				\
 	fifo->ctr	= D##channel##FIFOCTR;				\
 	fifo->tx_slave.shdma_slave.slave_id =				\
@@ -1215,6 +1215,11 @@ do {									\
 	usbhsf_dma_init(priv, fifo);					\
 } while (0)
 
+#define USBHS_DFIFO_INIT(priv, fifo, channel)				\
+		__USBHS_DFIFO_INIT(priv, fifo, channel, D##channel##FIFO)
+#define USBHS_DFIFO_INIT_NO_PORT(priv, fifo, channel)			\
+		__USBHS_DFIFO_INIT(priv, fifo, channel, 0)
+
 int usbhs_fifo_probe(struct usbhs_priv *priv)
 {
 	struct usbhs_fifo *fifo;
-- 
1.7.9.5

