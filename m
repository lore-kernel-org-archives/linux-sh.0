From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Feb 2011 07:40:16 +0000
Subject: [PATCH 5/7] sh: dmaengine support for SH7757
Message-Id: <4D675CE0.4020009@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/include/cpu-sh4/cpu/dma-register.h |    5 +
 arch/sh/include/cpu-sh4/cpu/sh7757.h       |   32 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c     |  518 +++++++++++++++++++++++++++-
 3 files changed, 554 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 9a6125e..18fa80a 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -40,6 +40,11 @@
 #define CHCR_TS_LOW_SHIFT	3
 #define CHCR_TS_HIGH_MASK	0
 #define CHCR_TS_HIGH_SHIFT	0
+#elif defined(CONFIG_CPU_SUBTYPE_SH7757)
+#define CHCR_TS_LOW_MASK	0x00000018
+#define CHCR_TS_LOW_SHIFT	3
+#define CHCR_TS_HIGH_MASK	0x00100000
+#define CHCR_TS_HIGH_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7780)
 #define CHCR_TS_LOW_MASK	0x00000018
 #define CHCR_TS_LOW_SHIFT	3
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7757.h b/arch/sh/include/cpu-sh4/cpu/sh7757.h
index 15f3de1..05b8196 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7757.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7757.h
@@ -251,4 +251,36 @@ enum {
 	GPIO_FN_ON_DQ3,	GPIO_FN_ON_DQ2,	GPIO_FN_ON_DQ1,	GPIO_FN_ON_DQ0,
 };

+enum {
+	SHDMA_SLAVE_SDHI_TX,
+	SHDMA_SLAVE_SDHI_RX,
+	SHDMA_SLAVE_MMCIF_TX,
+	SHDMA_SLAVE_MMCIF_RX,
+	SHDMA_SLAVE_SCIF2_TX,
+	SHDMA_SLAVE_SCIF2_RX,
+	SHDMA_SLAVE_SCIF3_TX,
+	SHDMA_SLAVE_SCIF3_RX,
+	SHDMA_SLAVE_SCIF4_TX,
+	SHDMA_SLAVE_SCIF4_RX,
+	SHDMA_SLAVE_RIIC0_TX,
+	SHDMA_SLAVE_RIIC0_RX,
+	SHDMA_SLAVE_RIIC1_TX,
+	SHDMA_SLAVE_RIIC1_RX,
+	SHDMA_SLAVE_RIIC2_TX,
+	SHDMA_SLAVE_RIIC2_RX,
+	SHDMA_SLAVE_RIIC3_TX,
+	SHDMA_SLAVE_RIIC3_RX,
+	SHDMA_SLAVE_RIIC4_TX,
+	SHDMA_SLAVE_RIIC4_RX,
+	SHDMA_SLAVE_RIIC5_TX,
+	SHDMA_SLAVE_RIIC5_RX,
+	SHDMA_SLAVE_RIIC6_TX,
+	SHDMA_SLAVE_RIIC6_RX,
+	SHDMA_SLAVE_RIIC7_TX,
+	SHDMA_SLAVE_RIIC7_RX,
+	SHDMA_SLAVE_RIIC8_TX,
+	SHDMA_SLAVE_RIIC8_RX,
+	SHDMA_SLAVE_RIIC9_TX,
+	SHDMA_SLAVE_RIIC9_RX,
+};
 #endif /* __ASM_SH7757_H__ */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 480f665..423dabf 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -1,7 +1,7 @@
 /*
  * SH7757 Setup
  *
- * Copyright (C) 2009  Renesas Solutions Corp.
+ * Copyright (C) 2009, 2011  Renesas Solutions Corp.
  *
  *  based on setup-sh7785.c : Copyright (C) 2007  Paul Mundt
  *
@@ -16,6 +16,10 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/sh_timer.h>
+#include <linux/sh_dma.h>
+
+#include <cpu/dma-register.h>
+#include <cpu/sh7757.h>

 static struct plat_sci_port scif2_platform_data = {
 	.mapbase	= 0xfe4b0000,		/* SCIF2 */
@@ -136,6 +140,514 @@ static struct resource spi0_resources[] = {
 	},
 };

