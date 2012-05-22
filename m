From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 May 2012 02:29:39 +0000
Subject: [PATCH 08/11] ARM: mach-shmobile: armadillo800eva: add HDMI support
Message-Id: <877gw5aqy8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/configs/armadillo800eva_defconfig     |    8 +--
 arch/arm/mach-shmobile/board-armadillo800eva.c |  100 ++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index ddc9fe6..384ec60 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -5,7 +5,6 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT
 # CONFIG_UTS_NS is not set
 # CONFIG_IPC_NS is not set
-# CONFIG_USER_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
@@ -90,25 +89,21 @@ CONFIG_I2C=y
 CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_SH_MOBILE_LCDC=y
+CONFIG_FB_SH_MOBILE_HDMI=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
-CONFIG_SOUND=y
-CONFIG_SND=y
 # CONFIG_SND_SUPPORT_OLD_API is not set
 # CONFIG_SND_VERBOSE_PROCFS is not set
 # CONFIG_SND_DRIVERS is not set
 # CONFIG_SND_ARM is not set
-CONFIG_SND_SOC=y
 CONFIG_SND_SOC_SH4_FSI=y
 # CONFIG_HID_SUPPORT is not set
 CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_RENESAS_USBHS=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=y
@@ -124,7 +119,6 @@ CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
-CONFIG_NFS_V3=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_NFS_V4_1=y
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 9e37026..e63f9c3 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -45,6 +45,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <mach/r8a7740.h>
 #include <video/sh_mobile_lcdc.h>
+#include <video/sh_mobile_hdmi.h>
 
 /*
  * CON1		Camera Module
@@ -384,6 +385,103 @@ static struct platform_device lcdc0_device = {
 	},
 };
 
+/*
+ * LCDC1/HDMI
+ */
+static struct sh_mobile_hdmi_info hdmi_info = {
+	.flags		= HDMI_OUTPUT_PUSH_PULL |
+			  HDMI_OUTPUT_POLARITY_HI |
+			  HDMI_32BIT_REG |
+			  HDMI_HAS_HTOP1 |
+			  HDMI_SND_SRC_SPDIF,
+};
+
+static struct resource hdmi_resources[] = {
+	[0] = {
+		.name	= "HDMI",
+		.start	= 0xe6be0000,
+		.end	= 0xe6be03ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= evt2irq(0x1700),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.name	= "HDMI emma3pf",
+		.start	= 0xe6be4000,
+		.end	= 0xe6be43ff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device hdmi_device = {
+	.name		= "sh-mobile-hdmi",
+	.num_resources	= ARRAY_SIZE(hdmi_resources),
+	.resource	= hdmi_resources,
+	.id             = -1,
+	.dev	= {
+		.platform_data	= &hdmi_info,
+	},
+};
+
+static const struct fb_videomode lcdc1_mode = {
+	.name		= "HDMI 1080i",
+	.xres		= 1920,
+	.yres		= 1080,
+	.pixclock	= 13468,
+	.left_margin	= 88,
+	.right_margin	= 148,
+	.hsync_len	= 44,
+	.upper_margin	= 4,
+	.lower_margin	= 31,
+	.vsync_len	= 10,
+	.refresh	= 60,
+	.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+};
+
+static struct sh_mobile_lcdc_info hdmi_lcdc_info = {
+	.clock_source	= LCDC_CLK_PERIPHERAL, /* HDMI clock */
+	.ch[0] = {
+		.chan			= LCDC_CHAN_MAINLCD,
+		.fourcc			= V4L2_PIX_FMT_RGB565,
+		.interface_type		= RGB24,
+		.clock_divider		= 1,
+		.flags			= LCDC_FLAGS_DWPOL,
+		.lcd_modes		= &lcdc1_mode,
+		.num_modes		= 1,
+		.tx_dev			= &hdmi_device,
+		.panel_cfg = {
+			.width	= 1920,
+			.height = 1080,
+		},
+	},
+};
+
+static struct resource hdmi_lcdc_resources[] = {
+	[0] = {
+		.name	= "LCDC1",
+		.start	= 0xfe944000,
+		.end	= 0xfe948000 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= intcs_evt2irq(0x1780),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device hdmi_lcdc_device = {
+	.name		= "sh_mobile_lcdc_fb",
+	.num_resources	= ARRAY_SIZE(hdmi_lcdc_resources),
+	.resource	= hdmi_lcdc_resources,
+	.id		= 1,
+	.dev	= {
+		.platform_data	= &hdmi_lcdc_info,
+		.coherent_dma_mask = ~0,
+	},
+};
+
 /* GPIO KEY */
 #define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
 
@@ -549,6 +647,8 @@ static struct platform_device *eva_devices[] __initdata = {
 	&sh_eth_device,
 	&sdhi0_device,
 	&sh_mmcif_device,
+	&hdmi_device,
+	&hdmi_lcdc_device,
 };
 
 static void __init eva_clock_init(void)
-- 
1.7.5.4

