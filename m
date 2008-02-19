From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2008 12:34:46 +0000
Subject: [PATCH 03/09] sh: avoid using PCIBIOS_MIN_xxx
Message-Id: <20080219123446.4266.65644.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replaces PCIBIOS_MIN_IO and PCIBIOS_MIN_MEM with direct struct pci_channel
access. This allows us to have more than one pci channel.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/drivers/pci/fixups-r7780rp.c |    2 +-
 arch/sh/drivers/pci/fixups-sdk7780.c |    2 +-
 arch/sh/drivers/pci/fixups-se7780.c  |    2 +-
 arch/sh/drivers/pci/pci-sh5.c        |    9 ++++++---
 arch/sh/drivers/pci/pci-sh7751.c     |   14 ++++++--------
 arch/sh/drivers/pci/pci-sh7780.c     |   10 ++++------
 6 files changed, 19 insertions(+), 20 deletions(-)

--- 0004/arch/sh/drivers/pci/fixups-r7780rp.c
+++ work/arch/sh/drivers/pci/fixups-r7780rp.c	2008-02-19 15:46:51.000000000 +0900
@@ -37,7 +37,7 @@ int pci_fixup_pcic(struct pci_channel *c
 #endif
 
 	/* Set IOBR for windows containing area specified in pci.h */
-	pci_write_reg(chan, (PCIBIOS_MIN_IO & ~(SH7780_PCI_IO_SIZE - 1)),
+	pci_write_reg(chan, chan->io_resource->start & ~(SH7780_PCI_IO_SIZE-1),
 		      SH7780_PCIIOBR);
 	pci_write_reg(chan, ((SH7780_PCI_IO_SIZE-1) & (7<<18)),
 		      SH7780_PCIIOBMR);
--- 0004/arch/sh/drivers/pci/fixups-sdk7780.c
+++ work/arch/sh/drivers/pci/fixups-sdk7780.c	2008-02-19 15:46:51.000000000 +0900
@@ -50,7 +50,7 @@ int pci_fixup_pcic(struct pci_channel *c
 	pci_write_reg(chan, 0x00FC0000 , SH7780_PCIMBMR0);	/* 16M */
 
 	/* Set IOBR for window containing area specified in pci.h */
-	pci_write_reg(chan, PCIBIOS_MIN_IO & ~(SH7780_PCI_IO_SIZE-1),
+	pci_write_reg(chan, chan->io_resource->start & ~(SH7780_PCI_IO_SIZE-1),
 		      SH7780_PCIIOBR);
 	pci_write_reg(chan, (SH7780_PCI_IO_SIZE-1) & (7 << 18),
 		      SH7780_PCIIOBMR);
--- 0004/arch/sh/drivers/pci/fixups-se7780.c
+++ work/arch/sh/drivers/pci/fixups-se7780.c	2008-02-19 15:46:51.000000000 +0900
@@ -51,7 +51,7 @@ int pci_fixup_pcic(struct pci_channel *c
 	pci_write_reg(chan, 0x00FC0000 , SH7780_PCIMBMR0);    /* 16M */
 
 	/* Set IOBR for window containing area specified in pci.h */
-	pci_write_reg(chan, PCIBIOS_MIN_IO & ~(SH7780_PCI_IO_SIZE-1),
+	pci_write_reg(chan, chan->io_resource->start & ~(SH7780_PCI_IO_SIZE-1),
 		      SH7780_PCIIOBR);
 	pci_write_reg(chan, (SH7780_PCI_IO_SIZE-1) & (7 << 18),
 		      SH7780_PCIIOBMR);
--- 0005/arch/sh/drivers/pci/pci-sh5.c
+++ work/arch/sh/drivers/pci/pci-sh5.c	2008-02-19 15:46:51.000000000 +0900
@@ -206,6 +206,9 @@ int __init sh5pci_init(unsigned long mem
 	return 0;
 }
 
+#define xPCIBIOS_MIN_IO		board_pci_channels->io_resource->start
+#define xPCIBIOS_MIN_MEM	board_pci_channels->mem_resource->start
+
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 {
 	struct pci_dev *dev = bus->self;
@@ -223,9 +226,9 @@ void __devinit pcibios_fixup_bus(struct 
 		/* For now, propagate host limits to the bus;
 		 * we'll adjust them later. */
 		bus->resource[0]->end = 64*1024 - 1 ;
-		bus->resource[1]->end = PCIBIOS_MIN_MEM+(256*1024*1024)-1;
-		bus->resource[0]->start = PCIBIOS_MIN_IO;
-		bus->resource[1]->start = PCIBIOS_MIN_MEM;
+		bus->resource[1]->end = xPCIBIOS_MIN_MEM+(256*1024*1024)-1;
+		bus->resource[0]->start = xPCIBIOS_MIN_IO;
+		bus->resource[1]->start = xPCIBIOS_MIN_MEM;
 
 		/* Turn off downstream PF memory address range by default */
 		bus->resource[2]->start = 1024*1024;
--- 0006/arch/sh/drivers/pci/pci-sh7751.c
+++ work/arch/sh/drivers/pci/pci-sh7751.c	2008-02-19 15:46:51.000000000 +0900
@@ -146,22 +146,20 @@ int __init sh7751_pcic_init(struct pci_c
 	/* Set the local 16MB PCI memory space window to
 	 * the lowest PCI mapped address
 	 */
-	word = PCIBIOS_MIN_MEM & SH4_PCIMBR_MASK;
+	word = chan->mem_resource->start & SH4_PCIMBR_MASK;
 	pr_debug("PCI: Setting upper bits of Memory window to 0x%x\n", word);
 	pci_write_reg(chan, word , SH4_PCIMBR);
 
-	/* Map IO space into PCI IO window
-	 * The IO window is 64K-PCIBIOS_MIN_IO in size
-	 * IO addresses will be translated to the
-	 * PCI IO window base address
+	/* Map IO space into PCI IO window:
+	 * IO addresses will be translated to the PCI IO window base address
 	 */
 	pr_debug("PCI: Mapping IO address 0x%x - 0x%x to base 0x%x\n",
-		 PCIBIOS_MIN_IO, (64 << 10),
-		 SH7751_PCI_IO_BASE + PCIBIOS_MIN_IO);
+		 chan->io_resource->start, chan->io_resource->end,
+		 SH7751_PCI_IO_BASE + chan->io_resource->start);
 
 	/* Make sure the MSB's of IO window are set to access PCI space
 	 * correctly */
-	word = PCIBIOS_MIN_IO & SH4_PCIIOBR_MASK;
+	word = chan->io_resource->start & SH4_PCIIOBR_MASK;
 	pr_debug("PCI: Setting upper bits of IO window to 0x%x\n", word);
 	pci_write_reg(chan, word, SH4_PCIIOBR);
 
--- 0006/arch/sh/drivers/pci/pci-sh7780.c
+++ work/arch/sh/drivers/pci/pci-sh7780.c	2008-02-19 15:46:51.000000000 +0900
@@ -138,14 +138,12 @@ int __init sh7780_pcic_init(struct pci_c
 	pci_write_reg(chan, 0x00000000, SH4_PCILAR1);
 	pci_write_reg(chan, 0x00000000, SH7780_PCIMBAR1);
 
-	/* Map IO space into PCI IO window
-	 * The IO window is 64K-PCIBIOS_MIN_IO in size
-	 * IO addresses will be translated to the
-	 * PCI IO window base address
+	/* Map IO space into PCI IO window:
+	 * IO addresses will be translated to the PCI IO window base address
 	 */
 	pr_debug("PCI: Mapping IO address 0x%x - 0x%x to base 0x%x\n",
-		 PCIBIOS_MIN_IO, (64 << 10),
-		 SH7780_PCI_IO_BASE + PCIBIOS_MIN_IO);
+		 chan->io_resource->start, chan->io_resource->end,
+		 SH7780_PCI_IO_BASE + chan->io_resource->start);
 
 	/* NOTE: I'm ignoring the PCI error IRQs for now..
 	 * TODO: add support for the internal error interrupts and
