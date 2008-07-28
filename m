From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 28 Jul 2008 09:51:01 +0000
Subject: [PATCH] sh: Add SuperH Mobile CEU platform data for Migo-R
Message-Id: <20080728095101.4257.1820.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add Migo-R specific platform data for on-chip sh7722 CEU and ov772x camera.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c |  173 +++++++++++++++++++++++++++++++++-
 include/asm-sh/migor.h               |    5 
 2 files changed, 177 insertions(+), 1 deletion(-)

--- 0009/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-07-28 16:24:51.000000000 +0900
@@ -15,6 +15,10 @@
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
 #include <linux/smc91x.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <media/soc_camera_platform.h>
+#include <media/sh_mobile_ceu.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
@@ -270,15 +274,167 @@ static struct platform_device migor_lcdc
 	},
 };
 
+static struct clk *camera_clk;
+
+static void camera_power_on(void)
+{
+	unsigned char value;
+
+	camera_clk = clk_get(NULL, "video_clk");
+	clk_set_rate(camera_clk, 24000000);
+	clk_enable(camera_clk);	/* start VIO_CKO */
+
+	mdelay(10);
+	value = ctrl_inb(PORT_PTDR);
+	value &= ~0x09;
+#ifndef CONFIG_SH_MIGOR_RTA_WVGA
+	value |= 0x01;
+#endif
+	ctrl_outb(value, PORT_PTDR);
+	mdelay(10);
+
+	ctrl_outb(value | 8, PORT_PTDR);
+}
+
+static void camera_power_off(void)
+{
+	clk_disable(camera_clk); /* stop VIO_CKO */
+	clk_put(camera_clk);
+
+	ctrl_outb(ctrl_inb(PORT_PTDR) & ~0x08, PORT_PTDR);
+}
+
+static unsigned char camera_ov772x_magic[] +{
+	0x09, 0x01, 0x0c, 0x10, 0x0d, 0x41, 0x0e, 0x01,
+	0x12, 0x00, 0x13, 0x8F, 0x14, 0x4A, 0x15, 0x00,
+	0x16, 0x00, 0x17, 0x23, 0x18, 0xa0, 0x19, 0x07,
+	0x1a, 0xf0, 0x1b, 0x40, 0x1f, 0x00, 0x20, 0x10,
+	0x22, 0xff, 0x23, 0x01, 0x28, 0x00, 0x29, 0xa0,
+	0x2a, 0x00, 0x2b, 0x00, 0x2c, 0xf0, 0x2d, 0x00,
+	0x2e, 0x00, 0x30, 0x80, 0x31, 0x60, 0x32, 0x00,
+	0x33, 0x00, 0x34, 0x00, 0x3d, 0x80, 0x3e, 0xe2,
+	0x3f, 0x1f, 0x42, 0x80, 0x43, 0x80, 0x44, 0x80,
+	0x45, 0x80, 0x46, 0x00, 0x47, 0x00, 0x48, 0x00,
+	0x49, 0x50, 0x4a, 0x30, 0x4b, 0x50, 0x4c, 0x50,
+	0x4d, 0x00, 0x4e, 0xef, 0x4f, 0x10, 0x50, 0x60,
+	0x51, 0x00, 0x52, 0x00, 0x53, 0x24, 0x54, 0x7a,
+	0x55, 0xfc, 0x62, 0xff, 0x63, 0xf0, 0x64, 0x1f,
+	0x65, 0x00, 0x66, 0x10, 0x67, 0x00, 0x68, 0x00,
+	0x69, 0x5c, 0x6a, 0x11, 0x6b, 0xa2, 0x6c, 0x01,
+	0x6d, 0x50, 0x6e, 0x80, 0x6f, 0x80, 0x70, 0x0f,
+	0x71, 0x00, 0x72, 0x00, 0x73, 0x0f, 0x74, 0x0f,
+	0x75, 0xff, 0x78, 0x10, 0x79, 0x70, 0x7a, 0x70,
+	0x7b, 0xf0, 0x7c, 0xf0, 0x7d, 0xf0, 0x7e, 0x0e,
+	0x7f, 0x1a, 0x80, 0x31, 0x81, 0x5a, 0x82, 0x69,
+	0x83, 0x75, 0x84, 0x7e, 0x85, 0x88, 0x86, 0x8f,
+	0x87, 0x96, 0x88, 0xa3, 0x89, 0xaf, 0x8a, 0xc4,
+	0x8b, 0xd7, 0x8c, 0xe8, 0x8d, 0x20, 0x8e, 0x00,
+	0x8f, 0x00, 0x90, 0x08, 0x91, 0x10, 0x92, 0x1f,
+	0x93, 0x01, 0x94, 0x2c, 0x95, 0x24, 0x96, 0x08,
+	0x97, 0x14, 0x98, 0x24, 0x99, 0x38, 0x9a, 0x9e,
+	0x9b, 0x00, 0x9c, 0x40, 0x9e, 0x11, 0x9f, 0x02,
+	0xa0, 0x00, 0xa1, 0x40, 0xa2, 0x40, 0xa3, 0x06,
+	0xa4, 0x00, 0xa6, 0x00, 0xa7, 0x40, 0xa8, 0x40,
+	0xa9, 0x80, 0xaa, 0x80, 0xab, 0x06, 0xac, 0xff,
+	0x12, 0x06, 0x64, 0x3f, 0x12, 0x46, 0x17, 0x3f,
+	0x18, 0x50, 0x19, 0x03, 0x1a, 0x78, 0x29, 0x50,
+	0x2c, 0x78,
+};
+
+static int ov772x_set_capture(struct soc_camera_platform_info *info,
+			      int enable)
+{
+	struct i2c_adapter *a = i2c_get_adapter(0);
+	struct i2c_msg msg;
+	int ret = 0;
+	int i;
+
+	if (!enable)
+		return 0; /* camera_power_off() is enough */
+
+	for (i = 0; i < ARRAY_SIZE(camera_ov772x_magic); i += 2) {
+		u_int8_t buf[8];
+
+		msg.addr = 0x21;
+		msg.buf = buf;
+		msg.len = 2;
+		msg.flags = 0;
+
+		buf[0] = camera_ov772x_magic[i];
+		buf[1] = camera_ov772x_magic[i + 1];
+
+		ret = (ret < 0) ? ret : i2c_transfer(a, &msg, 1);
+	}
+
+	return ret;
+}
+
+static struct soc_camera_platform_info ov772x_info = {
+	.iface = 0,
+	.format_name = "RGB565",
+	.format_depth = 16,
+	.format = {
+		.pixelformat = V4L2_PIX_FMT_RGB565,
+		.colorspace = V4L2_COLORSPACE_SRGB,
+		.width = 320,
+		.height = 240,
+	},
+	.bus_param =  SOCAM_PCLK_SAMPLE_RISING | SOCAM_HSYNC_ACTIVE_HIGH |
+	SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_MASTER | SOCAM_DATAWIDTH_8,
+	.set_capture = ov772x_set_capture,
+};
+
+static struct platform_device migor_camera_device = {
+	.name		= "soc_camera_platform",
+	.dev	= {
+		.platform_data	= &ov772x_info,
+	},
+};
+
+static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
+	.flags = SOCAM_MASTER | SOCAM_DATAWIDTH_8 | SOCAM_PCLK_SAMPLE_RISING \
+	| SOCAM_HSYNC_ACTIVE_HIGH | SOCAM_VSYNC_ACTIVE_HIGH,
+	.enable_camera = camera_power_on,
+	.disable_camera = camera_power_off,
+};
+
+static struct resource migor_ceu_resources[] = {
+	[0] = {
+		.name	= "CEU",
+		.start	= 0xfe910000,
+		.end	= 0xfe91009f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 52,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device migor_ceu_device = {
+	.name		= "sh_mobile_ceu",
+	.num_resources	= ARRAY_SIZE(migor_ceu_resources),
+	.resource	= migor_ceu_resources,
+	.dev	= {
+		.platform_data	= &sh_mobile_ceu_info,
+	},
+};
+
 static struct platform_device *migor_devices[] __initdata = {
 	&smc91x_eth_device,
 	&sh_keysc_device,
 	&migor_lcdc_device,
+	&migor_ceu_device,
+	&migor_camera_device,
 	&migor_nor_flash_device,
 	&migor_nand_flash_device,
 };
 
-static struct i2c_board_info __initdata migor_i2c_devices[] = {
+static struct i2c_board_info migor_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("rs5c372b", 0x32),
 	},
@@ -292,6 +448,9 @@ static int __init migor_devices_setup(vo
 {
 	clk_always_enable("mstp214"); /* KEYSC */
 	clk_always_enable("mstp200"); /* LCDC */
+	clk_always_enable("mstp203"); /* CEU */
+
+	platform_resource_setup_memory(&migor_ceu_device, "ceu", 4 << 20);
 
 	i2c_register_board_info(0, migor_i2c_devices,
 				ARRAY_SIZE(migor_i2c_devices));
@@ -344,6 +503,18 @@ static void __init migor_setup(char **cm
 	ctrl_outw(ctrl_inw(PORT_MSELCRB) | 0x0100, PORT_MSELCRB);
 	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x01e0, PORT_HIZCRA);
 #endif
+
+	/* CEU */
+	ctrl_outw((ctrl_inw(PORT_PTCR) & ~0x03c3) | 0x0051, PORT_PTCR);
+	ctrl_outw(ctrl_inw(PORT_PUCR) & ~0x03ff, PORT_PUCR);
+	ctrl_outw(ctrl_inw(PORT_PVCR) & ~0x03ff, PORT_PVCR);
+	ctrl_outw(ctrl_inw(PORT_PWCR) & ~0x3c00, PORT_PWCR);
+	ctrl_outw(ctrl_inw(PORT_PSELC) | 0x0001, PORT_PSELC);
+	ctrl_outw(ctrl_inw(PORT_PSELD) & ~0x2000, PORT_PSELD);
+	ctrl_outw(ctrl_inw(PORT_PSELE) | 0x000f, PORT_PSELE);
+	ctrl_outw(ctrl_inw(PORT_MSELCRB) | 0x2200, PORT_MSELCRB);
+	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x0a00, PORT_HIZCRA);
+	ctrl_outw(ctrl_inw(PORT_HIZCRB) & ~0x0003, PORT_HIZCRB);
 }
 
 static struct sh_machine_vector mv_migor __initmv = {
--- 0009/include/asm-sh/migor.h
+++ work/include/asm-sh/migor.h	2008-07-28 16:20:14.000000000 +0900
@@ -25,12 +25,16 @@
 #define PORT_PLCR 0xa4050114
 #define PORT_PMCR 0xa4050116
 #define PORT_PRCR 0xa405011c
+#define PORT_PTCR 0xa4050140
+#define PORT_PUCR 0xa4050142
+#define PORT_PVCR 0xa4050144
 #define PORT_PWCR 0xa4050146
 #define PORT_PXCR 0xa4050148
 #define PORT_PYCR 0xa405014a
 #define PORT_PZCR 0xa405014c
 #define PORT_PADR 0xa4050120
 #define PORT_PHDR 0xa405012e
+#define PORT_PTDR 0xa4050160
 #define PORT_PWDR 0xa4050166
 
 #define PORT_HIZCRA 0xa4050158
@@ -45,6 +49,7 @@
 #define PORT_PSELB 0xa4050150
 #define PORT_PSELC 0xa4050152
 #define PORT_PSELD 0xa4050154
+#define PORT_PSELE 0xa4050156
 
 #define PORT_HIZCRA 0xa4050158
 #define PORT_HIZCRB 0xa405015a
