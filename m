From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 May 2012 02:29:53 +0000
Subject: [PATCH 09/11] ARM: mach-shmobile: armadillo800eva: add camera support
Message-Id: <8762bpaqxu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/armadillo800eva_defconfig     |   10 ++
 arch/arm/mach-shmobile/board-armadillo800eva.c |  114 +++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 384ec60..f87260d 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -88,6 +88,16 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_VIDEO_DEV=y
+# CONFIG_RC_CORE is not set
+# CONFIG_VIDEO_HELPER_CHIPS_AUTO is not set
+# CONFIG_V4L_USB_DRIVERS is not set
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_SOC_CAMERA_MT9T112=y
+CONFIG_VIDEO_SH_MOBILE_CEU=y
+# CONFIG_RADIO_ADAPTERS is not set
 CONFIG_FB=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FB_SH_MOBILE_HDMI=y
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index e63f9c3..f8f8cbf 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -37,13 +37,16 @@
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
+#include <mach/r8a7740.h>
+#include <media/mt9t112.h>
+#include <media/sh_mobile_ceu.h>
+#include <media/soc_camera.h>
 #include <asm/page.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <mach/r8a7740.h>
 #include <video/sh_mobile_lcdc.h>
 #include <video/sh_mobile_hdmi.h>
 
@@ -630,6 +633,80 @@ static struct platform_device sh_mmcif_device = {
 	.resource	= sh_mmcif_resources,
 };
 
+/* Camera */
+static struct clk *cam1_mclk; /* initialized on eva_clock_init() */
+static int mt9t111_power(struct device *dev, int mode)
+{
+	if (!cam1_mclk)
+		return -EINVAL;
+
+	if (mode) {
+		gpio_direction_output(GPIO_PORT158, 1);
+		clk_enable(cam1_mclk);
+	} else {
+		gpio_direction_output(GPIO_PORT158, 0);
+		clk_disable(cam1_mclk);
+	}
+
+	return 0;
+}
+
+static struct i2c_board_info i2c_camera_mt9t111 = {
+	I2C_BOARD_INFO("mt9t112", 0x3d),
+};
+
+static struct mt9t112_camera_info mt9t111_info = {
+	.divider = { 16, 0, 0, 7, 0, 10, 14, 7, 7 },
+};
+
+static struct soc_camera_link mt9t111_link = {
+	.i2c_adapter_id	= 0,
+	.bus_id		= 0,
+	.board_info	= &i2c_camera_mt9t111,
+	.power		= mt9t111_power,
+	.priv		= &mt9t111_info,
+};
+
+static struct platform_device camera_device = {
+	.name	= "soc-camera-pdrv",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &mt9t111_link,
+	},
+};
+
+/* CEU0 */
+static struct sh_mobile_ceu_info sh_mobile_ceu0_info = {
+	.flags = SH_CEU_FLAG_LOWER_8BIT,
+};
+
+static struct resource ceu0_resources[] = {
+	[0] = {
+		.name	= "CEU",
+		.start	= 0xfe910000,
+		.end	= 0xfe91009f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = intcs_evt2irq(0x0500),
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device ceu0_device = {
+	.name		= "sh_mobile_ceu",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(ceu0_resources),
+	.resource	= ceu0_resources,
+	.dev	= {
+		.platform_data		= &sh_mobile_ceu0_info,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
 /* I2C */
 static struct i2c_board_info i2c0_devices[] = {
 	{
@@ -649,6 +726,8 @@ static struct platform_device *eva_devices[] __initdata = {
 	&sh_mmcif_device,
 	&hdmi_device,
 	&hdmi_lcdc_device,
+	&camera_device,
+	&ceu0_device,
 };
 
 static void __init eva_clock_init(void)
@@ -664,12 +743,21 @@ static void __init eva_clock_init(void)
 		goto clock_error;
 	}
 
+	cam1_mclk = clk_get(NULL, "video1");
+	if (IS_ERR(cam1_mclk)) {
+		cam1_mclk = NULL;
+		goto clock_error;
+	}
+
 	/* armadillo 800 eva extal1 is 24MHz */
 	clk_set_rate(xtal1, 24000000);
 
 	/* usb24s use extal1 (= system) clock (= 24MHz) */
 	clk_set_parent(usb24s, system);
 
+	/* video1 (= CON1 camera) expect 24MHz */
+	clk_set_rate(cam1_mclk, clk_round_rate(cam1_mclk, 24000000));
+
 clock_error:
 	if (!IS_ERR(system))
 		clk_put(system);
@@ -806,6 +894,30 @@ static void __init eva_init(void)
 	gpio_request(GPIO_FN_MMC1_D6_PORT143,	NULL);
 	gpio_request(GPIO_FN_MMC1_D7_PORT142,	NULL);
 
+	/* CEU0 */
+	gpio_request(GPIO_FN_VIO0_D7,		NULL);
+	gpio_request(GPIO_FN_VIO0_D6,		NULL);
+	gpio_request(GPIO_FN_VIO0_D5,		NULL);
+	gpio_request(GPIO_FN_VIO0_D4,		NULL);
+	gpio_request(GPIO_FN_VIO0_D3,		NULL);
+	gpio_request(GPIO_FN_VIO0_D2,		NULL);
+	gpio_request(GPIO_FN_VIO0_D1,		NULL);
+	gpio_request(GPIO_FN_VIO0_D0,		NULL);
+	gpio_request(GPIO_FN_VIO0_CLK,		NULL);
+	gpio_request(GPIO_FN_VIO0_HD,		NULL);
+	gpio_request(GPIO_FN_VIO0_VD,		NULL);
+	gpio_request(GPIO_FN_VIO0_FIELD,	NULL);
+	gpio_request(GPIO_FN_VIO_CKO,		NULL);
+
+	/* CON1/CON15 Camera */
+	gpio_request(GPIO_PORT173, NULL); /* STANDBY */
+	gpio_request(GPIO_PORT172, NULL); /* RST */
+	gpio_direction_output(GPIO_PORT173, 0);
+	gpio_direction_output(GPIO_PORT172, 1);
+
+	gpio_request(GPIO_PORT158, NULL); /* CAM_PON */
+	gpio_direction_output(GPIO_PORT158, 0); /* see mt9t111_power() */
+
 	/*
 	 * CAUTION
 	 *
-- 
1.7.5.4