+/* DMA */
+static const struct sh_dmae_slave_config sh7757_dmae0_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_SDHI_TX,
+		.addr		= 0x1fe50030,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc5,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_SDHI_RX,
+		.addr		= 0x1fe50030,
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc6,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
+		.addr		= 0x1fcb0034,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd3,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
+		.addr		= 0x1fcb0034,
+		.chcr		= DM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd7,
+	},
+};
+
+static const struct sh_dmae_slave_config sh7757_dmae1_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_SCIF2_TX,
+		.addr		= 0x1f4b000c,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x21,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_SCIF2_RX,
+		.addr		= 0x1f4b0014,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x22,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_SCIF3_TX,
+		.addr		= 0x1f4c000c,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x29,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_SCIF3_RX,
+		.addr		= 0x1f4c0014,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2a,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_SCIF4_TX,
+		.addr		= 0x1f4d000c,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x41,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_SCIF4_RX,
+		.addr		= 0x1f4d0014,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x42,
+	},
+};
+
+static const struct sh_dmae_slave_config sh7757_dmae2_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC0_TX,
+		.addr		= 0x1e500012,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x21,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC0_RX,
+		.addr		= 0x1e500013,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x22,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC1_TX,
+		.addr		= 0x1e510012,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x29,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC1_RX,
+		.addr		= 0x1e510013,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2a,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC2_TX,
+		.addr		= 0x1e520012,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0xa1,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC2_RX,
+		.addr		= 0x1e520013,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0xa2,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC3_TX,
+		.addr		= 0x1e530012,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0xab,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC3_RX,
+		.addr		= 0x1e530013,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0xaf,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC4_TX,
+		.addr		= 0x1e540012,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0xc1,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC4_RX,
+		.addr		= 0x1e540013,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0xc2,
+	},
+};
+
+static const struct sh_dmae_slave_config sh7757_dmae3_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC5_TX,
+		.addr		= 0x1e550012,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x21,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC5_RX,
+		.addr		= 0x1e550013,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x22,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC6_TX,
+		.addr		= 0x1e560012,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x29,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC6_RX,
+		.addr		= 0x1e560013,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2a,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC7_TX,
+		.addr		= 0x1e570012,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x41,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC7_RX,
+		.addr		= 0x1e570013,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x42,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC8_TX,
+		.addr		= 0x1e580012,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x45,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC8_RX,
+		.addr		= 0x1e580013,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x46,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC9_TX,
+		.addr		= 0x1e590012,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x51,
+	},
+	{
+		.slave_id	= SHDMA_SLAVE_RIIC9_RX,
+		.addr		= 0x1e590013,
+		.chcr		= SM_INC | 0x800 | 0x40000000 |
+				  TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x52,
+	},
+};
+
+static const struct sh_dmae_channel sh7757_dmae_channels[] = {
+	{
+		.offset = 0,
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
+static const unsigned int ts_shift[] = TS_SHIFT;
+
+static struct sh_dmae_pdata dma0_platform_data = {
+	.slave		= sh7757_dmae0_slaves,
+	.slave_num	= ARRAY_SIZE(sh7757_dmae0_slaves),
+	.channel	= sh7757_dmae_channels,
+	.channel_num	= ARRAY_SIZE(sh7757_dmae_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
+};
+
+static struct sh_dmae_pdata dma1_platform_data = {
+	.slave		= sh7757_dmae1_slaves,
+	.slave_num	= ARRAY_SIZE(sh7757_dmae1_slaves),
+	.channel	= sh7757_dmae_channels,
+	.channel_num	= ARRAY_SIZE(sh7757_dmae_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
+};
+
+static struct sh_dmae_pdata dma2_platform_data = {
+	.slave		= sh7757_dmae2_slaves,
+	.slave_num	= ARRAY_SIZE(sh7757_dmae2_slaves),
+	.channel	= sh7757_dmae_channels,
+	.channel_num	= ARRAY_SIZE(sh7757_dmae_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
+};
+
+static struct sh_dmae_pdata dma3_platform_data = {
+	.slave		= sh7757_dmae3_slaves,
+	.slave_num	= ARRAY_SIZE(sh7757_dmae3_slaves),
+	.channel	= sh7757_dmae_channels,
+	.channel_num	= ARRAY_SIZE(sh7757_dmae_channels),
+	.ts_low_shift	= CHCR_TS_LOW_SHIFT,
+	.ts_low_mask	= CHCR_TS_LOW_MASK,
+	.ts_high_shift	= CHCR_TS_HIGH_SHIFT,
+	.ts_high_mask	= CHCR_TS_HIGH_MASK,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_INIT,
+};
+
+/* channel 0 to 5 */
+static struct resource sh7757_dmae0_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xff608020,
+		.end	= 0xff60808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* DMARSx */
+		.start	= 0xff609000,
+		.end	= 0xff60900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= 34,
+		.end	= 34,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+};
+
+/* channel 6 to 11 */
+static struct resource sh7757_dmae1_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xff618020,
+		.end	= 0xff61808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* DMARSx */
+		.start	= 0xff619000,
+		.end	= 0xff61900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error */
+		.start	= 34,
+		.end	= 34,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+	{
+		/* IRQ for channels 4 */
+		.start	= 46,
+		.end	= 46,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+	{
+		/* IRQ for channels 5 */
+		.start	= 46,
+		.end	= 46,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+	{
+		/* IRQ for channels 6 */
+		.start	= 88,
+		.end	= 88,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+	{
+		/* IRQ for channels 7 */
+		.start	= 88,
+		.end	= 88,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+	{
+		/* IRQ for channels 8 */
+		.start	= 88,
+		.end	= 88,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+	{
+		/* IRQ for channels 9 */
+		.start	= 88,
+		.end	= 88,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+	{
+		/* IRQ for channels 10 */
+		.start	= 88,
+		.end	= 88,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+	{
+		/* IRQ for channels 11 */
+		.start	= 88,
+		.end	= 88,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+};
+
+/* channel 12 to 17 */
+static struct resource sh7757_dmae2_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xff708020,
+		.end	= 0xff70808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* DMARSx */
+		.start	= 0xff709000,
+		.end	= 0xff70900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error */
+		.start	= 323,
+		.end	= 323,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 12 to 16 */
+		.start	= 272,
+		.end	= 276,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channel 17 */
+		.start	= 279,
+		.end	= 279,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+/* channel 18 to 23 */
+static struct resource sh7757_dmae3_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xff718020,
+		.end	= 0xff71808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* DMARSx */
+		.start	= 0xff719000,
+		.end	= 0xff71900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error */
+		.start	= 324,
+		.end	= 324,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 18 to 22 */
+		.start	= 280,
+		.end	= 284,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channel 23 */
+		.start	= 288,
+		.end	= 288,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dma0_device = {
+	.name           = "sh-dma-engine",
+	.id             = 0,
+	.resource	= sh7757_dmae0_resources,
+	.num_resources	= ARRAY_SIZE(sh7757_dmae0_resources),
+	.dev            = {
+		.platform_data	= &dma0_platform_data,
+	},
+};
+
+static struct platform_device dma1_device = {
+	.name		= "sh-dma-engine",
+	.id		= 1,
+	.resource	= sh7757_dmae1_resources,
+	.num_resources	= ARRAY_SIZE(sh7757_dmae1_resources),
+	.dev		= {
+		.platform_data	= &dma1_platform_data,
+	},
+};
+
+static struct platform_device dma2_device = {
+	.name		= "sh-dma-engine",
+	.id		= 2,
+	.resource	= sh7757_dmae2_resources,
+	.num_resources	= ARRAY_SIZE(sh7757_dmae2_resources),
+	.dev		= {
+		.platform_data	= &dma2_platform_data,
+	},
+};
+
+static struct platform_device dma3_device = {
+	.name		= "sh-dma-engine",
+	.id		= 3,
+	.resource	= sh7757_dmae3_resources,
+	.num_resources	= ARRAY_SIZE(sh7757_dmae3_resources),
+	.dev		= {
+		.platform_data	= &dma3_platform_data,
+	},
+};
+
 static struct platform_device spi0_device = {
 	.name	= "sh_spi",
 	.id	= 0,
@@ -153,6 +665,10 @@ static struct platform_device *sh7757_devices[] __initdata = {
 	&scif4_device,
 	&tmu0_device,
 	&tmu1_device,
+	&dma0_device,
+	&dma1_device,
+	&dma2_device,
+	&dma3_device,
 	&spi0_device,
 };

-- 
1.7.1
