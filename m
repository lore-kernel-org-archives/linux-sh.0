From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 21 Jun 2011 06:09:19 +0000
Subject: [PATCH] usb: renesas_usbhs: use dma handler
Message-Id: <w3psjr3yauo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/usb/renesas_usbhs/mod_gadget.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/mod_gadget.c b/drivers/usb/renesas_usbhs/mod_gadget.c
index ce35319..da76634 100644
--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -485,9 +485,9 @@ static int usbhsg_ep_enable(struct usb_ep *ep,
 		pipe->mod_private	= uep;
 
 		if (usb_endpoint_dir_in(desc))
-			uep->handler = &usbhs_fifo_pio_push_handler;
+			uep->handler = &usbhs_fifo_dma_push_handler;
 		else
-			uep->handler = &usbhs_fifo_pio_pop_handler;
+			uep->handler = &usbhs_fifo_dma_pop_handler;
 
 		ret = 0;
 	}
-- 
1.7.4.1

