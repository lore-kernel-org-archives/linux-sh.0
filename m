From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 06 Nov 2013 16:36:07 +0000
Subject: Re: [RFC PATCH 1/2] usb: hcd: Remove USB phy if needed
Message-Id: <Pine.LNX.4.44L0.1311061134330.1220-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383683607-28119-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383683607-28119-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 6 Nov 2013, Felipe Balbi wrote:

> Hi,
> 
> On Wed, Nov 06, 2013 at 12:33:26AM +0400, Valentine Barshak wrote:
> > This adds remove_phy flag to the HCD structure. If the flag is
> > set and if hcd->phy is valid, the phy is shutdown and released
> > whenever usb_add_hcd fails or usb_hcd_remove is called.
> > This can be used by the HCD drivers to auto-remove
> > the external USB phy when it is no longer needed.
> > 
> > Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> > ---
> >  drivers/usb/core/hcd.c  | 14 +++++++++++++-
> >  include/linux/usb/hcd.h |  1 +
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> > index d6a8d23..d939521 100644
> > --- a/drivers/usb/core/hcd.c
> > +++ b/drivers/usb/core/hcd.c
> > @@ -43,6 +43,7 @@
> >  
> >  #include <linux/usb.h>
> >  #include <linux/usb/hcd.h>
> > +#include <linux/usb/phy.h>
> >  
> >  #include "usb.h"
> >  
> > @@ -2611,7 +2612,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
> >  	 */
> >  	if ((retval = hcd_buffer_create(hcd)) != 0) {
> >  		dev_dbg(hcd->self.controller, "pool alloc failed\n");
> > -		return retval;
> > +		goto err_remove_phy;
> >  	}
> >  
> >  	if ((retval = usb_register_bus(&hcd->self)) < 0)
> > @@ -2742,6 +2743,12 @@ err_allocate_root_hub:
> >  	usb_deregister_bus(&hcd->self);
> >  err_register_bus:
> >  	hcd_buffer_destroy(hcd);
> > +err_remove_phy:
> > +	if (hcd->remove_phy && hcd->phy) {
> > +		usb_phy_shutdown(hcd->phy);
> > +		usb_put_phy(hcd->phy);
> > +		hcd->phy = NULL;
> > +	}
> 
> why do you need the flag at all ? If hcd->phy is valid, just casll
> usb_phy_shutdown() followed by usb_put_phy(). Did you find any issues
> with that ?

That's a reasonable thing to do, but it means that a few other HC 
drivers would have to be updated (they shouldn't call usb_phy_shutdown 
or usb_put_phy any more).

Alan Stern

