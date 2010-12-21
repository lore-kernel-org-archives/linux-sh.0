From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 21 Dec 2010 08:40:59 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 TMU support
Message-Id: <20101221084059.22950.90136.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for 2 TMU timer channels on sh73a0.

One timer channel is used for clocksource and
the other is used for clockevents. All channels
in the same TMU block share MSTP bit as usual.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the INTCS patch.

 arch/arm/mach-shmobile/clock-sh73a0.c |    5 ++
 arch/arm/mach-shmobile/setup-sh73a0.c |   63 +++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/clock-sh73a0.c
+++ work/arch/arm/mach-shmobile/clock-sh73a0.c	2010-12-20 19:53:27.000000000 +0900
@@ -255,7 +255,7 @@ static struct clk div6_clks[DIV6_NR] = {
 };
 
 enum { MSTP001,
-	MSTP116,
+	MSTP125, MSTP116,
 	MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 	MSTP331, MSTP329, MSTP323,
@@ -267,6 +267,7 @@ enum { MSTP001,
 
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP001] = MSTP(&div4_clks[DIV4_HP], SMSTPCR0, 1, 0), /* IIC2 */
+	[MSTP125] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 25, 0), /* TMU0 */
 	[MSTP116] = MSTP(&div4_clks[DIV4_HP], SMSTPCR1, 16, 0), /* IIC0 */
 	[MSTP219] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 19, 0), /* SCIFA7 */
 	[MSTP207] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 7, 0), /* SCIFA5 */
@@ -292,6 +293,8 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* I2C2 */
+	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP125]), /* TMU00 */
+	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP125]), /* TMU01 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2010-12-20 19:44:20.000000000 +0900
@@ -208,6 +208,67 @@ static struct platform_device cmt10_devi
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
+		.start	= intcs_evt2irq(0x0e80), /* TMU0_TUNI00 */
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
+		.start	= intcs_evt2irq(0x0ea0), /* TMU0_TUNI01 */
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
 static struct resource i2c0_resources[] = {
 	[0] = {
 		.name	= "IIC0",
@@ -324,6 +385,8 @@ static struct platform_device *sh73a0_ea
 	&scif7_device,
 	&scif8_device,
 	&cmt10_device,
+	&tmu00_device,
+	&tmu01_device,
 };
 
 static struct platform_device *sh73a0_late_devices[] __initdata = {
