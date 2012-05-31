From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 31 May 2012 00:23:29 +0000
Subject: [PATCH 4/9] ARM: mach-shmobile: r8a7740: add FSI DMAEngine support
Message-Id: <87mx4p8agy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c        |    8 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    8 +
 arch/arm/mach-shmobile/setup-r8a7740.c        |  174 +++++++++++++++++++++++++
 3 files changed, 189 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 7b9e4ab..39b1311 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -463,6 +463,7 @@ enum {
 
 	MSTP230,
 	MSTP222,
+	MSTP218, MSTP217, MSTP216,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 
 	MSTP329, MSTP328, MSTP323, MSTP320,
@@ -485,6 +486,9 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 	[MSTP230] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2, 30, 0), /* SCIFA6 */
 	[MSTP222] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2, 22, 0), /* SCIFA7 */
+	[MSTP218] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 18, 0), /* DMAC1 */
+	[MSTP217] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 17, 0), /* DMAC2 */
+	[MSTP216] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 16, 0), /* DMAC3 */
 	[MSTP207] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2,  7, 0), /* SCIFA5 */
 	[MSTP206] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2,  6, 0), /* SCIFB */
 	[MSTP204] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2,  4, 0), /* SCIFA0 */
@@ -563,7 +567,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.0",		&mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.8",		&mstp_clks[MSTP206]),
 	CLKDEV_DEV_ID("sh-sci.5",		&mstp_clks[MSTP207]),
-
+	CLKDEV_DEV_ID("sh-dma-engine.2",	&mstp_clks[MSTP216]),
+	CLKDEV_DEV_ID("sh-dma-engine.1",	&mstp_clks[MSTP217]),
+	CLKDEV_DEV_ID("sh-dma-engine.0",	&mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("sh-sci.7",		&mstp_clks[MSTP222]),
 	CLKDEV_DEV_ID("sh-sci.6",		&mstp_clks[MSTP230]),
 
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 6468fcc..f71507b 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -588,4 +588,12 @@ enum {
 	GPIO_FN_TRACEAUD_FROM_MEMC,
 };
 
+/* DMA slave IDs */
+enum {
+	SHDMA_SLAVE_INVALID,
+	SHDMA_SLAVE_FSIA_RX,
+	SHDMA_SLAVE_FSIA_TX,
+	SHDMA_SLAVE_FSIB_TX,
+};
+
 #endif /* __ASM_R8A7740_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 366311b..24d1160 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -24,7 +24,10 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
+#include <linux/dma-mapping.h>
+#include <mach/dma-register.h>
 #include <mach/r8a7740.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -276,6 +279,174 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&cmt10_device,
 };
 
+/* DMA */
+static const struct sh_dmae_slave_config r8a7740_dmae_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_FSIA_TX,
+		.addr		= 0xfe1f0024,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xb1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_FSIA_RX,
+		.addr		= 0xfe1f0020,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xb2,
+	}, {
+		.slave_id	= SHDMA_SLAVE_FSIB_TX,
+		.addr		= 0xfe1f0064,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xb5,
+	},
+};
+
+#define DMA_CHANNEL(a, b, c)			\
+{						\
+	.offset		= a,			\
+	.dmars		= b,			\
+	.dmars_bit	= c,			\
+	.chclr_offset	= (0x220 - 0x20) + a	\
+}
+
+static const struct sh_dmae_channel r8a7740_dmae_channels[] = {
+	DMA_CHANNEL(0x00, 0, 0),
+	DMA_CHANNEL(0x10, 0, 8),
+	DMA_CHANNEL(0x20, 4, 0),
+	DMA_CHANNEL(0x30, 4, 8),
+	DMA_CHANNEL(0x50, 8, 0),
+	DMA_CHANNEL(0x60, 8, 8),
+};
+
+static const unsigned int ts_shift[] = TS_SHIFT;
+
+static struct sh_dmae_pdata dma_platform_data = {
+	.slave		= r8a7740_dmae_slaves,
+	.slave_num	= ARRAY_SIZE(r8a7740_dmae_slaves),
+	.channel	= r8a7740_dmae_channels,
+	.channel_num	= ARRAY_SIZE(r8a7740_dmae_channels),
+	.ts_low_shift	= TS_LOW_SHIFT,
+	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
+	.ts_high_shift	= TS_HI_SHIFT,
+	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
+	.ts_shift	= ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(ts_shift),
+	.dmaor_init	= DMAOR_DME,
+	.chclr_present	= 1,
+};
+
+/* Resource order important! */
+static struct resource r8a7740_dmae0_resources[] = {
+	{
+		/* Channel registers and DMAOR */
+		.start	= 0xfe008020,
+		.end	= 0xfe00828f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMARSx */
+		.start	= 0xfe009000,
+		.end	= 0xfe00900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "error_irq",
+		.start	= evt2irq(0x20c0),
+		.end	= evt2irq(0x20c0),
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-5 */
+		.start	= evt2irq(0x2000),
+		.end	= evt2irq(0x20a0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+/* Resource order important! */
+static struct resource r8a7740_dmae1_resources[] = {
+	{
+		/* Channel registers and DMAOR */
+		.start	= 0xfe018020,
+		.end	= 0xfe01828f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMARSx */
+		.start	= 0xfe019000,
+		.end	= 0xfe01900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "error_irq",
+		.start	= evt2irq(0x21c0),
+		.end	= evt2irq(0x21c0),
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-5 */
+		.start	= evt2irq(0x2100),
+		.end	= evt2irq(0x21a0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+/* Resource order important! */
+static struct resource r8a7740_dmae2_resources[] = {
+	{
+		/* Channel registers and DMAOR */
+		.start	= 0xfe028020,
+		.end	= 0xfe02828f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMARSx */
+		.start	= 0xfe029000,
+		.end	= 0xfe02900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "error_irq",
+		.start	= evt2irq(0x22c0),
+		.end	= evt2irq(0x22c0),
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-5 */
+		.start	= evt2irq(0x2200),
+		.end	= evt2irq(0x22a0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dma0_device = {
+	.name		= "sh-dma-engine",
+	.id		= 0,
+	.resource	= r8a7740_dmae0_resources,
+	.num_resources	= ARRAY_SIZE(r8a7740_dmae0_resources),
+	.dev		= {
+		.platform_data	= &dma_platform_data,
+	},
+};
+
+static struct platform_device dma1_device = {
+	.name		= "sh-dma-engine",
+	.id		= 1,
+	.resource	= r8a7740_dmae1_resources,
+	.num_resources	= ARRAY_SIZE(r8a7740_dmae1_resources),
+	.dev		= {
+		.platform_data	= &dma_platform_data,
+	},
+};
+
+static struct platform_device dma2_device = {
+	.name		= "sh-dma-engine",
+	.id		= 2,
+	.resource	= r8a7740_dmae2_resources,
+	.num_resources	= ARRAY_SIZE(r8a7740_dmae2_resources),
+	.dev		= {
+		.platform_data	= &dma_platform_data,
+	},
+};
+
 /* I2C */
 static struct resource i2c0_resources[] = {
 	[0] = {
@@ -322,6 +493,9 @@ static struct platform_device i2c1_device = {
 static struct platform_device *r8a7740_late_devices[] __initdata = {
 	&i2c0_device,
 	&i2c1_device,
+	&dma0_device,
+	&dma1_device,
+	&dma2_device,
 };
 
 /*
-- 
1.7.5.4

