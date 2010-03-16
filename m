From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 16 Mar 2010 03:29:35 +0000
Subject: Re: r8a66597-hcd panics when a USB device is removed from an attached
Message-Id: <4B9EFB1F.3090201@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F017F26D4B469@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F017F26D4B469@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Mon, Mar 15, 2010 at 10:00:07AM -0400, Alan Stern wrote:
>> Is there some reason why you guys haven't tried asking the author of 
>> r8a66597-hcd (CC'ed)?  He's in a better position than anyone else to 
>> fix the problem.
>>
> He's on the list as well, just unresponsive as of late, which is why I
> waited some time before replying and adding linux-usb to the Cc. 
> 
I'm sorry for my lazy response.
I check this issue, and I fixed it.


Hello Mr. Markus,

Thank you for your detail report!
I made a patch. If possible, would you test it on your environment?

Thanks,
Yoshihiro Shimoda
---

Subject: [PATCH] usb: r8a66597-hcd: fix removed from an attached hub

fix the problem that when a USB hub is attached to the r8a66597-hcd and
a device is removed from that hub, it's likely that a kernel panic follows.

Reported-by: Markus Pietrek <Markus.Pietrek@emtrion.de>
Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 drivers/usb/host/r8a66597-hcd.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
index bee558a..f71a73a 100644
--- a/drivers/usb/host/r8a66597-hcd.c
+++ b/drivers/usb/host/r8a66597-hcd.c
@@ -418,7 +418,7 @@ static u8 alloc_usb_address(struct r8a66597 *r8a66597, struct urb *urb)

 /* this function must be called with interrupt disabled */
 static void free_usb_address(struct r8a66597 *r8a66597,
-			     struct r8a66597_device *dev)
+			     struct r8a66597_device *dev, int reset)
 {
 	int port;

@@ -430,7 +430,13 @@ static void free_usb_address(struct r8a66597 *r8a66597,
 	dev->state = USB_STATE_DEFAULT;
 	r8a66597->address_map &= ~(1 << dev->address);
 	dev->address = 0;
-	dev_set_drvdata(&dev->udev->dev, NULL);
+	/*
+	 * Only when resetting USB, it is necessary to erase drvdata. When
+	 * a usb device with usb hub is disconnect, "dev->udev" is already
+	 * freed on usb_desconnect(). So we cannot access the data.
+	 */
+	if (reset)
+		dev_set_drvdata(&dev->udev->dev, NULL);
 	list_del(&dev->device_list);
 	kfree(dev);

@@ -1069,7 +1075,7 @@ static void r8a66597_usb_disconnect(struct r8a66597 *r8a66597, int port)
 	struct r8a66597_device *dev = r8a66597->root_hub[port].dev;

 	disable_r8a66597_pipe_all(r8a66597, dev);
-	free_usb_address(r8a66597, dev);
+	free_usb_address(r8a66597, dev, 0);

 	start_root_hub_sampling(r8a66597, port, 0);
 }
@@ -2085,7 +2091,7 @@ static void update_usb_address_map(struct r8a66597 *r8a66597,
 				spin_lock_irqsave(&r8a66597->lock, flags);
 				dev = get_r8a66597_device(r8a66597, addr);
 				disable_r8a66597_pipe_all(r8a66597, dev);
-				free_usb_address(r8a66597, dev);
+				free_usb_address(r8a66597, dev, 0);
 				put_child_connect_map(r8a66597, addr);
 				spin_unlock_irqrestore(&r8a66597->lock, flags);
 			}
@@ -2228,7 +2234,7 @@ static int r8a66597_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			rh->port |= (1 << USB_PORT_FEAT_RESET);

 			disable_r8a66597_pipe_all(r8a66597, dev);
-			free_usb_address(r8a66597, dev);
+			free_usb_address(r8a66597, dev, 1);

 			r8a66597_mdfy(r8a66597, USBRST, USBRST | UACT,
 				      get_dvstctr_reg(port));
-- 
1.5.5

