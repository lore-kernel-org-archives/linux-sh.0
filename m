From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 30 Jun 2011 09:22:50 +0000
Subject: [PATCH] ARM: mach-shmobile: Use CMT2 for timer on sh7372
Message-Id: <20110630092250.10279.25611.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Switch the sh7372 CPU support to use CMT2 instead
of CMT1 for system timer.

CMT1 is located in the A3SP power domain while CMT2
is located in the always-on power domain C5.

This improves our PM situation - with CMT2 as timer
we can power down A3SP and still access the timer.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh7372.c |    8 ++++----
 arch/arm/mach-shmobile/setup-sh7372.c |   30 +++++++++++++++---------------
 2 files changed, 19 insertions(+), 19 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2011-06-29 19:04:32.000000000 +0900
@@ -511,8 +511,8 @@ enum { MSTP001,
        MSTP223,
        MSTP218, MSTP217, MSTP216,
        MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-       MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313, MSTP312,
-       MSTP423, MSTP415, MSTP413, MSTP411, MSTP410, MSTP406, MSTP403,
+       MSTP328, MSTP323, MSTP322, MSTP314, MSTP313, MSTP312,
+       MSTP423, MSTP415, MSTP413, MSTP411, MSTP410, MSTP406, MSTP403, MSTP400,
        MSTP_NR };
 
 #define MSTP(_parent, _reg, _bit, _flags) \
@@ -545,7 +545,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP202] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 2, 0), /* SCIFA2 */
 	[MSTP201] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 1, 0), /* SCIFA3 */
 	[MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), /* SCIFA4 */
-	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
 	[MSTP328] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR3, 28, 0), /* FSI2 */
 	[MSTP323] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 23, 0), /* IIC1 */
 	[MSTP322] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 22, 0), /* USB0 */
@@ -559,6 +558,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP410] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 10, 0), /* IIC4 */
 	[MSTP406] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 6, 0), /* USB1 */
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
+	[MSTP400] = MSTP(&r_clk, SMSTPCR4, 0, 0), /* CMT2 */
 };
 
 #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
@@ -640,7 +640,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP202]), /* SCIFA2 */
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
-	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
 	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI2 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* IIC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP322]), /* USB0 */
@@ -658,6 +657,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a66597_udc.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
+	CLKDEV_DEV_ID("sh_cmt.2", &mstp_clks[MSTP400]), /* CMT2 */
 
 	CLKDEV_ICK_ID("ick", "sh-mobile-hdmi", &div6_reparent_clks[DIV6_HDMI]),
 	CLKDEV_ICK_ID("icka", "sh_fsi2", &div6_reparent_clks[DIV6_FSIA]),
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-06-29 19:03:43.000000000 +0900
@@ -169,35 +169,35 @@ static struct platform_device scif6_devi
 };
 
 /* CMT */
-static struct sh_timer_config cmt10_platform_data = {
-	.name = "CMT10",
-	.channel_offset = 0x10,
-	.timer_bit = 0,
+static struct sh_timer_config cmt2_platform_data = {
+	.name = "CMT2",
+	.channel_offset = 0x40,
+	.timer_bit = 5,
 	.clockevent_rating = 125,
 	.clocksource_rating = 125,
 };
 
-static struct resource cmt10_resources[] = {
+static struct resource cmt2_resources[] = {
 	[0] = {
-		.name	= "CMT10",
-		.start	= 0xe6138010,
-		.end	= 0xe613801b,
+		.name	= "CMT2",
+		.start	= 0xe6130040,
+		.end	= 0xe613004b,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= evt2irq(0x0b00), /* CMT1_CMT10 */
+		.start	= evt2irq(0x0b80), /* CMT2 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
 
-static struct platform_device cmt10_device = {
+static struct platform_device cmt2_device = {
 	.name		= "sh_cmt",
-	.id		= 10,
+	.id		= 2,
 	.dev = {
-		.platform_data	= &cmt10_platform_data,
+		.platform_data	= &cmt2_platform_data,
 	},
-	.resource	= cmt10_resources,
-	.num_resources	= ARRAY_SIZE(cmt10_resources),
+	.resource	= cmt2_resources,
+	.num_resources	= ARRAY_SIZE(cmt2_resources),
 };
 
 /* TMU */
@@ -818,7 +818,7 @@ static struct platform_device *sh7372_ea
 	&scif4_device,
 	&scif5_device,
 	&scif6_device,
-	&cmt10_device,
+	&cmt2_device,
 	&tmu00_device,
 	&tmu01_device,
 };
