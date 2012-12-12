From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 12 Dec 2012 10:08:09 +0000
Subject: [PATCH] ARM: shmobile: r8a7740: add TMU timer support
Message-Id: <871uevinw9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enabled TMU0 timer on r8a7740.
But TMU1 timer is not supported yet

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    6 +-
 arch/arm/mach-shmobile/setup-r8a7740.c |   94 ++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 6729e00..f35a51b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -554,10 +554,14 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0",	&mstp_clks[MSTP100]),
-	CLKDEV_DEV_ID("sh_tmu.1",		&mstp_clks[MSTP111]),
+	CLKDEV_DEV_ID("sh_tmu.3",		&mstp_clks[MSTP111]),
+	CLKDEV_DEV_ID("sh_tmu.4",		&mstp_clks[MSTP111]),
+	CLKDEV_DEV_ID("sh_tmu.5",		&mstp_clks[MSTP111]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.0",	&mstp_clks[MSTP116]),
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1",	&mstp_clks[MSTP117]),
 	CLKDEV_DEV_ID("sh_tmu.0",		&mstp_clks[MSTP125]),
+	CLKDEV_DEV_ID("sh_tmu.1",		&mstp_clks[MSTP125]),
+	CLKDEV_DEV_ID("sh_tmu.2",		&mstp_clks[MSTP125]),
 	CLKDEV_DEV_ID("sh_mobile_ceu.0",	&mstp_clks[MSTP127]),
 	CLKDEV_DEV_ID("sh_mobile_ceu.1",	&mstp_clks[MSTP128]),
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 11bb1d9..9cb0eb5 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -268,6 +268,97 @@ static struct platform_device cmt10_device = {
 	.num_resources	= ARRAY_SIZE(cmt10_resources),
 };
 
+/* TMU */
+static struct sh_timer_config tmu00_platform_data = {
+	.name = "TMU00",
+	.channel_offset = 0x4,
+	.timer_bit = 0,
+	.clockevent_rating = 200,
+};
+
+static struct resource tmu00_resources[] = {
+	[0] = {
+		.name	= "TMU00",
+		.start	= 0xfff80008,
+		.end	= 0xfff80014 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0xe80),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu00_device = {
+	.name		= "sh_tmu",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &tmu00_platform_data,
+	},
+	.resource	= tmu00_resources,
+	.num_resources	= ARRAY_SIZE(tmu00_resources),
+};
+
+static struct sh_timer_config tmu01_platform_data = {
+	.name = "TMU01",
+	.channel_offset = 0x10,
+	.timer_bit = 1,
+	.clocksource_rating = 200,
+};
+
+static struct resource tmu01_resources[] = {
+	[0] = {
+		.name	= "TMU01",
+		.start	= 0xfff80014,
+		.end	= 0xfff80020 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0xea0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu01_device = {
+	.name		= "sh_tmu",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &tmu01_platform_data,
+	},
+	.resource	= tmu01_resources,
+	.num_resources	= ARRAY_SIZE(tmu01_resources),
+};
+
+static struct sh_timer_config tmu02_platform_data = {
+	.name = "TMU02",
+	.channel_offset = 0x1C,
+	.timer_bit = 2,
+	.clocksource_rating = 200,
+};
+
+static struct resource tmu02_resources[] = {
+	[0] = {
+		.name	= "TMU02",
+		.start	= 0xfff80020,
+		.end	= 0xfff8002C - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0xec0),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu02_device = {
+	.name		= "sh_tmu",
+	.id		= 2,
+	.dev = {
+		.platform_data	= &tmu02_platform_data,
+	},
+	.resource	= tmu02_resources,
+	.num_resources	= ARRAY_SIZE(tmu02_resources),
+};
+
 static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -279,6 +370,9 @@ static struct platform_device *r8a7740_early_devices[] __initdata = {
 	&scif7_device,
 	&scifb_device,
 	&cmt10_device,
+	&tmu00_device,
+	&tmu01_device,
+	&tmu02_device,
 };
 
 /* DMA */
-- 
1.7.9.5

