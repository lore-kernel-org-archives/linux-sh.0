From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 28 Jul 2008 10:14:35 +0000
Subject: [PATCH] sh: SuperH Mobile CEU and camera platform data for AP325RXA
Message-Id: <20080728101435.18295.18517.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add AP325RXA specific platform data for on-chip sh7723 CEU and ncm03j camera.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/ap325rxa/setup.c |  119 ++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

--- 0005/arch/sh/boards/renesas/ap325rxa/setup.c
+++ work/arch/sh/boards/renesas/ap325rxa/setup.c	2008-07-28 19:01:53.000000000 +0900
@@ -19,6 +19,8 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/smc911x.h>
+#include <media/soc_camera_platform.h>
+#include <media/sh_mobile_ceu.h>
 #include <asm/sh_mobile_lcdc.h>
 #include <asm/io.h>
 #include <asm/clock.h>
@@ -99,9 +101,13 @@ static struct platform_device ap325rxa_n
 #define PORT_PLCR	0xA4050114
 #define PORT_PMCR	0xA4050116
 #define PORT_PRCR	0xA405011C
-#define PORT_HIZCRA	0xA4050158
 #define PORT_PSCR	0xA405011E
+#define PORT_PZCR	0xA405014C
+#define PORT_HIZCRA	0xA4050158
+#define PORT_MSELCRB	0xA4050182
 #define PORT_PSDR	0xA405013E
+#define PORT_PZDR	0xA405016C
+#define PORT_PSELD	0xA4050154
 
 static void ap320_wvga_power_on(void *board_data)
 {
@@ -159,10 +165,112 @@ static struct platform_device lcdc_devic
 	},
 };
 
+static unsigned char camera_ncm03j_magic[] +{
+	0x87, 0x00, 0x88, 0x08, 0x89, 0x01, 0x8A, 0xE8,
+	0x1D, 0x00, 0x1E, 0x8A, 0x21, 0x00, 0x33, 0x36,
+	0x36, 0x60, 0x37, 0x08, 0x3B, 0x31, 0x44, 0x0F,
+	0x46, 0xF0, 0x4B, 0x28, 0x4C, 0x21, 0x4D, 0x55,
+	0x4E, 0x1B, 0x4F, 0xC7, 0x50, 0xFC, 0x51, 0x12,
+	0x58, 0x02, 0x66, 0xC0, 0x67, 0x46, 0x6B, 0xA0,
+	0x6C, 0x34, 0x7E, 0x25, 0x7F, 0x25, 0x8D, 0x0F,
+	0x92, 0x40, 0x93, 0x04, 0x94, 0x26, 0x95, 0x0A,
+	0x99, 0x03, 0x9A, 0xF0, 0x9B, 0x14, 0x9D, 0x7A,
+	0xC5, 0x02, 0xD6, 0x07, 0x59, 0x00, 0x5A, 0x1A,
+	0x5B, 0x2A, 0x5C, 0x37, 0x5D, 0x42, 0x5E, 0x56,
+	0xC8, 0x00, 0xC9, 0x1A, 0xCA, 0x2A, 0xCB, 0x37,
+	0xCC, 0x42, 0xCD, 0x56, 0xCE, 0x00, 0xCF, 0x1A,
+	0xD0, 0x2A, 0xD1, 0x37, 0xD2, 0x42, 0xD3, 0x56,
+	0x5F, 0x68, 0x60, 0x87, 0x61, 0xA3, 0x62, 0xBC,
+	0x63, 0xD4, 0x64, 0xEA, 0xD6, 0x0F,
+};
+
+static int camera_set_capture(struct soc_camera_platform_info *info,
+			      int enable)
+{
+	struct i2c_adapter *a = i2c_get_adapter(0);
+	struct i2c_msg msg;
+	int ret = 0;
+	int i;
+
+	if (!enable)
+		return 0; /* no disable for now */
+
+	for (i = 0; i < ARRAY_SIZE(camera_ncm03j_magic); i += 2) {
+		u_int8_t buf[8];
+
+		msg.addr = 0x6e;
+		msg.buf = buf;
+		msg.len = 2;
+		msg.flags = 0;
+
+		buf[0] = camera_ncm03j_magic[i];
+		buf[1] = camera_ncm03j_magic[i + 1];
+
+		ret = (ret < 0) ? ret : i2c_transfer(a, &msg, 1);
+	}
+
+	return ret;
+}
+
+static struct soc_camera_platform_info camera_info = {
+	.iface = 0,
+	.format_name = "UYVY",
+	.format_depth = 16,
+	.format = {
+		.pixelformat = V4L2_PIX_FMT_UYVY,
+		.colorspace = V4L2_COLORSPACE_SMPTE170M,
+		.width = 640,
+		.height = 480,
+	},
+	.bus_param = SOCAM_PCLK_SAMPLE_RISING | SOCAM_HSYNC_ACTIVE_HIGH |
+	SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_MASTER | SOCAM_DATAWIDTH_8,
+	.set_capture = camera_set_capture,
+};
+
+static struct platform_device camera_device = {
+	.name		= "soc_camera_platform",
+	.dev		= {
+		.platform_data	= &camera_info,
+	},
+};
+
+static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
+	.flags = SOCAM_PCLK_SAMPLE_RISING | SOCAM_HSYNC_ACTIVE_HIGH |
+	SOCAM_VSYNC_ACTIVE_HIGH | SOCAM_MASTER | SOCAM_DATAWIDTH_8,
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
+		.start  = 52,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device ceu_device = {
+	.name		= "sh_mobile_ceu",
+	.num_resources	= ARRAY_SIZE(ceu_resources),
+	.resource	= ceu_resources,
+	.dev		= {
+		.platform_data	= &sh_mobile_ceu_info,
+	},
+};
+
 static struct platform_device *ap325rxa_devices[] __initdata = {
 	&smc9118_device,
 	&ap325rxa_nor_flash_device,
 	&lcdc_device,
+	&ceu_device,
+	&camera_device,
 };
 
 static struct i2c_board_info __initdata ap325rxa_i2c_devices[] = {
@@ -171,6 +279,9 @@ static struct i2c_board_info __initdata 
 static int __init ap325rxa_devices_setup(void)
 {
 	clk_always_enable("mstp200"); /* LCDC */
+	clk_always_enable("mstp203"); /* CEU */
+
+	platform_resource_setup_memory(&ceu_device, "ceu", 4 << 20);
 
 	i2c_register_board_info(0, ap325rxa_i2c_devices,
 				ARRAY_SIZE(ap325rxa_i2c_devices));
@@ -188,6 +299,12 @@ static void __init ap325rxa_setup(char *
 	ctrl_outw(ctrl_inw(PORT_PMCR) & ~0xffff, PORT_PMCR);
 	ctrl_outw(ctrl_inw(PORT_PRCR) & ~0x03ff, PORT_PRCR);
 	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x01C0, PORT_HIZCRA);
+
+	/* CEU */
+	ctrl_outw(ctrl_inw(PORT_MSELCRB) & ~0x0001, PORT_MSELCRB);
+	ctrl_outw(ctrl_inw(PORT_PSELD) & ~0x0003, PORT_PSELD);
+	ctrl_outw((ctrl_inw(PORT_PZCR) & ~0xff00) | 0x5500, PORT_PZCR);
+	ctrl_outb((ctrl_inb(PORT_PZDR) & ~0xf0) | 0x20, PORT_PZDR);
 }
 
 static struct sh_machine_vector mv_ap325rxa __initmv = {
