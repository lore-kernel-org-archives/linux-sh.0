From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 04 Jul 2013 20:38:49 +0000
Subject: [PATCH 1/6] ARM: shmobile: r8a73a4: add a DMAC platform device and clock for it
Message-Id: <1372970334-21485-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1369573557-11071-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1369573557-11071-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a DMAC platform device and clock definitions for it on r8a73a4.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c        |    4 +-
 arch/arm/mach-shmobile/include/mach/r8a73a4.h |   15 +++
 arch/arm/mach-shmobile/setup-r8a73a4.c        |  117 +++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 8ea5ef6..357b9bc 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -504,7 +504,7 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
-	MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203,
+	MSTP218, MSTP217, MSTP216, MSTP207, MSTP206, MSTP204, MSTP203,
 	MSTP329, MSTP323, MSTP318, MSTP317, MSTP316,
 	MSTP315, MSTP314, MSTP313, MSTP312, MSTP305, MSTP300,
 	MSTP411, MSTP410, MSTP409,
@@ -519,6 +519,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP207] = SH_CLK_MSTP32(&div6_clks[DIV6_MP],	SMSTPCR2, 7, 0), /* SCIFB1 */
 	[MSTP216] = SH_CLK_MSTP32(&div6_clks[DIV6_MP],	SMSTPCR2, 16, 0), /* SCIFB2 */
 	[MSTP217] = SH_CLK_MSTP32(&div6_clks[DIV6_MP],	SMSTPCR2, 17, 0), /* SCIFB3 */
+	[MSTP218] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR2, 18, 0), /* DMAC */
 	[MSTP300] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 0, 0), /* IIC2 */
 	[MSTP305] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC1],SMSTPCR3, 5, 0), /* MMCIF1 */
 	[MSTP312] = SH_CLK_MSTP32(&div6_clks[DIV6_SDHI2],SMSTPCR3, 12, 0), /* SDHI2 */
@@ -578,6 +579,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP207]),
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP217]),
+	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("e6520000.i2c", &mstp_clks[MSTP300]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index 144a85e..12a4ee9 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -1,6 +1,21 @@
 #ifndef __ASM_R8A73A4_H__
 #define __ASM_R8A73A4_H__
 
+/* DMA slave IDs */
+enum {
+	SHDMA_SLAVE_INVALID,
+	SHDMA_SLAVE_SDHI0_TX,
+	SHDMA_SLAVE_SDHI0_RX,
+	SHDMA_SLAVE_SDHI1_TX,
+	SHDMA_SLAVE_SDHI1_RX,
+	SHDMA_SLAVE_SDHI2_TX,
+	SHDMA_SLAVE_SDHI2_RX,
+	SHDMA_SLAVE_MMCIF0_TX,
+	SHDMA_SLAVE_MMCIF0_RX,
+	SHDMA_SLAVE_MMCIF1_TX,
+	SHDMA_SLAVE_MMCIF1_RX,
+};
+
 void r8a73a4_add_standard_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index d533bd2..6aa80645 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -22,8 +22,10 @@
 #include <linux/of_platform.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <mach/common.h>
+#include <mach/dma-register.h>
 #include <mach/irqs.h>
 #include <mach/r8a73a4.h>
 #include <asm/mach/arch.h>
@@ -188,6 +190,118 @@ static struct resource cmt10_resources[] = {
 					  &cmt##idx##_platform_data,	\
 					  sizeof(struct sh_timer_config))
 
+/* DMA */
+static const struct sh_dmae_slave_config dma_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
+		.addr		= 0xee100030,
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI0_RX,
+		.addr		= 0xee100030,
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc2,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI1_TX,
+		.addr		= 0xee120030,
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xc9,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI1_RX,
+		.addr		= 0xee120030,
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xca,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI2_TX,
+		.addr		= 0xee140030,
+		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xcd,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SDHI2_RX,
+		.addr		= 0xee140030,
+		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
+		.mid_rid	= 0xce,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF0_TX,
+		.addr		= 0xee200034,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF0_RX,
+		.addr		= 0xee200034,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd2,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF1_TX,
+		.addr		= 0xee220034,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xe1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF1_RX,
+		.addr		= 0xee220034,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xe2,
+	},
+};
+
+#define DMAE_CHANNEL(a, b)				\
+	{						\
+		.offset         = (a) - 0x20,		\
+		.dmars          = (a) - 0x20 + 0x40,	\
+		.chclr_bit	= (b),			\
+		.chclr_offset	= 0x80 - 0x20,		\
+	}
+
+static const struct sh_dmae_channel dma_channels[] = {
+	DMAE_CHANNEL(0x8000, 0),
+	DMAE_CHANNEL(0x8080, 1),
+	DMAE_CHANNEL(0x8100, 2),
+	DMAE_CHANNEL(0x8180, 3),
+	DMAE_CHANNEL(0x8200, 4),
+	DMAE_CHANNEL(0x8280, 5),
+	DMAE_CHANNEL(0x8300, 6),
+	DMAE_CHANNEL(0x8380, 7),
+	DMAE_CHANNEL(0x8400, 8),
+	DMAE_CHANNEL(0x8480, 9),
+	DMAE_CHANNEL(0x8500, 10),
+	DMAE_CHANNEL(0x8580, 11),
+	DMAE_CHANNEL(0x8600, 12),
+	DMAE_CHANNEL(0x8680, 13),
+	DMAE_CHANNEL(0x8700, 14),
+	DMAE_CHANNEL(0x8780, 15),
+	DMAE_CHANNEL(0x8800, 16),
+	DMAE_CHANNEL(0x8880, 17),
+	DMAE_CHANNEL(0x8900, 18),
+	DMAE_CHANNEL(0x8980, 19),
+};
+
+static struct sh_dmae_pdata dma_platform_data = {
+	.slave		= dma_slaves,
+	.slave_num	= ARRAY_SIZE(dma_slaves),
+	.channel	= dma_channels,
+	.channel_num	= ARRAY_SIZE(dma_channels),
+	.ts_low_shift	= TS_LOW_SHIFT,
+	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
+	.ts_high_shift	= TS_HI_SHIFT,
+	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
+	.ts_shift	= dma_ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
+	.dmaor_init     = DMAOR_DME,
+	.chclr_present	= 1,
+};
+
+static struct resource dma_resources[] = {
+	DEFINE_RES_MEM(0xe6700020, 0x89e0),
+	DEFINE_RES_IRQ_NAMED(gic_spi(220), "error_irq"),
+	{
+		/* IRQ for channels 0-19 */
+		.start  = gic_spi(200),
+		.end    = gic_spi(219),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
 void __init r8a73a4_add_standard_devices(void)
 {
 	r8a73a4_register_scif(SCIFA0);
@@ -200,6 +314,9 @@ void __init r8a73a4_add_standard_devices(void)
 	r8a73a4_register_irqc(1);
 	r8a73a4_register_thermal();
 	r8a7790_register_cmt(10);
+	platform_device_register_resndata(&platform_bus, "sh-dma-engine", 0,
+				dma_resources, ARRAY_SIZE(dma_resources),
+				&dma_platform_data, sizeof(dma_platform_data));
 }
 
 void __init r8a73a4_init_delay(void)
-- 
1.7.2.5

