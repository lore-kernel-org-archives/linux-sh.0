From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Dec 2010 14:47:40 +0000
Subject: [PATCH] ARM: mach-shmobile: Mackerel VGA camera support
Message-Id: <20101222144740.23663.49079.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add VGA camera support to the Mackerel board
using soc_camera_platform.

The VGA camera module is hooked up using the
8-bit CEU bus, and it is constantly bursting
out frames in fixed video mode setting. The
camera module does not allow any I2C control.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-mackerel.c |  126 ++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2010-12-22 23:31:15.000000000 +0900
@@ -44,7 +44,9 @@
 #include <linux/usb/r8a66597.h>
 
 #include <video/sh_mobile_lcdc.h>
-
+#include <media/sh_mobile_ceu.h>
+#include <media/soc_camera.h>
+#include <media/soc_camera_platform.h>
 #include <sound/sh_fsi.h>
 
 #include <mach/common.h>
@@ -595,6 +597,111 @@ static struct platform_device sh_mmcif_d
 	.resource	= sh_mmcif_resources,
 };
 
+
+static int mackerel_camera_add(struct soc_camera_link *icl, struct device *dev);
+static void mackerel_camera_del(struct soc_camera_link *icl);
+
+static int camera_set_capture(struct soc_camera_platform_info *info,
+			      int enable)
+{
+	return 0; /* camera sensor always enabled */
+}
+
+static struct soc_camera_platform_info camera_info = {
+	.format_name = "UYVY",
+	.format_depth = 16,
+	.format = {
+		.code = V4L2_MBUS_FMT_UYVY8_2X8,
+		.colorspace = V4L2_COLORSPACE_SMPTE170M,
+		.field = V4L2_FIELD_NONE,
+		.width = 640,
+		.height = 480,
+	},
+	.bus_param = SOCAM_PCLK_SAMPLE_RISING | SOCAM_HSYNC_ACTIVE_HIGH |
+	SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_MASTER | SOCAM_DATAWIDTH_8 |
+	SOCAM_DATA_ACTIVE_HIGH,
+	.set_capture = camera_set_capture,
+};
+
+static struct soc_camera_link camera_link = {
+	.bus_id		= 0,
+	.add_device	= mackerel_camera_add,
+	.del_device	= mackerel_camera_del,
+	.module_name	= "soc_camera_platform",
+	.priv		= &camera_info,
+};
+
+static void dummy_release(struct device *dev)
+{
+}
+
+static struct platform_device camera_device = {
+	.name		= "soc_camera_platform",
+	.dev		= {
+		.platform_data	= &camera_info,
+		.release	= dummy_release,
+	},
+};
+
+static int mackerel_camera_add(struct soc_camera_link *icl,
+			       struct device *dev)
+{
+	if (icl != &camera_link)
+		return -ENODEV;
+
+	camera_info.dev = dev;
+
+	return platform_device_register(&camera_device);
+}
+
+static void mackerel_camera_del(struct soc_camera_link *icl)
+{
+	if (icl != &camera_link)
+		return;
+
+	platform_device_unregister(&camera_device);
+	memset(&camera_device.dev.kobj, 0,
+	       sizeof(camera_device.dev.kobj));
+}
+
+static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
+	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
+};
+
+static struct resource ceu_resources[] = {
+	[0] = {
+		.name	= "CEU",
+		.start	= 0xfe910000,
+		.end	= 0xfe91009f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = intcs_evt2irq(0x880),
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device ceu_device = {
+	.name		= "sh_mobile_ceu",
+	.id             = 0, /* "ceu0" clock */
+	.num_resources	= ARRAY_SIZE(ceu_resources),
+	.resource	= ceu_resources,
+	.dev		= {
+		.platform_data	= &sh_mobile_ceu_info,
+	},
+};
+
+static struct platform_device mackerel_camera = {
+	.name	= "soc-camera-pdrv",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &camera_link,
+	},
+};
+
 static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
@@ -609,6 +716,8 @@ static struct platform_device *mackerel_
 #endif
 	&sdhi2_device,
 	&sh_mmcif_device,
+	&ceu_device,
+	&mackerel_camera,
 };
 
 /* Keypad Initialization */
@@ -811,6 +920,21 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SCIFA2_TXD1, NULL);
 	gpio_request(GPIO_FN_SCIFA2_RXD1, NULL);
 
+	/* CEU */
+	gpio_request(GPIO_FN_VIO_CLK, NULL);
+	gpio_request(GPIO_FN_VIO_VD, NULL);
+	gpio_request(GPIO_FN_VIO_HD, NULL);
+	gpio_request(GPIO_FN_VIO_FIELD, NULL);
+	gpio_request(GPIO_FN_VIO_CKO, NULL);
+	gpio_request(GPIO_FN_VIO_D7, NULL);
+	gpio_request(GPIO_FN_VIO_D6, NULL);
+	gpio_request(GPIO_FN_VIO_D5, NULL);
+	gpio_request(GPIO_FN_VIO_D4, NULL);
+	gpio_request(GPIO_FN_VIO_D3, NULL);
+	gpio_request(GPIO_FN_VIO_D2, NULL);
+	gpio_request(GPIO_FN_VIO_D1, NULL);
+	gpio_request(GPIO_FN_VIO_D0, NULL);
+
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
 	i2c_register_board_info(1, i2c1_devices,
