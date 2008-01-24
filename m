From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Jan 2008 09:40:50 +0000
Subject: [PATCH] sh: use declared coherent memory for dreamcast pci ethernet adapter
Message-Id: <20080124094050.25814.40528.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: use declared coherent memory for dreamcast pci ethernet adapter

This patch makes the dreamcast use the recently added declared coherent
memory functions to point out the memory window suitable for dma.

Apart from cleaning up, this gives the dreamcast a proper memory allocator
for pci dma memory.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/dreamcast/setup.c       |    8 ---
 arch/sh/drivers/pci/Makefile           |    3 -
 arch/sh/drivers/pci/dma-dreamcast.c    |   70 --------------------------------
 arch/sh/drivers/pci/fixups-dreamcast.c |   10 ++++
 4 files changed, 11 insertions(+), 80 deletions(-)

--- 0001/arch/sh/boards/dreamcast/setup.c
+++ work/arch/sh/boards/dreamcast/setup.c	2008-01-24 16:56:51.000000000 +0900
@@ -33,9 +33,6 @@ extern void aica_time_init(void);
 extern int gapspci_init(void);
 extern int systemasic_irq_demux(int);
 
-void *dreamcast_consistent_alloc(struct device *, size_t, dma_addr_t *, gfp_t);
-int dreamcast_consistent_free(struct device *, size_t, void *, dma_addr_t);
-
 static void __init dreamcast_setup(char **cmdline_p)
 {
 	int i;
@@ -64,9 +61,4 @@ static struct sh_machine_vector mv_dream
 	.mv_name		= "Sega Dreamcast",
 	.mv_setup		= dreamcast_setup,
 	.mv_irq_demux		= systemasic_irq_demux,
-
-#ifdef CONFIG_PCI
-	.mv_consistent_alloc	= dreamcast_consistent_alloc,
-	.mv_consistent_free	= dreamcast_consistent_free,
-#endif
 };
--- 0001/arch/sh/drivers/pci/Makefile
+++ work/arch/sh/drivers/pci/Makefile	2008-01-24 16:49:22.000000000 +0900
@@ -12,8 +12,7 @@ obj-$(CONFIG_CPU_SUBTYPE_SH7780)	+= pci-
 obj-$(CONFIG_CPU_SUBTYPE_SH7785)	+= pci-sh7780.o ops-sh4.o
 obj-$(CONFIG_CPU_SH5)			+= pci-sh5.o ops-sh5.o
 
-obj-$(CONFIG_SH_DREAMCAST)		+= ops-dreamcast.o fixups-dreamcast.o \
-					   dma-dreamcast.o
+obj-$(CONFIG_SH_DREAMCAST)		+= ops-dreamcast.o fixups-dreamcast.o
 obj-$(CONFIG_SH_SECUREEDGE5410)		+= ops-snapgear.o
 obj-$(CONFIG_SH_RTS7751R2D)		+= ops-rts7751r2d.o fixups-rts7751r2d.o
 obj-$(CONFIG_SH_SH03)			+= ops-sh03.o fixups-sh03.o
--- 0001/arch/sh/drivers/pci/dma-dreamcast.c
+++ /dev/null	2007-12-24 23:06:17.939005730 +0900
@@ -1,70 +0,0 @@
-/*
- * arch/sh/drivers/pci/dma-dreamcast.c
- *
- * PCI DMA support for the Sega Dreamcast
- *
- * Copyright (C) 2001, 2002  M. R. Brown
- * Copyright (C) 2002, 2003  Paul Mundt
- *
- * This file originally bore the message (with enclosed-$):
- *	Id: pci.c,v 1.3 2003/05/04 19:29:46 lethal Exp
- *	Dreamcast PCI: Supports SEGA Broadband Adaptor only.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/param.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/pci.h>
-#include <linux/dma-mapping.h>
-#include <linux/device.h>
-
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/mach/pci.h>
-
-static int gapspci_dma_used = 0;
-
-void *dreamcast_consistent_alloc(struct device *dev, size_t size,
-				 dma_addr_t *dma_handle, gfp_t flag)
-{
-	unsigned long buf;
-
-	if (dev && dev->bus != &pci_bus_type)
-		return NULL;
-
-	if (gapspci_dma_used + size > GAPSPCI_DMA_SIZE)
-		return ERR_PTR(-EINVAL);
-
-	buf = GAPSPCI_DMA_BASE + gapspci_dma_used;
-
-	gapspci_dma_used = PAGE_ALIGN(gapspci_dma_used+size);
-
-	*dma_handle = (dma_addr_t)buf;
-
-	buf = P2SEGADDR(buf);
-
-	/* Flush the dcache before we hand off the buffer */
-	__flush_purge_region((void *)buf, size);
-
-	return (void *)buf;
-}
-
-int dreamcast_consistent_free(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle)
-{
-	if (dev && dev->bus != &pci_bus_type)
-		return -EINVAL;
-
-	/* XXX */
-	gapspci_dma_used = 0;
-
-	return 0;
-}
-
--- 0001/arch/sh/drivers/pci/fixups-dreamcast.c
+++ work/arch/sh/drivers/pci/fixups-dreamcast.c	2008-01-24 16:48:56.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
+#include <linux/dma-mapping.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -40,6 +41,15 @@ static void __init gapspci_fixup_resourc
 		 */
 		dev->resource[1].start	= p->io_resource->start  + 0x100;
 		dev->resource[1].end	= dev->resource[1].start + 0x200 - 1;
+		/*
+		 * Redirect dma memory allocations to special memory window.
+		 */
+		BUG_ON(!dma_declare_coherent_memory(&dev->dev,
+						GAPSPCI_DMA_BASE,
+						GAPSPCI_DMA_BASE,
+						GAPSPCI_DMA_SIZE,
+						DMA_MEMORY_MAP |
+						DMA_MEMORY_EXCLUSIVE));
 		break;
 	default:
 		printk("PCI: Failed resource fixup\n");
