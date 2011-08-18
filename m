From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Aug 2011 05:44:16 +0000
Subject: [PATCH 02/07] ARM: mach-shmobile: Kota2 KEYSC support
Message-Id: <20110818054416.23410.50938.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds KEYSC support to the Kota2 board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kota2.c |   65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

--- 0005/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2011-08-15 10:33:09.000000000 +0900
@@ -29,6 +29,8 @@
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 #include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/input/sh_keysc.h>
 #include <mach/hardware.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
@@ -69,8 +71,52 @@ static struct platform_device eth_device
 	.num_resources	= ARRAY_SIZE(smsc9220_resources),
 };
 
+static struct sh_keysc_info keysc_platdata = {
+	.mode		= SH_KEYSC_MODE_6,
+	.scan_timing	= 3,
+	.delay		= 100,
+	.keycodes	= {
+		KEY_NUMERIC_STAR, KEY_NUMERIC_0, KEY_NUMERIC_POUND,
+		0, 0, 0, 0, 0,
+		KEY_NUMERIC_7, KEY_NUMERIC_8, KEY_NUMERIC_9,
+		0, KEY_DOWN, 0, 0, 0,
+		KEY_NUMERIC_4, KEY_NUMERIC_5, KEY_NUMERIC_6,
+		KEY_LEFT, KEY_ENTER, KEY_RIGHT, 0, 0,
+		KEY_NUMERIC_1, KEY_NUMERIC_2, KEY_NUMERIC_3,
+		0, KEY_UP, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0,
+		0, 0, 0, 0, 0, 0, 0, 0,
+	},
+};
+
+static struct resource keysc_resources[] = {
+	[0] = {
+		.name	= "KEYSC",
+		.start	= 0xe61b0000,
+		.end	= 0xe61b0098 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(71),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device keysc_device = {
+	.name		= "sh_keysc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(keysc_resources),
+	.resource	= keysc_resources,
+	.dev		= {
+		.platform_data	= &keysc_platdata,
+	},
+};
+
 static struct platform_device *kota2_devices[] __initdata = {
 	&eth_device,
+	&keysc_device,
 };
 
 static struct map_desc kota2_io_desc[] __initdata = {
@@ -140,6 +186,25 @@ static void __init kota2_init(void)
 	gpio_request(GPIO_PORT145, NULL); /* RESET */
 	gpio_direction_output(GPIO_PORT145, 1);
 
+	/* KEYSC */
+	gpio_request(GPIO_FN_KEYIN0_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN1_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN2_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN3_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN4_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN5_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN6_PU, NULL);
+	gpio_request(GPIO_FN_KEYIN7_PU, NULL);
+	gpio_request(GPIO_FN_KEYOUT0, NULL);
+	gpio_request(GPIO_FN_KEYOUT1, NULL);
+	gpio_request(GPIO_FN_KEYOUT2, NULL);
+	gpio_request(GPIO_FN_KEYOUT3, NULL);
+	gpio_request(GPIO_FN_KEYOUT4, NULL);
+	gpio_request(GPIO_FN_KEYOUT5, NULL);
+	gpio_request(GPIO_FN_PORT59_KEYOUT6, NULL);
+	gpio_request(GPIO_FN_PORT58_KEYOUT7, NULL);
+	gpio_request(GPIO_FN_KEYOUT8, NULL);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(__io(0xf0100000), 0x40460000, 0x82000fff);
