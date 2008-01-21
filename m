From: Katsuya MATSUBARA <matsu@igel.co.jp>
Date: Mon, 21 Jan 2008 08:04:20 +0000
Subject: Re: [BUG] cannot access IO ports in CMI8738 sound chip.
Message-Id: <20080121.170420.46634831.matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20080121.152550.68560038.matsu@igel.co.jp>
In-Reply-To: <20080121.152550.68560038.matsu@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 21 Jan 2008 16:52:41 +0900

> On Mon, Jan 21, 2008 at 04:39:04PM +0900, Katsuya MATSUBARA wrote:
> > > On Mon, Jan 21, 2008 at 03:25:50PM +0900, Katsuya MATSUBARA wrote:
> > > >  Unfortunately CMI8738 cannot treat (large) memory addresses
> > > >  as IO port numers because some upper bits of 'Base Address
> > > >  Register 0' in the PCI configuration space cannot be updated.
> > > >  (pcibios_setup_bars() in arch/sh/drivers/pci/pci-auto.c
> > > >  updates the register with the memory address.)
> > > >  
> > > >  How should I fix the problem?
> > > 
> > > Disable PCI_AUTO_UPDATE_RESOURCES like the dreamcast does?
> > 
> >  I did it.
> >  Any PCI devices, include an ethernet, cannot be accessed
> >  if PCI_AUTO_UPDATE_RESOURCES is disabled.
> >  
> And with pci-auto disabled?

 Yes, I did. I got the same failure even if PCI_AUTO was disabled.
---
 Katsuya Matsubara

