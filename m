From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 15 Dec 2009 05:37:39 +0000
Subject: [PATCH 3/3] sh: mach-ecovec24: Add FSI sound support
Message-Id: <uljh4vluk.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   98 ++++++++++++++++++++++++++++++++++
 1 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 459501c..0b1141e 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -23,6 +23,7 @@
 #include <linux/input/sh_keysc.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
 #include <video/sh_mobile_lcdc.h>
+#include <sound/sh_fsi.h>
 #include <media/sh_mobile_ceu.h>
 #include <media/tw9910.h>
 #include <media/mt9t112.h>
@@ -340,6 +341,12 @@ static struct platform_device ceu1_device = {
 };
 
 /* I2C device */
+static struct i2c_board_info i2c0_devices[] = {
+	{
+		I2C_BOARD_INFO("da7210", 0x1a),
+	},
+};
+
 static struct i2c_board_info i2c1_devices[] = {
 	{
 		I2C_BOARD_INFO("r2025sd", 0x32),
@@ -607,6 +614,69 @@ static struct platform_device camera_devices[] = {
 	},
 };
 
+/* FSI */
+/*
+ * FSI-B use external clock which came from da7210.
+ * So, we should change parent of fsi
+ */
+#define FCLKBCR		0xa415000c
+static void fsimck_init(struct clk *clk)
+{
+	u32 status = ctrl_inl(clk->enable_reg);
+
+	/* use external clock */
+	status &= ~0x000000ff;
+	status |= 0x00000080;
+
+	ctrl_outl(status, clk->enable_reg);
+}
+
+static struct clk_ops fsimck_clk_ops = {
+	.init = fsimck_init,
+};
+
+static struct clk fsimckb_clk = {
+	.name		= "fsimckb_clk",
+	.id		= -1,
+	.ops		= &fsimck_clk_ops,
+	.enable_reg	= (void __iomem *)FCLKBCR,
+	.rate		= 0, /* unknown */
+};
+
+struct sh_fsi_platform_info fsi_info = {
+	.portb_flags = SH_FSI_BRS_INV |
+		       SH_FSI_OUT_SLAVE_MODE |
+		       SH_FSI_IN_SLAVE_MODE |
+		       SH_FSI_OFMT(I2S) |
+		       SH_FSI_IFMT(I2S),
+};
+
+static struct resource fsi_resources[] = {
+	[0] = {
+		.name	= "FSI",
+		.start	= 0xFE3C0000,
+		.end	= 0xFE3C021d,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 108,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device fsi_device = {
+	.name		= "sh_fsi",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(fsi_resources),
+	.resource	= fsi_resources,
+	.dev	= {
+		.platform_data	= &fsi_info,
+	},
+	.archdata = {
+		.hwblk_id = HWBLK_SPU, /* FSI needs SPU hwblk */
+	},
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
@@ -622,6 +692,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&camera_devices[0],
 	&camera_devices[1],
 	&camera_devices[2],
+	&fsi_device,
 };
 
 #define EEPROM_ADDR 0x50
@@ -677,6 +748,8 @@ extern char ecovec24_sdram_leave_end;
 
 static int __init arch_setup(void)
 {
+	struct clk *clk;
+
 	/* register board specific self-refresh code */
 	sh_mobile_register_self_refresh(SUSP_SH_STANDBY | SUSP_SH_SF,
 					&ecovec24_sdram_enter_start,
@@ -927,7 +1000,32 @@ static int __init arch_setup(void)
 	gpio_direction_output(GPIO_PTA3, 0);
 	gpio_direction_output(GPIO_PTA4, 0);
 
+	/* enable FSI */
+	gpio_request(GPIO_FN_FSIMCKB,    NULL);
+	gpio_request(GPIO_FN_FSIIBSD,    NULL);
+	gpio_request(GPIO_FN_FSIOBSD,    NULL);
+	gpio_request(GPIO_FN_FSIIBBCK,   NULL);
+	gpio_request(GPIO_FN_FSIIBLRCK,  NULL);
+	gpio_request(GPIO_FN_FSIOBBCK,   NULL);
+	gpio_request(GPIO_FN_FSIOBLRCK,  NULL);
+	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
+
+	/* change parent of FSI B */
+	clk = clk_get(NULL, "fsib_clk");
+	clk_register(&fsimckb_clk);
+	clk_set_parent(clk, &fsimckb_clk);
+	clk_set_rate(clk, 11000);
+	clk_set_rate(&fsimckb_clk, 11000);
+	clk_put(clk);
+
+	gpio_request(GPIO_PTU0, NULL);
+	gpio_direction_output(GPIO_PTU0, 0);
+	mdelay(20);
+
 	/* enable I2C device */
+	i2c_register_board_info(0, i2c0_devices,
+				ARRAY_SIZE(i2c0_devices));
+
 	i2c_register_board_info(1, i2c1_devices,
 				ARRAY_SIZE(i2c1_devices));
 
-- 
1.6.3.3

