From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 08:31:58 +0000
Subject: [PATCH 03/11] ARM: shmobile: r8a7778: cleanup registration of usb phy
Message-Id: <87ip0hfqf9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

usb phy driver which needs platform data at the time of
registration is used from BockW only.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed in the future.
The driver registration method which needs platform data
and which is not shared complicates codes.
This patch registers it on board code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c          |   16 +++++++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 --
 arch/arm/mach-shmobile/setup-r8a7778.c        |   14 --------------
 3 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 4268daf..12341f3 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -23,6 +23,7 @@
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/partitions.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/usb-rcar-phy.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
@@ -153,6 +154,12 @@ static struct sh_mmcif_plat_data sh_mmcif_plat = {
 			  MMC_CAP_NEEDS_POLL,
 };
 
+/* USB PHY */
+static struct resource usb_phy_resources[] __initdata = {
+	DEFINE_RES_MEM(0xffe70800, 0x100),
+	DEFINE_RES_MEM(0xffe76000, 0x100),
+};
+
 static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
 
 static const struct pinctrl_map bockw_pinctrl_map[] = {
@@ -194,7 +201,6 @@ static void __init bockw_init(void)
 	r8a7778_add_standard_devices();
 	r8a7778_add_i2c_device(0);
 	r8a7778_add_hspi_device(0);
-	r8a7778_add_usb_phy_device(&usb_phy_platform_data);
 
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
@@ -216,6 +222,14 @@ static void __init bockw_init(void)
 		mmc_resources, ARRAY_SIZE(mmc_resources),
 		&sh_mmcif_plat, sizeof(struct sh_mmcif_plat_data));
 
+	platform_device_register_resndata(
+		&platform_bus, "rcar_usb_phy", -1,
+		usb_phy_resources,
+		ARRAY_SIZE(usb_phy_resources),
+		&usb_phy_platform_data,
+		sizeof(struct rcar_phy_platform_data));
+
+
 	/* for SMSC */
 	base = ioremap_nocache(FPGA, SZ_1M);
 	if (base) {
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 4fcbdf1..57a58dd 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -19,14 +19,12 @@
 #define __ASM_R8A7778_H__
 
 #include <linux/mmc/sh_mobile_sdhi.h>
-#include <linux/platform_data/usb-rcar-phy.h>
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
 
-extern void r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
 extern void r8a7778_init_late(void);
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq_dt(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 458426a..b2e4c37 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -95,20 +95,6 @@ static struct sh_timer_config sh_tmu1_platform_data __initdata = {
 		&sh_tmu##idx##_platform_data,		\
 		sizeof(sh_tmu##idx##_platform_data))
 
-/* USB PHY */
-static struct resource usb_phy_resources[] __initdata = {
-	DEFINE_RES_MEM(0xffe70800, 0x100),
-	DEFINE_RES_MEM(0xffe76000, 0x100),
-};
-
-void __init r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata)
-{
-	platform_device_register_resndata(&platform_bus, "rcar_usb_phy", -1,
-					  usb_phy_resources,
-					  ARRAY_SIZE(usb_phy_resources),
-					  pdata, sizeof(*pdata));
-}
-
 /* USB */
 static struct usb_phy *phy;
 
-- 
1.7.9.5

