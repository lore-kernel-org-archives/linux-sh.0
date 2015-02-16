From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 16 Feb 2015 01:52:58 +0000
Subject: [PATCH v2 3/4] usb: renesas_usbhs: fix the sequence in xfer_work()
Message-Id: <1424051579-5060-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424051579-5060-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1424051579-5060-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>

This patch fixes the setup sequence in xfer_work(). Otherwise,
sometimes a usb transaction will get stuck.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/renesas_usbhs/fifo.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/renesas_usbhs/fifo.c b/drivers/usb/renesas_usbhs/fifo.c
index 28d10eb..b737661 100644
--- a/drivers/usb/renesas_usbhs/fifo.c
+++ b/drivers/usb/renesas_usbhs/fifo.c
@@ -822,10 +822,10 @@ static void xfer_work(struct work_struct *work)
 		fifo->name, usbhs_pipe_number(pipe), pkt->length, pkt->zero);
 
 	usbhs_pipe_running(pipe, 1);
-	usbhs_pipe_set_trans_count_if_bulk(pipe, pkt->trans);
-	usbhs_pipe_enable(pipe);
 	usbhsf_dma_start(pipe, fifo);
+	usbhs_pipe_set_trans_count_if_bulk(pipe, pkt->trans);
 	dma_async_issue_pending(chan);
+	usbhs_pipe_enable(pipe);
 }
 
 /*
-- 
1.7.9.5

