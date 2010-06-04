From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Jun 2010 00:42:53 +0000
Subject: Re: IORESOURCE_PCI_FIXED usage in pcibios_fixup_device_resources()
Message-Id: <20100604004253.GB31868@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201006031638.33726.bjorn.helgaas@hp.com>
In-Reply-To: <201006031638.33726.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 03, 2010 at 04:38:32PM -0600, Bjorn Helgaas wrote:
> The SH implementation of pcibios_fixup_device_resources() does the
> equivalent of pcibios_bus_to_resource() for all the resources of a
> device, except that it skips resources with the IORESOURCE_PCI_FIXED
> flag set.
> 
> This looks like a bug to me.  IORESOURCE_PCI_FIXED means the resource
> cannot be moved, not that we should skip pcibios_bus_to_resource().
> 
> Does anybody know why pcibios_fixup_device_resources() does this check?
> 
> The only other IORESOURCE_PCI_FIXED reference I see in arch/sh is in
> gapspci_fixup_resources(), so maybe it has something to do with that?
> 
gapspci is a very special case, in that it's not really PCI but a bit of
mangling logic in a custom ASIC that interfaces an 8139 ethernet device
directly on to an ISA-style bus. If you take a look at
arch/sh/drivers/pci/fixups-dreamcast.c you can see where the flag is set
and the rationale behind it.

Looking at the code again though it seems like pcibios_bus_to_resource()
will not cause any problems, especially given that the io and mem offsets
are both cleared to 0 for that controller. I'll kill off the test from
pcibios_fixup_device_resources(), I assume this was a remnant from the
old pci-auto code which we moved off of some time ago.

We still need to retain the flag though, since nothing can be permitted
to touch the resources for any devices on that particular controller.
