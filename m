From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 May 2012 02:30:06 +0000
Subject: [PATCH 10/11] ARM: mach-shmobile: armadillo800eva: Add FSI-WM8978 support
Message-Id: <874nr9aqxg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig                 |    1 +
 arch/arm/mach-shmobile/board-armadillo800eva.c |   99 ++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 250277a..bedb41f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -106,6 +106,7 @@ config MACH_ARMADILLO800EVA
 	depends on ARCH_R8A7740
 	select ARCH_REQUIRE_GPIOLIB
 	select USE_OF
+	select SND_SOC_WM8978 if SND_SIMPLE_CARD
 
 config MACH_MARZEN
 	bool "MARZEN board"
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index f8f8cbf..d09953e 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -49,6 +49,8 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mobile_hdmi.h>
+#include <sound/sh_fsi.h>
+#include <sound/simple_card.h>
 
 /*
  * CON1		Camera Module
@@ -112,6 +114,28 @@
  */
 
 /*
+ * FSI-WM8978
+ *
+ * this command is required when playback.
+ *
+ * # amixer set "Headphone" 50
+ */
+
+/*
+ * FIXME !!
+ *
+ * gpio_no_direction
+ *
+ * current gpio frame work doesn't have
+ * the method to control only pull up/down/free.
+ * this function should be replaced by correct gpio function
+ */
+static void __init gpio_no_direction(u32 addr)
+{
+	__raw_writeb(0x00, addr);
+}
+
+/*
  * USB function
  *
  * When you use USB Function,
@@ -707,12 +731,71 @@ static struct platform_device ceu0_device = {
 	},
 };
 
+/* FSI */
+static struct sh_fsi_platform_info fsi_info = {
+	/* FSI-WM8978 */
+	.port_a = {
+	},
+};
+
+static struct resource fsi_resources[] = {
+	[0] = {
+		.name	= "FSI",
+		.start	= 0xfe1f0000,
+		.end	= 0xfe1f8400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = evt2irq(0x1840),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device fsi_device = {
+	.name		= "sh_fsi2",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(fsi_resources),
+	.resource	= fsi_resources,
+	.dev	= {
+		.platform_data	= &fsi_info,
+	},
+};
+
+/* FSI-WM8978 */
+static struct asoc_simple_dai_init_info fsi_wm8978_init_info = {
+	.fmt		= SND_SOC_DAIFMT_I2S,
+	.codec_daifmt	= SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_NB_NF,
+	.cpu_daifmt	= SND_SOC_DAIFMT_CBS_CFS,
+	.sysclk		= 12288000,
+};
+
+static struct asoc_simple_card_info fsi_wm8978_info = {
+	.name		= "wm8978",
+	.card		= "FSI2A-WM8978",
+	.cpu_dai	= "fsia-dai",
+	.codec		= "wm8978.0-001a",
+	.platform	= "sh_fsi2",
+	.codec_dai	= "wm8978-hifi",
+	.init		= &fsi_wm8978_init_info,
+};
+
+static struct platform_device fsi_wm8978_device = {
+	.name	= "asoc-simple-card",
+	.id	= 0,
+	.dev	= {
+		.platform_data	= &fsi_wm8978_info,
+	},
+};
+
 /* I2C */
 static struct i2c_board_info i2c0_devices[] = {
 	{
 		I2C_BOARD_INFO("st1232-ts", 0x55),
 		.irq = evt2irq(0x0340),
 	},
+	{
+		I2C_BOARD_INFO("wm8978", 0x1a),
+	},
 };
 
 /*
@@ -728,6 +811,8 @@ static struct platform_device *eva_devices[] __initdata = {
 	&hdmi_lcdc_device,
 	&camera_device,
 	&ceu0_device,
+	&fsi_device,
+	&fsi_wm8978_device,
 };
 
 static void __init eva_clock_init(void)
@@ -770,6 +855,8 @@ clock_error:
 /*
  * board init
  */
+#define GPIO_PORT7CR	0xe6050007
+#define GPIO_PORT8CR	0xe6050008
 static void __init eva_init(void)
 {
 	eva_clock_init();
@@ -918,6 +1005,18 @@ static void __init eva_init(void)
 	gpio_request(GPIO_PORT158, NULL); /* CAM_PON */
 	gpio_direction_output(GPIO_PORT158, 0); /* see mt9t111_power() */
 
+	/* FSI-WM8978 */
+	gpio_request(GPIO_FN_FSIAIBT,		NULL);
+	gpio_request(GPIO_FN_FSIAILR,		NULL);
+	gpio_request(GPIO_FN_FSIAOMC,		NULL);
+	gpio_request(GPIO_FN_FSIAOSLD,		NULL);
+	gpio_request(GPIO_FN_FSIAISLD_PORT5,	NULL);
+
+	gpio_request(GPIO_PORT7, NULL);
+	gpio_request(GPIO_PORT8, NULL);
+	gpio_no_direction(GPIO_PORT7CR); /* FSIAOBT needs no direction */
+	gpio_no_direction(GPIO_PORT8CR); /* FSIAOLR needs no direction */
+
 	/*
 	 * CAUTION
 	 *
-- 
1.7.5.4

