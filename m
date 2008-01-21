From: Katsuya MATSUBARA <matsu@igel.co.jp>
Date: Mon, 21 Jan 2008 03:05:08 +0000
Subject: [PATCH] sh: pci - fix the start address of IO ports area in
Message-Id: <20080121.120508.143310092.matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


sh: pci - fix the start address of IO ports area in RTS7751R2D.

This patch replaces the start address in 'sh7751_io_resource'
in arch/sh/drivers/pci/ops-rts7751r2d.c. The value must be
used for any PCI IO port access such as in*()/out*().

I drew upon the following patch:

[PATCH] [RFC] Support PCI IO access of SH7780 base boards
http://www.spinics.net/lists/linux-sh/msg00006.html

Signed-off-by: Katsuya Matsubara <matsu@igel.co.jp>
---
 ops-rts7751r2d.c |    4 ++--
 pci-sh7751.c     |    9 ---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/sh/drivers/pci/ops-rts7751r2d.c b/arch/sh/drivers/pci/ops-rts7751r2d.c
index ec8430c..692bea4 100644
--- a/arch/sh/drivers/pci/ops-rts7751r2d.c
+++ b/arch/sh/drivers/pci/ops-rts7751r2d.c
@@ -32,8 +32,8 @@ int __init pcibios_map_platform_irq(struct pci_dev *pdev, u8 slot, u8 pin)
 
 static struct resource sh7751_io_resource = {
 	.name	= "SH7751_IO",
-	.start	= 0x4000,
-	.end	= 0x4000 + SH7751_PCI_IO_SIZE - 1,
+	.start	= SH7751_PCI_IO_BASE,
+	.end	= SH7751_PCI_IO_BASE + SH7751_PCI_IO_SIZE - 1,
 	.flags	= IORESOURCE_IO
 };
 
diff --git a/arch/sh/drivers/pci/pci-sh7751.c b/arch/sh/drivers/pci/pci-sh7751.c
index 1aca7fe..cd47dc6 100644
--- a/arch/sh/drivers/pci/pci-sh7751.c
+++ b/arch/sh/drivers/pci/pci-sh7751.c
@@ -147,15 +147,6 @@ int __init sh7751_pcic_init(struct sh4_pci_address_map *map)
 	pr_debug("PCI: Setting upper bits of Memory window to 0x%x\n", word);
 	pci_write_reg(word , SH4_PCIMBR);
 
-	/* Map IO space into PCI IO window
-	 * The IO window is 64K-PCIBIOS_MIN_IO in size
-	 * IO addresses will be translated to the
-	 * PCI IO window base address
-	 */
-	pr_debug("PCI: Mapping IO address 0x%x - 0x%x to base 0x%x\n",
-		 PCIBIOS_MIN_IO, (64 << 10),
-		 SH7751_PCI_IO_BASE + PCIBIOS_MIN_IO);
-
 	/* Make sure the MSB's of IO window are set to access PCI space
 	 * correctly */
 	word = PCIBIOS_MIN_IO & SH4_PCIIOBR_MASK;
