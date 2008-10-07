From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 07 Oct 2008 13:56:20 +0000
Subject: [PATCH] sh: Hook up gpiommc to CN9 on Migo-R
Message-Id: <20081007135620.29530.26600.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Hook up SD Card connector CN9 using the gpiommc driver. This gives us
extremly slow but working SD Card storage using SPI Mode. CN10 is not
hooked up since the hardware seems to be designed for SD I/O.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Depends on the gpiommc driver.

 arch/sh/boards/mach-migor/setup.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- 0006/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-10-07 22:09:35.000000000 +0900
@@ -18,6 +18,8 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/mmc/gpiommc.h>
 #include <media/soc_camera_platform.h>
 #include <media/sh_mobile_ceu.h>
 #include <asm/clock.h>
@@ -429,6 +431,28 @@ static struct platform_device migor_ceu_
 	},
 };
 
+struct gpiommc_platform_data sdcard_cn9_platform_data =  {
+	.name = "CN9",
+	.pins = {
+		.gpio_di = GPIO_PTD1,
+		.gpio_do = GPIO_PTD2,
+		.gpio_clk = GPIO_PTD0,
+		.gpio_cs = GPIO_PTD5,
+		.cs_activelow = 1,
+	},
+	.mode = SPI_MODE_0,
+	.no_spi_delay = 1, /* more than slow enough already */
+	.max_bus_speed = 5000000,
+};
+
+static struct platform_device sdcard_cn9_device = {
+	.name		= "gpiommc",
+	.id		= 0,
+	.dev	= {
+		.platform_data	= &sdcard_cn9_platform_data,
+	},
+};
+
 static struct platform_device *migor_devices[] __initdata = {
 	&smc91x_eth_device,
 	&sh_keysc_device,
@@ -439,6 +463,7 @@ static struct platform_device *migor_dev
 #endif
 	&migor_nor_flash_device,
 	&migor_nand_flash_device,
+	&sdcard_cn9_device,
 };
 
 static struct i2c_board_info migor_i2c_devices[] = {
