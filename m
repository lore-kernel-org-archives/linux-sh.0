From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 08:31:48 +0000
Subject: [PATCH 02/11] ARM: shmobile: r8a7778: cleanup registration of mmcif
Message-Id: <87k3kxfqfj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_mmcif driver which needs platform data at the time of
registration is used from BockW only.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed in the future.
The driver registration method which needs platform data
and which is not shared complicates codes.
This patch registers it on board code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c          |   12 +++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 --
 arch/arm/mach-shmobile/setup-r8a7778.c        |   14 --------------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 82a5559..4268daf 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -20,6 +20,7 @@
 
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/partitions.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
@@ -139,6 +140,11 @@ static struct spi_board_info spi_board_info[] __initdata = {
 };
 
 /* MMC */
+static struct resource mmc_resources[] __initdata = {
+	DEFINE_RES_MEM(0xffe4e000, 0x100),
+	DEFINE_RES_IRQ(gic_iid(0x5d)),
+};
+
 static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
@@ -188,7 +194,6 @@ static void __init bockw_init(void)
 	r8a7778_add_standard_devices();
 	r8a7778_add_i2c_device(0);
 	r8a7778_add_hspi_device(0);
-	r8a7778_add_mmc_device(&sh_mmcif_plat);
 	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
 
 	i2c_register_board_info(0, i2c0_devices,
@@ -206,6 +211,11 @@ static void __init bockw_init(void)
 		&ether_platform_data,
 		sizeof(struct sh_eth_plat_data));
 
+	platform_device_register_resndata(
+		&platform_bus, "sh_mmcif", -1,
+		mmc_resources, ARRAY_SIZE(mmc_resources),
+		&sh_mmcif_plat, sizeof(struct sh_mmcif_plat_data));
+
 	/* for SMSC */
 	base = ioremap_nocache(FPGA, SZ_1M);
 	if (base) {
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index fab62d0..4fcbdf1 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -18,7 +18,6 @@
 #ifndef __ASM_R8A7778_H__
 #define __ASM_R8A7778_H__
 
-#include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/platform_data/usb-rcar-phy.h>
 
@@ -26,7 +25,6 @@ extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
-extern void r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info);
 
 extern void r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
 extern void r8a7778_init_late(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 21db023..458426a 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -305,20 +305,6 @@ void __init r8a7778_add_hspi_device(int id)
 		hspi_resources + (2 * id), 2);
 }
 
-/* MMC */
-static struct resource mmc_resources[] __initdata = {
-	DEFINE_RES_MEM(0xffe4e000, 0x100),
-	DEFINE_RES_IRQ(gic_iid(0x5d)),
-};
-
-void __init r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info)
-{
-	platform_device_register_resndata(
-		&platform_bus, "sh_mmcif", -1,
-		mmc_resources, ARRAY_SIZE(mmc_resources),
-		info, sizeof(*info));
-}
-
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
-- 
1.7.9.5

