From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 08 Oct 2008 11:42:20 +0000
Subject: [PATCH 05/09] sh: Use sh7723 GPIO on AP325RXA board
Message-Id: <20081008114220.25282.38689.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch enables the GPIO code on AP325RXA and converts the code from
register based pinmux configuration to GPIO based pin by pin setup.
While at it 2 LEDs and one switch are added and exported to user space.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/Kconfig          |    1 
 arch/sh/boards/board-ap325rxa.c |  100 ++++++++++++++++++++++++++++-----------
 2 files changed, 75 insertions(+), 26 deletions(-)

--- 0004/arch/sh/boards/Kconfig
+++ work/arch/sh/boards/Kconfig	2008-10-08 19:23:44.000000000 +0900
@@ -170,6 +170,7 @@ config SH_MIGOR
 config SH_AP325RXA
 	bool "AP-325RXA"
 	depends on CPU_SUBTYPE_SH7723
+	select GENERIC_GPIO
 	help
 	  Renesas "AP-325RXA" support.
 	  Compatible with ALGO SYSTEM CO.,LTD. "AP-320A"
--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2008-10-08 19:23:28.000000000 +0900
@@ -18,11 +18,13 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/smc911x.h>
+#include <linux/gpio.h>
 #include <media/soc_camera_platform.h>
 #include <media/sh_mobile_ceu.h>
 #include <video/sh_mobile_lcdc.h>
 #include <asm/io.h>
 #include <asm/clock.h>
+#include <asm/sh7723.h>
 
 static struct smc911x_platdata smc911x_info = {
 	.flags = SMC911X_USE_32BIT,
@@ -109,17 +111,7 @@ static struct platform_device ap325rxa_n
 #define FPGA_LCDREG	0xB4100180
 #define FPGA_BKLREG	0xB4100212
 #define FPGA_LCDREG_VAL	0x0018
-#define PORT_PHCR	0xA405010E
-#define PORT_PLCR	0xA4050114
-#define PORT_PMCR	0xA4050116
-#define PORT_PRCR	0xA405011C
-#define PORT_PSCR	0xA405011E
-#define PORT_PZCR	0xA405014C
-#define PORT_HIZCRA	0xA4050158
 #define PORT_MSELCRB	0xA4050182
-#define PORT_PSDR	0xA405013E
-#define PORT_PZDR	0xA405016C
-#define PORT_PSELD	0xA4050154
 
 static void ap320_wvga_power_on(void *board_data)
 {
@@ -129,8 +121,7 @@ static void ap320_wvga_power_on(void *bo
 	ctrl_outw(FPGA_LCDREG_VAL, FPGA_LCDREG);
 
 	/* backlight */
-	ctrl_outw((ctrl_inw(PORT_PSCR) & ~0x00C0) | 0x40, PORT_PSCR);
-	ctrl_outb(ctrl_inb(PORT_PSDR) & ~0x08, PORT_PSDR);
+	gpio_set_value(GPIO_PTS3, 0);
 	ctrl_outw(0x100, FPGA_BKLREG);
 }
 
@@ -298,8 +289,77 @@ static struct i2c_board_info __initdata 
 
 static int __init ap325rxa_devices_setup(void)
 {
-	clk_always_enable("mstp200"); /* LCDC */
-	clk_always_enable("mstp203"); /* CEU */
+	/* LD3 and LD4 LEDs */
+	gpio_request(GPIO_PTX5, NULL); /* RUN */
+	gpio_direction_output(GPIO_PTX5, 1);
+	gpio_export(GPIO_PTX5, 0);
+
+	gpio_request(GPIO_PTX4, NULL); /* INDICATOR */
+	gpio_direction_output(GPIO_PTX4, 0);
+	gpio_export(GPIO_PTX4, 0);
+
+	/* SW1 input */
+	gpio_request(GPIO_PTF7, NULL); /* MODE */
+	gpio_direction_input(GPIO_PTF7);
+	gpio_export(GPIO_PTF7, 0);
+
+	/* LCDC */
+	clk_always_enable("mstp200");
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
+	gpio_request(GPIO_FN_LCDLCLK_PTR, NULL);
+	gpio_request(GPIO_FN_LCDDCK, NULL);
+	gpio_request(GPIO_FN_LCDVEPWC, NULL);
+	gpio_request(GPIO_FN_LCDVCPWC, NULL);
+	gpio_request(GPIO_FN_LCDVSYN, NULL);
+	gpio_request(GPIO_FN_LCDHSYN, NULL);
+	gpio_request(GPIO_FN_LCDDISP, NULL);
+	gpio_request(GPIO_FN_LCDDON, NULL);
+
+	/* LCD backlight */
+	gpio_request(GPIO_PTS3, NULL);
+	gpio_direction_output(GPIO_PTS3, 1);
+
+	/* CEU */
+	clk_always_enable("mstp203");
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
+	gpio_request(GPIO_PTZ7, NULL);
+	gpio_direction_output(GPIO_PTZ7, 0); /* OE_CAM */
+	gpio_request(GPIO_PTZ6, NULL);
+	gpio_direction_output(GPIO_PTZ6, 0); /* STBY_CAM */
+	gpio_request(GPIO_PTZ5, NULL);
+	gpio_direction_output(GPIO_PTZ5, 1); /* RST_CAM */
+	gpio_request(GPIO_PTZ4, NULL);
+	gpio_direction_output(GPIO_PTZ4, 0); /* SADDR */
+
+	ctrl_outw(ctrl_inw(PORT_MSELCRB) & ~0x0001, PORT_MSELCRB);
 
 	platform_resource_setup_memory(&ceu_device, "ceu", 4 << 20);
 
@@ -313,18 +373,6 @@ device_initcall(ap325rxa_devices_setup);
 
 static void __init ap325rxa_setup(char **cmdline_p)
 {
-	/* LCDC configuration */
-	ctrl_outw(ctrl_inw(PORT_PHCR) & ~0xffff, PORT_PHCR);
-	ctrl_outw(ctrl_inw(PORT_PLCR) & ~0xffff, PORT_PLCR);
-	ctrl_outw(ctrl_inw(PORT_PMCR) & ~0xffff, PORT_PMCR);
-	ctrl_outw(ctrl_inw(PORT_PRCR) & ~0x03ff, PORT_PRCR);
-	ctrl_outw(ctrl_inw(PORT_HIZCRA) & ~0x01C0, PORT_HIZCRA);
-
-	/* CEU */
-	ctrl_outw(ctrl_inw(PORT_MSELCRB) & ~0x0001, PORT_MSELCRB);
-	ctrl_outw(ctrl_inw(PORT_PSELD) & ~0x0003, PORT_PSELD);
-	ctrl_outw((ctrl_inw(PORT_PZCR) & ~0xff00) | 0x5500, PORT_PZCR);
-	ctrl_outb((ctrl_inb(PORT_PZDR) & ~0xf0) | 0x20, PORT_PZDR);
 }
 
 static struct sh_machine_vector mv_ap325rxa __initmv = {
