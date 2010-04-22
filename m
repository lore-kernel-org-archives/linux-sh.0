From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Apr 2010 06:21:10 +0000
Subject: [PATCH] sh: sh7751 pci controller io port fix
Message-Id: <20100422062110.11523.24354.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the sh7751 pci code to handle io ports
correctly. The code is based on the sh7788x implementation.

Tested on a R2D-1 board with CONFIG_8139TOO_PIO=y.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/drivers/pci/pci-sh7751.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- 0001/arch/sh/drivers/pci/pci-sh7751.c
+++ work/arch/sh/drivers/pci/pci-sh7751.c	2010-04-22 13:15:00.000000000 +0900
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include "pci-sh4.h"
 #include <asm/addrspace.h>
+#include <asm/sizes.h>
 
 static int __init __area_sdram_check(struct pci_channel *chan,
 				     unsigned int area)
@@ -47,8 +48,8 @@ static int __init __area_sdram_check(str
 static struct resource sh7751_pci_resources[] = {
 	{
 		.name	= "SH7751_IO",
-		.start	= SH7751_PCI_IO_BASE,
-		.end	= SH7751_PCI_IO_BASE + SH7751_PCI_IO_SIZE - 1,
+		.start	= 0x1000,
+		.end	= SZ_4M - 1,
 		.flags	= IORESOURCE_IO
 	}, {
 		.name	= "SH7751_mem",
