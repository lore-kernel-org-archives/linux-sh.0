From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Mon, 04 Dec 2017 15:09:03 +0000
Subject: [PATCH 4/8] arch/sh: pcie-sh7786: mark unavailable PCI resource as disabled
Message-Id: <20171204150907.24345-5-thomas.petazzoni@free-electrons.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204150907.24345-1-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Some PCI MEM resources are marked as IORESOURCE_MEM_32BIT, which means
they are only usable when the SH core runs in 32-bit mode. In 29-bit
mode, such memory regions are not usable.

The existing code for SH7786 properly skips such regions when
configuring the PCIe controller registers. However, because such
regions are still described in the resource array, the
pcibios_scanbus() function in the SuperH pci.c will register them to
the PCI core. Due to this, the PCI core will allocate MEM areas from
this resource, and assign BARs pointing to this area, even though it's
unusable.

In order to prevent this from happening, we mark such regions as
IORESOURCE_DISABLED, which tells the SuperH pci.c pcibios_scanbus()
function to skip them.

Note that we separate marking the region as disabled from skipping it,
because other regions will be marked as disabled in follow-up patches.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/sh/drivers/pci/pcie-sh7786.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-sh7786.c
index 45bbe6927251..c2f877b4ef7e 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -419,6 +419,9 @@ static int __init pcie_init(struct sh7786_pcie_port *port)
 		 * mode, so just skip them entirely.
 		 */
 		if ((res->flags & IORESOURCE_MEM_32BIT) && __in_29bit_mode())
+			res->flags |= IORESOURCE_DISABLED;
+
+		if (res->flags & IORESOURCE_DISABLED)
 			continue;
 
 		pci_write_reg(chan, 0x00000000, SH4A_PCIEPTCTLR(win));
-- 
2.13.6

