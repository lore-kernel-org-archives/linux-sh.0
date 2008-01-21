From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 21 Jan 2008 08:35:08 +0000
Subject: Re: [BUG] cannot access IO ports in CMI8738 sound chip.
Message-Id: <20080121083508.GA20265@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080121.152550.68560038.matsu@igel.co.jp>
In-Reply-To: <20080121.152550.68560038.matsu@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 21, 2008 at 05:04:20PM +0900, Katsuya MATSUBARA wrote:
> > On Mon, Jan 21, 2008 at 04:39:04PM +0900, Katsuya MATSUBARA wrote:
> > > > On Mon, Jan 21, 2008 at 03:25:50PM +0900, Katsuya MATSUBARA wrote:
> > > > >  Unfortunately CMI8738 cannot treat (large) memory addresses
> > > > >  as IO port numers because some upper bits of 'Base Address
> > > > >  Register 0' in the PCI configuration space cannot be updated.
> > > > >  (pcibios_setup_bars() in arch/sh/drivers/pci/pci-auto.c
> > > > >  updates the register with the memory address.)
> > > > >  
> > > > >  How should I fix the problem?
> > > > 
> > > > Disable PCI_AUTO_UPDATE_RESOURCES like the dreamcast does?
> > > 
> > >  I did it.
> > >  Any PCI devices, include an ethernet, cannot be accessed
> > >  if PCI_AUTO_UPDATE_RESOURCES is disabled.
> > >  
> > And with pci-auto disabled?
> 
>  Yes, I did. I got the same failure even if PCI_AUTO was disabled.

The driver itself looks a bit questionable. There's a
pci_resource_start() for that BAR that assigns it to ->iobase and then
uses that for direct I/O without a remap. Whether this BAR is an I/O or
MEM bar, the remap is still necessary. So this does need to go through
something like pci_iomap() regardless.

If you need to do special handling for your pci_iomap() implementation,
that's perfectly acceptable, and a number of platforms do something like
that already. We definitely don't want to overload the I/O routines to
work around driver incompetence, though. Please fix the driver.
