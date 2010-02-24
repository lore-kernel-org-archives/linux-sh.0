From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 24 Feb 2010 00:32:28 +0000
Subject: [PATCH] sh: mach-ecovec24: Add sh_sir support
Message-Id: <ubpffv5gj.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 6f2e8a7..8cdf11e 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -751,6 +751,26 @@ static struct platform_device fsi_device = {
 	},
 };
 
+/* IrDA */
+static struct resource irda_resources[] = {
+	[0] = {
+		.name	= "IrDA",
+		.start  = 0xA45D0000,
+		.end    = 0xA45D0049,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 20,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device irda_device = {
+	.name           = "sh_sir",
+	.num_resources  = ARRAY_SIZE(irda_resources),
+	.resource       = irda_resources,
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
@@ -771,6 +791,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&camera_devices[1],
 	&camera_devices[2],
 	&fsi_device,
+	&irda_device,
 };
 
 #define EEPROM_ADDR 0x50
@@ -1131,6 +1152,12 @@ static int __init arch_setup(void)
 	clk_set_rate(clk, clk_round_rate(clk, 166000000));
 	clk_put(clk);
 
+	/* enable IrDA */
+	gpio_request(GPIO_FN_IRDA_OUT, NULL);
+	gpio_request(GPIO_FN_IRDA_IN,  NULL);
+	gpio_request(GPIO_PTU5, NULL);
+	gpio_direction_output(GPIO_PTU5, 0);
+
 	/* enable I2C device */
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
-- 
1.6.3.3

