From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 26 May 2015 11:13:43 +0000
Subject: [PATCH 2/2] usb: renesas_usbhs: Don't disable the pipe if Control write status stage
Message-Id: <1432638823-3028-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes an issue that sometimes this controller is not able
to complete the Control write status stage.

This driver should enable DCPCTR.CCPL and PID_BUF to complete the status
stage. However, if this driver detects the ctrl_stage interruption first
before the control write data is received, this driver will clear the
PID_BUF wrongly in the usbhsf_pio_try_pop(). To avoid this issue, this
patch doesn't clear the PID_BUF in the usbhsf_pio_try_pop().
(Since also the privious code doesn't disable the PID_BUF after a control
 transfer was finished, this patch doesn't have any side efforts.)

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 0bad84e..c0f5c65 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -678,7 +678,14 @@ static int usbhsf_pio_try_pop(struct usbhs_pkt *pkt, int *is_done)
 		*is_done = 1;
 		usbhsf_rx_irq_ctrl(pipe, 0);
 		usbhs_pipe_running(pipe, 0);
-		usbhs_pipe_disable(pipe);	/* disable pipe first */
+		/*
+		 * If function mode, since this controller is possible to enter
+		 * Control Write status stage at this timing, this driver
+		 * should not disable the pipe. If such a case happens, this
+		 * controller is not able to complete the status stage.
+		 */
+		if (!usbhs_mod_is_host(priv) && !usbhs_pipe_is_dcp(pipe))
+			usbhs_pipe_disable(pipe);	/* disable pipe first */
 	}
 
 	/*
-- 
1.9.1

