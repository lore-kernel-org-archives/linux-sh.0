From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Feb 2008 04:52:43 +0000
Subject: [PATCH] sh: use ctrl_in/out for on chip pci access
Message-Id: <20080214045243.6842.31222.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch makes sure ctrl_inN/outN are used instead of inN/outN for on chip
pci registers. Without this patch addresses may be adjusted using the value
in generic_io_base. This patch makes it possible to set generic_io_base and
have pci without reading and writing all over the place.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Acked-by: Katsuya MATSUBARA <matsu@igel.co.jp>
---

 arch/sh/drivers/pci/fixups-lboxre2.c    |    4 +-
 arch/sh/drivers/pci/fixups-rts7751r2d.c |    4 +-
 arch/sh/drivers/pci/ops-dreamcast.c     |   44 +++++++++++++++----------------
 arch/sh/drivers/pci/pci-sh4.h           |    4 +-
 arch/sh/drivers/pci/pci-sh7751.c        |   16 +++++------
 arch/sh/drivers/pci/pci-sh7780.c        |    2 -
 6 files changed, 37 insertions(+), 37 deletions(-)

--- 0001/arch/sh/drivers/pci/fixups-lboxre2.c
+++ work/arch/sh/drivers/pci/fixups-lboxre2.c	2008-02-13 18:08:22.000000000 +0900
@@ -18,7 +18,7 @@ int pci_fixup_pcic(void)
 {
 	unsigned long bcr1, mcr;
 
-	bcr1 = inl(SH7751_BCR1);
+	bcr1 = ctrl_inl(SH7751_BCR1);
 	bcr1 |= 0x40080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
 	pci_write_reg(bcr1, SH4_PCIBCR1);
 
@@ -28,7 +28,7 @@ int pci_fixup_pcic(void)
 	pci_write_reg(0xfb900047, SH7751_PCICONF1);
 	pci_write_reg(0xab000001, SH7751_PCICONF4);
 
-	mcr = inl(SH7751_MCR);
+	mcr = ctrl_inl(SH7751_MCR);
 	mcr = (mcr & PCIMCR_MRSET_OFF) & PCIMCR_RFSH_OFF;
 	pci_write_reg(mcr, SH4_PCIMCR);
 
--- 0001/arch/sh/drivers/pci/fixups-rts7751r2d.c
+++ work/arch/sh/drivers/pci/fixups-rts7751r2d.c	2008-02-13 18:08:22.000000000 +0900
@@ -19,7 +19,7 @@ int pci_fixup_pcic(void)
 {
 	unsigned long bcr1, mcr;
 
-	bcr1 = inl(SH7751_BCR1);
+	bcr1 = ctrl_inl(SH7751_BCR1);
 	bcr1 |= 0x40080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
 	pci_write_reg(bcr1, SH4_PCIBCR1);
 
@@ -30,7 +30,7 @@ int pci_fixup_pcic(void)
 	pci_write_reg(0xfb900047, SH7751_PCICONF1);
 	pci_write_reg(0xab000001, SH7751_PCICONF4);
 
-	mcr = inl(SH7751_MCR);
+	mcr = ctrl_inl(SH7751_MCR);
 	mcr = (mcr & PCIMCR_MRSET_OFF) & PCIMCR_RFSH_OFF;
 	pci_write_reg(mcr, SH4_PCIMCR);
 
--- 0001/arch/sh/drivers/pci/ops-dreamcast.c
+++ work/arch/sh/drivers/pci/ops-dreamcast.c	2008-02-13 18:14:43.000000000 +0900
@@ -83,9 +83,9 @@ static int gapspci_read(struct pci_bus *
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	switch (size) {
-		case 1: *val = inb(GAPSPCI_BBA_CONFIG+where); break;
-		case 2: *val = inw(GAPSPCI_BBA_CONFIG+where); break;
-		case 4: *val = inl(GAPSPCI_BBA_CONFIG+where); break;
+		case 1: *val = ctrl_inb(GAPSPCI_BBA_CONFIG+where); break;
+		case 2: *val = ctrl_inw(GAPSPCI_BBA_CONFIG+where); break;
+		case 4: *val = ctrl_inl(GAPSPCI_BBA_CONFIG+where); break;
 	}	
 
         return PCIBIOS_SUCCESSFUL;
@@ -97,9 +97,9 @@ static int gapspci_write(struct pci_bus 
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	switch (size) {
-		case 1: outb(( u8)val, GAPSPCI_BBA_CONFIG+where); break;
-		case 2: outw((u16)val, GAPSPCI_BBA_CONFIG+where); break;
-		case 4: outl((u32)val, GAPSPCI_BBA_CONFIG+where); break;
+		case 1: ctrl_outb(( u8)val, GAPSPCI_BBA_CONFIG+where); break;
+		case 2: ctrl_outw((u16)val, GAPSPCI_BBA_CONFIG+where); break;
+		case 4: ctrl_outl((u32)val, GAPSPCI_BBA_CONFIG+where); break;
 	}
 
         return PCIBIOS_SUCCESSFUL;
@@ -127,36 +127,36 @@ int __init gapspci_init(void)
 	 */
 
 	for (i=0; i<16; i++)
-		idbuf[i] = inb(GAPSPCI_REGS+i);
+		idbuf[i] = ctrl_inb(GAPSPCI_REGS+i);
 
 	if (strncmp(idbuf, "GAPSPCI_BRIDGE_2", 16))
 		return -ENODEV;
 
-	outl(0x5a14a501, GAPSPCI_REGS+0x18);
+	ctrl_outl(0x5a14a501, GAPSPCI_REGS+0x18);
 
 	for (i=0; i<1000000; i++)
 		;
 
-	if (inl(GAPSPCI_REGS+0x18) != 1)
+	if (ctrl_inl(GAPSPCI_REGS+0x18) != 1)
 		return -EINVAL;
 
-	outl(0x01000000, GAPSPCI_REGS+0x20);
-	outl(0x01000000, GAPSPCI_REGS+0x24);
+	ctrl_outl(0x01000000, GAPSPCI_REGS+0x20);
+	ctrl_outl(0x01000000, GAPSPCI_REGS+0x24);
 
-	outl(GAPSPCI_DMA_BASE, GAPSPCI_REGS+0x28);
-	outl(GAPSPCI_DMA_BASE+GAPSPCI_DMA_SIZE, GAPSPCI_REGS+0x2c);
+	ctrl_outl(GAPSPCI_DMA_BASE, GAPSPCI_REGS+0x28);
+	ctrl_outl(GAPSPCI_DMA_BASE+GAPSPCI_DMA_SIZE, GAPSPCI_REGS+0x2c);
 
-	outl(1, GAPSPCI_REGS+0x14);
-	outl(1, GAPSPCI_REGS+0x34);
+	ctrl_outl(1, GAPSPCI_REGS+0x14);
+	ctrl_outl(1, GAPSPCI_REGS+0x34);
 
 	/* Setting Broadband Adapter */
-	outw(0xf900, GAPSPCI_BBA_CONFIG+0x06);
-	outl(0x00000000, GAPSPCI_BBA_CONFIG+0x30);
-	outb(0x00, GAPSPCI_BBA_CONFIG+0x3c);
-	outb(0xf0, GAPSPCI_BBA_CONFIG+0x0d);
-	outw(0x0006, GAPSPCI_BBA_CONFIG+0x04);
-	outl(0x00002001, GAPSPCI_BBA_CONFIG+0x10);
-	outl(0x01000000, GAPSPCI_BBA_CONFIG+0x14);
+	ctrl_outw(0xf900, GAPSPCI_BBA_CONFIG+0x06);
+	ctrl_outl(0x00000000, GAPSPCI_BBA_CONFIG+0x30);
+	ctrl_outb(0x00, GAPSPCI_BBA_CONFIG+0x3c);
+	ctrl_outb(0xf0, GAPSPCI_BBA_CONFIG+0x0d);
+	ctrl_outw(0x0006, GAPSPCI_BBA_CONFIG+0x04);
+	ctrl_outl(0x00002001, GAPSPCI_BBA_CONFIG+0x10);
+	ctrl_outl(0x01000000, GAPSPCI_BBA_CONFIG+0x14);
 
 	return 0;
 }
--- 0001/arch/sh/drivers/pci/pci-sh4.h
+++ work/arch/sh/drivers/pci/pci-sh4.h	2008-02-13 18:08:22.000000000 +0900
@@ -172,11 +172,11 @@ struct sh4_pci_address_map {
 
 static inline void pci_write_reg(unsigned long val, unsigned long reg)
 {
-	outl(val, PCI_REG(reg));
+	ctrl_outl(val, PCI_REG(reg));
 }
 
 static inline unsigned long pci_read_reg(unsigned long reg)
 {
-	return inl(PCI_REG(reg));
+	return ctrl_inl(PCI_REG(reg));
 }
 #endif /* __PCI_SH4_H */
--- 0001/arch/sh/drivers/pci/pci-sh7751.c
+++ work/arch/sh/drivers/pci/pci-sh7751.c	2008-02-13 18:14:33.000000000 +0900
@@ -58,7 +58,7 @@ static int __init __area_sdram_check(uns
 {
 	u32 word;
 
-	word = inl(SH7751_BCR1);
+	word = ctrl_inl(SH7751_BCR1);
 	/* check BCR for SDRAM in area */
 	if (((word >> area) & 1) = 0) {
 		printk("PCI: Area %d is not configured for SDRAM. BCR1=0x%x\n",
@@ -67,7 +67,7 @@ static int __init __area_sdram_check(uns
 	}
 	pci_write_reg(word, SH4_PCIBCR1);
 
-	word = (u16)inw(SH7751_BCR2);
+	word = (u16)ctrl_inw(SH7751_BCR2);
 	/* check BCR2 for 32bit SDRAM interface*/
 	if (((word >> (area << 1)) & 0x3) != 0x3) {
 		printk("PCI: Area %d is not 32 bit SDRAM. BCR2=0x%x\n",
@@ -85,9 +85,9 @@ int __init sh7751_pcic_init(struct sh4_p
 	u32 word;
 
 	/* Set the BCR's to enable PCI access */
-	reg = inl(SH7751_BCR1);
+	reg = ctrl_inl(SH7751_BCR1);
 	reg |= 0x80000;
-	outl(reg, SH7751_BCR1);
+	ctrl_outl(reg, SH7751_BCR1);
 
 	/* Turn the clocks back on (not done in reset)*/
 	pci_write_reg(0, SH4_PCICLKR);
@@ -179,13 +179,13 @@ int __init sh7751_pcic_init(struct sh4_p
 		return 0;
 
 	/* configure the wait control registers */
-	word = inl(SH7751_WCR1);
+	word = ctrl_inl(SH7751_WCR1);
 	pci_write_reg(word, SH4_PCIWCR1);
-	word = inl(SH7751_WCR2);
+	word = ctrl_inl(SH7751_WCR2);
 	pci_write_reg(word, SH4_PCIWCR2);
-	word = inl(SH7751_WCR3);
+	word = ctrl_inl(SH7751_WCR3);
 	pci_write_reg(word, SH4_PCIWCR3);
-	word = inl(SH7751_MCR);
+	word = ctrl_inl(SH7751_MCR);
 	pci_write_reg(word, SH4_PCIMCR);
 
 	/* NOTE: I'm ignoring the PCI error IRQs for now..
--- 0001/arch/sh/drivers/pci/pci-sh7780.c
+++ work/arch/sh/drivers/pci/pci-sh7780.c	2008-02-13 18:08:22.000000000 +0900
@@ -52,7 +52,7 @@ static int __init sh7780_pci_init(void)
 
 	pr_debug("PCI: Starting intialization.\n");
 
-	outl(0x00000001, SH7780_PCI_VCR2); /* Enable PCIC */
+	ctrl_outl(0x00000001, SH7780_PCI_VCR2); /* Enable PCIC */
 
 	/* check for SH7780/SH7780R hardware */
 	id = pci_read_reg(SH7780_PCIVID);
