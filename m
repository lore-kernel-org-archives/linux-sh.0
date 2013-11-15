From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Nov 2013 01:56:00 +0000
Subject: [PATCH 2/2 v2] ARM: shmobile: lager: add SDHI0/2 support
Message-Id: <877gcao2c3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
	<87a9h6o2gi.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9h6o2gi.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>
Cc: Laurent <laurent.pinchart@ideasonboard.com>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

SDHI0 (CN8) needs JP/SW settings

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - 1/2 patch become 2/2

 arch/arm/mach-shmobile/board-lager.c |   66 ++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 3d1640f..f32679a 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -24,8 +24,10 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/rcar-du.h>
@@ -42,6 +44,19 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
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
@@ -233,6 +248,34 @@ static const struct resource ether_resources[] __initconst = {
 	DEFINE_RES_IRQ(gic_spi(162)),
 };
 
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
@@ -241,6 +284,22 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 				  "du_sync_1", "du"),
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
 				  "du_clk_out_0", "du"),
+	/* SDHI */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7790",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7790",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7790",
+				  "sdhi0_cd", "sdhi0"),
+
+	/* SDHI2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-r8a7790",
+				  "sdhi2_data4", "sdhi2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-r8a7790",
+				  "sdhi2_ctrl", "sdhi2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.2", "pfc-r8a7790",
+				  "sdhi2_cd", "sdhi2"),
+
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
 				  "scif0_data", "scif0"),
@@ -304,6 +363,13 @@ static void __init lager_add_standard_devices(void)
 				      &vccq_sdhi0_info, sizeof(struct gpio_regulator_config));
 	platform_device_register_data(&platform_bus, "gpio-regulator", gpio_regulator_idx++,
 				      &vccq_sdhi2_info, sizeof(struct gpio_regulator_config));
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

