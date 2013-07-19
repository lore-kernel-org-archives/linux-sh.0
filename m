From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Jul 2013 20:22:52 +0000
Subject: [PATCH v2 11/15] ARM: shmobile: r8a7740: switch DMAC controllers to using device ID data
Message-Id: <1374265376-30777-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1374251374-30186-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374251374-30186-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This patch removes DMAC platform data on r8a7740 and switches to using
device ID data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    6 +-
 arch/arm/mach-shmobile/setup-r8a7740.c |  106 +-------------------------------
 2 files changed, 6 insertions(+), 106 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index de10fd7..62b86f9 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -575,9 +575,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.5",		&mstp_clks[MSTP207]),
 	CLKDEV_DEV_ID("e6cb0000.sci",		&mstp_clks[MSTP207]),
 	CLKDEV_DEV_ID("sh-dma-engine.3",	&mstp_clks[MSTP214]),
-	CLKDEV_DEV_ID("sh-dma-engine.2",	&mstp_clks[MSTP216]),
-	CLKDEV_DEV_ID("sh-dma-engine.1",	&mstp_clks[MSTP217]),
-	CLKDEV_DEV_ID("sh-dma-engine.0",	&mstp_clks[MSTP218]),
+	CLKDEV_DEV_ID("shdma-r8a7740.2",	&mstp_clks[MSTP216]),
+	CLKDEV_DEV_ID("shdma-r8a7740.1",	&mstp_clks[MSTP217]),
+	CLKDEV_DEV_ID("shdma-r8a7740.0",	&mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("sh-sci.7",		&mstp_clks[MSTP222]),
 	CLKDEV_DEV_ID("e6cd0000.sci",		&mstp_clks[MSTP222]),
 	CLKDEV_DEV_ID("sh-sci.6",		&mstp_clks[MSTP230]),
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 84c5bb6..01dcb3b 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -542,97 +542,6 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 };
 
 /* DMA */
-static const struct sh_dmae_slave_config r8a7740_dmae_slaves[] = {
-	{
-		.slave_id	= SHDMA_SLAVE_SDHI0_TX,
-		.addr		= 0xe6850030,
-		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
-		.mid_rid	= 0xc1,
-	}, {
-		.slave_id	= SHDMA_SLAVE_SDHI0_RX,
-		.addr		= 0xe6850030,
-		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
-		.mid_rid	= 0xc2,
-	}, {
-		.slave_id	= SHDMA_SLAVE_SDHI1_TX,
-		.addr		= 0xe6860030,
-		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
-		.mid_rid	= 0xc9,
-	}, {
-		.slave_id	= SHDMA_SLAVE_SDHI1_RX,
-		.addr		= 0xe6860030,
-		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
-		.mid_rid	= 0xca,
-	}, {
-		.slave_id	= SHDMA_SLAVE_SDHI2_TX,
-		.addr		= 0xe6870030,
-		.chcr		= CHCR_TX(XMIT_SZ_16BIT),
-		.mid_rid	= 0xcd,
-	}, {
-		.slave_id	= SHDMA_SLAVE_SDHI2_RX,
-		.addr		= 0xe6870030,
-		.chcr		= CHCR_RX(XMIT_SZ_16BIT),
-		.mid_rid	= 0xce,
-	}, {
-		.slave_id	= SHDMA_SLAVE_FSIA_TX,
-		.addr		= 0xfe1f0024,
-		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
-		.mid_rid	= 0xb1,
-	}, {
-		.slave_id	= SHDMA_SLAVE_FSIA_RX,
-		.addr		= 0xfe1f0020,
-		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
-		.mid_rid	= 0xb2,
-	}, {
-		.slave_id	= SHDMA_SLAVE_FSIB_TX,
-		.addr		= 0xfe1f0064,
-		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
-		.mid_rid	= 0xb5,
-	}, {
-		.slave_id	= SHDMA_SLAVE_MMCIF_TX,
-		.addr		= 0xe6bd0034,
-		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
-		.mid_rid	= 0xd1,
-	}, {
-		.slave_id	= SHDMA_SLAVE_MMCIF_RX,
-		.addr		= 0xe6bd0034,
-		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
-		.mid_rid	= 0xd2,
-	},
-};
-
-#define DMA_CHANNEL(a, b, c)			\
-{						\
-	.offset		= a,			\
-	.dmars		= b,			\
-	.dmars_bit	= c,			\
-	.chclr_offset	= (0x220 - 0x20) + a	\
-}
-
-static const struct sh_dmae_channel r8a7740_dmae_channels[] = {
-	DMA_CHANNEL(0x00, 0, 0),
-	DMA_CHANNEL(0x10, 0, 8),
-	DMA_CHANNEL(0x20, 4, 0),
-	DMA_CHANNEL(0x30, 4, 8),
-	DMA_CHANNEL(0x50, 8, 0),
-	DMA_CHANNEL(0x60, 8, 8),
-};
-
-static struct sh_dmae_pdata dma_platform_data = {
-	.slave		= r8a7740_dmae_slaves,
-	.slave_num	= ARRAY_SIZE(r8a7740_dmae_slaves),
-	.channel	= r8a7740_dmae_channels,
-	.channel_num	= ARRAY_SIZE(r8a7740_dmae_channels),
-	.ts_low_shift	= TS_LOW_SHIFT,
-	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
-	.ts_high_shift	= TS_HI_SHIFT,
-	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
-	.ts_shift	= dma_ts_shift,
-	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
-	.dmaor_init	= DMAOR_DME,
-	.chclr_present	= 1,
-};
-
 /* Resource order important! */
 static struct resource r8a7740_dmae0_resources[] = {
 	{
@@ -718,33 +627,24 @@ static struct resource r8a7740_dmae2_resources[] = {
 };
 
 static struct platform_device dma0_device = {
-	.name		= "sh-dma-engine",
+	.name		= "shdma-r8a7740",
 	.id		= 0,
 	.resource	= r8a7740_dmae0_resources,
 	.num_resources	= ARRAY_SIZE(r8a7740_dmae0_resources),
-	.dev		= {
-		.platform_data	= &dma_platform_data,
-	},
 };
 
 static struct platform_device dma1_device = {
-	.name		= "sh-dma-engine",
+	.name		= "shdma-r8a7740",
 	.id		= 1,
 	.resource	= r8a7740_dmae1_resources,
 	.num_resources	= ARRAY_SIZE(r8a7740_dmae1_resources),
-	.dev		= {
-		.platform_data	= &dma_platform_data,
-	},
 };
 
 static struct platform_device dma2_device = {
-	.name		= "sh-dma-engine",
+	.name		= "shdma-r8a7740",
 	.id		= 2,
 	.resource	= r8a7740_dmae2_resources,
 	.num_resources	= ARRAY_SIZE(r8a7740_dmae2_resources),
-	.dev		= {
-		.platform_data	= &dma_platform_data,
-	},
 };
 
 /* USB-DMAC */
-- 
1.7.2.5

