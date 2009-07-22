From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Jul 2009 16:23:45 +0000
Subject: [PATCH] sh: kfr2r09 board support - KEYSC keypad
Message-Id: <20090722162345.18191.55193.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds KEYSC keypad support to the kfr2r09 board.

The keys driven by the sh7724 on-chip KEYSC block are
described as a platform device and platform data for
the sh_keysc driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Applies on top of the NOR flash patch.

 arch/sh/boards/mach-kfr2r09/setup.c |   53 +++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

--- 0010/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-07-23 00:40:01.000000000 +0900
@@ -14,9 +14,11 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/input.h>
 #include <asm/clock.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
+#include <asm/sh_keysc.h>
 #include <cpu/sh7724.h>
 
 static struct mtd_partition kfr2r09_nor_flash_partitions[] @@ -58,8 +60,46 @@ static struct platform_device kfr2r09_no
 	},
 };
 
+static struct sh_keysc_info kfr2r09_sh_keysc_info = {
+	.mode = SH_KEYSC_MODE_1, /* KEYOUT0->4, KEYIN0->4 */
+	.scan_timing = 3,
+	.delay = 10,
+	.keycodes = {
+		KEY_PHONE, KEY_CLEAR, KEY_MAIL, KEY_WWW, KEY_ENTER,
+		KEY_1, KEY_2, KEY_3, 0, KEY_UP,
+		KEY_4, KEY_5, KEY_6, 0, KEY_LEFT,
+		KEY_7, KEY_8, KEY_9, KEY_PROG1, KEY_RIGHT,
+		KEY_S, KEY_0, KEY_P, KEY_PROG2, KEY_DOWN,
+		0, 0, 0, 0, 0
+	},
+};
+
+static struct resource kfr2r09_sh_keysc_resources[] = {
+	[0] = {
+		.name	= "KEYSC",
+		.start  = 0x044b0000,
+		.end    = 0x044b000f,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 79,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device kfr2r09_sh_keysc_device = {
+	.name           = "sh_keysc",
+	.id             = 0, /* "keysc0" clock */
+	.num_resources  = ARRAY_SIZE(kfr2r09_sh_keysc_resources),
+	.resource       = kfr2r09_sh_keysc_resources,
+	.dev	= {
+		.platform_data	= &kfr2r09_sh_keysc_info,
+	},
+};
+
 static struct platform_device *kfr2r09_devices[] __initdata = {
 	&kfr2r09_nor_flash_device,
+	&kfr2r09_sh_keysc_device,
 };
 
 #define BSC_CS0BCR 0xfec10004
@@ -75,6 +115,19 @@ static int __init kfr2r09_devices_setup(
 	ctrl_outl(0x36db0400, BSC_CS0BCR);
 	ctrl_outl(0x00000500, BSC_CS0WCR);
 
+	/* setup KEYSC pins */
+	gpio_request(GPIO_FN_KEYOUT0, NULL);
+	gpio_request(GPIO_FN_KEYOUT1, NULL);
+	gpio_request(GPIO_FN_KEYOUT2, NULL);
+	gpio_request(GPIO_FN_KEYOUT3, NULL);
+	gpio_request(GPIO_FN_KEYOUT4_IN6, NULL);
+	gpio_request(GPIO_FN_KEYIN0, NULL);
+	gpio_request(GPIO_FN_KEYIN1, NULL);
+	gpio_request(GPIO_FN_KEYIN2, NULL);
+	gpio_request(GPIO_FN_KEYIN3, NULL);
+	gpio_request(GPIO_FN_KEYIN4, NULL);
+	gpio_request(GPIO_FN_KEYOUT5_IN5, NULL);
+
 	return platform_add_devices(kfr2r09_devices,
 				    ARRAY_SIZE(kfr2r09_devices));
 }
