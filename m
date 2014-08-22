From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 22 Aug 2014 11:14:10 +0000
Subject: [PATCH 3/4] usb: renesas_usbhs: fix the condition of is_done in usbhsf_dma_push_done
Message-Id: <53F72602.3010704@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes the condition of is_done in usbhsf_dma_push_done().
This function will be called after a transmission finished by DMAC.
So, the function should check if the transmission packet is short packet
or not. Also the function should call try_run to send the zero packet
by the pio handler if the "*is_done" is not set. Otherwize, the
transaction will not finish if a gadget driver sets the "zero" flag
in a transmission.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 3efece3..1564829 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -889,16 +889,29 @@ usbhsf_pio_prepare_push:
 static int usbhsf_dma_push_done(struct usbhs_pkt *pkt, int *is_done)
 {
 	struct usbhs_pipe *pipe = pkt->pipe;
+	int is_short = pkt->trans % usbhs_pipe_get_maxpacket(pipe);

-	pkt->actual = pkt->trans;
+	pkt->actual += pkt->trans;
+
+	if (pkt->actual < pkt->length)
+		*is_done = 0;		/* there are remainder data */
+	else if (is_short)
+		*is_done = 1;		/* short packet */
+	else
+		*is_done = !pkt->zero;	/* send zero packet? */

-	*is_done = !pkt->zero;	/* send zero packet ? */
 	usbhs_pipe_running(pipe, !*is_done);

 	usbhsf_dma_stop(pipe, pipe->fifo);
 	usbhsf_dma_unmap(pkt);
 	usbhsf_fifo_unselect(pipe, pipe->fifo);

+	if (!*is_done) {
+		/* change handler to PIO */
+		pkt->handler = &usbhs_fifo_pio_push_handler;
+		return pkt->handler->try_run(pkt, is_done);
+	}
+
 	return 0;
 }

-- 
1.7.9.5

