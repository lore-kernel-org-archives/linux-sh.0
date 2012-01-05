From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 05 Jan 2012 06:37:22 +0000
Subject: [PATCH v2 2/2] usb: renesas_usbhs: add support for SUDMAC
Message-Id: <4F054522.7000806@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SUDMAC uses 8-bit width only. So, when the driver uses SUDMAC,
we have to clear the MBW_32.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v2:
  - No change

 drivers/usb/renesas_usbhs/fifo.c  |    6 +++++-
 include/linux/usb/renesas_usbhs.h |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index ffdf5d1..918a1da 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -23,6 +23,7 @@
 #define usbhsf_get_cfifo(p)	(&((p)->fifo_info.cfifo))
 #define usbhsf_get_d0fifo(p)	(&((p)->fifo_info.d0fifo))
 #define usbhsf_get_d1fifo(p)	(&((p)->fifo_info.d1fifo))
+#define usbhsf_is_cfifo(p, f)	(usbhsf_get_cfifo(p) = f)

 #define usbhsf_fifo_is_busy(f)	((f)->pipe) /* see usbhs_pipe_select_fifo */

@@ -304,7 +305,10 @@ static int usbhsf_fifo_select(struct usbhs_pipe *pipe,
 	}

 	/* "base" will be used below  */
-	usbhs_write(priv, fifo->sel, base | MBW_32);
+	if (usbhs_get_dparam(priv, has_sudmac) && !usbhsf_is_cfifo(priv, fifo))
+		usbhs_write(priv, fifo->sel, base);
+	else
+		usbhs_write(priv, fifo->sel, base | MBW_32);

 	/* check ISEL and CURPIPE value */
 	while (timeout--) {
diff --git a/include/linux/usb/renesas_usbhs.h b/include/linux/usb/renesas_usbhs.h
index e5a40c3..f60db75 100644
--- a/include/linux/usb/renesas_usbhs.h
+++ b/include/linux/usb/renesas_usbhs.h
@@ -141,6 +141,7 @@ struct renesas_usbhs_driver_param {
 	 * option:
 	 */
 	u32 has_otg:1; /* for controlling PWEN/EXTLP */
+	u32 has_sudmac:1; /* for SUDMAC */
 };

 /*
-- 
1.7.1
