From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 06 Dec 2011 16:52:58 +0000
Subject: [PATCH 07/07] ARM: mach-shmobile: Marzen GPIO LED test code
Message-Id: <20111206165258.19348.75164.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add prototype code for LED2, LED3 and LED4 on the Marzen board.

Should most likely use the LED framework, but is OK as-is for
now when testing the r8a7779 GPIO/PFC code.

Not-yet-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- 0010/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2011-12-07 00:25:39.000000000 +0900
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 #include <linux/dma-mapping.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
@@ -94,6 +95,18 @@ static void __init marzen_init(void)
 {
 	r8a7779_pinmux_init();
 
+	gpio_request(GPIO_GP_4_29, NULL); /* LED2 */
+	gpio_direction_output(GPIO_GP_4_29, 0);
+	gpio_export(GPIO_GP_4_29, false);
+
+	gpio_request(GPIO_GP_4_30, NULL); /* LED3 */
+	gpio_direction_output(GPIO_GP_4_30, 0);
+	gpio_export(GPIO_GP_4_30, false);
+
+	gpio_request(GPIO_GP_4_31, NULL); /* LED4 */
+	gpio_direction_output(GPIO_GP_4_31, 0);
+	gpio_export(GPIO_GP_4_31, false);
+
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
