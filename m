From: yoshii.takashi@renesas.com
Date: Thu, 02 Apr 2009 09:03:30 +0000
Subject: [PATCH] sh7785lcr: Map whole address space to PCI
Message-Id: <20090402180330.00319c4f.yoshii.takashi@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

PCI still doesn't work on sh7785lcr 29bit 256M map mode.

On SH7785, PCI -> SHwy address translation is not base+offset but somewhat like
 base|offset (See HW Manual (rej09b0261) Fig. 13.11).
So, you can't export CS2,3,4,5 by 256M at CS2 (results CS0,1,2,3 exported, I guess).
There are two candidates.
a) 128M@CS2 + 128M@CS4
b) 512M@CS0

Attached patch is B. It maps 512M Byte at 0 independently of memory size.
It results CS0 to CS6 and perhaps some more being accessible from PCI.

If A is preferable, you can do like this.
arch/sh/drivers/pci/ops-sh7785lcr.c: 
static struct sh4_pci_address_map sh7785_pci_map = {
        .window0        = {
                .base   = SH7780_CS2_BASE_ADDR,
                .size   = 0x08000000,
        },
#if CONFIG_MEMORY_SIZE > 0x08000000
        .window1        = {
                .base   = SH7780_CS4_BASE_ADDR,
                .size   = 0x08000000,
        },
#endif

If B is acceptable. The system enabling windows per platform itself is useless.
Actually, pci-sh7780.c ignores these parameters, even now.
So, I'm not confident if the code should be like this.
But anyway, I can run 7785lcr 29bit 256M map, with this patch.

Tested on
7785lcr 29bit 128M map
7785lcr 29bit 256M map
(NOT tested on 32bit)

Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>
---
 arch/sh/drivers/pci/ops-sh7785lcr.c |    9 ++-------
 arch/sh/drivers/pci/pci-sh7780.c    |   16 ++++++----------
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/sh/drivers/pci/ops-sh7785lcr.c b/arch/sh/drivers/pci/ops-sh7785lcr.c
index b3bd687..e8b7446 100644
--- a/arch/sh/drivers/pci/ops-sh7785lcr.c
+++ b/arch/sh/drivers/pci/ops-sh7785lcr.c
@@ -48,13 +48,8 @@ EXPORT_SYMBOL(board_pci_channels);
 
 static struct sh4_pci_address_map sh7785_pci_map = {
 	.window0	= {
-		.base	= SH7780_CS2_BASE_ADDR,
-		.size	= 0x04000000,
-	},
-
-	.window1	= {
-		.base	= SH7780_CS3_BASE_ADDR,
-		.size	= 0x04000000,
+		.base	= SH7780_CS0_BASE_ADDR,
+		.size	= 0x20000000,
 	},
 
 	.flags	= SH4_PCIC_NO_RESET,
diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7780.c
index 773d575..bae6a2c 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -120,19 +120,15 @@ int __init sh7780_pcic_init(struct sh4_pci_address_map *map)
 
 	/* Set IO and Mem windows to local address
 	 * Make PCI and local address the same for easy 1 to 1 mapping
-	 * Window0 = map->window0.size @ non-cached area base = SDRAM
-	 * Window1 = map->window1.size @ cached area base = SDRAM
 	 */
-	word = (CONFIG_MEMORY_SIZE - 0x00100000) | 0x00000001;
-	pci_write_reg(word, SH4_PCILSR0);
-	pci_write_reg(0x00000001, SH4_PCILSR1);
+	pci_write_reg(map->window0.size - 0xfffff, SH4_PCILSR0);
+	pci_write_reg(map->window1.size - 0xfffff, SH4_PCILSR1);
 	/* Set the values on window 0 PCI config registers */
-	word = CONFIG_MEMORY_START | (CONFIG_MEMORY_SIZE - 0x01000000);
-	pci_write_reg(word, SH4_PCILAR0);
-	pci_write_reg(word, SH7780_PCIMBAR0);
+	pci_write_reg(map->window0.base, SH4_PCILAR0);
+	pci_write_reg(map->window0.base, SH7780_PCIMBAR0);
 	/* Set the values on window 1 PCI config registers */
-	pci_write_reg(0x00000000, SH4_PCILAR1);
-	pci_write_reg(0x00000000, SH7780_PCIMBAR1);
+	pci_write_reg(map->window1.base, SH4_PCILAR1);
+	pci_write_reg(map->window1.base, SH7780_PCIMBAR1);
 
 	/* Map IO space into PCI IO window
 	 * The IO window is 64K-PCIBIOS_MIN_IO in size
-- 
1.6.0.6

