From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 25 Mar 2008 08:20:24 +0000
Subject: [PATCH] sh: Add I2C support to MigoR
Message-Id: <20080325082024.10598.25130.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enable the sh7722 I2C controller on the MigoR board.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- 0008/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-03-21 10:48:14.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/input.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
+#include <linux/i2c.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <asm/sh_keysc.h>
@@ -174,8 +175,14 @@ static struct platform_device *migor_dev
 	&migor_nand_flash_device,
 };
 
+static struct i2c_board_info __initdata migor_i2c_devices[] = {
+};
+
 static int __init migor_devices_setup(void)
 {
+	i2c_register_board_info(0, migor_i2c_devices,
+				ARRAY_SIZE(migor_i2c_devices));
+ 
 	return platform_add_devices(migor_devices, ARRAY_SIZE(migor_devices));
 }
 __initcall(migor_devices_setup);
@@ -197,6 +204,9 @@ static void __init migor_setup(char **cm
 	ctrl_outw(ctrl_inw(PORT_PXCR) & 0x0fff, PORT_PXCR);
 	ctrl_outl((ctrl_inl(BSC_CS6ABCR) & ~0x00000600) | 0x00000200,
 		  BSC_CS6ABCR);
+
+	/* I2C */
+	ctrl_outl(ctrl_inl(MSTPCR1) & ~0x00000200, MSTPCR1);
 }
 
 static struct sh_machine_vector mv_migor __initmv = {
