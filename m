From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Oct 2010 06:57:25 +0000
Subject: [PATCH] ARM: mach-shmobile: add TMU platform data for sh7372
Message-Id: <20101014065725.11235.95393.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds support for the two first channels of
the TMU0 timer block on sh7372. One channel is used
for clock event, the other for clock source.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh7372.c |    5 ++
 arch/arm/mach-shmobile/setup-sh7372.c |   63 +++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2010-10-14 15:41:55.000000000 +0900
@@ -394,7 +394,7 @@ static struct clk div6_reparent_clks[DIV
 
 enum { MSTP001,
        MSTP131, MSTP130,
-       MSTP129, MSTP128, MSTP127, MSTP126,
+       MSTP129, MSTP128, MSTP127, MSTP126, MSTP125,
        MSTP118, MSTP117, MSTP116,
        MSTP106, MSTP101, MSTP100,
        MSTP223,
@@ -414,6 +414,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP128] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 28, 0), /* VEU0 */
 	[MSTP127] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 27, 0), /* CEU */
 	[MSTP126] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 26, 0), /* CSI2 */
+	[MSTP125] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 25, 0), /* TMU0 */
 	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX */
 	[MSTP117] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 17, 0), /* LCDC1 */
 	[MSTP116] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 16, 0), /* IIC0 */
@@ -501,6 +502,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("uio_pdrv_genirq.1", &mstp_clks[MSTP128]), /* VEU0 */
 	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[MSTP127]), /* CEU */
 	CLKDEV_DEV_ID("sh-mobile-csi2.0", &mstp_clks[MSTP126]), /* CSI2 */
+	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP125]), /* TMU00 */
+	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP125]), /* TMU01 */
 	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1", &mstp_clks[MSTP117]), /* LCDC1 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* IIC0 */
--- 0008/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2010-10-14 15:42:41.000000000 +0900
@@ -186,6 +186,67 @@ static struct platform_device cmt10_devi
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
+		.start	= 0xfff60008,
+		.end	= 0xfff60013,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0xe80), /* TMU_TUNI0 */
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
+		.start	= 0xfff60014,
+		.end	= 0xfff6001f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0xea0), /* TMU_TUNI1 */
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
 /* I2C */
 static struct resource iic0_resources[] = {
 	[0] = {
@@ -526,6 +587,8 @@ static struct platform_device *sh7372_ea
 	&scif5_device,
 	&scif6_device,
 	&cmt10_device,
+	&tmu00_device,
+	&tmu01_device,
 };
 
 static struct platform_device *sh7372_late_devices[] __initdata = {
