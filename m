From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 06:22:03 +0000
Subject: [PATCH] sh: Add SDHI1 support to the AP325RXA board
Message-Id: <20091030062203.24074.90609.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the SDHI platform data for the AP325RXA board
to include support for the CN7 Micro SD Card slot.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ap325rxa/setup.c |   36 +++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

--- 0003/arch/sh/boards/mach-ap325rxa/setup.c
+++ work/arch/sh/boards/mach-ap325rxa/setup.c	2009-10-30 14:48:58.000000000 +0900
@@ -423,6 +423,7 @@ static struct resource sdhi0_cn3_resourc
 
 static struct platform_device sdhi0_cn3_device = {
 	.name		= "sh_mobile_sdhi",
+	.id             = 0, /* "sdhi0" clock */
 	.num_resources	= ARRAY_SIZE(sdhi0_cn3_resources),
 	.resource	= sdhi0_cn3_resources,
 	.archdata = {
@@ -430,6 +431,29 @@ static struct platform_device sdhi0_cn3_
 	},
 };
 
+static struct resource sdhi1_cn7_resources[] = {
+	[0] = {
+		.name	= "SDHI1",
+		.start	= 0x04cf0000,
+		.end	= 0x04cf01ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 24,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi1_cn7_device = {
+	.name		= "sh_mobile_sdhi",
+	.id             = 1, /* "sdhi1" clock */
+	.num_resources	= ARRAY_SIZE(sdhi1_cn7_resources),
+	.resource	= sdhi1_cn7_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_SDHI1,
+	},
+};
+
 static struct i2c_board_info __initdata ap325rxa_i2c_devices[] = {
 	{
 		I2C_BOARD_INFO("pcf8563", 0x51),
@@ -478,6 +502,7 @@ static struct platform_device *ap325rxa_
 	&ceu_device,
 	&nand_flash_device,
 	&sdhi0_cn3_device,
+	&sdhi1_cn7_device,
 	&ap325rxa_camera[0],
 	&ap325rxa_camera[1],
 };
@@ -588,7 +613,7 @@ static int __init ap325rxa_devices_setup
 
 	platform_resource_setup_memory(&ceu_device, "ceu", 4 << 20);
 
-	/* SDHI0 */
+	/* SDHI0 - CN3 - SD CARD */
 	gpio_request(GPIO_FN_SDHI0CD_PTD, NULL);
 	gpio_request(GPIO_FN_SDHI0WP_PTD, NULL);
 	gpio_request(GPIO_FN_SDHI0D3_PTD, NULL);
@@ -598,6 +623,15 @@ static int __init ap325rxa_devices_setup
 	gpio_request(GPIO_FN_SDHI0CMD_PTD, NULL);
 	gpio_request(GPIO_FN_SDHI0CLK_PTD, NULL);
 
+	/* SDHI1 - CN7 - MICRO SD CARD */
+	gpio_request(GPIO_FN_SDHI1CD, NULL);
+	gpio_request(GPIO_FN_SDHI1D3, NULL);
+	gpio_request(GPIO_FN_SDHI1D2, NULL);
+	gpio_request(GPIO_FN_SDHI1D1, NULL);
+	gpio_request(GPIO_FN_SDHI1D0, NULL);
+	gpio_request(GPIO_FN_SDHI1CMD, NULL);
+	gpio_request(GPIO_FN_SDHI1CLK, NULL);
+
 	i2c_register_board_info(0, ap325rxa_i2c_devices,
 				ARRAY_SIZE(ap325rxa_i2c_devices));
 
