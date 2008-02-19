From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2008 12:34:28 +0000
Subject: [PATCH 01/09] sh: pass along struct pci_channel
Message-Id: <20080219123428.4266.43660.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch makes sure a struct pci_channel pointer is passed along to
various pci functions such as pci_read_reg(), pci_write_reg(),
pci_fixup_pcic(), sh7751_pcic_init() and sh7780_pcic_init().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/drivers/pci/fixups-lboxre2.c    |   23 +++++-----
 arch/sh/drivers/pci/fixups-r7780rp.c    |   33 +++++++--------
 arch/sh/drivers/pci/fixups-rts7751r2d.c |   23 +++++-----
 arch/sh/drivers/pci/fixups-sdk7780.c    |   50 +++++++++++-----------
 arch/sh/drivers/pci/fixups-se7780.c     |   34 ++++++++-------
 arch/sh/drivers/pci/ops-landisk.c       |    2 
 arch/sh/drivers/pci/ops-lboxre2.c       |    2 
 arch/sh/drivers/pci/ops-r7780rp.c       |    2 
 arch/sh/drivers/pci/ops-rts7751r2d.c    |    2 
 arch/sh/drivers/pci/ops-sdk7780.c       |    2 
 arch/sh/drivers/pci/ops-se7780.c        |    2 
 arch/sh/drivers/pci/ops-sh4.c           |   24 +++++-----
 arch/sh/drivers/pci/ops-snapgear.c      |    2 
 arch/sh/drivers/pci/ops-titan.c         |    2 
 arch/sh/drivers/pci/pci-sh4.h           |   11 +++--
 arch/sh/drivers/pci/pci-sh7751.c        |   68 +++++++++++++++----------------
 arch/sh/drivers/pci/pci-sh7751.h        |    3 -
 arch/sh/drivers/pci/pci-sh7780.c        |   31 +++++++-------
 arch/sh/drivers/pci/pci-sh7780.h        |    3 -
 19 files changed, 167 insertions(+), 152 deletions(-)

--- 0002/arch/sh/drivers/pci/fixups-lboxre2.c
+++ work/arch/sh/drivers/pci/fixups-lboxre2.c	2008-02-14 14:41:47.000000000 +0900
@@ -9,33 +9,34 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <linux/pci.h>
 #include "pci-sh4.h"
 
 #define PCIMCR_MRSET_OFF	0xBFFFFFFF
 #define PCIMCR_RFSH_OFF		0xFFFFFFFB
 
-int pci_fixup_pcic(void)
+int pci_fixup_pcic(struct pci_channel *chan)
 {
 	unsigned long bcr1, mcr;
 
 	bcr1 = ctrl_inl(SH7751_BCR1);
 	bcr1 |= 0x40080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
-	pci_write_reg(bcr1, SH4_PCIBCR1);
+	pci_write_reg(chan, bcr1, SH4_PCIBCR1);
 
 	/* Enable all interrupts, so we known what to fix */
-	pci_write_reg(0x0000c3ff, SH4_PCIINTM);
-	pci_write_reg(0x0000380f, SH4_PCIAINTM);
-	pci_write_reg(0xfb900047, SH7751_PCICONF1);
-	pci_write_reg(0xab000001, SH7751_PCICONF4);
+	pci_write_reg(chan, 0x0000c3ff, SH4_PCIINTM);
+	pci_write_reg(chan, 0x0000380f, SH4_PCIAINTM);
+	pci_write_reg(chan, 0xfb900047, SH7751_PCICONF1);
+	pci_write_reg(chan, 0xab000001, SH7751_PCICONF4);
 
 	mcr = ctrl_inl(SH7751_MCR);
 	mcr = (mcr & PCIMCR_MRSET_OFF) & PCIMCR_RFSH_OFF;
-	pci_write_reg(mcr, SH4_PCIMCR);
+	pci_write_reg(chan, mcr, SH4_PCIMCR);
 
-	pci_write_reg(0x0c000000, SH7751_PCICONF5);
-	pci_write_reg(0xd0000000, SH7751_PCICONF6);
-	pci_write_reg(0x0c000000, SH4_PCILAR0);
-	pci_write_reg(0x00000000, SH4_PCILAR1);
+	pci_write_reg(chan, 0x0c000000, SH7751_PCICONF5);
+	pci_write_reg(chan, 0xd0000000, SH7751_PCICONF6);
+	pci_write_reg(chan, 0x0c000000, SH4_PCILAR0);
+	pci_write_reg(chan, 0x00000000, SH4_PCILAR1);
 
 	return 0;
 }
--- 0001/arch/sh/drivers/pci/fixups-r7780rp.c
+++ work/arch/sh/drivers/pci/fixups-r7780rp.c	2008-02-14 14:41:36.000000000 +0900
@@ -14,32 +14,33 @@
 #include "pci-sh4.h"
 #include <asm/io.h>
 
