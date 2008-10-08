From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 08 Oct 2008 11:42:38 +0000
Subject: [PATCH 07/09] sh: Use sh7203 GPIO on rsk7203 board
Message-Id: <20081008114238.25282.57017.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Make the rsk7203 board use the newly added sh7203 pinmux code.
Only a single LED plus the serial console pins for now.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/Kconfig         |    1 +
 arch/sh/boards/board-rsk7203.c |   11 +++++++++++
 2 files changed, 12 insertions(+)

--- 0006/arch/sh/boards/Kconfig
+++ work/arch/sh/boards/Kconfig	2008-10-08 19:34:15.000000000 +0900
@@ -128,6 +128,7 @@ config SH_RTS7751R2D
 
 config SH_RSK7203
 	bool "RSK7203"
+	select GENERIC_GPIO
 	depends on CPU_SUBTYPE_SH7203
 
 config SH_SDK7780
--- 0001/arch/sh/boards/board-rsk7203.c
+++ work/arch/sh/boards/board-rsk7203.c	2008-10-08 19:33:50.000000000 +0900
@@ -16,8 +16,10 @@
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/map.h>
 #include <linux/smc911x.h>
+#include <linux/gpio.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
+#include <asm/sh7203.h>
 
 static struct smc911x_platdata smc911x_info = {
 	.flags		= SMC911X_USE_16BIT,
@@ -122,6 +124,15 @@ static struct platform_device *rsk7203_d
 
 static int __init rsk7203_devices_setup(void)
 {
+	/* Select pins for SCIF0 */
+	gpio_request(GPIO_FN_TXD0, NULL);
+	gpio_request(GPIO_FN_RXD0, NULL);
+
+	/* Lit LED0 */
+	gpio_request(GPIO_PE10, NULL);
+	gpio_direction_output(GPIO_PE10, 0);
+	gpio_export(GPIO_PE10, 0);
+
 	set_mtd_partitions();
 	return platform_add_devices(rsk7203_devices,
 				    ARRAY_SIZE(rsk7203_devices));
