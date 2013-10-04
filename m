From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 04 Oct 2013 01:30:55 +0000
Subject: [PATCH 2/7] ARM: shmobile: bockw: use regulator for MMCIF
Message-Id: <874n8x256b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When regulators are used with MMC devices, sh_mmcif_plat_data::ocr
is not needed, they can be removed from platform data.
This patch adds v3.3 regulator settings,
and moved fixed-dummy regulator registration position

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 6163fb1..1b1dae3 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -116,6 +116,11 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
 };
 
+static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif"),
+	REGULATOR_SUPPLY("vqmmc", "sh_mmcif"),
+};
+
 static struct smsc911x_platform_config smsc911x_data __initdata = {
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
 	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
@@ -271,7 +276,6 @@ static struct resource mmc_resources[] __initdata = {
 
 static struct sh_mmcif_plat_data sh_mmcif_plat __initdata = {
 	.sup_pclk	= 0,
-	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.caps		= MMC_CAP_4_BIT_DATA |
 			  MMC_CAP_8_BIT_DATA |
 			  MMC_CAP_NEEDS_POLL,
@@ -614,6 +618,10 @@ static void __init bockw_init(void)
 		&usb_phy_platform_data,
 		sizeof(struct rcar_phy_platform_data));
 
+	regulator_register_fixed(0, dummy_supplies,
+				 ARRAY_SIZE(dummy_supplies));
+	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 
 	/* for SMSC */
 	fpga = ioremap_nocache(FPGA, SZ_1M);
@@ -629,9 +637,6 @@ static void __init bockw_init(void)
 		val &= ~(1 << 4); /* enable SMSC911x */
 		iowrite16(val, fpga + IRQ0MR);
 
-		regulator_register_fixed(0, dummy_supplies,
-					 ARRAY_SIZE(dummy_supplies));
-
 		platform_device_register_resndata(
 			&platform_bus, "smsc911x", -1,
 			smsc911x_resources, ARRAY_SIZE(smsc911x_resources),
-- 
1.7.9.5

