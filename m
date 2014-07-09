From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 09 Jul 2014 11:30:03 +0000
Subject: [PATCH 1/2] usb: renesas_usbhs: fix usbhs_pipe_malloc() to re-enable a pipe.
Message-Id: <53BD27BB.5050606@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes an issue that the driver cannot push a new data when
a pipe is re-enabled after the pipe is queued.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/pipe.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/renesas_usbhs/pipe.c b/drivers/usb/renesas_usbhs/pipe.c
index 7926e1c..239b889 100644
--- a/drivers/usb/renesas_usbhs/pipe.c
+++ b/drivers/usb/renesas_usbhs/pipe.c
@@ -710,6 +710,7 @@ struct usbhs_pipe *usbhs_pipe_malloc(struct usbhs_priv *priv,
 	usbhsp_pipe_select(pipe);
 	usbhsp_pipe_cfg_set(pipe, 0xFFFF, pipecfg);
 	usbhsp_pipe_buf_set(pipe, 0xFFFF, pipebuf);
+	usbhs_pipe_clear(pipe);

 	usbhs_pipe_sequence_data0(pipe);

-- 
1.7.9.5

