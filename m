From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 31 Oct 2013 16:54:01 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <Pine.LNX.4.44L0.1310311154160.1285-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 31 Oct 2013, Valentine wrote:

> > Do you mean to change usb_hcd_pci_probe() to return -EPROBE_DEFER if the phy is not ready?
> > Or should I defer the whole PCI subsystem initialization (pci_common_int)?
> 
> Greg,
> the reason I ask is that it doesn't seem that simple to me.
> 
> Here's some details:
> The h/w is an ARM SoC that has 3 internal PCI controllers with a single EHCI/OHCI on each one.
> This gives us 3 USB channels as this is called in the h/w manual.
> Channel 0 is shared with USBHS (USB function) device.
> Channel 2 is shared with USBSS (USB3.0 host).
> Both channels are configured by a single USB phy.
> USB PHY is a platform device, while EHCI/OCHI are located on the PCI busses.
> 
> If PCI USB host is probed before USB phy, the EHCI/OHCI device is
> detected, but nothing works.
> 
> We could change the USB HDC PCI driver and make usb_hcd_pci_probe() return -EPROBE_DEFER,
> but I'm not sure how the condition for that should be phrased.

You need to tell usb_hcd_pci_probe() to wait for the PHY.  That seems
to be the proper solution to your problem.

The difficulty is that you have a discoverable device (the PCI EHCI
controller) which needs to wait for a platform device (the PHY).  The
kernel doesn't have a good way to describe such a constraint between
two different kinds of device like that, as far as I know.

This is similar to the problems facing Runtime Interpreted Power 
Sequences, although not quite the same.

Alan Stern

