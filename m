From: Greg KH <greg@kroah.com>
Date: Fri, 01 Nov 2013 15:33:24 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <20131101153324.GB21250@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 01, 2013 at 07:04:00PM +0400, Valentine wrote:
> >We should implement a proper solution.  One that can be used
> >everywhere, not an initcall-order hack.
> 
> That would be great, but I don't think we can implement a universal solution for all of those drivers.
> The solution that may suit R-Car may not be good for other USB phy drivers since most likely they have
> their init order fixed-up for other reasons not related to PCI USB hosts.

That's the best reason I've heard to fix this properly, and NOT use init
call ordering.  So glad we agree :)

> Fixing all the drivers so that they all can use deferred probing is, in my opinion, a bit out of scope
> here.

Not at all.  I understand you feel a little put-apon due to this, but
that's how kernel development works, sorry.

> The USB HDC PCI deferred probing could be used on R-Car. But I'm not sure how to make a particular
> PCI USB HDC device attached to a particular PCI host controller on a particular SoC defer its probing
> while waiting for the USB phy. At the same time other identical PCI USB HCD devices (with the same PCI id)
> on the same SoC should be probed as usual.
> 
> We can't use PCI ids here to distinguish between PCI USB HCD devices. Neither can we use PCI busses
> to distinguish between PCI host controllers, since bus numbers are assigned dynamically.
> 
> It looks that it's quite hard to do that without bigger hacks in the PCI USB HCD driver that are
> most likely not to be used on any other platforms except for R-Car.
> 
> I just can't see why changing init order is considered such a bad hack in this case,
> while it is being used fine with other USB phy drivers.

It isn't fine for those other drivers, I just happened to miss that they
were doing this, and you got "caught" trying to make the same change.
I'll go break them as well if it makes you feel any better.

> Can't we use it for R-Car until a universal solution to the deferred probing is found?

The "universal" solution is to implement deferred probing, why not just
do that?

greg k-h