-int pci_fixup_pcic(void)
+int pci_fixup_pcic(struct pci_channel *chan)
 {
-	pci_write_reg(0x000043ff, SH4_PCIINTM);
-	pci_write_reg(0x0000380f, SH4_PCIAINTM);
+	pci_write_reg(chan, 0x000043ff, SH4_PCIINTM);
+	pci_write_reg(chan, 0x0000380f, SH4_PCIAINTM);
 
-	pci_write_reg(0xfbb00047, SH7780_PCICMD);
-	pci_write_reg(0x00000000, SH7780_PCIIBAR);
+	pci_write_reg(chan, 0xfbb00047, SH7780_PCICMD);
+	pci_write_reg(chan, 0x00000000, SH7780_PCIIBAR);
 
-	pci_write_reg(0x00011912, SH7780_PCISVID);
-	pci_write_reg(0x08000000, SH7780_PCICSCR0);
-	pci_write_reg(0x0000001b, SH7780_PCICSAR0);
-	pci_write_reg(0xfd000000, SH7780_PCICSCR1);
-	pci_write_reg(0x0000000f, SH7780_PCICSAR1);
+	pci_write_reg(chan, 0x00011912, SH7780_PCISVID);
+	pci_write_reg(chan, 0x08000000, SH7780_PCICSCR0);
+	pci_write_reg(chan, 0x0000001b, SH7780_PCICSAR0);
+	pci_write_reg(chan, 0xfd000000, SH7780_PCICSCR1);
+	pci_write_reg(chan, 0x0000000f, SH7780_PCICSAR1);
 
-	pci_write_reg(0xfd000000, SH7780_PCIMBR0);
-	pci_write_reg(0x00fc0000, SH7780_PCIMBMR0);
+	pci_write_reg(chan, 0xfd000000, SH7780_PCIMBR0);
+	pci_write_reg(chan, 0x00fc0000, SH7780_PCIMBMR0);
 
 #ifdef CONFIG_32BIT
-	pci_write_reg(0xc0000000, SH7780_PCIMBR2);
-	pci_write_reg(0x20000000 - SH7780_PCI_IO_SIZE, SH7780_PCIMBMR2);
+	pci_write_reg(chan, 0xc0000000, SH7780_PCIMBR2);
+	pci_write_reg(chan, 0x20000000 - SH7780_PCI_IO_SIZE, SH7780_PCIMBMR2);
 #endif
 
 	/* Set IOBR for windows containing area specified in pci.h */
-	pci_write_reg((PCIBIOS_MIN_IO & ~(SH7780_PCI_IO_SIZE - 1)),
+	pci_write_reg(chan, (PCIBIOS_MIN_IO & ~(SH7780_PCI_IO_SIZE - 1)),
 		      SH7780_PCIIOBR);
-	pci_write_reg(((SH7780_PCI_IO_SIZE-1) & (7<<18)), SH7780_PCIIOBMR);
+	pci_write_reg(chan, ((SH7780_PCI_IO_SIZE-1) & (7<<18)),
+		      SH7780_PCIIOBMR);
 
 	return 0;
 }
--- 0002/arch/sh/drivers/pci/fixups-rts7751r2d.c
+++ work/arch/sh/drivers/pci/fixups-rts7751r2d.c	2008-02-14 14:41:53.000000000 +0900
@@ -10,34 +10,35 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <linux/pci.h>
 #include "pci-sh4.h"
 
 #define PCIMCR_MRSET_OFF	0xBFFFFFFF
 #define PCIMCR_RFSH_OFF		0xFFFFFFFB
 
-int pci_fixup_pcic(void)
+int pci_fixup_pcic(struct pci_channel *chan)
 {
 	unsigned long bcr1, mcr;
 
 	bcr1 = ctrl_inl(SH7751_BCR1);
 	bcr1 |= 0x40080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
-	pci_write_reg(bcr1, SH4_PCIBCR1);
+	pci_write_reg(chan, bcr1, SH4_PCIBCR1);
 
 	/* Enable all interrupts, so we known what to fix */
-	pci_write_reg(0x0000c3ff, SH4_PCIINTM);
-	pci_write_reg(0x0000380f, SH4_PCIAINTM);
+	pci_write_reg(chan, 0x0000c3ff, SH4_PCIINTM);
+	pci_write_reg(chan, 0x0000380f, SH4_PCIAINTM);
 
-	pci_write_reg(0xfb900047, SH7751_PCICONF1);
-	pci_write_reg(0xab000001, SH7751_PCICONF4);
+	pci_write_reg(chan, 0xfb900047, SH7751_PCICONF1);
+	pci_write_reg(chan, 0xab000001, SH7751_PCICONF4);
 
 	mcr = ctrl_inl(SH7751_MCR);
 	mcr = (mcr & PCIMCR_MRSET_OFF) & PCIMCR_RFSH_OFF;
-	pci_write_reg(mcr, SH4_PCIMCR);
+	pci_write_reg(chan, mcr, SH4_PCIMCR);
 
-	pci_write_reg(0x0c000000, SH7751_PCICONF5);
-	pci_write_reg(0xd0000000, SH7751_PCICONF6);
-	pci_write_reg(0x0c000000, SH4_PCILAR0);
-	pci_write_reg(0x00000000, SH4_PCILAR1);
+	pci_write_reg(chan, 0x0c000000, SH7751_PCICONF5);
+	pci_write_reg(chan, 0xd0000000, SH7751_PCICONF6);
+	pci_write_reg(chan, 0x0c000000, SH4_PCILAR0);
+	pci_write_reg(chan, 0x00000000, SH4_PCILAR1);
 
 	return 0;
 }
--- 0001/arch/sh/drivers/pci/fixups-sdk7780.c
+++ work/arch/sh/drivers/pci/fixups-sdk7780.c	2008-02-14 14:41:28.000000000 +0900
@@ -14,46 +14,48 @@
 #include "pci-sh4.h"
 #include <asm/io.h>
 
-int pci_fixup_pcic(void)
+int pci_fixup_pcic(struct pci_channel *chan)
 {
 	ctrl_outl(0x00000001, SH7780_PCI_VCR2);
 
 	/* Enable all interrupts, so we know what to fix */
-	pci_write_reg(0x0000C3FF, SH7780_PCIIMR);
-	pci_write_reg(0x0000380F, SH7780_PCIAINTM);
+	pci_write_reg(chan, 0x0000C3FF, SH7780_PCIIMR);
+	pci_write_reg(chan, 0x0000380F, SH7780_PCIAINTM);
 
 	/* Set up standard PCI config registers */
-	pci_write_reg(0xFB00, SH7780_PCISTATUS);
-	pci_write_reg(0x0047, SH7780_PCICMD);
-	pci_write_reg(0x00, SH7780_PCIPIF);
-	pci_write_reg(0x00, SH7780_PCISUB);
-	pci_write_reg(0x06, SH7780_PCIBCC);
-	pci_write_reg(0x1912, SH7780_PCISVID);
-	pci_write_reg(0x0001, SH7780_PCISID);
-
-	pci_write_reg(0x08000000, SH7780_PCIMBAR0);	/* PCI */
-	pci_write_reg(0x08000000, SH7780_PCILAR0);	/* SHwy */
-	pci_write_reg(0x07F00001, SH7780_PCILSR);	/* size 128M w/ MBAR */
-
-	pci_write_reg(0x00000000, SH7780_PCIMBAR1);
-	pci_write_reg(0x00000000, SH7780_PCILAR1);
-	pci_write_reg(0x00000000, SH7780_PCILSR1);
+	pci_write_reg(chan, 0xFB00, SH7780_PCISTATUS);
+	pci_write_reg(chan, 0x0047, SH7780_PCICMD);
+	pci_write_reg(chan, 0x00, SH7780_PCIPIF);
+	pci_write_reg(chan, 0x00, SH7780_PCISUB);
+	pci_write_reg(chan, 0x06, SH7780_PCIBCC);
+	pci_write_reg(chan, 0x1912, SH7780_PCISVID);
+	pci_write_reg(chan, 0x0001, SH7780_PCISID);
+
+	pci_write_reg(chan, 0x08000000, SH7780_PCIMBAR0);	/* PCI */
+	pci_write_reg(chan, 0x08000000, SH7780_PCILAR0);	/* SHwy */
+	pci_write_reg(chan, 0x07F00001, SH7780_PCILSR);	/* size 128M w/ MBAR */
+
+	pci_write_reg(chan, 0x00000000, SH7780_PCIMBAR1);
+	pci_write_reg(chan, 0x00000000, SH7780_PCILAR1);
+	pci_write_reg(chan, 0x00000000, SH7780_PCILSR1);
 
-	pci_write_reg(0xAB000801, SH7780_PCIIBAR);
+	pci_write_reg(chan, 0xAB000801, SH7780_PCIIBAR);
 
 	/*
 	 * Set the MBR so PCI address is one-to-one with window,
 	 * meaning all calls go straight through... use ifdef to
 	 * catch erroneous assumption.
 	 */
-	pci_write_reg(0xFD000000 , SH7780_PCIMBR0);
-	pci_write_reg(0x00FC0000 , SH7780_PCIMBMR0);	/* 16M */
+	pci_write_reg(chan, 0xFD000000 , SH7780_PCIMBR0);
+	pci_write_reg(chan, 0x00FC0000 , SH7780_PCIMBMR0);	/* 16M */
 
 	/* Set IOBR for window containing area specified in pci.h */
-	pci_write_reg(PCIBIOS_MIN_IO & ~(SH7780_PCI_IO_SIZE-1), SH7780_PCIIOBR);
-	pci_write_reg((SH7780_PCI_IO_SIZE-1) & (7 << 18), SH7780_PCIIOBMR);
+	pci_write_reg(chan, PCIBIOS_MIN_IO & ~(SH7780_PCI_IO_SIZE-1),
+		      SH7780_PCIIOBR);
+	pci_write_reg(chan, (SH7780_PCI_IO_SIZE-1) & (7 << 18),
+		      SH7780_PCIIOBMR);
 
-	pci_write_reg(0xA5000C01, SH7780_PCICR);
+	pci_write_reg(chan, 0xA5000C01, SH7780_PCICR);
 
 	return 0;
 }
--- 0001/arch/sh/drivers/pci/fixups-se7780.c
+++ work/arch/sh/drivers/pci/fixups-se7780.c	2008-02-14 14:43:03.000000000 +0900
@@ -15,13 +15,13 @@
 #include "pci-sh4.h"
 #include <asm/io.h>
 
-int pci_fixup_pcic(void)
+int pci_fixup_pcic(struct pci_channel *chan)
 {
 	ctrl_outl(0x00000001, SH7780_PCI_VCR2);
 
 	/* Enable all interrupts, so we know what to fix */
-	pci_write_reg(0x0000C3FF, SH7780_PCIIMR);
-	pci_write_reg(0x0000380F, SH7780_PCIAINTM);
+	pci_write_reg(chan, 0x0000C3FF, SH7780_PCIIMR);
+	pci_write_reg(chan, 0x0000380F, SH7780_PCIAINTM);
 
 	/* Set up standard PCI config registers */
 	ctrl_outw(0xFB00, PCI_REG(SH7780_PCISTATUS));
@@ -32,29 +32,31 @@ int pci_fixup_pcic(void)
 	ctrl_outw(0x1912, PCI_REG(SH7780_PCISVID));
 	ctrl_outw(0x0001, PCI_REG(SH7780_PCISID));
 
-	pci_write_reg(0x08000000, SH7780_PCIMBAR0);     /* PCI */
-	pci_write_reg(0x08000000, SH7780_PCILAR0);     /* SHwy */
-	pci_write_reg(0x07F00001, SH7780_PCILSR);      /* size 128M w/ MBAR */
-
-	pci_write_reg(0x00000000, SH7780_PCIMBAR1);
-	pci_write_reg(0x00000000, SH7780_PCILAR1);
-	pci_write_reg(0x00000000, SH7780_PCILSR1);
+	pci_write_reg(chan, 0x08000000, SH7780_PCIMBAR0);     /* PCI */
+	pci_write_reg(chan, 0x08000000, SH7780_PCILAR0);     /* SHwy */
+	pci_write_reg(chan, 0x07F00001, SH7780_PCILSR); /* size 128M w/ MBAR */
+
+	pci_write_reg(chan, 0x00000000, SH7780_PCIMBAR1);
+	pci_write_reg(chan, 0x00000000, SH7780_PCILAR1);
+	pci_write_reg(chan, 0x00000000, SH7780_PCILSR1);
 
-	pci_write_reg(0xAB000801, SH7780_PCIIBAR);
+	pci_write_reg(chan, 0xAB000801, SH7780_PCIIBAR);
 
 	/*
 	 * Set the MBR so PCI address is one-to-one with window,
 	 * meaning all calls go straight through... use ifdef to
 	 * catch erroneous assumption.
 	 */
-	pci_write_reg(0xFD000000 , SH7780_PCIMBR0);
-	pci_write_reg(0x00FC0000 , SH7780_PCIMBMR0);    /* 16M */
+	pci_write_reg(chan, 0xFD000000 , SH7780_PCIMBR0);
+	pci_write_reg(chan, 0x00FC0000 , SH7780_PCIMBMR0);    /* 16M */
 
 	/* Set IOBR for window containing area specified in pci.h */
-	pci_write_reg(PCIBIOS_MIN_IO & ~(SH7780_PCI_IO_SIZE-1), SH7780_PCIIOBR);
-	pci_write_reg((SH7780_PCI_IO_SIZE-1) & (7 << 18), SH7780_PCIIOBMR);
+	pci_write_reg(chan, PCIBIOS_MIN_IO & ~(SH7780_PCI_IO_SIZE-1),
+		      SH7780_PCIIOBR);
+	pci_write_reg(chan, (SH7780_PCI_IO_SIZE-1) & (7 << 18),
+		      SH7780_PCIIOBMR);
 
-	pci_write_reg(0xA5000C01, SH7780_PCICR);
+	pci_write_reg(chan, 0xA5000C01, SH7780_PCICR);
 
 	return 0;
 }
--- 0001/arch/sh/drivers/pci/ops-landisk.c
+++ work/arch/sh/drivers/pci/ops-landisk.c	2008-02-14 14:31:39.000000000 +0900
@@ -45,7 +45,7 @@ static struct sh4_pci_address_map sh7751
 
 int __init pcibios_init_platform(void)
 {
-	return sh7751_pcic_init(&sh7751_pci_map);
+	return sh7751_pcic_init(&board_pci_channels[0], &sh7751_pci_map);
 }
 
 int pcibios_map_platform_irq(struct pci_dev *pdev, u8 slot, u8 pin)
--- 0001/arch/sh/drivers/pci/ops-lboxre2.c
+++ work/arch/sh/drivers/pci/ops-lboxre2.c	2008-02-14 14:32:48.000000000 +0900
@@ -59,5 +59,5 @@ static struct sh4_pci_address_map sh7751
 
 int __init pcibios_init_platform(void)
 {
-	return sh7751_pcic_init(&sh7751_pci_map);
+	return sh7751_pcic_init(&board_pci_channels[0], &sh7751_pci_map);
 }
--- 0001/arch/sh/drivers/pci/ops-r7780rp.c
+++ work/arch/sh/drivers/pci/ops-r7780rp.c	2008-02-14 14:48:06.000000000 +0900
@@ -64,5 +64,5 @@ static struct sh4_pci_address_map sh7780
 
 int __init pcibios_init_platform(void)
 {
-	return sh7780_pcic_init(&sh7780_pci_map);
+	return sh7780_pcic_init(&board_pci_channels[0], &sh7780_pci_map);
 }
--- 0004/arch/sh/drivers/pci/ops-rts7751r2d.c
+++ work/arch/sh/drivers/pci/ops-rts7751r2d.c	2008-02-14 14:28:30.000000000 +0900
@@ -69,6 +69,6 @@ static struct sh4_pci_address_map sh7751
 int __init pcibios_init_platform(void)
 {
 	__set_io_port_base(SH7751_PCI_IO_BASE);
-	return sh7751_pcic_init(&sh7751_pci_map);
+	return sh7751_pcic_init(&board_pci_channels[0], &sh7751_pci_map);
 }
 
--- 0001/arch/sh/drivers/pci/ops-sdk7780.c
+++ work/arch/sh/drivers/pci/ops-sdk7780.c	2008-02-14 14:48:29.000000000 +0900
@@ -69,5 +69,5 @@ static struct sh4_pci_address_map sdk778
 int __init pcibios_init_platform(void)
 {
 	printk(KERN_INFO "SH7780 PCI: Finished initializing PCI controller\n");
-	return sh7780_pcic_init(&sdk7780_pci_map);
+	return sh7780_pcic_init(&board_pci_channels[0], &sdk7780_pci_map);
 }
--- 0001/arch/sh/drivers/pci/ops-se7780.c
+++ work/arch/sh/drivers/pci/ops-se7780.c	2008-02-14 14:48:55.000000000 +0900
@@ -92,5 +92,5 @@ int __init pcibios_init_platform(void)
 	ctrl_outw(0x0013, FPGA_PCI_INTSEL1);
 	ctrl_outw(0xE402, FPGA_PCI_INTSEL2);
 
-	return sh7780_pcic_init(&se7780_pci_map);
+	return sh7780_pcic_init(&board_pci_channels[0], &se7780_pci_map);
 }
