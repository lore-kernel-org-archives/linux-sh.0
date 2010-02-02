From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 02 Feb 2010 07:00:32 +0000
Subject: Re: USB boot problems submission
Message-Id: <20100202070032.GA5716@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B5D3019.9080900@renesas.com>
In-Reply-To: <4B5D3019.9080900@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Goda-san, Shimoda-san,

On Tue, Jan 26, 2010 at 05:33:18PM +0900, Yusuke Goda wrote:
> > You should rebuild your kernel with verbose BUG reporting and all of the
> > kallsyms bits turned on, which will give you a meaningful oops. That
> I attach log(CONFIG_KALLSYMS=y).
> 
> > should at least give us an idea of where things are going wrong,
> > otherwise we go back to bisecting.
> This problem seems to occur with the following commit.
>  commit 2277ab4a1df50e05bc732fe9488d4e902bb8399a
>   sh: Migrate from PG_mapped to PG_dcache_dirty.
> 
I suspect the PG_mapped behaviour just ended up hiding the problem by
doing far too aggressive flushing. PG_dcache_dirty takes a more subdued
approach to lazy writeback, which only trips us up when someone has
called in to update_mmu_cache() without the pages having a chance to be
flagged as having dirty dcache lines.

USB mass storage appears to be one of these beasts, but there doesn't
seem to be any good way around this without just walking over the URB
transfer buffer and making sure that flush_dcache_page() gets called for
each page. Doing this in the HCD is unfortunate, but there doesn't seem
to be any better place for it. Likewise, it's really only mass storage
that really has this problem, so it ends up with superfluous flushing for
all of the other cases.

The attached patch fixes these issues up for me, along with a spinlock
recursion bug in the HCD driver (r8a66597_check_syssts() specifically),
tested with an SSD over USB running XFS on SE7724. This is based on a
patch by Catalin Marinas doing the same thing for isp1760-hcd.

Note that this only impacts HCDs using PIO. Any of the others (like
ohci-sm501) that are using the DMA mapping ops already have their cache
handling taken care of through the DMA mapping API.

If this works for you, I'll split the patch up in to the locking fix and
the cache handling fix and check them in once Shimoda-san Acks them.

---

 drivers/usb/host/r8a66597-hcd.c |   40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index 0ceec12..f54f5e2 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -36,6 +36,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <asm/cacheflush.h>
 
 #include "../core/hcd.h"
 #include "r8a66597.h"
@@ -820,6 +821,26 @@ static void enable_r8a66597_pipe(struct r8a66597 *r8a66597, struct urb *urb,
 	enable_r8a66597_pipe_dma(r8a66597, dev, pipe, urb);
 }
 
+static void r8a66597_urb_done(struct r8a66597 *r8a66597, struct urb *urb,
+			      int status)
+__releases(r8a66597->lock)
+__acquires(r8a66597->lock)
+{
+	if (usb_pipein(urb->pipe) && usb_pipetype(urb->pipe) = PIPE_BULK) {
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
@@ -838,15 +859,9 @@ static void force_dequeue(struct r8a66597 *r8a66597, u16 pipenum, u16 address)
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
@@ -1006,6 +1021,8 @@ static void start_root_hub_sampling(struct r8a66597 *r8a66597, int port,
 /* this function must be called with interrupt disabled */
 static void r8a66597_check_syssts(struct r8a66597 *r8a66597, int port,
 					u16 syssts)
+__releases(r8a66597->lock)
+__acquires(r8a66597->lock)
 {
 	if (syssts = SE0) {
 		r8a66597_write(r8a66597, ~ATTCH, get_intsts_reg(port));
@@ -1023,7 +1040,9 @@ static void r8a66597_check_syssts(struct r8a66597 *r8a66597, int port,
 			usb_hcd_resume_root_hub(r8a66597_to_hcd(r8a66597));
 	}
 
+	spin_unlock(&r8a66597->lock);
 	usb_hcd_poll_rh_status(r8a66597_to_hcd(r8a66597));
+	spin_lock(&r8a66597->lock);
 }
 
 /* this function must be called with interrupt disabled */
@@ -1283,10 +1302,7 @@ __releases(r8a66597->lock) __acquires(r8a66597->lock)
 		if (usb_pipeisoc(urb->pipe))
 			urb->start_frame = r8a66597_get_frame(hcd);
 
-		usb_hcd_unlink_urb_from_ep(r8a66597_to_hcd(r8a66597), urb);
-		spin_unlock(&r8a66597->lock);
-		usb_hcd_giveback_urb(hcd, urb, status);
-		spin_lock(&r8a66597->lock);
+		r8a66597_urb_done(r8a66597, urb, status);
 	}
 
 	if (restart) {
