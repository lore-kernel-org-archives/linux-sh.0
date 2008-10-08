From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 08 Oct 2008 11:42:01 +0000
Subject: [PATCH 03/09] sh: Use sh7722 GPIO on Migo-R board
Message-Id: <20081008114201.25282.69471.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch enables the GPIO code on Migo-R and converts the code from
register based pinmux configuration to GPIO based pin by pin setup.
Fix whitespace damage while at it and add 2 LEDs and export them to
user space.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/Kconfig               |    1 
 arch/sh/boards/mach-migor/lcd_qvga.c |    6 -
 arch/sh/boards/mach-migor/setup.c    |  187 +++++++++++++++++++++-------------
 3 files changed, 125 insertions(+), 69 deletions(-)

--- 0001/arch/sh/boards/Kconfig
+++ work/arch/sh/boards/Kconfig	2008-10-08 18:51:31.000000000 +0900
@@ -162,6 +162,7 @@ config SH_SH7785LCR_29BIT_PHYSMAPS
 config SH_MIGOR
 	bool "Migo-R"
 	depends on CPU_SUBTYPE_SH7722
+	select GENERIC_GPIO
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
           by Renesas System Solutions Asia Pte. Ltd.
--- 0001/arch/sh/boards/mach-migor/lcd_qvga.c
+++ work/arch/sh/boards/mach-migor/lcd_qvga.c	2008-10-08 18:50:59.000000000 +0900
@@ -17,7 +17,9 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/gpio.h>
 #include <video/sh_mobile_lcdc.h>
+#include <asm/sh7722.h>
 #include <asm/migor.h>
 
 /* LCD Module is a PH240320T according to board schematics. This module
@@ -30,9 +32,9 @@
 
 static void reset_lcd_module(void)
 {
-	ctrl_outb(ctrl_inb(PORT_PHDR) & ~0x04, PORT_PHDR);
+	gpio_set_value(GPIO_PTH2, 0);
 	mdelay(2);
-	ctrl_outb(ctrl_inb(PORT_PHDR) | 0x04, PORT_PHDR);
+	gpio_set_value(GPIO_PTH2, 1);
 	mdelay(1);
 }
 
--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-10-08 18:52:25.000000000 +0900
@@ -17,6 +17,7 @@
 #include <linux/smc91x.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
+#include <linux/gpio.h>
 #include <media/soc_camera_platform.h>
 #include <media/sh_mobile_ceu.h>
 #include <video/sh_mobile_lcdc.h>
@@ -25,6 +26,7 @@
 #include <asm/io.h>
 #include <asm/sh_keysc.h>
 #include <asm/migor.h>
+#include <asm/sh7722.h>
 
 /* Address     IRQ  Size  Bus  Description
  * 0x00000000       64MB  16   NOR Flash (SP29PL256N)
@@ -169,7 +171,7 @@ static void migor_nand_flash_cmd_ctl(str
 
 static int migor_nand_flash_ready(struct mtd_info *mtd)
 {
-	return ctrl_inb(PORT_PADR) & 0x02; /* PTA1 */
+	return gpio_get_value(GPIO_PTA1); /* NAND_RBn */
 }
 
 struct platform_nand_data migor_nand_flash_data = {
@@ -286,22 +288,15 @@ static struct clk *camera_clk;
 
 static void camera_power_on(void)
 {
-	unsigned char value;
-
 	camera_clk = clk_get(NULL, "video_clk");
 	clk_set_rate(camera_clk, 24000000);
 	clk_enable(camera_clk);	/* start VIO_CKO */
 
+	/* use VIO_RST to take camera out of reset */
 	mdelay(10);
-	value = ctrl_inb(PORT_PTDR);
-	value &= ~0x09;
-#ifndef CONFIG_SH_MIGOR_RTA_WVGA
-	value |= 0x01;
-#endif
-	ctrl_outb(value, PORT_PTDR);
+	gpio_set_value(GPIO_PTT3, 0);
 	mdelay(10);
-
-	ctrl_outb(value | 8, PORT_PTDR);
+	gpio_set_value(GPIO_PTT3, 1);
 }
 
 static void camera_power_off(void)
@@ -309,7 +304,7 @@ static void camera_power_off(void)
 	clk_disable(camera_clk); /* stop VIO_CKO */
 	clk_put(camera_clk);
 
-	ctrl_outb(ctrl_inb(PORT_PTDR) & ~0x08, PORT_PTDR);
+	gpio_set_value(GPIO_PTT3, 0);
 }
 
 #ifdef CONFIG_I2C
