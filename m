From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Date: Fri, 19 Nov 2010 13:20:45 +0000
Subject: [PATCH 1/2] ARM: sh-mobile: sh73a0 i2c_shmobile support.
Message-Id: <4CE679AD.2020109@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Platform device resource/data definition for CPU, and clkdev entries

Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |   21 ++++++-
 arch/arm/mach-shmobile/setup-sh73a0.c |  115 +++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 82c7251..6e48aae 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -40,21 +40,30 @@ static struct clk sub_clk = {
 	.rate           = 48000000,
 };
 
+/* Temporarily fixed 104 MHz HP clock */
+static struct clk hp_clk = {
+	.rate           = 104000000,
+};
+
 static struct clk *main_clks[] = {
 	&r_clk,
 	&sub_clk,
+	&hp_clk,
 };
 
 enum { MSTP219,
-	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-	MSTP331, MSTP329, MSTP403,
+	MSTP001, MSTP116, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
+	MSTP201, MSTP200, MSTP323, MSTP331, MSTP329, MSTP312, MSTP411,
+	MSTP410, MSTP403,
 	MSTP_NR };
 
 #define MSTP(_parent, _reg, _bit, _flags) \
 	SH_CLK_MSTP32(_parent, _reg, _bit, _flags)
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP001] = MSTP(&hp_clk, SMSTPCR0, 1, 0), /* I2C2 */
 	[MSTP219] = MSTP(&sub_clk, SMSTPCR2, 19, 0), /* SCIFA7 */
+	[MSTP116] = MSTP(&hp_clk, SMSTPCR1, 16, 0), /* I2C0 */
 	[MSTP207] = MSTP(&sub_clk, SMSTPCR2, 7, 0), /* SCIFA5 */
 	[MSTP206] = MSTP(&sub_clk, SMSTPCR2, 6, 0), /* SCIFB */
 	[MSTP204] = MSTP(&sub_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
@@ -64,7 +73,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP200] = MSTP(&sub_clk, SMSTPCR2, 0, 0), /* SCIFA4 */
 	[MSTP331] = MSTP(&sub_clk, SMSTPCR3, 31, 0), /* SCIFA6 */
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
+	[MSTP323] = MSTP(&hp_clk, SMSTPCR3, 23, 0), /* I2C1 */
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 0, 0), /* KEYSC0 */
+	[MSTP411] = MSTP(&hp_clk, SMSTPCR4, 11, 0), /* I2C3 */
+	[MSTP410] = MSTP(&hp_clk, SMSTPCR4, 10, 0), /* I2C4 */
 };
 
 #define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
@@ -82,6 +94,11 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
 	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC0 */
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
+	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
+	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* I2C2 */
+	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* I2C3 */
+	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
 };
 
 void __init sh73a0_clock_init(void)
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 0bc1106..53f1ea6 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -208,6 +208,111 @@ static struct platform_device cmt10_device = {
 	.num_resources	= ARRAY_SIZE(cmt10_resources),
 };
 
+static struct resource i2c0_resources[] = {
+	[0] = {
+		.name	= "IIC0",
+		.start	= 0xe6820000,
+		.end	= 0xe6820425 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(167),
+		.end	= gic_spi(170),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource i2c1_resources[] = {
+	[0] = {
+		.name	= "IIC1",
+		.start	= 0xe6822000,
+		.end	= 0xe6822425 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(51),
+		.end	= gic_spi(54),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource i2c2_resources[] = {
+	[0] = {
+		.name	= "IIC2",
+		.start	= 0xe6824000,
+		.end	= 0xe6824425 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(171),
+		.end	= gic_spi(174),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource i2c3_resources[] = {
+	[0] = {
+		.name	= "IIC3",
+		.start	= 0xe6826000,
+		.end	= 0xe6826425 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(183),
+		.end	= gic_spi(186),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource i2c4_resources[] = {
+	[0] = {
+		.name	= "IIC4",
+		.start	= 0xe6828000,
+		.end	= 0xe6828425 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(187),
+		.end	= gic_spi(190),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device i2c0_device = {
+	.name		= "i2c-sh_mobile",
+	.id		= 0,
+	.resource	= i2c0_resources,
+	.num_resources	= ARRAY_SIZE(i2c0_resources),
+};
+
+static struct platform_device i2c1_device = {
+	.name		= "i2c-sh_mobile",
+	.id		= 1,
+	.resource	= i2c1_resources,
+	.num_resources	= ARRAY_SIZE(i2c1_resources),
+};
+
+static struct platform_device i2c2_device = {
+	.name		= "i2c-sh_mobile",
+	.id		= 2,
+	.resource	= i2c2_resources,
+	.num_resources	= ARRAY_SIZE(i2c2_resources),
+};
+
+static struct platform_device i2c3_device = {
+	.name		= "i2c-sh_mobile",
+	.id		= 3,
+	.resource	= i2c3_resources,
+	.num_resources	= ARRAY_SIZE(i2c3_resources),
+};
+
+static struct platform_device i2c4_device = {
+	.name		= "i2c-sh_mobile",
+	.id		= 4,
+	.resource	= i2c4_resources,
+	.num_resources	= ARRAY_SIZE(i2c4_resources),
+};
+
 static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -221,10 +326,20 @@ static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&cmt10_device,
 };
 
+static struct platform_device *sh73a0_late_devices[] __initdata = {
+	&i2c0_device,
+	&i2c1_device,
+	&i2c2_device,
+	&i2c3_device,
+	&i2c4_device,
+};
+
 void __init sh73a0_add_standard_devices(void)
 {
 	platform_add_devices(sh73a0_early_devices,
 			    ARRAY_SIZE(sh73a0_early_devices));
+	platform_add_devices(sh73a0_late_devices,
+			    ARRAY_SIZE(sh73a0_late_devices));
 }
 
 void __init sh73a0_add_early_devices(void)
-- 1.7.2.2 
