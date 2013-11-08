From: Peter Chen <Peter.Chen@freescale.com>
Date: Fri, 08 Nov 2013 01:44:38 +0000
Subject: RE: [RFC V2 PATCH 2/2] usb: hcd: Initialize USB phy if needed
Message-Id: <F281D0F91ED19E4D8E63A7504E8A6498040EBD5C@039-SN2MPN1-021.039d.mgd.msft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1383822869-20283-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383822869-20283-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


 
> >>
> >> +#ifdef CONFIG_USB_PHY
> >> +	if (!hcd->phy) {
> >> +		struct usb_phy *phy = usb_get_phy_dev(hcd->self.controller,
> >> 0);
> >> +
> >> +		if (IS_ERR(phy)) {
> >> +			retval = PTR_ERR(phy);
> >> +			if (retval = -EPROBE_DEFER)
> >> +				return retval;
> >> +		} else {
> >> +			retval = usb_phy_init(phy);
> >> +			if (retval) {
> >> +				usb_put_phy(phy);
> >> +				return retval;
> >> +			}
> >> +			hcd->phy = phy;
> >> +			hcd->remove_phy = 1;
> >> +		}
> >> +	}
> >> +#endif
> >> +
> >
> > If the platform doesn't has phy driver, and with CONFIG_USB_PHY enabled,
> it
> > will have problem for above code.
> >
> 
> It shouldn't have any problems since there's no phy bound to the HCD in
> this case.
> Thus, usb_get_phy_dev returns -ENODEV and the HCD will be added as usual.
> 
Yes, my fault. The retval will be override later.

Peter


