From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date: Thu, 03 Jun 2010 22:38:32 +0000
Subject: IORESOURCE_PCI_FIXED usage in pcibios_fixup_device_resources()
Message-Id: <201006031638.33726.bjorn.helgaas@hp.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SH implementation of pcibios_fixup_device_resources() does the
equivalent of pcibios_bus_to_resource() for all the resources of a
device, except that it skips resources with the IORESOURCE_PCI_FIXED
flag set.

This looks like a bug to me.  IORESOURCE_PCI_FIXED means the resource
cannot be moved, not that we should skip pcibios_bus_to_resource().

Does anybody know why pcibios_fixup_device_resources() does this check?

The only other IORESOURCE_PCI_FIXED reference I see in arch/sh is in
gapspci_fixup_resources(), so maybe it has something to do with that?

Bjorn
