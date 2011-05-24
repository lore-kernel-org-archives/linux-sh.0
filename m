From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 24 May 2011 10:37:16 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 DMA Engine support for SY-DMAC
Message-Id: <20110524103716.10342.89052.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SY-DMAC support via shdma.c to the sh73a0 SoC
including slave ids, platform data and clock bindings.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Has a runtime dependency on the series:
 "[PATCH 00/03] dmaengine: shdma: sh73a0 and SH_DMAC_MAX_CHANNELS"

 arch/arm/mach-shmobile/clock-sh73a0.c        |    5 
 arch/arm/mach-shmobile/include/mach/sh73a0.h |   29 +++
 arch/arm/mach-shmobile/setup-sh73a0.c        |  244 ++++++++++++++++++++++++++
 3 files changed, 277 insertions(+), 1 deletion(-)

--- 0009/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2011-05-24 19:02:00.000000000 +0900
@@ -266,7 +266,8 @@ enum { MSTP001,
 	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP100,
 	MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-	MSTP331, MSTP329, MSTP325, MSTP323, MSTP314, MSTP313, MSTP312, MSTP311,
+	MSTP331, MSTP329, MSTP325, MSTP323, MSTP318,
+	MSTP314, MSTP313, MSTP312, MSTP311,
 	MSTP411, MSTP410, MSTP403,
 	MSTP_NR };
 
@@ -295,6 +296,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
 	[MSTP325] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 25, 0), /* IrDA */
 	[MSTP323] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 23, 0), /* IIC1 */
+	[MSTP318] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 18, 0), /* SY-DMAC */
 	[MSTP314] = MSTP(&div6_clks[DIV6_SDHI0], SMSTPCR3, 14, 0), /* SDHI0 */
 	[MSTP313] = MSTP(&div6_clks[DIV6_SDHI1], SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMCIF0 */
@@ -347,6 +349,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
 	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[MSTP325]), /* IrDA */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
+	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP318]), /* SY-DMAC */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
--- 0001/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ work/arch/arm/mach-shmobile/include/mach/sh73a0.h	2011-05-24 19:02:00.000000000 +0900
@@ -463,5 +463,34 @@ enum {
 	GPIO_FN_FSIAIBT_PU,
 	GPIO_FN_FSIAISLD_PU,
 };
+/* DMA slave IDs */
+enum {
+	SHDMA_SLAVE_SCIF0_TX,
+	SHDMA_SLAVE_SCIF0_RX,
+	SHDMA_SLAVE_SCIF1_TX,
+	SHDMA_SLAVE_SCIF1_RX,
+	SHDMA_SLAVE_SCIF2_TX,
+	SHDMA_SLAVE_SCIF2_RX,
+	SHDMA_SLAVE_SCIF3_TX,
+	SHDMA_SLAVE_SCIF3_RX,
+	SHDMA_SLAVE_SCIF4_TX,
+	SHDMA_SLAVE_SCIF4_RX,
+	SHDMA_SLAVE_SCIF5_TX,
+	SHDMA_SLAVE_SCIF5_RX,
+	SHDMA_SLAVE_SCIF6_TX,
+	SHDMA_SLAVE_SCIF6_RX,
+	SHDMA_SLAVE_SCIF7_TX,
+	SHDMA_SLAVE_SCIF7_RX,
+	SHDMA_SLAVE_SCIF8_TX,
+	SHDMA_SLAVE_SCIF8_RX,
+	SHDMA_SLAVE_SDHI0_TX,
+	SHDMA_SLAVE_SDHI0_RX,
+	SHDMA_SLAVE_SDHI1_TX,
+	SHDMA_SLAVE_SDHI1_RX,
+	SHDMA_SLAVE_SDHI2_TX,
+	SHDMA_SLAVE_SDHI2_RX,
+	SHDMA_SLAVE_MMCIF_TX,
+	SHDMA_SLAVE_MMCIF_RX,
+};
 
 #endif /* __ASM_SH73A0_H__ */
--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2011-05-24 19:06:48.000000000 +0900
@@ -27,9 +27,11 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_dma.h>
 #include <linux/sh_intc.h>
 #include <linux/sh_timer.h>
 #include <mach/hardware.h>
+#include <mach/sh73a0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -392,6 +394,242 @@ static struct platform_device i2c4_devic
 	.num_resources	= ARRAY_SIZE(i2c4_resources),
 };
 
