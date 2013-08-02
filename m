From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 01:34:09 +0000
Subject: [PATCH 3/4] ARM: shmobile: bockw: add missing __initdata
Message-Id: <87siys98q9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds missing __initdata to driver data/resource
which are used from platform_device_register_xxx()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 8094803..4424058 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -78,14 +78,14 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
 };
 
-static struct smsc911x_platform_config smsc911x_data = {
+static struct smsc911x_platform_config smsc911x_data __initdata = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
 	.flags		= SMSC911X_USE_32BIT,
 	.phy_interface	= PHY_INTERFACE_MODE_MII,
 };
 
-static struct resource smsc911x_resources[] = {
+static struct resource smsc911x_resources[] __initdata = {
 	DEFINE_RES_MEM(0x18300000, 0x1000),
 	DEFINE_RES_IRQ(irq_pin(0)), /* IRQ 0 */
 };
@@ -157,7 +157,7 @@ static struct rcar_phy_platform_data usb_phy_platform_data __initdata  
 
 /* SDHI */
-static struct sh_mobile_sdhi_info sdhi0_info = {
+static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
@@ -222,7 +222,7 @@ static struct resource mmc_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x5d)),
 };
 
-static struct sh_mmcif_plat_data sh_mmcif_plat = {
+static struct sh_mmcif_plat_data sh_mmcif_plat __initdata = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.caps		= MMC_CAP_4_BIT_DATA |
-- 
1.7.9.5

