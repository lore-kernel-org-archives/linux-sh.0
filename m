From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 26 May 2015 11:13:42 +0000
Subject: [PATCH 1/2] usb: renesas_usbhs: Fix fifo unclear in usbhsf_prepare_pop
Message-Id: <1432638823-3028-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

This patch fixes an issue for control write. When usbhsf_prepare_pop()
is called after this driver called a gadget setup function, this controller
doesn't receive the control write data. So, this patch adds a code to clear
the fifo for control write in usbhsf_prepare_pop().

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index bc23b4a..0bad84e 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -611,6 +611,8 @@ struct usbhs_pkt_handle usbhs_fifo_pio_push_handler = {
 static int usbhsf_prepare_pop(struct usbhs_pkt *pkt, int *is_done)
 {
 	struct usbhs_pipe *pipe = pkt->pipe;
+	struct usbhs_priv *priv = usbhs_pipe_to_priv(pipe);
+	struct usbhs_fifo *fifo = usbhsf_get_cfifo(priv);
 
 	if (usbhs_pipe_is_busy(pipe))
 		return 0;
@@ -624,6 +626,9 @@ static int usbhsf_prepare_pop(struct usbhs_pkt *pkt, int *is_done)
 	usbhs_pipe_data_sequence(pipe, pkt->sequence);
 	pkt->sequence = -1; /* -1 sequence will be ignored */
 
+	if (usbhs_pipe_is_dcp(pipe))
+		usbhsf_fifo_clear(pipe, fifo);
+
 	usbhs_pipe_set_trans_count_if_bulk(pipe, pkt->length);
 	usbhs_pipe_enable(pipe);
 	usbhs_pipe_running(pipe, 1);
-- 
1.9.1

