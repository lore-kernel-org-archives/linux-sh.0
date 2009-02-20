From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Fri, 20 Feb 2009 10:32:14 +0000
Subject: [PATCH 3/3] sh: pci-sh7780: fix pci memory address for fixed PMB
Message-Id: <499E86AE.6070209@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix the problem that cannot work a PCI device when 32-bit physical
address mode.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 I changed this driver before. I think that I must revise it so
 that a hardcoding...

 arch/sh/drivers/pci/pci-sh7780.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7780.c
index 078dc44..773d575 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -127,8 +127,8 @@ int __init sh7780_pcic_init(struct sh4_pci_address_map *map)
 	pci_write_reg(word, SH4_PCILSR0);
 	pci_write_reg(0x00000001, SH4_PCILSR1);
 	/* Set the values on window 0 PCI config registers */
-	word = (CONFIG_MEMORY_SIZE > 0x08000000) ? 0x10000000 : 0x08000000;
-	pci_write_reg(word | 0xa0000000, SH4_PCILAR0);
+	word = CONFIG_MEMORY_START | (CONFIG_MEMORY_SIZE - 0x01000000);
+	pci_write_reg(word, SH4_PCILAR0);
 	pci_write_reg(word, SH7780_PCIMBAR0);
 	/* Set the values on window 1 PCI config registers */
 	pci_write_reg(0x00000000, SH4_PCILAR1);
-- 
1.5.5

