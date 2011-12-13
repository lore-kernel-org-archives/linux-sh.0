From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 13 Dec 2011 16:36:42 +0000
Subject: [PATCH 04/05] ARM: mach-shmobile: Marzen SCIF2/SCIF4 support
Message-Id: <20111213163642.4096.59993.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SCIF2 and SCIF4 pin configuration code to
the r8a7779 Marzen board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0020/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2011-12-14 00:06:37.000000000 +0900
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
 #include <linux/dma-mapping.h>
 #include <mach/hardware.h>
 #include <mach/r8a7779.h>
@@ -86,6 +87,14 @@ static void __init marzen_init(void)
 {
 	r8a7779_pinmux_init();
 
+	/* SCIF2 (CN18: DEBUG0) */
+	gpio_request(GPIO_FN_TX2_C, NULL);
+	gpio_request(GPIO_FN_RX2_C, NULL);
+
+	/* SCIF4 (CN19: DEBUG1) */
+	gpio_request(GPIO_FN_TX4, NULL);
+	gpio_request(GPIO_FN_RX4, NULL);
+
 	r8a7779_add_standard_devices();
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
