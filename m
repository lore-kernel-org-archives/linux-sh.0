From: Thomas Schwinge <thomas@codesourcery.com>
Date: Fri, 09 Mar 2012 16:38:52 +0000
Subject: [PATCH 6/7] SH: pci-sh7780: enable big-endian operation.
Message-Id: <1331311133-26937-6-git-send-email-thomas@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If in big-endian mode, switch the PCI bus, too.

Tested on both litte-endian and big-endian sh7785lcr.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/drivers/pci/pci-sh7780.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7780.c
index fa7b978..d87aac6 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -21,6 +21,13 @@
 #include <asm/mmu.h>
 #include <asm/sizes.h>
 
+#if defined(CONFIG_CPU_BIG_ENDIAN)
+# define PCICR_ENDIANNESS SH4_PCICR_BSWP
+#else
+# define PCICR_ENDIANNESS 0
+#endif
+
+
 static struct resource sh7785_pci_resources[] = {
 	{
 		.name	= "PCI IO",
@@ -254,7 +261,7 @@ static int __init sh7780_pci_init(void)
 	__raw_writel(PCIECR_ENBL, PCIECR);
 
 	/* Reset */
-	__raw_writel(SH4_PCICR_PREFIX | SH4_PCICR_PRST,
+	__raw_writel(SH4_PCICR_PREFIX | SH4_PCICR_PRST | PCICR_ENDIANNESS,
 		     chan->reg_base + SH4_PCICR);
 
 	/*
@@ -290,7 +297,8 @@ static int __init sh7780_pci_init(void)
 	 * Now throw it in to register initialization mode and
 	 * start the real work.
 	 */
-	__raw_writel(SH4_PCICR_PREFIX, chan->reg_base + SH4_PCICR);
+	__raw_writel(SH4_PCICR_PREFIX | PCICR_ENDIANNESS,
+		     chan->reg_base + SH4_PCICR);
 
 	memphys = __pa(memory_start);
 	memsize = roundup_pow_of_two(memory_end - memory_start);
@@ -380,7 +388,8 @@ static int __init sh7780_pci_init(void)
 	 * Initialization mode complete, release the control register and
 	 * enable round robin mode to stop device overruns/starvation.
 	 */
-	__raw_writel(SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_FTO,
+	__raw_writel(SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_FTO |
+		     PCICR_ENDIANNESS,
 		     chan->reg_base + SH4_PCICR);
 
 	ret = register_pci_controller(chan);
-- 
1.7.4.1

