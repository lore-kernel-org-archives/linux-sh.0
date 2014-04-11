From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 11 Apr 2014 15:04:24 +0000
Subject: [PATCH v3 41/52] ARM: shmobile: r8a7790: Switch to new style CMT device
Message-Id: <1397228675-11684-42-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/mach-shmobile/board-lager-reference.c |  2 +-
 arch/arm/mach-shmobile/clock-r8a7790.c         |  2 +-
 arch/arm/mach-shmobile/setup-r8a7790.c         | 17 +++++++----------
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 013c42b..749832e 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -90,7 +90,7 @@ static void __init lager_add_du_device(void)
  * devices until they get moved to DT.
  */
 static const struct clk_name clk_names[] __initconst = {
-	{ "cmt0", NULL, "sh_cmt.0" },
+	{ "cmt0", "fck", "sh-cmt-48-gen2.0" },
 	{ "du0", "du.0", "rcar-du-r8a7790" },
 	{ "du1", "du.1", "rcar-du-r8a7790" },
 	{ "du2", "du.2", "rcar-du-r8a7790" },
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 05f92d4..c5e03fa 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -361,7 +361,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP312]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP311]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
-	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
 	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
 	CLKDEV_DEV_ID("pci-rcar-gen2.0", &mstp_clks[MSTP703]),
@@ -371,6 +370,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sata-r8a7790.1", &mstp_clks[MSTP814]),
 
 	/* ICK */
+	CLKDEV_ICK_ID("fck", "sh-cmt-48-gen2.0", &mstp_clks[MSTP124]),
 	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),
 	CLKDEV_ICK_ID("lvds.0", "rcar-du-r8a7790", &mstp_clks[MSTP726]),
 	CLKDEV_ICK_ID("lvds.1", "rcar-du-r8a7790", &mstp_clks[MSTP725]),
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index db92959..119ba2e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -263,20 +263,17 @@ static const struct resource thermal_resources[] __initconst = {
 					thermal_resources,		\
 					ARRAY_SIZE(thermal_resources))
 
-static const struct sh_timer_config cmt00_platform_data __initconst = {
-	.name = "CMT00",
-	.timer_bit = 0,
-	.clockevent_rating = 80,
+static struct sh_timer_config cmt0_platform_data = {
+	.channels_mask = 0x60,
 };
 
-static const struct resource cmt00_resources[] __initconst = {
-	DEFINE_RES_MEM(0xffca0510, 0x0c),
-	DEFINE_RES_MEM(0xffca0500, 0x04),
-	DEFINE_RES_IRQ(gic_spi(142)), /* CMT0_0 */
+static struct resource cmt0_resources[] = {
+	DEFINE_RES_MEM(0xffca0000, 0x1004),
+	DEFINE_RES_IRQ(gic_spi(142)),
 };
 
 #define r8a7790_register_cmt(idx)					\
-	platform_device_register_resndata(&platform_bus, "sh_cmt",	\
+	platform_device_register_resndata(&platform_bus, "sh-cmt-48-gen2", \
 					  idx, cmt##idx##_resources,	\
 					  ARRAY_SIZE(cmt##idx##_resources), \
 					  &cmt##idx##_platform_data,	\
@@ -284,7 +281,7 @@ static const struct resource cmt00_resources[] __initconst = {
 
 void __init r8a7790_add_dt_devices(void)
 {
-	r8a7790_register_cmt(00);
+	r8a7790_register_cmt(0);
 }
 
 void __init r8a7790_add_standard_devices(void)
-- 
1.8.3.2

