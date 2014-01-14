From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 14 Jan 2014 02:25:50 +0000
Subject: [PATCH 3/4] ARM: shmobile: lager: add sound support
Message-Id: <877ga3guz8.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds sound support for Lager board.
But, it is using PIO transfer at this point.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig       |    1 +
 arch/arm/mach-shmobile/board-lager.c |  100 ++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 8011329..110c9ba 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -274,6 +274,7 @@ config MACH_LAGER
 	depends on ARCH_R8A7790
 	select USE_OF
 	select MICREL_PHY if SH_ETH
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 
 config MACH_KOELSCH
 	bool "Koelsch board"
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 8dde446..8a09490 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -20,6 +20,7 @@
 
 #include <linux/gpio.h>
 #include <linux/gpio_keys.h>
+#include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -48,6 +49,20 @@
 #include <linux/spi/flash.h>
 #include <linux/spi/rspi.h>
 #include <linux/spi/spi.h>
+#include <sound/rcar_snd.h>
+#include <sound/simple_card.h>
+
+/*
+ * SSI-AK4643
+ *
+ * SW1: 1: AK4643
+ *      2: CN22
+ *      3: ADV7511
+ *
+ * this command is required when playback.
+ *
+ * # amixer set "LINEOUT Mixer DACL" on
+ */
 
 /* DU */
 static struct rcar_du_encoder_data lager_du_encoders[] = {
@@ -364,6 +379,77 @@ static const struct platform_device_info sata1_info __initconst = {
 	.dma_mask	= DMA_BIT_MASK(32),
 };
 
+/* I2C */
+static struct i2c_board_info i2c2_devices[] = {
+	{
+		I2C_BOARD_INFO("ak4643", 0x12),
+	}
+};
+
+/* Sound */
+static struct resource rsnd_resources[] __initdata = {
+	[RSND_GEN2_SCU]  = DEFINE_RES_MEM(0xec500000, 0x1000),
+	[RSND_GEN2_ADG]  = DEFINE_RES_MEM(0xec5a0000, 0x100),
+	[RSND_GEN2_SSIU] = DEFINE_RES_MEM(0xec540000, 0x1000),
+	[RSND_GEN2_SSI]  = DEFINE_RES_MEM(0xec541000, 0x1280),
+};
+
+static struct rsnd_ssi_platform_info rsnd_ssi[] = {
+	RSND_SSI_SET(0, 0, gic_spi(370), RSND_SSI_PLAY),
+	RSND_SSI_SET(0, 0, gic_spi(371), RSND_SSI_CLK_PIN_SHARE),
+};
+
+static struct rsnd_scu_platform_info rsnd_scu[2] = {
+	/* no member at this point */
+};
+
+static struct rcar_snd_info rsnd_info = {
+	.flags		= RSND_GEN2,
+	.ssi_info	= rsnd_ssi,
+	.ssi_info_nr	= ARRAY_SIZE(rsnd_ssi),
+	.scu_info	= rsnd_scu,
+	.scu_info_nr	= ARRAY_SIZE(rsnd_scu),
+};
+
+static struct asoc_simple_card_info rsnd_card_info = {
+	.name		= "AK4643",
+	.card		= "SSI01-AK4643",
+	.codec		= "ak4642-codec.2-0012",
+	.platform	= "rcar_sound",
+	.daifmt		= SND_SOC_DAIFMT_LEFT_J,
+	.cpu_dai = {
+		.name	= "rcar_sound",
+		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
+	},
+	.codec_dai = {
+		.name	= "ak4642-hifi",
+		.fmt	= SND_SOC_DAIFMT_CBM_CFM,
+		.sysclk	= 11289600,
+	},
+};
+
+static void __init lager_add_rsnd_device(void)
+{
+	struct platform_device_info cardinfo = {
+		.parent         = &platform_bus,
+		.name           = "asoc-simple-card",
+		.id             = -1,
+		.data           = &rsnd_card_info,
+		.size_data      = sizeof(struct asoc_simple_card_info),
+		.dma_mask       = DMA_BIT_MASK(32),
+	};
+
+	i2c_register_board_info(2, i2c2_devices,
+				ARRAY_SIZE(i2c2_devices));
+
+	platform_device_register_resndata(
+		&platform_bus, "rcar_sound", -1,
+		rsnd_resources, ARRAY_SIZE(rsnd_resources),
+		&rsnd_info, sizeof(rsnd_info));
+
+	platform_device_register_full(&cardinfo);
+}
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -372,12 +458,24 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 				  "du_sync_1", "du"),
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
 				  "du_clk_out_0", "du"),
+	/* I2C2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("i2c-rcar.2", "pfc-r8a7790",
+				  "i2c2", "i2c2"),
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
 				  "scif0_data", "scif0"),
 	/* SCIF1 (CN20: DEBUG SERIAL1) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
 				  "scif1_data", "scif1"),
+	/* SSI (CN17: sound) */
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7790",
+				  "ssi0129_ctrl", "ssi"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7790",
+				  "ssi0_data", "ssi"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7790",
+				  "ssi1_data", "ssi"),
+	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7790",
+				  "audio_clk_a", "audio_clk"),
 	/* MMCIF1 */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.1", "pfc-r8a7790",
 				  "mmc1_data8", "mmc1"),
@@ -461,6 +559,8 @@ static void __init lager_add_standard_devices(void)
 	lager_add_camera1_device();
 
 	platform_device_register_full(&sata1_info);
+
+	lager_add_rsnd_device();
 }
 
 /*
-- 
1.7.9.5

