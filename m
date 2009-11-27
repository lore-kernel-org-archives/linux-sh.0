From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 27 Nov 2009 04:36:58 +0000
Subject: [PATCH] sh: Add SDHI power control support to Ecovec
Message-Id: <20091127043658.13573.80166.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds support for SDHI power control to the
Ecovec board. Platform data and power control callbacks
for SDHI0 and SDHI1 are added. Power is by default off.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the SDHI power control patch.

 arch/sh/boards/mach-ecovec24/setup.c |   36 ++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

--- 0012/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2009-11-26 17:57:38.000000000 +0900
@@ -20,6 +20,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
 #include <linux/input.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
 #include <media/tw9910.h>
@@ -423,6 +424,15 @@ static struct i2c_board_info ts_i2c_clie
 };
 
 /* SHDI0 */
+static void sdhi0_set_pwr(struct platform_device *pdev, int state)
+{
+	gpio_set_value(GPIO_PTB6, state);
+}
+
+static struct sh_mobile_sdhi_info sdhi0_info = {
+	.set_pwr = sdhi0_set_pwr,
+};
+
 static struct resource sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
@@ -441,12 +451,24 @@ static struct platform_device sdhi0_devi
 	.num_resources  = ARRAY_SIZE(sdhi0_resources),
 	.resource       = sdhi0_resources,
 	.id             = 0,
+	.dev	= {
+		.platform_data	= &sdhi0_info,
+	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI0,
 	},
 };
 
 /* SHDI1 */
+static void sdhi1_set_pwr(struct platform_device *pdev, int state)
+{
+	gpio_set_value(GPIO_PTB7, state);
+}
+
+static struct sh_mobile_sdhi_info sdhi1_info = {
+	.set_pwr = sdhi1_set_pwr,
+};
+
 static struct resource sdhi1_resources[] = {
 	[0] = {
 		.name	= "SDHI1",
@@ -465,6 +487,9 @@ static struct platform_device sdhi1_devi
 	.num_resources  = ARRAY_SIZE(sdhi1_resources),
 	.resource       = sdhi1_resources,
 	.id             = 1,
+	.dev	= {
+		.platform_data	= &sdhi1_info,
+	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI1,
 	},
@@ -865,7 +890,7 @@ static int __init arch_setup(void)
 	gpio_direction_input(GPIO_PTR5);
 	gpio_direction_input(GPIO_PTR6);
 
-	/* enable SDHI0 */
+	/* enable SDHI0 (needs DS2.4 set to ON) */
 	gpio_request(GPIO_FN_SDHI0CD,  NULL);
 	gpio_request(GPIO_FN_SDHI0WP,  NULL);
 	gpio_request(GPIO_FN_SDHI0CMD, NULL);
@@ -874,8 +899,10 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI0D2,  NULL);
 	gpio_request(GPIO_FN_SDHI0D1,  NULL);
 	gpio_request(GPIO_FN_SDHI0D0,  NULL);
+	gpio_request(GPIO_PTB6, NULL);
+	gpio_direction_output(GPIO_PTB6, 0);
 
-	/* enable SDHI1 */
+	/* enable SDHI1 (needs DS2.6,7 set to ON,OFF) */
 	gpio_request(GPIO_FN_SDHI1CD,  NULL);
 	gpio_request(GPIO_FN_SDHI1WP,  NULL);
 	gpio_request(GPIO_FN_SDHI1CMD, NULL);
@@ -884,11 +911,8 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_SDHI1D2,  NULL);
 	gpio_request(GPIO_FN_SDHI1D1,  NULL);
 	gpio_request(GPIO_FN_SDHI1D0,  NULL);
-
-	gpio_request(GPIO_PTB6, NULL);
 	gpio_request(GPIO_PTB7, NULL);
-	gpio_direction_output(GPIO_PTB6, 1);
-	gpio_direction_output(GPIO_PTB7, 1);
+	gpio_direction_output(GPIO_PTB7, 0);
 
 	/* I/O buffer drive ability is high for SDHI1 */
 	ctrl_outw((ctrl_inw(IODRIVEA) & ~0x3000) | 0x2000 , IODRIVEA);
