From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 31 Oct 2014 01:24:23 +0000
Subject: [PATCH v4 3/4] usb: renesas_usbhs: fix the timing of dcp_control_transfer_done
Message-Id: <1414718664-4568-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

According to the datasheet, this driver should clear the INTSTS0.CTRT
bit before this controller detects the next stage transition. Otherwise,
the driver may not be able to clear the bit after the controller went to
the next stage transition. After that, the driver will not be able to
clear the INTSTS0.VALID, and a usb control transfer will not finish
finally.

If we use the testusb tool, it is easy to reproduce this issue:

 # testusb -a -t 10

Since the previous code handled a data stage and a status stage in
the usbhsf_pio_try_push(), it may not clear the INTSTS0.CTRT at the
right timing.
So, this patch change the timing of usbhs_dcp_control_transfer_done()
to the usbhsg_irq_ctrl_stage().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c       |   16 ----------------
 drivers/usb/renesas_usbhs/mod_gadget.c |    3 +++
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index b0c97a3..0e07925 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -577,14 +577,6 @@ static int usbhsf_pio_try_push(struct usbhs_pkt *pkt, int *is_done)
 		usbhs_pipe_number(pipe),
 		pkt->length, pkt->actual, *is_done, pkt->zero);
 
-	/*
-	 * Transmission end
-	 */
-	if (*is_done) {
-		if (usbhs_pipe_is_dcp(pipe))
-			usbhs_dcp_control_transfer_done(pipe);
-	}
-
 	usbhsf_fifo_unselect(pipe, fifo);
 
 	return 0;
@@ -722,14 +714,6 @@ usbhs_fifo_read_end:
 		usbhs_pipe_number(pipe),
 		pkt->length, pkt->actual, *is_done, pkt->zero);
 
-	/*
-	 * Transmission end
-	 */
-	if (*is_done) {
-		if (usbhs_pipe_is_dcp(pipe))
-			usbhs_dcp_control_transfer_done(pipe);
-	}
-
 usbhs_fifo_read_busy:
 	usbhsf_fifo_unselect(pipe, fifo);
 
diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index b27b2bc..9cf07c0 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -485,6 +485,9 @@ static int usbhsg_irq_ctrl_stage(struct usbhs_priv *priv,
 	case NODATA_STATUS_STAGE:
 		pipe->handler = &usbhs_ctrl_stage_end_handler;
 		break;
+	case READ_STATUS_STAGE:
+	case WRITE_STATUS_STAGE:
+		usbhs_dcp_control_transfer_done(pipe);
 	default:
 		return ret;
 	}
-- 
1.7.9.5

