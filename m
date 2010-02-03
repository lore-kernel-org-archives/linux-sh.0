From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Feb 2010 14:44:12 +0000
Subject: [PATCH 2/3 v4] sh: fix Transfer Size calculation in both DMA drivers
Message-Id: <Pine.LNX.4.64.1002031541250.6324@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Both the original arch/sh/drivers/dma/dma-sh.c and the new SH dmaengine drivers
do not take into account bits 3:2 of the Transfer Size field in the CHCR
register, besides, bit-field defines set bit 2, but the mask only passes bits
1:0 through. TS_16BLK and TS_32BLK macros are bogus too. This patch fixes all
these issues for sh7722 and sh7724, other CPUs stay unchanged and might need to
be fixed too.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
On Wed, 3 Feb 2010, Dan Williams wrote:

> Guennadi Liakhovetski wrote:
> > 
> >  arch/sh/drivers/dma/dma-sh.c           |    5 +-
> 
> This bit collides with 9d56dd3b "sh: Mass ctrl_in/outX to __raw_read/writeX
> conversion." in Paul's tree.  I'm fine with these going through the sh tree
> with my acked-by modulo that minor nit with the dma_list_mutex comment in 3/3.

v3 -> v4:

1. rebase to current linux-next

 arch/sh/drivers/dma/dma-sh.c           |    5 +-
 arch/sh/include/asm/dma-sh.h           |    2 +-
 arch/sh/include/cpu-sh3/cpu/dma.h      |   20 ++++---
 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h |   97 ++++++++++++++++++++++++--------
 arch/sh/include/cpu-sh4/cpu/dma.h      |   35 ++++++-----
 drivers/dma/shdma.c                    |    6 ++-
 6 files changed, 114 insertions(+), 51 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index 565cc1a..8272087 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -52,11 +52,14 @@ static inline unsigned int get_dmte_irq(unsigned int chan)
  *
  * iterations to complete the transfer.
  */
+static unsigned int ts_shift[] = TS_SHIFT;
 static inline unsigned int calc_xmit_shift(struct dma_channel *chan)
 {
 	u32 chcr = __raw_readl(dma_base_addr[chan->chan] + CHCR);
+	int cnt = ((chcr & CHCR_TS_LOW_MASK) >> CHCR_TS_LOW_SHIFT) |
+		((chcr & CHCR_TS_HIGH_MASK) >> CHCR_TS_HIGH_SHIFT);
 
-	return ts_shift[(chcr & CHCR_TS_MASK)>>CHCR_TS_SHIFT];
+	return ts_shift[cnt];
 }
 
 /*
diff --git a/arch/sh/include/asm/dma-sh.h b/arch/sh/include/asm/dma-sh.h
index 47de109..b22926d 100644
--- a/arch/sh/include/asm/dma-sh.h
+++ b/arch/sh/include/asm/dma-sh.h
@@ -83,7 +83,7 @@ static int dmte_irq_map[] __maybe_unused = {
  * Define the default configuration for dual address memory-memory transfer.
  * The 0x400 value represents auto-request, external->external.
  */
-#define RS_DUAL	(DM_INC | SM_INC | 0x400 | TS_32)
+#define RS_DUAL	(DM_INC | SM_INC | 0x400 | TS_INDEX2VAL(XMIT_SZ_32BIT))
 
 /* DMA base address */
 static u32 dma_base_addr[] __maybe_unused = {
diff --git a/arch/sh/include/cpu-sh3/cpu/dma.h b/arch/sh/include/cpu-sh3/cpu/dma.h
index 0ea15f3..207811a 100644
--- a/arch/sh/include/cpu-sh3/cpu/dma.h
+++ b/arch/sh/include/cpu-sh3/cpu/dma.h
@@ -20,8 +20,10 @@
 #define TS_32		0x00000010
 #define TS_128		0x00000018
 
-#define CHCR_TS_MASK	0x18
-#define CHCR_TS_SHIFT	3
+#define CHCR_TS_LOW_MASK	0x18
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
 
 #define DMAOR_INIT	DMAOR_DME
 
@@ -36,11 +38,13 @@ enum {
 	XMIT_SZ_128BIT,
 };
 
-static unsigned int ts_shift[] __maybe_unused = {
-	[XMIT_SZ_8BIT]		= 0,
-	[XMIT_SZ_16BIT]		= 1,
-	[XMIT_SZ_32BIT]		= 2,
-	[XMIT_SZ_128BIT]	= 4,
-};
+#define TS_SHIFT {			\
+	[XMIT_SZ_8BIT]		= 0,	\
+	[XMIT_SZ_16BIT]		= 1,	\
+	[XMIT_SZ_32BIT]		= 2,	\
+	[XMIT_SZ_128BIT]	= 4,	\
+}
+
+#define TS_INDEX2VAL(i)	(((i) & 3) << CHCR_TS_LOW_SHIFT)
 
 #endif /* __ASM_CPU_SH3_DMA_H */
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
index c4ed660..cc1cf3e 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
@@ -2,13 +2,26 @@
 #define __ASM_SH_CPU_SH4_DMA_SH7780_H
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7343) || \
-	defined(CONFIG_CPU_SUBTYPE_SH7722) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7730)
 #define DMTE0_IRQ	48
 #define DMTE4_IRQ	76
 #define DMAE0_IRQ	78	/* DMA Error IRQ*/
 #define SH_DMAC_BASE0	0xFE008020
 #define SH_DMARS_BASE	0xFE009000
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
+#elif defined(CONFIG_CPU_SUBTYPE_SH7722)
+#define DMTE0_IRQ	48
+#define DMTE4_IRQ	76
+#define DMAE0_IRQ	78	/* DMA Error IRQ*/
+#define SH_DMAC_BASE0	0xFE008020
+#define SH_DMARS_BASE	0xFE009000
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0x00300000
+#define CHCR_TS_HIGH_SHIFT	20
 #elif defined(CONFIG_CPU_SUBTYPE_SH7763) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7764)
 #define DMTE0_IRQ	34
