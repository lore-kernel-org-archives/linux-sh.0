From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 29 Jul 2008 11:57:38 +0000
Subject: [PATCH] sh: I2C fix for AP325RXA and Migo-R
Message-Id: <20080729115738.11977.19703.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Fix recently introduced I2C build breakage on AP325RXA and Migo-R.

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/ap325rxa/setup.c |    4 ++++
 arch/sh/boards/renesas/migor/setup.c    |    4 ++++
 2 files changed, 8 insertions(+)

--- 0001/arch/sh/boards/renesas/ap325rxa/setup.c
+++ work/arch/sh/boards/renesas/ap325rxa/setup.c	2008-07-29 20:41:59.000000000 +0900
@@ -165,6 +165,7 @@ static struct platform_device lcdc_devic
 	},
 };
 
+#ifdef CONFIG_I2C
 static unsigned char camera_ncm03j_magic[]  {
 	0x87, 0x00, 0x88, 0x08, 0x89, 0x01, 0x8A, 0xE8,
@@ -234,6 +235,7 @@ static struct platform_device camera_dev
 		.platform_data	= &camera_info,
 	},
 };
+#endif /* CONFIG_I2C */
 
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
 	.flags = SOCAM_PCLK_SAMPLE_RISING | SOCAM_HSYNC_ACTIVE_HIGH |
@@ -270,7 +272,9 @@ static struct platform_device *ap325rxa_
 	&ap325rxa_nor_flash_device,
 	&lcdc_device,
 	&ceu_device,
+#ifdef CONFIG_I2C
 	&camera_device,
+#endif
 };
 
 static struct i2c_board_info __initdata ap325rxa_i2c_devices[] = {
--- 0001/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-07-29 20:42:20.000000000 +0900
@@ -304,6 +304,7 @@ static void camera_power_off(void)
 	ctrl_outb(ctrl_inb(PORT_PTDR) & ~0x08, PORT_PTDR);
 }
 
+#ifdef CONFIG_I2C
 static unsigned char camera_ov772x_magic[]  {
 	0x09, 0x01, 0x0c, 0x10, 0x0d, 0x41, 0x0e, 0x01,
@@ -391,6 +392,7 @@ static struct platform_device migor_came
 		.platform_data	= &ov772x_info,
 	},
 };
+#endif /* CONFIG_I2C */
 
 static struct sh_mobile_ceu_info sh_mobile_ceu_info = {
 	.flags = SOCAM_MASTER | SOCAM_DATAWIDTH_8 | SOCAM_PCLK_SAMPLE_RISING \
@@ -429,7 +431,9 @@ static struct platform_device *migor_dev
 	&sh_keysc_device,
 	&migor_lcdc_device,
 	&migor_ceu_device,
+#ifdef CONFIG_I2C
 	&migor_camera_device,
+#endif
 	&migor_nor_flash_device,
 	&migor_nand_flash_device,
 };
