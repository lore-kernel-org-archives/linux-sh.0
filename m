From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 10 Nov 2014 11:02:44 +0000
Subject: [PATCH 1/4] usb: renesas_usbhs: change d{0,1}fifo to dfifo array
Message-Id: <1415617367-3828-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To extend DnFIFOs in the future, this patch changes d{0,1}fifo of
usbhs_fifo_info to dfifo array.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c |    4 ++--
 drivers/usb/renesas_usbhs/fifo.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 9b48384..341508a 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -21,8 +21,8 @@
 #include "pipe.h"
 
 #define usbhsf_get_cfifo(p)	(&((p)->fifo_info.cfifo))
-#define usbhsf_get_d0fifo(p)	(&((p)->fifo_info.d0fifo))
-#define usbhsf_get_d1fifo(p)	(&((p)->fifo_info.d1fifo))
+#define usbhsf_get_d0fifo(p)	(&((p)->fifo_info.dfifo[0]))
+#define usbhsf_get_d1fifo(p)	(&((p)->fifo_info.dfifo[1]))
 #define usbhsf_is_cfifo(p, f)	(usbhsf_get_cfifo(p) = f)
 
 #define usbhsf_fifo_is_busy(f)	((f)->pipe) /* see usbhs_pipe_select_fifo */
diff --git a/drivers/usb/renesas_usbhs/fifo.h b/drivers/usb/renesas_usbhs/fifo.h
index 79ad5f9..e1e51c6 100644
--- a/drivers/usb/renesas_usbhs/fifo.h
+++ b/drivers/usb/renesas_usbhs/fifo.h
@@ -38,10 +38,10 @@ struct usbhs_fifo {
 	struct sh_dmae_slave	rx_slave;
 };
 
+#define USBHS_MAX_NUM_DFIFO	2
 struct usbhs_fifo_info {
 	struct usbhs_fifo cfifo;
-	struct usbhs_fifo d0fifo;
-	struct usbhs_fifo d1fifo;
+	struct usbhs_fifo dfifo[USBHS_MAX_NUM_DFIFO];
 };
 
 struct usbhs_pkt_handle;
-- 
1.7.9.5

