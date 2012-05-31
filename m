From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 31 May 2012 00:23:51 +0000
Subject: [PATCH 6/9] ARM: mach-shmobile: r8a7740: add USB DMAEngine support
Message-Id: <87k3zt8agc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c        |    4 +-
 arch/arm/mach-shmobile/include/mach/r8a7740.h |    2 +
 arch/arm/mach-shmobile/setup-r8a7740.c        |   73 +++++++++++++++++++++++++
 3 files changed, 78 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 39b1311..daf3eac 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -463,7 +463,7 @@ enum {
 
 	MSTP230,
 	MSTP222,
-	MSTP218, MSTP217, MSTP216,
+	MSTP218, MSTP217, MSTP216, MSTP214,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 
 	MSTP329, MSTP328, MSTP323, MSTP320,
@@ -489,6 +489,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP218] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 18, 0), /* DMAC1 */
 	[MSTP217] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 17, 0), /* DMAC2 */
 	[MSTP216] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 16, 0), /* DMAC3 */
+	[MSTP214] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 14, 0), /* USBDMAC */
 	[MSTP207] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2,  7, 0), /* SCIFA5 */
 	[MSTP206] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2,  6, 0), /* SCIFB */
 	[MSTP204] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2,  4, 0), /* SCIFA0 */
@@ -567,6 +568,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.0",		&mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.8",		&mstp_clks[MSTP206]),
 	CLKDEV_DEV_ID("sh-sci.5",		&mstp_clks[MSTP207]),
+	CLKDEV_DEV_ID("sh-dma-engine.3",	&mstp_clks[MSTP214]),
 	CLKDEV_DEV_ID("sh-dma-engine.2",	&mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("sh-dma-engine.1",	&mstp_clks[MSTP217]),
 	CLKDEV_DEV_ID("sh-dma-engine.0",	&mstp_clks[MSTP218]),
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7740.h b/arch/arm/mach-shmobile/include/mach/r8a7740.h
index 0f14ce8..8bd7b9c 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7740.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7740.h
@@ -600,6 +600,8 @@ enum {
 	SHDMA_SLAVE_FSIA_RX,
 	SHDMA_SLAVE_FSIA_TX,
 	SHDMA_SLAVE_FSIB_TX,
+	SHDMA_SLAVE_USBHS_TX,
+	SHDMA_SLAVE_USBHS_RX,
 };
 
 #endif /* __ASM_R8A7740_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 794afeb..f98564d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -472,6 +472,78 @@ static struct platform_device dma2_device = {
 	},
 };
 
+/* USB-DMAC */
+unsigned int usbts_shift[] = USBTS_SHIFT;
+
+static const struct sh_dmae_channel r8a7740_usb_dma_channels[] = {
+	{
+		.offset = 0,
+	}, {
+		.offset = 0x20,
+	},
+};
+
+static const struct sh_dmae_slave_config r8a7740_usb_dma_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_USBHS_TX,
+		.chcr		= USBTS_INDEX2VAL(USBTS_XMIT_SZ_8BYTE),
+	}, {
+		.slave_id	= SHDMA_SLAVE_USBHS_RX,
+		.chcr		= USBTS_INDEX2VAL(USBTS_XMIT_SZ_8BYTE),
+	},
+};
+
+static struct sh_dmae_pdata usb_dma_platform_data = {
+	.slave		= r8a7740_usb_dma_slaves,
+	.slave_num	= ARRAY_SIZE(r8a7740_usb_dma_slaves),
+	.channel	= r8a7740_usb_dma_channels,
+	.channel_num	= ARRAY_SIZE(r8a7740_usb_dma_channels),
+	.ts_low_shift	= USBTS_LOW_SHIFT,
+	.ts_low_mask	= USBTS_LOW_BIT << USBTS_LOW_SHIFT,
+	.ts_high_shift	= USBTS_HI_SHIFT,
+	.ts_high_mask	= USBTS_HI_BIT << USBTS_HI_SHIFT,
+	.ts_shift	= usbts_shift,
+	.ts_shift_num	= ARRAY_SIZE(usbts_shift),
+	.dmaor_init	= DMAOR_DME,
+	.chcr_offset	= 0x14,
+	.chcr_ie_bit	= 1 << 5,
+	.dmaor_is_32bit	= 1,
+	.needs_tend_set	= 1,
+	.no_dmars	= 1,
+	.slave_only	= 1,
+};
+
+static struct resource r8a7740_usb_dma_resources[] = {
+	{
+		/* Channel registers and DMAOR */
+		.start	= 0xe68a0020,
+		.end	= 0xe68a0064 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* VCR/SWR/DMICR */
+		.start	= 0xe68a0000,
+		.end	= 0xe68a0014 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* IRQ for channels */
+		.start	= evt2irq(0x0a00),
+		.end	= evt2irq(0x0a00),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb_dma_device = {
+	.name		= "sh-dma-engine",
+	.id		= 3,
+	.resource	= r8a7740_usb_dma_resources,
+	.num_resources	= ARRAY_SIZE(r8a7740_usb_dma_resources),
+	.dev		= {
+		.platform_data	= &usb_dma_platform_data,
+	},
+};
+
 /* I2C */
 static struct resource i2c0_resources[] = {
 	[0] = {
@@ -521,6 +593,7 @@ static struct platform_device *r8a7740_late_devices[] __initdata = {
 	&dma0_device,
 	&dma1_device,
 	&dma2_device,
+	&usb_dma_device,
 };
 
 /*
-- 
1.7.5.4