@@ -458,75 +453,133 @@ static struct i2c_board_info migor_i2c_d
 
 static int __init migor_devices_setup(void)
 {
+	/* Lit D11 LED */
+	gpio_request(GPIO_PTJ7, NULL);
+	gpio_direction_output(GPIO_PTJ7, 1);
+	gpio_export(GPIO_PTJ7, 0);
+
+	/* Lit D12 LED */
+	gpio_request(GPIO_PTJ5, NULL);
+	gpio_direction_output(GPIO_PTJ5, 1);
+	gpio_export(GPIO_PTJ5, 0);
+
+	/* SMC91C111 */
+	gpio_request(GPIO_FN_IRQ0, NULL);
+
+	/* KEYSC */
 	clk_always_enable("mstp214"); /* KEYSC */
+	gpio_request(GPIO_FN_KEYOUT0, NULL);
+	gpio_request(GPIO_FN_KEYOUT1, NULL);
+	gpio_request(GPIO_FN_KEYOUT2, NULL);
+	gpio_request(GPIO_FN_KEYOUT3, NULL);
+	gpio_request(GPIO_FN_KEYOUT4_IN6, NULL);
+	gpio_request(GPIO_FN_KEYIN1, NULL);
+	gpio_request(GPIO_FN_KEYIN2, NULL);
+	gpio_request(GPIO_FN_KEYIN3, NULL);
+	gpio_request(GPIO_FN_KEYIN4, NULL);
+	gpio_request(GPIO_FN_KEYOUT5_IN5, NULL);
+
+	/* NAND Flash */
+	gpio_request(GPIO_FN_CS6A_CE2B, NULL);
+	ctrl_outl((ctrl_inl(BSC_CS6ABCR) & ~0x0600) | 0x0200, BSC_CS6ABCR);
+	gpio_request(GPIO_PTA1, NULL);
+	gpio_direction_input(GPIO_PTA1);
+
+	/* Touch Panel */
+	gpio_request(GPIO_FN_IRQ6, NULL);
+
+	/* LCD Panel */
 	clk_always_enable("mstp200"); /* LCDC */
+#ifdef CONFIG_SH_MIGOR_QVGA /* LCDC - QVGA - Enable SYS Interface signals */
+	gpio_request(GPIO_FN_LCDD17, NULL);
+	gpio_request(GPIO_FN_LCDD16, NULL);
+	gpio_request(GPIO_FN_LCDD15, NULL);
+	gpio_request(GPIO_FN_LCDD14, NULL);
+	gpio_request(GPIO_FN_LCDD13, NULL);
+	gpio_request(GPIO_FN_LCDD12, NULL);
+	gpio_request(GPIO_FN_LCDD11, NULL);
+	gpio_request(GPIO_FN_LCDD10, NULL);
+	gpio_request(GPIO_FN_LCDD8, NULL);
+	gpio_request(GPIO_FN_LCDD7, NULL);
+	gpio_request(GPIO_FN_LCDD6, NULL);
+	gpio_request(GPIO_FN_LCDD5, NULL);
+	gpio_request(GPIO_FN_LCDD4, NULL);
+	gpio_request(GPIO_FN_LCDD3, NULL);
+	gpio_request(GPIO_FN_LCDD2, NULL);
+	gpio_request(GPIO_FN_LCDD1, NULL);
+	gpio_request(GPIO_FN_LCDRS, NULL);
+	gpio_request(GPIO_FN_LCDCS, NULL);
+	gpio_request(GPIO_FN_LCDRD, NULL);
+	gpio_request(GPIO_FN_LCDWR, NULL);
+	gpio_request(GPIO_PTH2, NULL); /* LCD_DON */
+	gpio_direction_output(GPIO_PTH2, 1);
+#endif
+#ifdef CONFIG_SH_MIGOR_RTA_WVGA /* LCDC - WVGA - Enable RGB Interface signals */
+	gpio_request(GPIO_FN_LCDD15, NULL);
+	gpio_request(GPIO_FN_LCDD14, NULL);
+	gpio_request(GPIO_FN_LCDD13, NULL);
+	gpio_request(GPIO_FN_LCDD12, NULL);
+	gpio_request(GPIO_FN_LCDD11, NULL);
+	gpio_request(GPIO_FN_LCDD10, NULL);
+	gpio_request(GPIO_FN_LCDD9, NULL);
+	gpio_request(GPIO_FN_LCDD8, NULL);
+	gpio_request(GPIO_FN_LCDD7, NULL);
+	gpio_request(GPIO_FN_LCDD6, NULL);
+	gpio_request(GPIO_FN_LCDD5, NULL);
+	gpio_request(GPIO_FN_LCDD4, NULL);
+	gpio_request(GPIO_FN_LCDD3, NULL);
+	gpio_request(GPIO_FN_LCDD2, NULL);
+	gpio_request(GPIO_FN_LCDD1, NULL);
+	gpio_request(GPIO_FN_LCDD0, NULL);
+	gpio_request(GPIO_FN_LCDLCLK, NULL);
+	gpio_request(GPIO_FN_LCDDCK, NULL);
+	gpio_request(GPIO_FN_LCDVEPWC, NULL);
+	gpio_request(GPIO_FN_LCDVCPWC, NULL);
+	gpio_request(GPIO_FN_LCDVSYN, NULL);
+	gpio_request(GPIO_FN_LCDHSYN, NULL);
+	gpio_request(GPIO_FN_LCDDISP, NULL);
+	gpio_request(GPIO_FN_LCDDON, NULL);
+#endif
+
+	/* CEU */
 	clk_always_enable("mstp203"); /* CEU */
+	gpio_request(GPIO_FN_VIO_CLK2, NULL);
+	gpio_request(GPIO_FN_VIO_VD2, NULL);
+	gpio_request(GPIO_FN_VIO_HD2, NULL);
+	gpio_request(GPIO_FN_VIO_FLD, NULL);
+	gpio_request(GPIO_FN_VIO_CKO, NULL);
+	gpio_request(GPIO_FN_VIO_D15, NULL);
+	gpio_request(GPIO_FN_VIO_D14, NULL);
+	gpio_request(GPIO_FN_VIO_D13, NULL);
+	gpio_request(GPIO_FN_VIO_D12, NULL);
+	gpio_request(GPIO_FN_VIO_D11, NULL);
+	gpio_request(GPIO_FN_VIO_D10, NULL);
+	gpio_request(GPIO_FN_VIO_D9, NULL);
+	gpio_request(GPIO_FN_VIO_D8, NULL);
+
+	gpio_request(GPIO_PTT3, NULL); /* VIO_RST */
+	gpio_direction_output(GPIO_PTT3, 0);
+	gpio_request(GPIO_PTT2, NULL); /* TV_IN_EN */
+	gpio_direction_output(GPIO_PTT2, 1);
+	gpio_request(GPIO_PTT0, NULL); /* CAM_EN */
+#ifdef CONFIG_SH_MIGOR_RTA_WVGA
+	gpio_direction_output(GPIO_PTT0, 0);
+#else
+	gpio_direction_output(GPIO_PTT0, 1);
+#endif
+	ctrl_outw(ctrl_inw(PORT_MSELCRB) | 0x2000, PORT_MSELCRB); /* D15->D8 */
 
 	platform_resource_setup_memory(&migor_ceu_device, "ceu", 4 << 20);
 
 	i2c_register_board_info(0, migor_i2c_devices,
 				ARRAY_SIZE(migor_i2c_devices));
- 
+
 	return platform_add_devices(migor_devices, ARRAY_SIZE(migor_devices));
 }
 __initcall(migor_devices_setup);
 
 static void __init migor_setup(char **cmdline_p)
 {
-	/* SMC91C111 - Enable IRQ0 */
-	ctrl_outw(ctrl_inw(PORT_PJCR) & ~0x0003, PORT_PJCR);
-
-	/* KEYSC */
-	ctrl_outw(ctrl_inw(PORT_PYCR) & ~0x0fff, PORT_PYCR);
-	ctrl_outw(ctrl_inw(PORT_PZCR) & ~0x0ff0, PORT_PZCR);
-	ctrl_outw(ctrl_inw(PORT_PSELA) & ~0x4100, PORT_PSELA);
-	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x4000, PORT_HIZCRA);
-	ctrl_outw(ctrl_inw(PORT_HIZCRC) & ~0xc000, PORT_HIZCRC);
-
-	/* NAND Flash */
-	ctrl_outw(ctrl_inw(PORT_PXCR) & 0x0fff, PORT_PXCR);
-	ctrl_outl((ctrl_inl(BSC_CS6ABCR) & ~0x00000600) | 0x00000200,
-		  BSC_CS6ABCR);
-
-	/* Touch Panel - Enable IRQ6 */
-	ctrl_outw(ctrl_inw(PORT_PZCR) & ~0xc, PORT_PZCR);
-	ctrl_outw((ctrl_inw(PORT_PSELA) | 0x8000), PORT_PSELA);
-	ctrl_outw((ctrl_inw(PORT_HIZCRC) & ~0x4000), PORT_HIZCRC);
-
-#ifdef CONFIG_SH_MIGOR_RTA_WVGA
-	/* LCDC - WVGA - Enable RGB Interface signals */
-	ctrl_outw(ctrl_inw(PORT_PACR) & ~0x0003, PORT_PACR);
-	ctrl_outw(0x0000, PORT_PHCR);
-	ctrl_outw(0x0000, PORT_PLCR);
-	ctrl_outw(0x0000, PORT_PMCR);
-	ctrl_outw(ctrl_inw(PORT_PRCR) & ~0x000f, PORT_PRCR);
-	ctrl_outw((ctrl_inw(PORT_PSELD) & ~0x000d) | 0x0400, PORT_PSELD);
-	ctrl_outw(ctrl_inw(PORT_MSELCRB) & ~0x0100, PORT_MSELCRB);
-	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x01e0, PORT_HIZCRA);
-#endif
-#ifdef CONFIG_SH_MIGOR_QVGA
-	/* LCDC - QVGA - Enable SYS Interface signals */
-	ctrl_outw(ctrl_inw(PORT_PACR) & ~0x0003, PORT_PACR);
-	ctrl_outw((ctrl_inw(PORT_PHCR) & ~0xcfff) | 0x0010, PORT_PHCR);
-	ctrl_outw(0x0000, PORT_PLCR);
-	ctrl_outw(0x0000, PORT_PMCR);
-	ctrl_outw(ctrl_inw(PORT_PRCR) & ~0x030f, PORT_PRCR);
-	ctrl_outw((ctrl_inw(PORT_PSELD) & ~0x0001) | 0x0420, PORT_PSELD);
-	ctrl_outw(ctrl_inw(PORT_MSELCRB) | 0x0100, PORT_MSELCRB);
-	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x01e0, PORT_HIZCRA);
-#endif
-
-	/* CEU */
-	ctrl_outw((ctrl_inw(PORT_PTCR) & ~0x03c3) | 0x0051, PORT_PTCR);
-	ctrl_outw(ctrl_inw(PORT_PUCR) & ~0x03ff, PORT_PUCR);
-	ctrl_outw(ctrl_inw(PORT_PVCR) & ~0x03ff, PORT_PVCR);
-	ctrl_outw(ctrl_inw(PORT_PWCR) & ~0x3c00, PORT_PWCR);
-	ctrl_outw(ctrl_inw(PORT_PSELC) | 0x0001, PORT_PSELC);
-	ctrl_outw(ctrl_inw(PORT_PSELD) & ~0x2000, PORT_PSELD);
-	ctrl_outw(ctrl_inw(PORT_PSELE) | 0x000f, PORT_PSELE);
-	ctrl_outw(ctrl_inw(PORT_MSELCRB) | 0x2200, PORT_MSELCRB);
-	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x0a00, PORT_HIZCRA);
-	ctrl_outw(ctrl_inw(PORT_HIZCRB) & ~0x0003, PORT_HIZCRB);
 }
 
 static struct sh_machine_vector mv_migor __initmv = {
