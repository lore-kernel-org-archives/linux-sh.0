From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 04 Feb 2010 06:57:58 +0000
Subject: [PATCH] usb: r8a66597-hdc: Flush the D-cache for the pipe-in transfer buffers.
Message-Id: <20100204065758.GA5574@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This implements the same D-cache flushing logic for r8a66597-hcd as
Catalin's isp1760 (http://patchwork.kernel.org/patch/76391/) change,
with the same note applying here as well:

    When the HDC driver writes the data to the transfer buffers it
    pollutes the D-cache (unlike DMA drivers where the device writes
    the data). If the corresponding pages get mapped into user space,
    there are no additional cache flushing operations performed and
    this causes random user space faults on architectures with
    separate I and D caches (Harvard) or those with aliasing D-cache.

This fixes up crashes during USB boot on SH7724 and others:

	http://marc.info/?l=linux-sh&m6439837308912&w=2

Reported-by: Goda Yusuke <goda.yusuke@renesas.com>
Tested-by: Goda Yusuke <goda.yusuke@renesas.com>
Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

Shimoda-san, once you Ack these I plan to send them off to Linus for 2.6.33.

 drivers/usb/host/r8a66597-hcd.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 0ceec12..bee558a 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -35,7 +35,9 @@
 #include <linux/usb.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <linux/irq.h>
+#include <asm/cacheflush.h>
 
 #include "../core/hcd.h"
 #include "r8a66597.h"
@@ -820,6 +822,26 @@ static void enable_r8a66597_pipe(struct r8a66597 *r8a66597, struct urb *urb,
 	enable_r8a66597_pipe_dma(r8a66597, dev, pipe, urb);
 }
 
+static void r8a66597_urb_done(struct r8a66597 *r8a66597, struct urb *urb,
+			      int status)
+__releases(r8a66597->lock)
+__acquires(r8a66597->lock)
+{
+	if (usb_pipein(urb->pipe) && usb_pipetype(urb->pipe) != PIPE_CONTROL) {
+		void *ptr;
+
+		for (ptr = urb->transfer_buffer;
+		     ptr < urb->transfer_buffer + urb->transfer_buffer_length;
+		     ptr += PAGE_SIZE)
+			flush_dcache_page(virt_to_page(ptr));
+	}
+
+	usb_hcd_unlink_urb_from_ep(r8a66597_to_hcd(r8a66597), urb);
+	spin_unlock(&r8a66597->lock);
+	usb_hcd_giveback_urb(r8a66597_to_hcd(r8a66597), urb, status);
+	spin_lock(&r8a66597->lock);
+}
+
 /* this function must be called with interrupt disabled */
 static void force_dequeue(struct r8a66597 *r8a66597, u16 pipenum, u16 address)
 {
@@ -838,15 +860,9 @@ static void force_dequeue(struct r8a66597 *r8a66597, u16 pipenum, u16 address)
 		list_del(&td->queue);
 		kfree(td);
 
-		if (urb) {
-			usb_hcd_unlink_urb_from_ep(r8a66597_to_hcd(r8a66597),
-					urb);
+		if (urb)
+			r8a66597_urb_done(r8a66597, urb, -ENODEV);
 
-			spin_unlock(&r8a66597->lock);
-			usb_hcd_giveback_urb(r8a66597_to_hcd(r8a66597), urb,
-					-ENODEV);
-			spin_lock(&r8a66597->lock);
-		}
 		break;
 	}
 }
@@ -1283,10 +1303,7 @@ __releases(r8a66597->lock) __acquires(r8a66597->lock)
 		if (usb_pipeisoc(urb->pipe))
 			urb->start_frame = r8a66597_get_frame(hcd);
 
-		usb_hcd_unlink_urb_from_ep(r8a66597_to_hcd(r8a66597), urb);
-		spin_unlock(&r8a66597->lock);
-		usb_hcd_giveback_urb(hcd, urb, status);
-		spin_lock(&r8a66597->lock);
+		r8a66597_urb_done(r8a66597, urb, status);
 	}
 
 	if (restart) {
