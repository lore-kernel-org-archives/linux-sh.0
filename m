From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Dec 2015 11:26:03 +0000
Subject: [PATCH] usb: renesas_usbhs: gadget: fix giveback status code in usbhsg_pipe_disable()
Message-Id: <1451042763-4648-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A udc driver should set the giveback status to -ESHUTDOWN in
usb_ep_disable(). Otherwise, a gadget driver (e.g. g_serial) might
request next data wrongly and it is possible to cause kernel panic.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on Felipe's usb.git / testing/fixes branch.
 (commit id = 5072cfc40a80cea3749fd3413b3896630d8c787e)

 drivers/usb/renesas_usbhs/mod_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index 657f967..664b263 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -561,7 +561,7 @@ static int usbhsg_pipe_disable(struct usbhsg_uep *uep)
 		if (!pkt)
 			break;
 
-		usbhsg_queue_pop(uep, usbhsg_pkt_to_ureq(pkt), -ECONNRESET);
+		usbhsg_queue_pop(uep, usbhsg_pkt_to_ureq(pkt), -ESHUTDOWN);
 	}
 
 	usbhs_pipe_disable(pipe);
-- 
1.9.1

