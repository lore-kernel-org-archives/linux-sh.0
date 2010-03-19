From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 04:47:19 +0000
Subject: [PATCH 05/05] dmaengine: shdma: Enable on SH-Mobile ARM
Message-Id: <20100319044719.17051.57155.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Enable the shdma dmaengine driver on SH-Mobile ARM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/dma/Kconfig        |    2 +-
 drivers/dma/shdma.c        |    8 ++++----
 include/linux/serial_sci.h |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

--- 0001/drivers/dma/Kconfig
+++ work/drivers/dma/Kconfig	2010-03-18 23:38:59.000000000 +0900
@@ -128,7 +128,7 @@ config TXX9_DMAC
 
 config SH_DMAE
 	tristate "Renesas SuperH DMAC support"
-	depends on SUPERH && SH_DMA
+	depends on (SUPERH && SH_DMA) || (ARM && ARCH_SHMOBILE)
 	depends on !SH_DMA_API
 	select DMA_ENGINE
 	help
--- 0008/drivers/dma/shdma.c
+++ work/drivers/dma/shdma.c	2010-03-19 12:39:33.000000000 +0900
@@ -793,7 +793,7 @@ static irqreturn_t sh_dmae_interrupt(int
 	return ret;
 }
 
-#if defined(CONFIG_CPU_SH4)
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
 static irqreturn_t sh_dmae_err(int irq, void *data)
 {
 	struct sh_dmae_device *shdev = (struct sh_dmae_device *)data;
@@ -1034,7 +1034,7 @@ static int __init sh_dmae_probe(struct p
 	/* Default transfer size of 32 bytes requires 32-byte alignment */
 	shdev->common.copy_align = LOG2_DEFAULT_XFER_SIZE;
 
-#if defined(CONFIG_CPU_SH4)
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
 	chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
 
 	if (!chanirq_res)
@@ -1059,7 +1059,7 @@ static int __init sh_dmae_probe(struct p
 
 #else
 	chanirq_res = errirq_res;
-#endif /* CONFIG_CPU_SH4 */
+#endif /* CONFIG_CPU_SH4 || CONFIG_ARCH_SHMOBILE */
 
 	if (chanirq_res->start = chanirq_res->end &&
 	    !platform_get_resource(pdev, IORESOURCE_IRQ, 1)) {
@@ -1106,7 +1106,7 @@ static int __init sh_dmae_probe(struct p
 chan_probe_err:
 	sh_dmae_chan_remove(shdev);
 eirqres:
-#if defined(CONFIG_CPU_SH4)
+#if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
 	free_irq(errirq, shdev);
 eirq_err:
 #endif
--- 0005/include/linux/serial_sci.h
+++ work/include/linux/serial_sci.h	2010-03-18 23:38:59.000000000 +0900
@@ -3,7 +3,7 @@
 
 #include <linux/serial_core.h>
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
-#include <asm/dmaengine.h>
+#include <linux/sh_dma.h>
 #endif
 
 /*
