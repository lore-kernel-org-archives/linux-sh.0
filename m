From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2008 12:35:14 +0000
Subject: [PATCH 06/09] sh: add io_base member to pci_channel
Message-Id: <20080219123514.4266.45284.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Store the io window base address in struct pci_channel and use that one
instead of SH77xx_PCI_IO_BASE.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/drivers/pci/pci-sh7751.c |    5 +++--
 arch/sh/drivers/pci/pci-sh7780.c |    5 +++--
 include/asm-sh/pci.h             |    1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

--- 0007/arch/sh/drivers/pci/pci-sh7751.c
+++ work/arch/sh/drivers/pci/pci-sh7751.c	2008-02-19 16:44:19.000000000 +0900
@@ -40,6 +40,7 @@ int __init sh7751_pci_init(struct pci_ch
 	pr_debug("PCI: Starting intialization.\n");
 
 	chan->reg_base = 0xfe200000;
+	chan->io_base = 0xfe240000;
 
 	/* check for SH7751/SH7751R hardware */
 	id = pci_read_reg(chan, SH7751_PCICONF0);
@@ -153,9 +154,9 @@ int __init sh7751_pcic_init(struct pci_c
 	/* Map IO space into PCI IO window:
 	 * IO addresses will be translated to the PCI IO window base address
 	 */
-	pr_debug("PCI: Mapping IO address 0x%x - 0x%x to base 0x%x\n",
+	pr_debug("PCI: Mapping IO address 0x%x - 0x%x to base 0x%lx\n",
 		 chan->io_resource->start, chan->io_resource->end,
-		 SH7751_PCI_IO_BASE + chan->io_resource->start);
+		 chan->io_base + chan->io_resource->start);
 
 	/* Make sure the MSB's of IO window are set to access PCI space
 	 * correctly */
--- 0007/arch/sh/drivers/pci/pci-sh7780.c
+++ work/arch/sh/drivers/pci/pci-sh7780.c	2008-02-19 16:44:29.000000000 +0900
@@ -53,6 +53,7 @@ int __init sh7780_pci_init(struct pci_ch
 	pr_debug("PCI: Starting intialization.\n");
 
 	chan->reg_base = 0xfe040000;
+	chan->io_base = 0xfe200000;
 
 	ctrl_outl(0x00000001, SH7780_PCI_VCR2); /* Enable PCIC */
 
@@ -141,9 +142,9 @@ int __init sh7780_pcic_init(struct pci_c
 	/* Map IO space into PCI IO window:
 	 * IO addresses will be translated to the PCI IO window base address
 	 */
-	pr_debug("PCI: Mapping IO address 0x%x - 0x%x to base 0x%x\n",
+	pr_debug("PCI: Mapping IO address 0x%x - 0x%x to base 0x%lx\n",
 		 chan->io_resource->start, chan->io_resource->end,
-		 SH7780_PCI_IO_BASE + chan->io_resource->start);
+		 chan->io_base + chan->io_resource->start);
 
 	/* NOTE: I'm ignoring the PCI error IRQs for now..
 	 * TODO: add support for the internal error interrupts and
--- 0006/include/asm-sh/pci.h
+++ work/include/asm-sh/pci.h	2008-02-19 16:36:14.000000000 +0900
@@ -25,6 +25,7 @@ struct pci_channel {
 	int last_devfn;
 	int enabled;
 	unsigned long reg_base;
+	unsigned long io_base;
 };
 
 /*
