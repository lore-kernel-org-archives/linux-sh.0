From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 20 Aug 2009 07:01:06 +0000
Subject: Re: [PATCH] usb: add support R8A66597 peripheral controller driver
Message-Id: <4A8CF4B2.9090000@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4A8B86BB.1020605@renesas.com>
In-Reply-To: <4A8B86BB.1020605@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Alan Stern wrote:
> On Wed, 19 Aug 2009, Yoshihiro Shimoda wrote:
> 
>> The R8A66597 is Renesas USB 2.0 host and peripheral controller.
>> This controller supports USB High-speed. This driver supports
>> peripheral side.
> 
>> +static struct usb_ep_ops r8a66597_ep_ops = {
>> +	.enable		= r8a66597_enable,
>> +	.disable	= r8a66597_disable,
>> +
>> +	.alloc_request	= r8a66597_alloc_request,
>> +	.free_request	= r8a66597_free_request,
>> +
>> +	.queue		= r8a66597_queue,
>> +	.dequeue	= r8a66597_dequeue,
>> +
>> +	.set_halt	= r8a66597_set_halt,
>> +	.fifo_flush	= r8a66597_fifo_flush,
>> +};
> 
> All new peripheral controller drivers should implement the set_wedge 
> method.

Thank you very much for your comment!
I made a new patch of implement the set_wedge method.
Would you check this patch?

Best regards,
Yoshihiro Shimoda

---
Subject: [PATCH] usb: r8a66597-udc: implement the set_wedge method

fix the problem that MSC Tests of USBCV detects some warnings.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 drivers/usb/gadget/r8a66597-udc.c |   28 ++++++++++++++++++++++++++--
 drivers/usb/gadget/r8a66597-udc.h |    1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 1e3e638..473e03e 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -974,8 +974,13 @@ static void clear_feature(struct r8a66597 *r8a66597,
 		u16 w_index = le16_to_cpu(ctrl->wIndex);

 		ep = r8a66597->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK];
-		pipe_stop(r8a66597, ep->pipenum);
-		control_reg_sqclr(r8a66597, ep->pipenum);
+		if (!ep->wedge) {
+			pipe_stop(r8a66597, ep->pipenum);
+			control_reg_sqclr(r8a66597, ep->pipenum);
+			spin_unlock(&r8a66597->lock);
+			usb_ep_clear_halt(&ep->ep);
+			spin_lock(&r8a66597->lock);
+		}

 		control_end(r8a66597, 1);

@@ -1348,6 +1353,7 @@ static int r8a66597_set_halt(struct usb_ep *_ep, int value)
 		pipe_stall(ep->r8a66597, ep->pipenum);
 	} else {
 		ep->busy = 0;
+		ep->wedge = 0;
 		pipe_stop(ep->r8a66597, ep->pipenum);
 	}

@@ -1356,6 +1362,23 @@ out:
 	return ret;
 }

+static int r8a66597_set_wedge(struct usb_ep *_ep)
+{
+	struct r8a66597_ep *ep;
+	unsigned long flags;
+
+	ep = container_of(_ep, struct r8a66597_ep, ep);
+
+	if (!ep || !ep->desc)
+		return -EINVAL;
+
+	spin_lock_irqsave(&ep->r8a66597->lock, flags);
+	ep->wedge = 1;
+	spin_unlock_irqrestore(&ep->r8a66597->lock, flags);
+
+	return usb_ep_set_halt(_ep);
+}
+
 static void r8a66597_fifo_flush(struct usb_ep *_ep)
 {
 	struct r8a66597_ep *ep;
@@ -1381,6 +1404,7 @@ static struct usb_ep_ops r8a66597_ep_ops = {
 	.dequeue	= r8a66597_dequeue,

 	.set_halt	= r8a66597_set_halt,
+	.set_wedge	= r8a66597_set_wedge,
 	.fifo_flush	= r8a66597_fifo_flush,
 };

diff --git a/drivers/usb/gadget/r8a66597-udc.h b/drivers/usb/gadget/r8a66597-udc.h
index 7d9a325..3ff922c 100644
--- a/drivers/usb/gadget/r8a66597-udc.h
+++ b/drivers/usb/gadget/r8a66597-udc.h
@@ -73,6 +73,7 @@ struct r8a66597_ep {

 	struct list_head	queue;
 	unsigned		busy:1;
+	unsigned		wedge:1;
 	unsigned		internal_ccpl:1;	/* use only control */

 	/* this member can able to after r8a66597_enable */
-- 
1.5.5

