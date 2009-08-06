From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Aug 2009 14:19:18 +0000
Subject: [PATCH] sh: fix i2c init order on ap325rxa
Message-Id: <20090806141918.3609.29170.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Convert the AP325RXA board code to register i2c devices from
arch_initcall() instead of __initcall(). This fix unbreaks
pcf8563 RTC driver support.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Suitable for 2.6.31-rc.

 arch/sh/boards/board-ap325rxa.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2009-08-05 18:36:47.000000000 +0900
@@ -399,6 +399,15 @@ static struct i2c_board_info __initdata 
 	},
 };
 
+static int __init ap325rxa_devices_i2c_setup(void)
+{
+	i2c_register_board_info(0, ap325rxa_i2c_devices,
+				ARRAY_SIZE(ap325rxa_i2c_devices));
+
+	return 0;
+}
+arch_initcall(ap325rxa_devices_i2c_setup);
+
 static struct i2c_board_info ap325rxa_i2c_camera[] = {
 	{
 		I2C_BOARD_INFO("ov772x", 0x21),
@@ -538,9 +547,6 @@ static int __init ap325rxa_devices_setup
 
 	platform_resource_setup_memory(&ceu_device, "ceu", 4 << 20);
 
-	i2c_register_board_info(0, ap325rxa_i2c_devices,
-				ARRAY_SIZE(ap325rxa_i2c_devices));
-
 	spi_register_board_info(ap325rxa_spi_devices,
 				ARRAY_SIZE(ap325rxa_spi_devices));
 
