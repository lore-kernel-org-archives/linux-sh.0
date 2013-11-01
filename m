From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 01 Nov 2013 14:17:18 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <Pine.LNX.4.44L0.1311011010340.1364-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 1 Nov 2013, Valentine wrote:

> > You need to tell usb_hcd_pci_probe() to wait for the PHY.  That seems
> > to be the proper solution to your problem.
> >
> > The difficulty is that you have a discoverable device (the PCI EHCI
> > controller) which needs to wait for a platform device (the PHY).  The
> > kernel doesn't have a good way to describe such a constraint between
> > two different kinds of device like that, as far as I know.
> 
> Thanks, unfortunately this doesn't help.
> I'm not sure how this problem should be addressed using USB HCD PCI deferred probing.

I'm not sure either.  It requires further discussion, and it is an 
important problem.  Not a trivial one, as you seem to think.

> However, at the same time I see that six usb phy drivers use subsys_initcall and one
> uses postcore_initcall to adjust the initialization order.
> 
> The same approach is used with other drivers quite often. Take I2C, for example.
> I'm not sure why we can't use it here with the R-Car Gen2 phy.

The fact that other drivers do it doesn't mean it is the right thing to
do.  (Besides, I2C is different from PCI because it isn't discoverable,
right?)

Greg KH can explain further, if you ask him.

> This driver is used only with R-Car SoC and the approach is trivial and  working fine.
> 
> Why can't we use it instead of trying to create a bigger mess in the USB HCD PCI driver,
> which is used on quite a number of platforms, to workaround the PHY initialization order
> that is only relevant to R-Car Gen2 SoC?

Because other platforms are likely to experience the same problem in 
the future.  And as you pointed out, other platforms already _are_ 
experiencing this problem (although perhaps for other drivers).

We should implement a proper solution.  One that can be used
everywhere, not an initcall-order hack.

Alan Stern