--- 0001/arch/sh/drivers/pci/ops-sh4.c
+++ work/arch/sh/drivers/pci/ops-sh4.c	2008-02-14 15:31:21.000000000 +0900
@@ -34,8 +34,8 @@ static int sh4_pci_read(struct pci_bus *
 	 * so we must do byte alignment by hand
 	 */
 	spin_lock_irqsave(&sh4_pci_lock, flags);
-	pci_write_reg(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
-	data = pci_read_reg(SH4_PCIPDR);
+	pci_write_reg(NULL, CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	data = pci_read_reg(NULL, SH4_PCIPDR);
 	spin_unlock_irqrestore(&sh4_pci_lock, flags);
 
 	switch (size) {
@@ -68,8 +68,8 @@ static int sh4_pci_write(struct pci_bus 
 	u32 data;
 
 	spin_lock_irqsave(&sh4_pci_lock, flags);
-	pci_write_reg(CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
-	data = pci_read_reg(SH4_PCIPDR);
+	pci_write_reg(NULL, CONFIG_CMD(bus, devfn, where), SH4_PCIPAR);
+	data = pci_read_reg(NULL, SH4_PCIPDR);
 	spin_unlock_irqrestore(&sh4_pci_lock, flags);
 
 	switch (size) {
@@ -90,7 +90,7 @@ static int sh4_pci_write(struct pci_bus 
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
 
-	pci_write_reg(data, SH4_PCIPDR);
+	pci_write_reg(NULL, data, SH4_PCIPDR);
 
 	return PCIBIOS_SUCCESSFUL;
 }
@@ -106,25 +106,25 @@ struct pci_ops sh4_pci_ops = {
  */
 static unsigned int pci_probe = PCI_PROBE_CONF1;
 
-int __init sh4_pci_check_direct(void)
+int __init sh4_pci_check_direct(struct pci_channel *chan)
 {
 	/*
 	 * Check if configuration works.
 	 */
 	if (pci_probe & PCI_PROBE_CONF1) {
-		unsigned int tmp = pci_read_reg(SH4_PCIPAR);
+		unsigned int tmp = pci_read_reg(chan, SH4_PCIPAR);
 
-		pci_write_reg(P1SEG, SH4_PCIPAR);
+		pci_write_reg(chan, P1SEG, SH4_PCIPAR);
 
-		if (pci_read_reg(SH4_PCIPAR) = P1SEG) {
-			pci_write_reg(tmp, SH4_PCIPAR);
+		if (pci_read_reg(chan, SH4_PCIPAR) = P1SEG) {
+			pci_write_reg(chan, tmp, SH4_PCIPAR);
 			printk(KERN_INFO "PCI: Using configuration type 1\n");
 			request_region(PCI_REG(SH4_PCIPAR), 8, "PCI conf1");
 
 			return 0;
 		}
 
-		pci_write_reg(tmp, SH4_PCIPAR);
+		pci_write_reg(chan, tmp, SH4_PCIPAR);
 	}
 
 	pr_debug("PCI: pci_check_direct failed\n");
@@ -163,7 +163,7 @@ char * __devinit pcibios_setup(char *str
 	return str;
 }
 
-int __attribute__((weak)) pci_fixup_pcic(void)
+int __attribute__((weak)) pci_fixup_pcic(struct pci_channel *chan)
 {
 	/* Nothing to do. */
 	return 0;
--- 0001/arch/sh/drivers/pci/ops-snapgear.c
+++ work/arch/sh/drivers/pci/ops-snapgear.c	2008-02-14 14:32:41.000000000 +0900
@@ -66,7 +66,7 @@ static struct sh4_pci_address_map sh7751
  */
 int __init pcibios_init_platform(void)
 {
-	return sh7751_pcic_init(&sh7751_pci_map);
+	return sh7751_pcic_init(&board_pci_channels[0], &sh7751_pci_map);
 }
 
 int __init pcibios_map_platform_irq(struct pci_dev *pdev, u8 slot, u8 pin)
--- 0001/arch/sh/drivers/pci/ops-titan.c
+++ work/arch/sh/drivers/pci/ops-titan.c	2008-02-14 14:34:42.000000000 +0900
@@ -73,5 +73,5 @@ static struct sh4_pci_address_map sh7751
 
 int __init pcibios_init_platform(void)
 {
-	return sh7751_pcic_init(&sh7751_pci_map);
+	return sh7751_pcic_init(&board_pci_channels[0], &sh7751_pci_map);
 }
--- 0002/arch/sh/drivers/pci/pci-sh4.h
+++ work/arch/sh/drivers/pci/pci-sh4.h	2008-02-14 14:53:37.000000000 +0900
@@ -156,8 +156,8 @@
 
 /* arch/sh/kernel/drivers/pci/ops-sh4.c */
 extern struct pci_ops sh4_pci_ops;
-int sh4_pci_check_direct(void);
-int pci_fixup_pcic(void);
+int sh4_pci_check_direct(struct pci_channel *chan);
+int pci_fixup_pcic(struct pci_channel *chan);
 
 struct sh4_pci_address_space {
 	unsigned long base;
@@ -170,13 +170,16 @@ struct sh4_pci_address_map {
 	unsigned long flags;
 };
 
-static inline void pci_write_reg(unsigned long val, unsigned long reg)
+static inline void pci_write_reg(struct pci_channel *chan,
+				 unsigned long val, unsigned long reg)
 {
 	ctrl_outl(val, PCI_REG(reg));
 }
 
-static inline unsigned long pci_read_reg(unsigned long reg)
+static inline unsigned long pci_read_reg(struct pci_channel *chan,
+					 unsigned long reg)
 {
 	return ctrl_inl(PCI_REG(reg));
 }
+
 #endif /* __PCI_SH4_H */
--- 0002/arch/sh/drivers/pci/pci-sh7751.c
+++ work/arch/sh/drivers/pci/pci-sh7751.c	2008-02-14 15:39:56.000000000 +0900
@@ -40,21 +40,22 @@ static int __init sh7751_pci_init(void)
 	pr_debug("PCI: Starting intialization.\n");
 
 	/* check for SH7751/SH7751R hardware */
-	id = pci_read_reg(SH7751_PCICONF0);
+	id = pci_read_reg(NULL, SH7751_PCICONF0);
 	if (id != ((SH7751_DEVICE_ID << 16) | SH7751_VENDOR_ID) &&
 	    id != ((SH7751R_DEVICE_ID << 16) | SH7751_VENDOR_ID)) {
 		pr_debug("PCI: This is not an SH7751(R) (%x)\n", id);
 		return -ENODEV;
 	}
 
-	if ((ret = sh4_pci_check_direct()) != 0)
+	if ((ret = sh4_pci_check_direct(NULL)) != 0)
 		return ret;
 
 	return pcibios_init_platform();
 }
 subsys_initcall(sh7751_pci_init);
 
-static int __init __area_sdram_check(unsigned int area)
+static int __init __area_sdram_check(struct pci_channel *chan,
+				     unsigned int area)
 {
 	u32 word;
 
@@ -65,7 +66,7 @@ static int __init __area_sdram_check(uns
 		       area, word);
 		return 0;
 	}
-	pci_write_reg(word, SH4_PCIBCR1);
+	pci_write_reg(chan, word, SH4_PCIBCR1);
 
 	word = (u16)ctrl_inw(SH7751_BCR2);
 	/* check BCR2 for 32bit SDRAM interface*/
@@ -74,12 +75,13 @@ static int __init __area_sdram_check(uns
 		       area, word);
 		return 0;
 	}
-	pci_write_reg(word, SH4_PCIBCR2);
+	pci_write_reg(chan, word, SH4_PCIBCR2);
 
 	return 1;
 }
 
-int __init sh7751_pcic_init(struct sh4_pci_address_map *map)
+int __init sh7751_pcic_init(struct pci_channel *chan,
+			    struct sh4_pci_address_map *map)
 {
 	u32 reg;
 	u32 word;
@@ -90,10 +92,10 @@ int __init sh7751_pcic_init(struct sh4_p
 	ctrl_outl(reg, SH7751_BCR1);
 
 	/* Turn the clocks back on (not done in reset)*/
-	pci_write_reg(0, SH4_PCICLKR);
+	pci_write_reg(chan, 0, SH4_PCICLKR);
 	/* Clear Powerdown IRQ's (not done in reset) */
 	word = SH4_PCIPINT_D3 | SH4_PCIPINT_D0;
-	pci_write_reg(word, SH4_PCIPINT);
+	pci_write_reg(chan, word, SH4_PCIPINT);
 
 	/*
 	 * This code is unused for some boards as it is done in the
@@ -103,11 +105,11 @@ int __init sh7751_pcic_init(struct sh4_p
 	if (!(map->flags & SH4_PCIC_NO_RESET)) {
 		/* toggle PCI reset pin */
 		word = SH4_PCICR_PREFIX | SH4_PCICR_PRST;
-		pci_write_reg(word, SH4_PCICR);
+		pci_write_reg(chan, word, SH4_PCICR);
 		/* Wait for a long time... not 1 sec. but long enough */
 		mdelay(100);
 		word = SH4_PCICR_PREFIX;
-		pci_write_reg(word, SH4_PCICR);
+		pci_write_reg(chan, word, SH4_PCICR);
 	}
 
 	/* set the command/status bits to:
@@ -116,11 +118,11 @@ int __init sh7751_pcic_init(struct sh4_p
 	 */
 	word = SH7751_PCICONF1_WCC | SH7751_PCICONF1_PER |
 	       SH7751_PCICONF1_BUM | SH7751_PCICONF1_MES;
-	pci_write_reg(word, SH7751_PCICONF1);
+	pci_write_reg(chan, word, SH7751_PCICONF1);
 
 	/* define this host as the host bridge */
 	word = PCI_BASE_CLASS_BRIDGE << 24;
-	pci_write_reg(word, SH7751_PCICONF2);
+	pci_write_reg(chan, word, SH7751_PCICONF2);
 
 	/* Set IO and Mem windows to local address
 	 * Make PCI and local address the same for easy 1 to 1 mapping
@@ -128,24 +130,24 @@ int __init sh7751_pcic_init(struct sh4_p
 	 * Window1 = map->window1.size @ cached area base = SDRAM
 	 */
 	word = map->window0.size - 1;
-	pci_write_reg(word, SH4_PCILSR0);
+	pci_write_reg(chan, word, SH4_PCILSR0);
 	word = map->window1.size - 1;
-	pci_write_reg(word, SH4_PCILSR1);
+	pci_write_reg(chan, word, SH4_PCILSR1);
 	/* Set the values on window 0 PCI config registers */
 	word = P2SEGADDR(map->window0.base);
-	pci_write_reg(word, SH4_PCILAR0);
-	pci_write_reg(word, SH7751_PCICONF5);
+	pci_write_reg(chan, word, SH4_PCILAR0);
+	pci_write_reg(chan, word, SH7751_PCICONF5);
 	/* Set the values on window 1 PCI config registers */
 	word =  PHYSADDR(map->window1.base);
-	pci_write_reg(word, SH4_PCILAR1);
-	pci_write_reg(word, SH7751_PCICONF6);
+	pci_write_reg(chan, word, SH4_PCILAR1);
+	pci_write_reg(chan, word, SH7751_PCICONF6);
 
 	/* Set the local 16MB PCI memory space window to
 	 * the lowest PCI mapped address
 	 */
 	word = PCIBIOS_MIN_MEM & SH4_PCIMBR_MASK;
 	pr_debug("PCI: Setting upper bits of Memory window to 0x%x\n", word);
-	pci_write_reg(word , SH4_PCIMBR);
+	pci_write_reg(chan, word , SH4_PCIMBR);
 
 	/* Map IO space into PCI IO window
 	 * The IO window is 64K-PCIBIOS_MIN_IO in size
@@ -160,19 +162,19 @@ int __init sh7751_pcic_init(struct sh4_p
 	 * correctly */
 	word = PCIBIOS_MIN_IO & SH4_PCIIOBR_MASK;
 	pr_debug("PCI: Setting upper bits of IO window to 0x%x\n", word);
-	pci_write_reg(word, SH4_PCIIOBR);
+	pci_write_reg(chan, word, SH4_PCIIOBR);
 
 	/* Set PCI WCRx, BCRx's, copy from BSC locations */
 
 	/* check BCR for SDRAM in specified area */
 	switch (map->window0.base) {
-	case SH7751_CS0_BASE_ADDR: word = __area_sdram_check(0); break;
-	case SH7751_CS1_BASE_ADDR: word = __area_sdram_check(1); break;
-	case SH7751_CS2_BASE_ADDR: word = __area_sdram_check(2); break;
-	case SH7751_CS3_BASE_ADDR: word = __area_sdram_check(3); break;
-	case SH7751_CS4_BASE_ADDR: word = __area_sdram_check(4); break;
-	case SH7751_CS5_BASE_ADDR: word = __area_sdram_check(5); break;
-	case SH7751_CS6_BASE_ADDR: word = __area_sdram_check(6); break;
+	case SH7751_CS0_BASE_ADDR: word = __area_sdram_check(chan, 0); break;
+	case SH7751_CS1_BASE_ADDR: word = __area_sdram_check(chan, 1); break;
+	case SH7751_CS2_BASE_ADDR: word = __area_sdram_check(chan, 2); break;
+	case SH7751_CS3_BASE_ADDR: word = __area_sdram_check(chan, 3); break;
+	case SH7751_CS4_BASE_ADDR: word = __area_sdram_check(chan, 4); break;
+	case SH7751_CS5_BASE_ADDR: word = __area_sdram_check(chan, 5); break;
+	case SH7751_CS6_BASE_ADDR: word = __area_sdram_check(chan, 6); break;
 	}
 
 	if (!word)
@@ -180,25 +182,25 @@ int __init sh7751_pcic_init(struct sh4_p
 
 	/* configure the wait control registers */
 	word = ctrl_inl(SH7751_WCR1);
-	pci_write_reg(word, SH4_PCIWCR1);
+	pci_write_reg(chan, word, SH4_PCIWCR1);
 	word = ctrl_inl(SH7751_WCR2);
-	pci_write_reg(word, SH4_PCIWCR2);
+	pci_write_reg(chan, word, SH4_PCIWCR2);
 	word = ctrl_inl(SH7751_WCR3);
-	pci_write_reg(word, SH4_PCIWCR3);
+	pci_write_reg(chan, word, SH4_PCIWCR3);
 	word = ctrl_inl(SH7751_MCR);
-	pci_write_reg(word, SH4_PCIMCR);
+	pci_write_reg(chan, word, SH4_PCIMCR);
 
 	/* NOTE: I'm ignoring the PCI error IRQs for now..
 	 * TODO: add support for the internal error interrupts and
 	 * DMA interrupts...
 	 */
 
-	pci_fixup_pcic();
+	pci_fixup_pcic(chan);
 
 	/* SH7751 init done, set central function init complete */
 	/* use round robin mode to stop a device starving/overruning */
 	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_ARBM;
-	pci_write_reg(word, SH4_PCICR);
+	pci_write_reg(chan, word, SH4_PCICR);
 
 	return 1;
 }
--- 0001/arch/sh/drivers/pci/pci-sh7751.h
+++ work/arch/sh/drivers/pci/pci-sh7751.h	2008-02-14 14:31:06.000000000 +0900
@@ -130,6 +130,7 @@
 struct sh4_pci_address_map;
 
 /* arch/sh/drivers/pci/pci-sh7751.c */
-int sh7751_pcic_init(struct sh4_pci_address_map *map);
+int sh7751_pcic_init(struct pci_channel *chan,
+		     struct sh4_pci_address_map *map);
 
 #endif /* _PCI_SH7751_H_ */
--- 0002/arch/sh/drivers/pci/pci-sh7780.c
+++ work/arch/sh/drivers/pci/pci-sh7780.c	2008-02-14 14:56:46.000000000 +0900
@@ -55,7 +55,7 @@ static int __init sh7780_pci_init(void)
 	ctrl_outl(0x00000001, SH7780_PCI_VCR2); /* Enable PCIC */
 
 	/* check for SH7780/SH7780R hardware */
-	id = pci_read_reg(SH7780_PCIVID);
+	id = pci_read_reg(NULL, SH7780_PCIVID);
 	if ((id & 0xffff) = SH7780_VENDOR_ID) {
 		switch ((id >> 16) & 0xffff) {
 		case SH7763_DEVICE_ID:
@@ -82,14 +82,15 @@ static int __init sh7780_pci_init(void)
 		ctrl_outl(0x33333333, INTC_INTPRI);
 	}
 
-	if ((ret = sh4_pci_check_direct()) != 0)
+	if ((ret = sh4_pci_check_direct(NULL)) != 0)
 		return ret;
 
 	return pcibios_init_platform();
 }
 core_initcall(sh7780_pci_init);
 
-int __init sh7780_pcic_init(struct sh4_pci_address_map *map)
+int __init sh7780_pcic_init(struct pci_channel *chan,
+			    struct sh4_pci_address_map *map)
 {
 	u32 word;
 
@@ -101,22 +102,22 @@ int __init sh7780_pcic_init(struct sh4_p
 	if (!(map->flags & SH4_PCIC_NO_RESET)) {
 		/* toggle PCI reset pin */
 		word = SH4_PCICR_PREFIX | SH4_PCICR_PRST;
-		pci_write_reg(word, SH4_PCICR);
+		pci_write_reg(chan, word, SH4_PCICR);
 		/* Wait for a long time... not 1 sec. but long enough */
 		mdelay(100);
 		word = SH4_PCICR_PREFIX;
-		pci_write_reg(word, SH4_PCICR);
+		pci_write_reg(chan, word, SH4_PCICR);
 	}
 
 	/* set the command/status bits to:
 	 * Wait Cycle Control + Parity Enable + Bus Master +
 	 * Mem space enable
 	 */
-	pci_write_reg(0x00000046, SH7780_PCICMD);
+	pci_write_reg(chan, 0x00000046, SH7780_PCICMD);
 
 	/* define this host as the host bridge */
 	word = PCI_BASE_CLASS_BRIDGE << 24;
-	pci_write_reg(word, SH7780_PCIRID);
+	pci_write_reg(chan, word, SH7780_PCIRID);
 
 	/* Set IO and Mem windows to local address
 	 * Make PCI and local address the same for easy 1 to 1 mapping
@@ -124,17 +125,17 @@ int __init sh7780_pcic_init(struct sh4_p
 	 * Window1 = map->window1.size @ cached area base = SDRAM
 	 */
 	word = ((map->window0.size - 1) & 0x1ff00001) | 0x01;
-	pci_write_reg(0x07f00001, SH4_PCILSR0);
+	pci_write_reg(chan, 0x07f00001, SH4_PCILSR0);
 	word = ((map->window1.size - 1) & 0x1ff00001) | 0x01;
-	pci_write_reg(0x00000001, SH4_PCILSR1);
+	pci_write_reg(chan, 0x00000001, SH4_PCILSR1);
 	/* Set the values on window 0 PCI config registers */
 	word = P2SEGADDR(map->window0.base);
-	pci_write_reg(0xa8000000, SH4_PCILAR0);
-	pci_write_reg(0x08000000, SH7780_PCIMBAR0);
+	pci_write_reg(chan, 0xa8000000, SH4_PCILAR0);
+	pci_write_reg(chan, 0x08000000, SH7780_PCIMBAR0);
 	/* Set the values on window 1 PCI config registers */
 	word = P2SEGADDR(map->window1.base);
-	pci_write_reg(0x00000000, SH4_PCILAR1);
-	pci_write_reg(0x00000000, SH7780_PCIMBAR1);
+	pci_write_reg(chan, 0x00000000, SH4_PCILAR1);
+	pci_write_reg(chan, 0x00000000, SH7780_PCIMBAR1);
 
 	/* Map IO space into PCI IO window
 	 * The IO window is 64K-PCIBIOS_MIN_IO in size
@@ -151,12 +152,12 @@ int __init sh7780_pcic_init(struct sh4_p
 	 */
 
 	/* Apply any last-minute PCIC fixups */
-	pci_fixup_pcic();
+	pci_fixup_pcic(chan);
 
 	/* SH7780 init done, set central function init complete */
 	/* use round robin mode to stop a device starving/overruning */
 	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_FTO;
-	pci_write_reg(word, SH4_PCICR);
+	pci_write_reg(chan, word, SH4_PCICR);
 
 	return 1;
 }
--- 0001/arch/sh/drivers/pci/pci-sh7780.h
+++ work/arch/sh/drivers/pci/pci-sh7780.h	2008-02-14 14:47:50.000000000 +0900
@@ -107,6 +107,7 @@
 struct sh4_pci_address_map;
 
 /* arch/sh/drivers/pci/pci-sh7780.c */
-int sh7780_pcic_init(struct sh4_pci_address_map *map);
+int sh7780_pcic_init(struct pci_channel *chan,
+		     struct sh4_pci_address_map *map);
 
 #endif /* _PCI_SH7780_H_ */
