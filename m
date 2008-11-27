From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 27 Nov 2008 09:57:35 +0000
Subject: [PATCH] sh: pci-sh7780: fix pci memory address mask
Message-Id: <492E6F0F.8040400@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix the problem that cannot work a PCI device when system memory size is
256Mbyte in 29bit address mode.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/drivers/pci/pci-sh7780.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7780.c
index b2a2bfa..078dc44 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -123,16 +123,14 @@ int __init sh7780_pcic_init(struct sh4_pci_address_map *map)
 	 * Window0 = map->window0.size @ non-cached area base = SDRAM
 	 * Window1 = map->window1.size @ cached area base = SDRAM
 	 */
-	word = ((map->window0.size - 1) & 0x1ff00001) | 0x01;
-	pci_write_reg(0x07f00001, SH4_PCILSR0);
-	word = ((map->window1.size - 1) & 0x1ff00001) | 0x01;
+	word = (CONFIG_MEMORY_SIZE - 0x00100000) | 0x00000001;
+	pci_write_reg(word, SH4_PCILSR0);
 	pci_write_reg(0x00000001, SH4_PCILSR1);
 	/* Set the values on window 0 PCI config registers */
-	word = P2SEGADDR(map->window0.base);
-	pci_write_reg(0xa8000000, SH4_PCILAR0);
-	pci_write_reg(0x08000000, SH7780_PCIMBAR0);
+	word = (CONFIG_MEMORY_SIZE > 0x08000000) ? 0x10000000 : 0x08000000;
+	pci_write_reg(word | 0xa0000000, SH4_PCILAR0);
+	pci_write_reg(word, SH7780_PCIMBAR0);
 	/* Set the values on window 1 PCI config registers */
-	word = P2SEGADDR(map->window1.base);
 	pci_write_reg(0x00000000, SH4_PCILAR1);
 	pci_write_reg(0x00000000, SH7780_PCIMBAR1);

-- 
1.5.5

