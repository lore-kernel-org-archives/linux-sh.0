From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 13 Feb 2014 05:42:52 +0000
Subject: [PATCH 1/2 v4] ARM: shmobile: lager: add SDHI0/2 support
Message-Id: <8761ojd0vb.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SDHI0 (CN8) needs JP/SW settings

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - no change

 arch/arm/mach-shmobile/board-lager.c |   64 ++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 3175748..90d7e81 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -26,8 +26,10 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/gpio-rcar.h>
@@ -68,6 +70,19 @@
  * # amixer set "LINEOUT Mixer DACL" on
  */
 
+/*
+ * SDHI0 (CN8)
+ *
+ * JP3:  pin1
+ * SW20: pin1
+
+ * GP5_24:	1:  VDD  3.3V (defult)
+ *		0:  VDD  0.0V
+ * GP5_29:	1:  VccQ 3.3V (defult)
+ *		0:  VccQ 1.8V
+ *
+ */
+
 /* DU */
 static struct rcar_du_encoder_data lager_du_encoders[] = {
 	{
@@ -595,6 +610,34 @@ static void __init lager_add_rsnd_device(void)
 	platform_device_register_full(&cardinfo);
 }
 
+/* SDHI0 */
+static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_POWER_OFF_CARD,
+	.tmio_caps2	= MMC_CAP2_NO_MULTI_READ,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
+			  TMIO_MMC_WRPROTECT_DISABLE,
+};
+
+static struct resource sdhi0_resources[] __initdata = {
+	DEFINE_RES_MEM(0xee100000, 0x200),
+	DEFINE_RES_IRQ(gic_spi(165)),
+};
+
+/* SDHI2 */
+static struct sh_mobile_sdhi_info sdhi2_info __initdata = {
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_POWER_OFF_CARD,
+	.tmio_caps2	= MMC_CAP2_NO_MULTI_READ,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
+			  TMIO_MMC_WRPROTECT_DISABLE,
+};
+
+static struct resource sdhi2_resources[] __initdata = {
+	DEFINE_RES_MEM(0xee140000, 0x100),
+	DEFINE_RES_IRQ(gic_spi(167)),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -612,6 +655,20 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF1 (CN20: DEBUG SERIAL1) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
 				  "scif1_data", "scif1"),
+	/* SDHI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7790",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7790",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7790",
+				  "sdhi0_cd", "sdhi0"),
+	/* SDHI2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-r8a7790",
+				  "sdhi2_data4", "sdhi2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-r8a7790",
+				  "sdhi2_ctrl", "sdhi2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-r8a7790",
+				  "sdhi2_cd", "sdhi2"),
 	/* SSI (CN17: sound) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7790",
 				  "ssi0129_ctrl", "ssi"),
@@ -716,6 +773,13 @@ static void __init lager_add_standard_devices(void)
 	lager_register_usbhs();
 
 	lager_add_rsnd_device();
+
+	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 0,
+					  sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
+					  &sdhi0_info, sizeof(struct sh_mobile_sdhi_info));
+	platform_device_register_resndata(&platform_bus, "sh_mobile_sdhi", 2,
+					  sdhi2_resources, ARRAY_SIZE(sdhi2_resources),
+					  &sdhi2_info, sizeof(struct sh_mobile_sdhi_info));
 }
 
 /*
-- 
1.7.9.5

