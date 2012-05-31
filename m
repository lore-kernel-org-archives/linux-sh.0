From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 31 May 2012 00:29:30 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: sh73a0: add MPDMAC support
Message-Id: <87d35l8a6w.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On v2.0 manual, MPDMAC MID/RID number were wrong.
This patch is using the number which seems correct.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh73a0.c        |    4 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h |    7 ++
 arch/arm/mach-shmobile/setup-sh73a0.c        |  106 ++++++++++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index ad6f9ad..76bdcca 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -475,7 +475,7 @@ static struct clk *late_main_clks[] = {
 
 enum { MSTP001,
 	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP100,
-	MSTP219, MSTP218,
+	MSTP219, MSTP218, MSTP217,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 	MSTP331, MSTP329, MSTP328, MSTP325, MSTP323,
 	MSTP314, MSTP313, MSTP312, MSTP311,
@@ -498,6 +498,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, 0), /* LCDC0 */
 	[MSTP219] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 19, 0), /* SCIFA7 */
 	[MSTP218] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 18, 0), /* SY-DMAC */
+	[MSTP217] = MSTP(&div4_clks[DIV4_HP], SMSTPCR2, 17, 0), /* MP-DMAC */
 	[MSTP207] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 7, 0), /* SCIFA5 */
 	[MSTP206] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 6, 0), /* SCIFB */
 	[MSTP204] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 4, 0), /* SCIFA0 */
@@ -554,6 +555,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
 	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP218]), /* SY-DMAC */
+	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP217]), /* MP-DMAC */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index 398e2c1..fe950f2 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -516,6 +516,13 @@ enum {
 	SHDMA_SLAVE_SDHI2_RX,
 	SHDMA_SLAVE_MMCIF_TX,
 	SHDMA_SLAVE_MMCIF_RX,
+	SHDMA_SLAVE_FSI2A_TX,
+	SHDMA_SLAVE_FSI2A_RX,
+	SHDMA_SLAVE_FSI2B_TX,
+	SHDMA_SLAVE_FSI2B_RX,
+	SHDMA_SLAVE_FSI2C_TX,
+	SHDMA_SLAVE_FSI2C_RX,
+	SHDMA_SLAVE_FSI2D_RX,
 };
 
 /*
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 7f4757f..d2c18a1 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -626,6 +626,111 @@ static struct platform_device dma0_device = {
 	},
 };
 
+/* MPDMAC */
+static const struct sh_dmae_slave_config sh73a0_mpdma_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_FSI2A_RX,
+		.addr		= 0xec230020,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd6, /* CHECK ME */
+	}, {
+		.slave_id	= SHDMA_SLAVE_FSI2A_TX,
+		.addr		= 0xec230024,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd5, /* CHECK ME */
+	}, {
+		.slave_id	= SHDMA_SLAVE_FSI2C_RX,
+		.addr		= 0xec230060,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xda, /* CHECK ME */
+	}, {
+		.slave_id	= SHDMA_SLAVE_FSI2C_TX,
+		.addr		= 0xec230064,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd9, /* CHECK ME */
+	}, {
+		.slave_id	= SHDMA_SLAVE_FSI2B_RX,
+		.addr		= 0xec240020,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0x8e, /* CHECK ME */
+	}, {
+		.slave_id	= SHDMA_SLAVE_FSI2B_TX,
+		.addr		= 0xec240024,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0x8d, /* CHECK ME */
+	}, {
+		.slave_id	= SHDMA_SLAVE_FSI2D_RX,
+		.addr		=  0xec240060,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0x9a, /* CHECK ME */
+	},
+};
+
+#define MPDMA_CHANNEL(a, b, c) \
+	{ .offset = a, .dmars = b, .dmars_bit = c, .chclr_offset = (0x220 - 0x20) + a }
+
+static const struct sh_dmae_channel sh73a0_mpdma_channels[] = {
+	MPDMA_CHANNEL(0x00, 0, 0),
+	MPDMA_CHANNEL(0x10, 0, 8),
+	MPDMA_CHANNEL(0x20, 4, 0),
+	MPDMA_CHANNEL(0x30, 4, 8),
+	MPDMA_CHANNEL(0x50, 8, 0),
+	MPDMA_CHANNEL(0x70, 8, 8),
+};
+
+static struct sh_dmae_pdata sh73a0_mpdma_platform_data = {
+	.slave		= sh73a0_mpdma_slaves,
+	.slave_num	= ARRAY_SIZE(sh73a0_mpdma_slaves),
+	.channel	= sh73a0_mpdma_channels,
+	.channel_num	= ARRAY_SIZE(sh73a0_mpdma_channels),
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
+static struct resource sh73a0_mpdma_resources[] = {
+	{
+		/* Channel registers and DMAOR */
+		.start	= 0xec618020,
+		.end	= 0xec61828f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMARSx */
+		.start	= 0xec619000,
+		.end	= 0xec61900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "error_irq",
+		.start	= gic_spi(181),
+		.end	= gic_spi(181),
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-5 */
+		.start	= gic_spi(175),
+		.end	= gic_spi(180),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mpdma0_device = {
+	.name		= "sh-dma-engine",
+	.id		= 1,
+	.resource	= sh73a0_mpdma_resources,
+	.num_resources	= ARRAY_SIZE(sh73a0_mpdma_resources),
+	.dev		= {
+		.platform_data	= &sh73a0_mpdma_platform_data,
+	},
+};
+
 static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -648,6 +753,7 @@ static struct platform_device *sh73a0_late_devices[] __initdata = {
 	&i2c3_device,
 	&i2c4_device,
 	&dma0_device,
+	&mpdma0_device,
 };
 
 #define SRCR2          0xe61580b0
-- 
1.7.5.4