+/* Transmit sizes and respective CHCR register values */
+enum {
+	XMIT_SZ_8BIT		= 0,
+	XMIT_SZ_16BIT		= 1,
+	XMIT_SZ_32BIT		= 2,
+	XMIT_SZ_64BIT		= 7,
+	XMIT_SZ_128BIT		= 3,
+	XMIT_SZ_256BIT		= 4,
+	XMIT_SZ_512BIT		= 5,
+};
+
+/* log2(size / 8) - used to calculate number of transfers */
+#define TS_SHIFT {			\
+	[XMIT_SZ_8BIT]		= 0,	\
+	[XMIT_SZ_16BIT]		= 1,	\
+	[XMIT_SZ_32BIT]		= 2,	\
+	[XMIT_SZ_64BIT]		= 3,	\
+	[XMIT_SZ_128BIT]	= 4,	\
+	[XMIT_SZ_256BIT]	= 5,	\
+	[XMIT_SZ_512BIT]	= 6,	\
+}
+
+#define TS_INDEX2VAL(i) ((((i) & 3) << 3) | (((i) & 0xc) << (20 - 2)))
+#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
+
+static const struct sh_dmae_slave_config sh73a0_dmae_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_SCIF0_TX,
+		.addr		= 0xe6c40020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x21,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF0_RX,
+		.addr		= 0xe6c40024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x22,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF1_TX,
+		.addr		= 0xe6c50020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x25,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF1_RX,
+		.addr		= 0xe6c50024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x26,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF2_TX,
+		.addr		= 0xe6c60020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x29,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF2_RX,
+		.addr		= 0xe6c60024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF3_TX,
+		.addr		= 0xe6c70020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2d,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF3_RX,
+		.addr		= 0xe6c70024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2e,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF4_TX,
+		.addr		= 0xe6c80020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x39,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF4_RX,
+		.addr		= 0xe6c80024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF5_TX,
+		.addr		= 0xe6cb0020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x35,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF5_RX,
+		.addr		= 0xe6cb0024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x36,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF6_TX,
+		.addr		= 0xe6cc0020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x1d,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF6_RX,
+		.addr		= 0xe6cc0024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x1e,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF7_TX,
+		.addr		= 0xe6cd0020,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x19,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF7_RX,
+		.addr		= 0xe6cd0024,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x1a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF8_TX,
+		.addr		= 0xe6c30040,
+		.chcr		= CHCR_TX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3d,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF8_RX,
+		.addr		= 0xe6c30060,
+		.chcr		= CHCR_RX(XMIT_SZ_8BIT),
+		.mid_rid	= 0x3e,
+	}, {
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
+		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
+		.addr		= 0xe6bd0034,
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
+		.addr		= 0xe6bd0034,
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd2,
+	},
+};
+
+#define DMAE_CHANNEL(_offset)					\
+	{							\
+		.offset         = _offset - 0x20,		\
+		.dmars          = _offset - 0x20 + 0x40,	\
+	}
+
+static const struct sh_dmae_channel sh73a0_dmae_channels[] = {
+	DMAE_CHANNEL(0x8000),
+	DMAE_CHANNEL(0x8080),
+	DMAE_CHANNEL(0x8100),
+	DMAE_CHANNEL(0x8180),
+	DMAE_CHANNEL(0x8200),
+	DMAE_CHANNEL(0x8280),
+	DMAE_CHANNEL(0x8300),
+	DMAE_CHANNEL(0x8380),
+	DMAE_CHANNEL(0x8400),
+	DMAE_CHANNEL(0x8480),
+	DMAE_CHANNEL(0x8500),
+	DMAE_CHANNEL(0x8580),
+	DMAE_CHANNEL(0x8600),
+	DMAE_CHANNEL(0x8680),
+	DMAE_CHANNEL(0x8700),
+	DMAE_CHANNEL(0x8780),
+	DMAE_CHANNEL(0x8800),
+	DMAE_CHANNEL(0x8880),
+	DMAE_CHANNEL(0x8900),
+	DMAE_CHANNEL(0x8980),
+};
+
+static const unsigned int ts_shift[] = TS_SHIFT;
+
+static struct sh_dmae_pdata sh73a0_dmae_platform_data = {
+	.slave          = sh73a0_dmae_slaves,
+	.slave_num      = ARRAY_SIZE(sh73a0_dmae_slaves),
+	.channel        = sh73a0_dmae_channels,
+	.channel_num    = ARRAY_SIZE(sh73a0_dmae_channels),
+	.ts_low_shift   = 3,
+	.ts_low_mask    = 0x18,
+	.ts_high_shift  = (20 - 2),     /* 2 bits for shifted low TS */
+	.ts_high_mask   = 0x00300000,
+	.ts_shift       = ts_shift,
+	.ts_shift_num   = ARRAY_SIZE(ts_shift),
+	.dmaor_init     = DMAOR_DME,
+};
+
+static struct resource sh73a0_dmae_resources[] = {
+	{
+		/* Registers including DMAOR and channels including DMARSx */
+		.start  = 0xfe000020,
+		.end    = 0xfe008a00 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	{
+		/* DMA error IRQ */
+		.start  = gic_spi(129),
+		.end    = gic_spi(129),
+		.flags  = IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-19 */
+		.start  = gic_spi(109),
+		.end    = gic_spi(128),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dma0_device = {
+	.name		= "sh-dma-engine",
+	.id		= 0,
+	.resource	= sh73a0_dmae_resources,
+	.num_resources	= ARRAY_SIZE(sh73a0_dmae_resources),
+	.dev		= {
+		.platform_data	= &sh73a0_dmae_platform_data,
+	},
+};
+
 static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -413,10 +651,16 @@ static struct platform_device *sh73a0_la
 	&i2c2_device,
 	&i2c3_device,
 	&i2c4_device,
+	&dma0_device,
 };
 
+#define SRCR2          0xe61580b0
+
 void __init sh73a0_add_standard_devices(void)
 {
+	/* Clear software reset bit on SY-DMAC module */
+	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
+
 	platform_add_devices(sh73a0_early_devices,
 			    ARRAY_SIZE(sh73a0_early_devices));
 	platform_add_devices(sh73a0_late_devices,
