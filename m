From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 12 Mar 2009 06:34:39 +0000
Subject: [PATCH] sh: Revert CONFIG_NR_ONCHIP_DMA_CHANNELS to MAX_DMA_CHANNELS
Message-Id: <49B8ACFF.1030604@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/include/asm/dma-sh.h |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/dma-sh.h b/arch/sh/include/asm/dma-sh.h
index e873eca..0c8f8e1 100644
--- a/arch/sh/include/asm/dma-sh.h
+++ b/arch/sh/include/asm/dma-sh.h
@@ -11,6 +11,7 @@
 #ifndef __DMA_SH_H
 #define __DMA_SH_H

+#include <asm/dma.h>
 #include <cpu/dma.h>

 /* DMAOR contorl: The DMAOR access size is different by CPU.*/
@@ -29,21 +30,21 @@
 #endif

 static int dmte_irq_map[] __maybe_unused = {
-#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 4)
+#if (MAX_DMA_CHANNELS >= 4)
     DMTE0_IRQ,
     DMTE0_IRQ + 1,
     DMTE0_IRQ + 2,
     DMTE0_IRQ + 3,
 #endif
-#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 6)
+#if (MAX_DMA_CHANNELS >= 6)
     DMTE4_IRQ,
     DMTE4_IRQ + 1,
 #endif
-#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 8)
+#if (MAX_DMA_CHANNELS >= 8)
     DMTE6_IRQ,
     DMTE6_IRQ + 1,
 #endif
-#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 12)
+#if (MAX_DMA_CHANNELS >= 12)
     DMTE8_IRQ,
     DMTE9_IRQ,
     DMTE10_IRQ,
@@ -85,21 +86,21 @@ static int dmte_irq_map[] __maybe_unused = {

 /* DMA base address */
 static u32 dma_base_addr[] __maybe_unused = {
-#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 4)
+#if (MAX_DMA_CHANNELS >= 4)
 	SH_DMAC_BASE0 + 0x00,	/* channel 0 */
 	SH_DMAC_BASE0 + 0x10,
 	SH_DMAC_BASE0 + 0x20,
 	SH_DMAC_BASE0 + 0x30,
 #endif
-#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 6)
+#if (MAX_DMA_CHANNELS >= 6)
 	SH_DMAC_BASE0 + 0x50,
 	SH_DMAC_BASE0 + 0x60,
 #endif
-#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 8)
+#if (MAX_DMA_CHANNELS >= 8)
 	SH_DMAC_BASE1 + 0x00,
 	SH_DMAC_BASE1 + 0x10,
 #endif
-#if (CONFIG_NR_ONCHIP_DMA_CHANNELS >= 12)
+#if (MAX_DMA_CHANNELS >= 12)
 	SH_DMAC_BASE1 + 0x20,
 	SH_DMAC_BASE1 + 0x30,
 	SH_DMAC_BASE1 + 0x50,
-- 
1.6.2

