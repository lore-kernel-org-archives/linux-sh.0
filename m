From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 07 Jan 2011 02:58:15 +0000
Subject: [PATCH 1/5] sh: pci: Add pci_fixup_pcic to pci of landisk
Message-Id: <1294369335-4064-1-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds a pci setting revision for landisk.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/drivers/pci/fixups-landisk.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/pci/fixups-landisk.c b/arch/sh/drivers/pci/fixups-landisk.c
index bb1a6bb..95c6e2d 100644
--- a/arch/sh/drivers/pci/fixups-landisk.c
+++ b/arch/sh/drivers/pci/fixups-landisk.c
@@ -1,9 +1,10 @@
 /*
- * arch/sh/drivers/pci/ops-landisk.c
+ * arch/sh/drivers/pci/fixups-landisk.c
  *
  * PCI initialization for the I-O DATA Device, Inc. LANDISK board
  *
  * Copyright (C) 2006 kogiidena
+ * Copyright (C) 2010 Nobuhiro Iwamatsu
  *
  * May be copied or modified under the terms of the GNU General Public
  * License.  See linux/COPYING for more information.
@@ -15,6 +16,9 @@
 #include <linux/pci.h>
 #include "pci-sh4.h"
 
+#define PCIMCR_MRSET_OFF	0xBFFFFFFF
+#define PCIMCR_RFSH_OFF		0xFFFFFFFB
+
 int pcibios_map_platform_irq(struct pci_dev *pdev, u8 slot, u8 pin)
 {
 	/*
@@ -26,9 +30,29 @@ int pcibios_map_platform_irq(struct pci_dev *pdev, u8 slot, u8 pin)
 	int irq = ((slot + pin - 1) & 0x3) + 5;
 
 	if ((slot | (pin - 1)) > 0x3) {
-		printk("PCI: Bad IRQ mapping request for slot %d pin %c\n",
+		printk(KERN_WARNING "PCI: Bad IRQ mapping request for slot %d pin %c\n",
 		       slot, pin - 1 + 'A');
 		return -1;
 	}
 	return irq;
 }
+
+int pci_fixup_pcic(struct pci_channel *chan)
+{
+	unsigned long bcr1, mcr;
+
+	bcr1 = __raw_readl(SH7751_BCR1);
+	bcr1 |= 0x40080000;	/* Enable Bit 19 BREQEN, set PCIC to slave */
+	pci_write_reg(chan, bcr1, SH4_PCIBCR1);
+
+	mcr = __raw_readl(SH7751_MCR);
+	mcr = (mcr & PCIMCR_MRSET_OFF) & PCIMCR_RFSH_OFF;
+	pci_write_reg(chan, mcr, SH4_PCIMCR);
+
+	pci_write_reg(chan, 0x0c000000, SH7751_PCICONF5);
+	pci_write_reg(chan, 0xd0000000, SH7751_PCICONF6);
+	pci_write_reg(chan, 0x0c000000, SH4_PCILAR0);
+	pci_write_reg(chan, 0x00000000, SH4_PCILAR1);
+
+	return 0;
+}
-- 
1.7.2.3

