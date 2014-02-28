From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:58:04 +0000
Subject: [PATCH v2 34/40] ARM: shmobile: sh73a0: Switch to new style CMT device
Message-Id: <1393603090-23144-35-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The CMT (Compare Match Timer) driver implements a new style of platform
data that handles the timer as a single device with multiple channel.
Switch from the old-style platform data to the new-style platform data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |  2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c | 36 ++++++++++++-----------------------
 2 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 23edf83..ca03989 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -650,7 +650,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
-	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
 	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI */
 	CLKDEV_DEV_ID("ec230000.sound", &mstp_clks[MSTP328]), /* FSI */
 	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[MSTP325]), /* IrDA */
@@ -683,6 +682,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
 	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.0", &dsi0phy_clk),
 	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.1", &dsi1phy_clk),
+	CLKDEV_ICK_ID("fck", "sh-cmt-48.1", &mstp_clks[MSTP329]), /* CMT1 */
 };
 
 void __init sh73a0_clock_init(void)
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index f74ab53..61b15d9 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -104,35 +104,23 @@ SH73A0_SCIF(PORT_SCIFA, 6, 0xe6cc0000, gic_spi(156));
 SH73A0_SCIF(PORT_SCIFA, 7, 0xe6cd0000, gic_spi(143));
 SH73A0_SCIF(PORT_SCIFB, 8, 0xe6c30000, gic_spi(80));
 
-static struct sh_timer_config cmt10_platform_data = {
-	.name = "CMT10",
-	.channel_offset = 0x10,
-	.timer_bit = 0,
-	.clockevent_rating = 80,
-	.clocksource_rating = 125,
+static struct sh_timer_config cmt1_platform_data = {
+	.channels_mask = 0x3f,
 };
 
-static struct resource cmt10_resources[] = {
-	[0] = {
-		.name	= "CMT10",
-		.start	= 0xe6138010,
-		.end	= 0xe613801b,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= gic_spi(65),
-		.flags	= IORESOURCE_IRQ,
-	},
+static struct resource cmt1_resources[] = {
+	DEFINE_RES_MEM(0xe6138010, 0x200),
+	DEFINE_RES_IRQ(gic_spi(65)),
 };
 
-static struct platform_device cmt10_device = {
-	.name		= "sh_cmt",
-	.id		= 10,
+static struct platform_device cmt1_device = {
+	.name		= "sh-cmt-48",
+	.id		= 1,
 	.dev = {
-		.platform_data	= &cmt10_platform_data,
+		.platform_data	= &cmt1_platform_data,
 	},
-	.resource	= cmt10_resources,
-	.num_resources	= ARRAY_SIZE(cmt10_resources),
+	.resource	= cmt1_resources,
+	.num_resources	= ARRAY_SIZE(cmt1_resources),
 };
 
 /* TMU */
@@ -746,7 +734,7 @@ static struct platform_device *sh73a0_devices_dt[] __initdata = {
 	&scif6_device,
 	&scif7_device,
 	&scif8_device,
-	&cmt10_device,
+	&cmt1_device,
 };
 
 static struct platform_device *sh73a0_early_devices[] __initdata = {
-- 
1.8.3.2

