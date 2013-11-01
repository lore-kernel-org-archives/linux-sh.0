From: Alan Stern <stern@rowland.harvard.edu>
Date: Fri, 01 Nov 2013 15:55:30 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <Pine.LNX.4.44L0.1311011149390.1364-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 1 Nov 2013, Valentine wrote:

> The USB HDC PCI deferred probing could be used on R-Car. But I'm not sure how to make a particular
> PCI USB HDC device attached to a particular PCI host controller on a particular SoC defer its probing
> while waiting for the USB phy. At the same time other identical PCI USB HCD devices (with the same PCI id)
> on the same SoC should be probed as usual.

That is the hard part.  That's what we need to discuss.

And not just on the linux-usb mailing list.  Get other people 
(especially PCI people) involved too.

> We can't use PCI ids here to distinguish between PCI USB HCD devices. Neither can we use PCI busses
> to distinguish between PCI host controllers, since bus numbers are assigned dynamically.

There must be some way for you to tell which PCI devices use the PHY.  
But I'm not a PCI expert, and I'm not familiar with your platform.

> It looks that it's quite hard to do that without bigger hacks in the PCI USB HCD driver that are
> most likely not to be used on any other platforms except for R-Car.

You never know what will happen in the future.  Besides, even if nobody 
else needs to do this for a PCI device, you can be certain that the 
same sort of thing will be needed for devices on other buses.  A 
suitably general solution would help them too.

Alan Stern