@@ -16,8 +29,11 @@
 #define DMAE0_IRQ	38
 #define SH_DMAC_BASE0	0xFF608020
 #define SH_DMARS_BASE	0xFF609000
-#elif defined(CONFIG_CPU_SUBTYPE_SH7723) || \
-      defined(CONFIG_CPU_SUBTYPE_SH7724)
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
+#elif defined(CONFIG_CPU_SUBTYPE_SH7723)
 #define DMTE0_IRQ	48	/* DMAC0A*/
 #define DMTE4_IRQ	76	/* DMAC0B */
 #define DMTE6_IRQ	40
@@ -30,6 +46,27 @@
 #define SH_DMAC_BASE0	0xFE008020
 #define SH_DMAC_BASE1	0xFDC08020
 #define SH_DMARS_BASE	0xFDC09000
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
+#elif defined(CONFIG_CPU_SUBTYPE_SH7724)
+#define DMTE0_IRQ	48	/* DMAC0A*/
+#define DMTE4_IRQ	76	/* DMAC0B */
+#define DMTE6_IRQ	40
+#define DMTE8_IRQ	42	/* DMAC1A */
+#define DMTE9_IRQ	43
+#define DMTE10_IRQ	72	/* DMAC1B */
+#define DMTE11_IRQ	73
+#define DMAE0_IRQ	78	/* DMA Error IRQ*/
+#define DMAE1_IRQ	74	/* DMA Error IRQ*/
+#define SH_DMAC_BASE0	0xFE008020
+#define SH_DMAC_BASE1	0xFDC08020
+#define SH_DMARS_BASE	0xFDC09000
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0x00600000
+#define CHCR_TS_HIGH_SHIFT	21
 #elif defined(CONFIG_CPU_SUBTYPE_SH7780)
 #define DMTE0_IRQ	34
 #define DMTE4_IRQ	44
@@ -42,6 +79,10 @@
 #define SH_DMAC_BASE0	0xFC808020
 #define SH_DMAC_BASE1	0xFC818020
 #define SH_DMARS_BASE	0xFC809000
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
 #else /* SH7785 */
 #define DMTE0_IRQ	33
 #define DMTE4_IRQ	37
@@ -55,17 +96,16 @@
 #define SH_DMAC_BASE0	0xFC808020
 #define SH_DMAC_BASE1	0xFCC08020
 #define SH_DMARS_BASE	0xFC809000
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
 #endif
 
-#define REQ_HE	0x000000C0
-#define REQ_H	0x00000080
-#define REQ_LE	0x00000040
-#define TM_BURST 0x0000020
-#define TS_8	0x00000000
-#define TS_16	0x00000008
-#define TS_32	0x00000010
-#define TS_16BLK	0x00000018
-#define TS_32BLK	0x00100000
+#define REQ_HE		0x000000C0
+#define REQ_H		0x00000080
+#define REQ_LE		0x00000040
+#define TM_BURST	0x00000020
 
 /*
  * The SuperH DMAC supports a number of transmit sizes, we list them here,
@@ -74,22 +114,31 @@
  * Defaults to a 64-bit transfer size.
  */
 enum {
-	XMIT_SZ_8BIT,
-	XMIT_SZ_16BIT,
-	XMIT_SZ_32BIT,
-	XMIT_SZ_128BIT,
-	XMIT_SZ_256BIT,
+	XMIT_SZ_8BIT		= 0,
+	XMIT_SZ_16BIT		= 1,
+	XMIT_SZ_32BIT		= 2,
+	XMIT_SZ_64BIT		= 7,
+	XMIT_SZ_128BIT		= 3,
+	XMIT_SZ_256BIT		= 4,
+	XMIT_SZ_128BIT_BLK	= 0xb,
+	XMIT_SZ_256BIT_BLK	= 0xc,
 };
 
 /*
  * The DMA count is defined as the number of bytes to transfer.
  */
