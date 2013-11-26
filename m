From: Greg KH <greg@kroah.com>
Date: Tue, 26 Nov 2013 21:44:37 +0000
Subject: Re: [RFC V2 PATCH 0/2] Defer HCD init until the external PHY, bound to the HCD is ready
Message-Id: <20131126214437.GA17961@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383822869-20283-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383822869-20283-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 27, 2013 at 01:31:06AM +0400, Valentine wrote:
> On 11/07/2013 03:14 PM, Valentine Barshak wrote:
> >This adds remove_phy flag to the HCD structure. If the flag is
> >set and if hcd->phy is valid, the phy is shutdown and released
> >whenever usb_add_hcd fails or usb_hcd_remove is called.
> >This also adds generic external phy support that allows
> >the HCD driver to search for a USB phy, bound to the HCD,
> >when the HC is being added.
> >
> >If the USB PHY is found, it is initialized and the remove_phy flag
> >is set. In case PHY is not ready, the usb_add_hcd function returns
> >the -EPROBE_DEFER error code which defers HCD probing till the PHY
> >becomes ready.
> >If no PHY is bound to the HCD, or it has been initialized by
> >the glue-driver before calling usb_add_hcd(), the HCD is
> >added as usual.
> >
> >This approach can be used to initialize the external PHY for
> >the R-Car PCI USB hosts, that share USB ports with USBHS/USBSS devices.
> >All we need to do is to make R-Car Gen2 platform code bind the
> >Gen2 USB phy device to the PCI HC devices, and make the phy-rcar-gen2-usb
> >driver register USB phy with usb_add_phy_dev() AOT usb_add_phy() callback.
> >
> >Changes from previous version:
> >* Used #ifdef CONFIG_USB_PHY instead of introducing new config option.
> >
> >Valentine Barshak (2):
> >   usb: hcd: Remove USB phy if needed
> >   usb: hcd: Initialize USB phy if needed
> >
> >  drivers/usb/core/hcd.c  | 34 +++++++++++++++++++++++++++++++++-
> >  include/linux/usb/hcd.h |  1 +
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> 
> Greg, are you going to take these or is there anything else I have to do?

I don't see anything to "take" here, sorry.  You sent some patches with
"Request for Comments", which usually means, "don't apply them, I just
want people to look at them", so I don't apply them...

If you want me to apply them, please resend without that.

Also, I'd like to get Alan's ACK on these, as they touch the core HCD
code.

thanks,

greg k-h
