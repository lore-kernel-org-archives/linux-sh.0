From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Feb 2014 15:58:05 +0000
Subject: [PATCH v2 35/40] ARM: shmobile: r8a73a4: Switch to new style CMT device
Message-Id: <1393603090-23144-36-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/mach-shmobile/clock-r8a73a4.c |  2 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c | 17 +++++++----------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 7348d58..b5bc22c 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -597,7 +597,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6560000.i2c", &mstp_clks[MSTP317]),
 	CLKDEV_DEV_ID("e6500000.i2c", &mstp_clks[MSTP318]),
 	CLKDEV_DEV_ID("e6510000.i2c", &mstp_clks[MSTP323]),
-	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]),
+	CLKDEV_ICK_ID("fck", "sh-cmt-48-gen2.1", &mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("e60b0000.i2c", &mstp_clks[MSTP409]),
 	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP410]),
 	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP411]),
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index cd36f80..9333770 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -169,20 +169,17 @@ static const struct resource thermal0_resources[] = {
 					thermal0_resources,		\
 					ARRAY_SIZE(thermal0_resources))
 
-static struct sh_timer_config cmt10_platform_data = {
-	.name = "CMT10",
-	.timer_bit = 0,
-	.clockevent_rating = 80,
+static struct sh_timer_config cmt1_platform_data = {
+	.channels_mask = 0xff,
 };
 
-static struct resource cmt10_resources[] = {
-	DEFINE_RES_MEM(0xe6130010, 0x0c),
-	DEFINE_RES_MEM(0xe6130000, 0x04),
-	DEFINE_RES_IRQ(gic_spi(120)), /* CMT1_0 */
+static struct resource cmt1_resources[] = {
+	DEFINE_RES_MEM(0xe6130000, 0x1004),
+	DEFINE_RES_IRQ(gic_spi(120)),
 };
 
 #define r8a7790_register_cmt(idx)					\
-	platform_device_register_resndata(&platform_bus, "sh_cmt",	\
+	platform_device_register_resndata(&platform_bus, "sh-cmt-48-gen2", \
 					  idx, cmt##idx##_resources,	\
 					  ARRAY_SIZE(cmt##idx##_resources), \
 					  &cmt##idx##_platform_data,	\
@@ -196,7 +193,7 @@ void __init r8a73a4_add_dt_devices(void)
 	r8a73a4_register_scif(3);
 	r8a73a4_register_scif(4);
 	r8a73a4_register_scif(5);
-	r8a7790_register_cmt(10);
+	r8a7790_register_cmt(1);
 }
 
 /* DMA */
-- 
1.8.3.2

