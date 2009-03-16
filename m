From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Mon, 16 Mar 2009 03:22:07 +0000
Subject: [PATCH] sh: Move IRQ multi definition of DMAC to defconfig
Message-Id: <49BDC5DF.6070108@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When SuperH CPU has IRQ multi of DMAC, SH_DMA_IRQ_MULTI becomes enable.
The following CPU's are Multi IRQ of DMAC now.
 - SH775X and SH7091
 - SH776X
 - SH7780
 - SH7785

If SH_DMA_IRQ_MULTI becomes enable, dma-sh api driver is optimized
for Multi IRQ.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/drivers/dma/Kconfig  |    8 ++++++++
 arch/sh/drivers/dma/dma-sh.c |   17 +++++------------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
index 57d95fc..32bb8fa 100644
--- a/arch/sh/drivers/dma/Kconfig
+++ b/arch/sh/drivers/dma/Kconfig
@@ -9,6 +9,14 @@ config SH_DMA
 	select SH_DMA_API
 	default n

+config SH_DMA_IRQ_MULTI
+	bool
+	depends on SH_DMA
+	default y if CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7751 || \
+		CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R || \
+		CPU_SUBTYPE_SH7091 || CPU_SUBTYPE_SH7763 || CPU_SUBTYPE_SH7764 || \
+		CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785
+
 config NR_ONCHIP_DMA_CHANNELS
 	int
 	depends on SH_DMA
diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index ab7b18d..d7a91c4 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -19,13 +19,6 @@
 #include <asm/io.h>
 #include <asm/dma-sh.h>

-#if defined(CONFIG_CPU_SUBTYPE_SH7763)	|| \
-		defined(CONFIG_CPU_SUBTYPE_SH7764)	|| \
-		defined(CONFIG_CPU_SUBTYPE_SH7780)	|| \
-		defined(CONFIG_CPU_SUBTYPE_SH7785)
-#define DMAC_IRQ_MULTI	1
-#endif
-
 #if defined(DMAE1_IRQ)
 #define NR_DMAE		2
 #else
@@ -42,7 +35,7 @@ static inline unsigned int get_dmte_irq(unsigned int chan)
 	if (chan < ARRAY_SIZE(dmte_irq_map))
 		irq = dmte_irq_map[chan];

-#if defined(DMAC_IRQ_MULTI)
+#if defined(CONFIG_SH_DMA_IRQ_MULTI)
 	if (irq > DMTE6_IRQ)
 		return DMTE6_IRQ;
 	return DMTE0_IRQ;
@@ -96,7 +89,7 @@ static int sh_dmac_request_dma(struct dma_channel *chan)
 		return 0;

 	return request_irq(get_dmte_irq(chan->chan), dma_tei,
-#if defined(DMAC_IRQ_MULTI)
+#if defined(CONFIG_SH_DMA_IRQ_MULTI)
 				IRQF_SHARED,
 #else
 				IRQF_DISABLED,
@@ -235,7 +228,7 @@ static inline int dmaor_reset(int no)
 #if defined(CONFIG_CPU_SH4)
 static irqreturn_t dma_err(int irq, void *dummy)
 {
-#if defined(DMAC_IRQ_MULTI)
+#if defined(CONFIG_SH_DMA_IRQ_MULTI)
 	int cnt = 0;
 	switch (irq) {
 #if defined(DMTE6_IRQ) && defined(DMAE1_IRQ)
@@ -282,7 +275,7 @@ static struct dma_info sh_dmac_info = {

 static unsigned int get_dma_error_irq(int n)
 {
-#if defined(DMAC_IRQ_MULTI)
+#if defined(CONFIG_SH_DMA_IRQ_MULTI)
 	return (n = 0) ? get_dmte_irq(0) : get_dmte_irq(6);
 #else
 	return (n = 0) ? DMAE0_IRQ :
@@ -304,7 +297,7 @@ static int __init sh_dmac_init(void)

 	for (n = 0; n < NR_DMAE; n++) {
 		i = request_irq(get_dma_error_irq(n), dma_err,
-#if defined(DMAC_IRQ_MULTI)
+#if defined(CONFIG_SH_DMA_IRQ_MULTI)
 				IRQF_SHARED,
 #else
 				IRQF_DISABLED,
-- 
1.6.2
