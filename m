From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 20 Oct 2010 13:15:49 +0000
Subject: [PATCH] ARM: arch-shmobile: Add IMX074 camera sensor data to the
Message-Id: <Pine.LNX.4.64.1010201514590.29312@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add platform data, necessary to use Sony IMX074 camera sensor with AP4EVB.
Note: this does not work reliably without an API to reserve contiguous and
coherent memory for V4L DMA buffers. Such memory reservation has to be added as
soon as a suitable API becomes available.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |  113 +++++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 300808f..7d0a8c4 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -43,6 +43,10 @@
 #include <linux/input/sh_keysc.h>
 #include <linux/usb/r8a66597.h>
 
+#include <media/sh_mobile_ceu.h>
+#include <media/sh_mobile_csi2.h>
+#include <media/soc_camera.h>
+
 #include <sound/sh_fsi.h>
 
 #include <video/sh_mobile_hdmi.h>
@@ -698,6 +702,95 @@ static struct platform_device leds_device = {
 	},
 };
 
+static struct i2c_board_info imx074_info = {
+	I2C_BOARD_INFO("imx074", 0x1a),
+};
+
+struct soc_camera_link imx074_link = {
+	.bus_id		= 0,
+	.board_info	= &imx074_info,
+	.i2c_adapter_id	= 0,
+	.module_name	= "imx074",
+};
+
+static struct platform_device ap4evb_camera = {
+	.name   = "soc-camera-pdrv",
+	.id     = 0,
+	.dev    = {
+		.platform_data = &imx074_link,
+	},
+};
+
+static struct sh_csi2_client_config csi2_clients[] = {
+	{
+		.phy		= SH_CSI2_PHY_MAIN,
+		.lanes		= 3,
+		.channel	= 0,
+		.pdev		= &ap4evb_camera,
+	},
+};
+
+static struct sh_csi2_pdata csi2_info = {
+	.type		= SH_CSI2C,
+	.clients	= csi2_clients,
+	.num_clients	= ARRAY_SIZE(csi2_clients),
+	.flags		= SH_CSI2_ECC | SH_CSI2_CRC,
+};
+
+static struct resource csi2_resources[] = {
+	[0] = {
+		.name	= "CSI2",
+		.start	= 0xffc90000,
+		.end	= 0xffc90fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x17a0),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device csi2_device = {
+	.name   = "sh-mobile-csi2",
+	.id     = 0,
+	.num_resources	= ARRAY_SIZE(csi2_resources),
+	.resource	= csi2_resources,
+	.dev    = {
+		.platform_data = &csi2_info,
+	},
+};
+
+static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
+	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
+	.csi2_dev = &csi2_device.dev,
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
+		.start	= intcs_evt2irq(0x880),
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
+	.dev	= {
+		.platform_data	= &sh_mobile_ceu_info,
+	},
+};
+
 static struct platform_device *ap4evb_devices[] __initdata = {
 	&leds_device,
 	&nor_flash_device,
@@ -710,6 +803,9 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&lcdc1_device,
 	&lcdc_device,
 	&hdmi_device,
+	&csi2_device,
+	&ceu_device,
+	&ap4evb_camera,
 };
 
 static int __init hdmi_init_pm_clock(void)
@@ -1054,6 +1150,23 @@ static void __init ap4evb_init(void)
 	i2c_register_board_info(0, &tsc_device, 1);
 #endif /* CONFIG_AP4EVB_QHD */
 
+	/* CEU */
+
+	/*
+	 * TODO: reserve memory for V4L2 DMA buffers, when a suitable API
+	 * becomes available
+	 */
+
+	/* MIPI-CSI stuff */
+	gpio_request(GPIO_FN_VIO_CKO, NULL);
+
+	clk = clk_get(NULL, "vck1_clk");
+	if (!IS_ERR(clk)) {
+		clk_set_rate(clk, clk_round_rate(clk, 13000000));
+		clk_enable(clk);
+		clk_put(clk);
+	}
+
 	sh7372_add_standard_devices();
 
 	/* HDMI */
-- 
1.7.1

