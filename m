From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 02 Oct 2009 07:54:42 +0000
Subject: [PATCH] sh: mach-ecevec24: Add SDHI support
Message-Id: <uocoqmdrx.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
This patch needs Magnus's SDHI patch series

 arch/sh/boards/mach-ecovec24/setup.c |   78 ++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 0fb665d..d9f6d3e 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -414,6 +414,54 @@ static struct i2c_board_info ts_i2c_clients = {
 	.irq		= IRQ0,
 };
 
+/* SHDI0 */
+static struct resource sdhi0_resources[] = {
+	[0] = {
+		.name	= "SDHI0",
+		.start  = 0x04ce0000,
+		.end    = 0x04ce01ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 101,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi0_device = {
+	.name           = "sh_mobile_sdhi",
+	.num_resources  = ARRAY_SIZE(sdhi0_resources),
+	.resource       = sdhi0_resources,
+	.id             = 0,
+	.archdata = {
+		.hwblk_id = HWBLK_SDHI0,
+	},
+};
+
+/* SHDI1 */
+static struct resource sdhi1_resources[] = {
+	[0] = {
+		.name	= "SDHI1",
+		.start  = 0x04cf0000,
+		.end    = 0x04cf01ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 24,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi1_device = {
+	.name           = "sh_mobile_sdhi",
+	.num_resources  = ARRAY_SIZE(sdhi1_resources),
+	.resource       = sdhi1_resources,
+	.id             = 1,
+	.archdata = {
+		.hwblk_id = HWBLK_SDHI1,
+	},
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
@@ -424,6 +472,8 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&ceu0_device,
 	&ceu1_device,
 	&keysc_device,
+	&sdhi0_device,
+	&sdhi1_device,
 };
 
 #define EEPROM_ADDR 0x50
@@ -691,6 +741,34 @@ static int __init arch_setup(void)
 	gpio_direction_input(GPIO_PTR5);
 	gpio_direction_input(GPIO_PTR6);
 
+	/* enable SDHI0 */
+	gpio_request(GPIO_FN_SDHI0CD,  NULL);
+	gpio_request(GPIO_FN_SDHI0WP,  NULL);
+	gpio_request(GPIO_FN_SDHI0CMD, NULL);
+	gpio_request(GPIO_FN_SDHI0CLK, NULL);
+	gpio_request(GPIO_FN_SDHI0D3,  NULL);
+	gpio_request(GPIO_FN_SDHI0D2,  NULL);
+	gpio_request(GPIO_FN_SDHI0D1,  NULL);
+	gpio_request(GPIO_FN_SDHI0D0,  NULL);
+
+	/* enable SDHI1 */
+	gpio_request(GPIO_FN_SDHI1CD,  NULL);
+	gpio_request(GPIO_FN_SDHI1WP,  NULL);
+	gpio_request(GPIO_FN_SDHI1CMD, NULL);
+	gpio_request(GPIO_FN_SDHI1CLK, NULL);
+	gpio_request(GPIO_FN_SDHI1D3,  NULL);
+	gpio_request(GPIO_FN_SDHI1D2,  NULL);
+	gpio_request(GPIO_FN_SDHI1D1,  NULL);
+	gpio_request(GPIO_FN_SDHI1D0,  NULL);
+
+	gpio_request(GPIO_PTB6, NULL);
+	gpio_request(GPIO_PTB7, NULL);
+	gpio_direction_output(GPIO_PTB6, 1);
+	gpio_direction_output(GPIO_PTB7, 1);
+
+	/* I/O buffer drive ability is high for SDHI1 */
+	ctrl_outw((ctrl_inw(IODRIVEA) & ~0x3000) | 0x2000 , IODRIVEA);
+
 	/* enable I2C device */
 	i2c_register_board_info(1, i2c1_devices,
 				ARRAY_SIZE(i2c1_devices));
-- 
1.6.0.4

