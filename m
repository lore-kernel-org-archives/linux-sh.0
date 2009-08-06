From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Aug 2009 14:15:36 +0000
Subject: [PATCH] sh: fix i2c init order on Migo-R
Message-Id: <20090806141536.28146.17373.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Convert the Migo-R board code to register i2c devices from
arch_initcall() instead of __initcall(). This fix unbreaks
migor_ts touch screen driver support.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Suitable for 2.6.31-rc.

 arch/sh/boards/mach-migor/setup.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2009-07-30 17:22:47.000000000 +0900
@@ -405,6 +405,15 @@ static struct i2c_board_info migor_i2c_d
 	},
 };
 
+static int __init migor_devices_i2c_setup(void)
+{
+	i2c_register_board_info(0, migor_i2c_devices,
+				ARRAY_SIZE(migor_i2c_devices));
+
+	return 0;
+}
+arch_initcall(migor_devices_i2c_setup);
+
 static struct i2c_board_info migor_i2c_camera[] = {
 	{
 		I2C_BOARD_INFO("ov772x", 0x21),
@@ -600,9 +609,6 @@ static int __init migor_devices_setup(vo
 
 	platform_resource_setup_memory(&migor_ceu_device, "ceu", 4 << 20);
 
-	i2c_register_board_info(0, migor_i2c_devices,
-				ARRAY_SIZE(migor_i2c_devices));
-
 	spi_register_board_info(migor_spi_devices,
 				ARRAY_SIZE(migor_spi_devices));
 
