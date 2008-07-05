From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 05 Jul 2008 03:32:44 +0000
Subject: [PATCH] sh: enable I2C on the ap325rxa board
Message-Id: <20080705033244.17254.72036.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables I2C on the sh7723-based ap325rxa board.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/ap325rxa/setup.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- 0001/arch/sh/boards/renesas/ap325rxa/setup.c
+++ work/arch/sh/boards/renesas/ap325rxa/setup.c	2008-07-02 12:58:29.000000000 +0900
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/mtd/physmap.h>
 #include <linux/delay.h>
+#include <linux/i2c.h>
 #include <asm/io.h>
 
 static struct resource smc9118_resources[] = {
@@ -83,14 +84,21 @@ static struct platform_device *ap325rxa_
 	&ap325rxa_nor_flash_device
 };
 
+static struct i2c_board_info __initdata ap325rxa_i2c_devices[] = {
+};
+
 static int __init ap325rxa_devices_setup(void)
 {
+	i2c_register_board_info(0, ap325rxa_i2c_devices,
+				ARRAY_SIZE(ap325rxa_i2c_devices));
+ 
 	return platform_add_devices(ap325rxa_devices,
 				ARRAY_SIZE(ap325rxa_devices));
 }
 device_initcall(ap325rxa_devices_setup);
 
 #define MSTPCR0		(0xA4150030)
+#define MSTPCR1		(0xA4150034)
 #define MSTPCR2		(0xA4150038)
 
 static void __init ap325rxa_setup(char **cmdline_p)
@@ -100,6 +108,9 @@ static void __init ap325rxa_setup(char *
 
 	/* enable MERAM */
 	ctrl_outl(ctrl_inl(MSTPCR0) & ~0x00000001, MSTPCR0);	/* bit 0 */
+
+	/* I2C */
+	ctrl_outl(ctrl_inl(MSTPCR1) & ~0x00000200, MSTPCR1);
 }
 
 static struct sh_machine_vector mv_ap325rxa __initmv = {
