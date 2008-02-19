From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2008 12:35:04 +0000
Subject: [PATCH 05/09] sh: add reg_base member to pci_channel
Message-Id: <20080219123504.4266.46496.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Store the base address of the pci host controller registers in struct
pci_channel and use the address in pci_read_reg() and pci_write_reg().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/drivers/pci/ops-sh4.c    |    4 ++--
 arch/sh/drivers/pci/pci-sh4.h    |    4 ++--
 arch/sh/drivers/pci/pci-sh7751.c |    2 ++
 arch/sh/drivers/pci/pci-sh7751.h |    1 -
 arch/sh/drivers/pci/pci-sh7780.c |    2 ++
 arch/sh/drivers/pci/pci-sh7780.h |    1 -
 include/asm-sh/pci.h             |    1 +
 7 files changed, 9 insertions(+), 6 deletions(-)

--- 0007/arch/sh/drivers/pci/ops-sh4.c
+++ work/arch/sh/drivers/pci/ops-sh4.c	2008-02-14 16:45:07.000000000 +0900
@@ -121,8 +121,8 @@ int __init sh4_pci_check_direct(struct p
 		if (pci_read_reg(chan, SH4_PCIPAR) = P1SEG) {
 			pci_write_reg(chan, tmp, SH4_PCIPAR);
 			printk(KERN_INFO "PCI: Using configuration type 1\n");
-			request_region(PCI_REG(SH4_PCIPAR), 8, "PCI conf1");
-
+			request_region(chan->reg_base + SH4_PCIPAR, 8,
+				       "PCI conf1");
 			return 0;
 		}
 
--- 0005/arch/sh/drivers/pci/pci-sh4.h
+++ work/arch/sh/drivers/pci/pci-sh4.h	2008-02-14 16:45:55.000000000 +0900
@@ -173,13 +173,13 @@ struct sh4_pci_address_map {
 static inline void pci_write_reg(struct pci_channel *chan,
 				 unsigned long val, unsigned long reg)
 {
-	ctrl_outl(val, PCI_REG(reg));
+	ctrl_outl(val, chan->reg_base + reg);
 }
 
 static inline unsigned long pci_read_reg(struct pci_channel *chan,
 					 unsigned long reg)
 {
-	return ctrl_inl(PCI_REG(reg));
+	return ctrl_inl(chan->reg_base + reg);
 }
 
 #endif /* __PCI_SH4_H */
--- 0006/arch/sh/drivers/pci/pci-sh7751.c
+++ work/arch/sh/drivers/pci/pci-sh7751.c	2008-02-14 16:43:10.000000000 +0900
@@ -39,6 +39,8 @@ int __init sh7751_pci_init(struct pci_ch
 
 	pr_debug("PCI: Starting intialization.\n");
 
+	chan->reg_base = 0xfe200000;
+
 	/* check for SH7751/SH7751R hardware */
 	id = pci_read_reg(chan, SH7751_PCICONF0);
 	if (id != ((SH7751_DEVICE_ID << 16) | SH7751_VENDOR_ID) &&
--- 0006/arch/sh/drivers/pci/pci-sh7751.h
+++ work/arch/sh/drivers/pci/pci-sh7751.h	2008-02-14 16:42:47.000000000 +0900
@@ -26,7 +26,6 @@
 #define SH7751_PCI_IO_SIZE           0x40000     /* Size of IO window */
 
 #define SH7751_PCIREG_BASE           0xFE200000  /* PCI regs base address */
-#define PCI_REG(n)                  (SH7751_PCIREG_BASE+ n)
 
 #define SH7751_PCICONF0            0x0           /* PCI Config Reg 0 */
   #define SH7751_PCICONF0_DEVID      0xFFFF0000  /* Device ID */
--- 0006/arch/sh/drivers/pci/pci-sh7780.c
+++ work/arch/sh/drivers/pci/pci-sh7780.c	2008-02-14 16:43:45.000000000 +0900
@@ -52,6 +52,8 @@ int __init sh7780_pci_init(struct pci_ch
 
 	pr_debug("PCI: Starting intialization.\n");
 
+	chan->reg_base = 0xfe040000;
+
 	ctrl_outl(0x00000001, SH7780_PCI_VCR2); /* Enable PCIC */
 
 	/* check for SH7780/SH7780R hardware */
--- 0006/arch/sh/drivers/pci/pci-sh7780.h
+++ work/arch/sh/drivers/pci/pci-sh7780.h	2008-02-14 16:43:49.000000000 +0900
@@ -35,7 +35,6 @@
 #define SH7780_PCI_IO_SIZE	0x00400000	/* Size of IO window */
 
 #define SH7780_PCIREG_BASE	0xFE040000	/* PCI regs base address */
-#define PCI_REG(n)		(SH7780_PCIREG_BASE+n)
 
 /* SH7780 PCI Config Registers */
 #define SH7780_PCIVID		0x000		/* Vendor ID */
--- 0006/include/asm-sh/pci.h
+++ work/include/asm-sh/pci.h	2008-02-14 16:39:38.000000000 +0900
@@ -24,6 +24,7 @@ struct pci_channel {
 	int first_devfn;
 	int last_devfn;
 	int enabled;
+	unsigned long reg_base;
 };
 
 /*
