From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Mar 2010 07:15:28 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb SDHI0 platform data
Message-Id: <20100310071528.5975.28821.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add SDHI0 platform data for the AP4EVB board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on "ARM: mach-shmobile: sh7372 SDHI vector merge".

 arch/arm/mach-shmobile/board-ap4evb.c |   39 +++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2010-03-10 16:11:27.000000000 +0900
@@ -31,6 +31,7 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
 #include <mach/common.h>
 #include <mach/sh7372.h>
 #include <asm/mach-types.h>
@@ -206,10 +207,38 @@ static struct platform_device keysc_devi
 	},
 };
 
+/* SDHI0 */
+static struct sh_mobile_sdhi_info sdhi0_info = {
+};
+
+static struct resource sdhi0_resources[] = {
+	[0] = {
+		.name	= "SDHI0",
+		.start  = 0xe6850000,
+		.end    = 0xe68501ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 96,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi0_device = {
+	.name           = "sh_mobile_sdhi",
+	.num_resources  = ARRAY_SIZE(sdhi0_resources),
+	.resource       = sdhi0_resources,
+	.id             = 0,
+	.dev	= {
+		.platform_data	= &sdhi0_info,
+	},
+};
+
 static struct platform_device *ap4evb_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&keysc_device,
+	&sdhi0_device,
 };
 
 static struct map_desc ap4evb_io_desc[] __initdata = {
@@ -286,6 +315,16 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_KEYIN3_133, NULL);
 	gpio_request(GPIO_FN_KEYIN4,     NULL);
 
+	/* SDHI0 */
+	gpio_request(GPIO_FN_SDHICD0, NULL);
+	gpio_request(GPIO_FN_SDHIWP0, NULL);
+	gpio_request(GPIO_FN_SDHICMD0, NULL);
+	gpio_request(GPIO_FN_SDHICLK0, NULL);
+	gpio_request(GPIO_FN_SDHID0_3, NULL);
+	gpio_request(GPIO_FN_SDHID0_2, NULL);
+	gpio_request(GPIO_FN_SDHID0_1, NULL);
+	gpio_request(GPIO_FN_SDHID0_0, NULL);
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
