From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Nov 2013 04:28:36 +0000
Subject: Re: [PATCH 3/9] usb: hcd: Initialize USB phy if needed
Message-Id: <20131121042836.GP31130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1384969086-8920-4-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1384969086-8920-4-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 21, 2013 at 01:26:19AM +0400, Valentine wrote:
> On 11/20/2013 09:46 PM, Fabio Estevam wrote:
> >On Wed, Nov 20, 2013 at 3:38 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> >>From: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>
> >>This adds external USB phy support to USB HCD driver that
> >>allows to find and initialize external USB phy, bound to
> >>the HCD, when the HCD is added.
> >>The usb_add_hcd function returns -EPROBE_DEFER if the USB
> >>phy, bound to the HCD, is not ready.
> >>If no USB phy is bound, the HCD is initialized as usual.
> >>
> >>Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >>Acked-by: Alan Stern <stern@rowland.harvard.edu>
> >>---
> >>  drivers/usb/core/hcd.c | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >>diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> >>index d939521..fd09ec6 100644
> >>--- a/drivers/usb/core/hcd.c
> >>+++ b/drivers/usb/core/hcd.c
> >>@@ -2597,6 +2597,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
> >>         int retval;
> >>         struct usb_device *rhdev;
> >>
> >>+#ifdef CONFIG_USB_PHY
> >>+       if (!hcd->phy) {
> >>+               struct usb_phy *phy = usb_get_phy_dev(hcd->self.controller, 0);
> >
> >Wouldn't it be better to use the following instead?
> >
> >           if (IS_ENABLED(CONFIG_USB_PHY) && !hcd->(phy) {
> 
> Since USB_PHY is a bool I don't see much of a difference.

The difference is that IS_ENABLED() is thought to be less ugly
than #ifdef. For this reason I agree with Fabio's comment.

> 
> >
> >Regards,
> >
> >Fabio Estevam
> 
> Thanks,
> Val.
> 
> >
> >>+
> >>+               if (IS_ERR(phy)) {
> >>+                       retval = PTR_ERR(phy);
> >>+                       if (retval = -EPROBE_DEFER)
> >>+                               return retval;
> >>+               } else {
> >>+                       retval = usb_phy_init(phy);
> >>+                       if (retval) {
> >>+                               usb_put_phy(phy);
> >>+                               return retval;
> >>+                       }
> >>+                       hcd->phy = phy;
> >>+                       hcd->remove_phy = 1;
> >>+               }
> >>+       }
> >>+#endif
> >>+
> >>         dev_info(hcd->self.controller, "%s\n", hcd->product_desc);
> >>
> >>         /* Keep old behaviour if authorized_default is not in [0, 1]. */
> >>--
> >>1.8.4
> >>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