-static unsigned int ts_shift[] __maybe_unused = {
-	[XMIT_SZ_8BIT]		= 0,
-	[XMIT_SZ_16BIT]		= 1,
-	[XMIT_SZ_32BIT]		= 2,
-	[XMIT_SZ_128BIT]	= 4,
-	[XMIT_SZ_256BIT]	= 5,
-};
+#define TS_SHIFT {			\
+	[XMIT_SZ_8BIT]		= 0,	\
+	[XMIT_SZ_16BIT]		= 1,	\
+	[XMIT_SZ_32BIT]		= 2,	\
+	[XMIT_SZ_64BIT]		= 3,	\
+	[XMIT_SZ_128BIT]	= 4,	\
+	[XMIT_SZ_256BIT]	= 5,	\
+	[XMIT_SZ_128BIT_BLK]	= 4,	\
+	[XMIT_SZ_256BIT_BLK]	= 5,	\
+}
+
+#define TS_INDEX2VAL(i)	((((i) & 3) << CHCR_TS_LOW_SHIFT) | \
+			 ((((i) >> 2) & 3) << CHCR_TS_HIGH_SHIFT))
 
 #endif /* __ASM_SH_CPU_SH4_DMA_SH7780_H */
diff --git a/arch/sh/include/cpu-sh4/cpu/dma.h b/arch/sh/include/cpu-sh4/cpu/dma.h
index bcb3024..114a369 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma.h
@@ -6,8 +6,6 @@
 #ifdef CONFIG_CPU_SH4A
 
 #define DMAOR_INIT	(DMAOR_DME)
-#define CHCR_TS_MASK	0x18
-#define CHCR_TS_SHIFT	3
 
 #include <cpu/dma-sh4a.h>
 #else /* CONFIG_CPU_SH4A */
@@ -29,8 +27,10 @@
 #define TS_32		0x00000030
 #define TS_64		0x00000000
 
-#define CHCR_TS_MASK	0x70
-#define CHCR_TS_SHIFT	4
+#define CHCR_TS_LOW_MASK	0x70
+#define CHCR_TS_LOW_SHIFT	4
+#define CHCR_TS_HIGH_MASK	0
+#define CHCR_TS_HIGH_SHIFT	0
 
 #define DMAOR_COD	0x00000008
 
@@ -41,23 +41,26 @@
  * Defaults to a 64-bit transfer size.
  */
 enum {
-	XMIT_SZ_64BIT,
-	XMIT_SZ_8BIT,
-	XMIT_SZ_16BIT,
-	XMIT_SZ_32BIT,
-	XMIT_SZ_256BIT,
+	XMIT_SZ_8BIT	= 1,
+	XMIT_SZ_16BIT	= 2,
+	XMIT_SZ_32BIT	= 3,
+	XMIT_SZ_64BIT	= 0,
+	XMIT_SZ_256BIT	= 4,
 };
 
 /*
  * The DMA count is defined as the number of bytes to transfer.
  */
-static unsigned int ts_shift[] __maybe_unused = {
-	[XMIT_SZ_64BIT]		= 3,
-	[XMIT_SZ_8BIT]		= 0,
-	[XMIT_SZ_16BIT]		= 1,
-	[XMIT_SZ_32BIT]		= 2,
-	[XMIT_SZ_256BIT]	= 5,
-};
+#define TS_SHIFT {			\
+	[XMIT_SZ_8BIT]		= 0,	\
+	[XMIT_SZ_16BIT]		= 1,	\
+	[XMIT_SZ_32BIT]		= 2,	\
+	[XMIT_SZ_64BIT]		= 3,	\
+	[XMIT_SZ_256BIT]	= 5,	\
+}
+
+#define TS_INDEX2VAL(i)	(((i) & 7) << CHCR_TS_LOW_SHIFT)
+
 #endif
 
 #endif /* __ASM_CPU_SH4_DMA_H */
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 427c3ef..3e1037c 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -105,10 +105,14 @@ static bool dmae_is_busy(struct sh_dmae_chan *sh_chan)
 	return false; /* waiting */
 }
 
+static unsigned int ts_shift[] = TS_SHIFT;
 static inline unsigned int calc_xmit_shift(struct sh_dmae_chan *sh_chan)
 {
 	u32 chcr = sh_dmae_readl(sh_chan, CHCR);
-	return ts_shift[(chcr & CHCR_TS_MASK) >> CHCR_TS_SHIFT];
+	int cnt = ((chcr & CHCR_TS_LOW_MASK) >> CHCR_TS_LOW_SHIFT) |
+		((chcr & CHCR_TS_HIGH_MASK) >> CHCR_TS_HIGH_SHIFT);
+
+	return ts_shift[cnt];
 }
 
 static void dmae_set_reg(struct sh_dmae_chan *sh_chan, struct sh_dmae_regs *hw)
-- 
1.6.2.4

