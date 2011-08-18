From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Aug 2011 05:44:25 +0000
Subject: [PATCH 03/07] ARM: mach-shmobile: Kota2 GPIO Keys support
Message-Id: <20110818054425.23410.51390.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch ties in GPIO Keys support on the Kota2
board. For now the keys are used in polling mode,
but after extending the sh73a0 PFC with IRQ support
we should be able to switch to the IRQ driven driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kota2.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- 0006/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2011-08-17 22:37:04.000000000 +0900
@@ -31,6 +31,7 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/gpio_keys.h>
 #include <mach/hardware.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
@@ -114,9 +115,40 @@ static struct platform_device keysc_devi
 	},
 };
 
+#define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
+
+static struct gpio_keys_button gpio_buttons[] = {
+	GPIO_KEY(KEY_VOLUMEUP, GPIO_PORT56, "+"), /* S2: VOL+ [IRQ9] */
+	GPIO_KEY(KEY_VOLUMEDOWN, GPIO_PORT54, "-"), /* S3: VOL- [IRQ10] */
+	GPIO_KEY(KEY_MENU, GPIO_PORT27, "Menu"), /* S4: MENU [IRQ30] */
+	GPIO_KEY(KEY_HOMEPAGE, GPIO_PORT26, "Home"), /* S5: HOME [IRQ31] */
+	GPIO_KEY(KEY_BACK, GPIO_PORT11, "Back"), /* S6: BACK [IRQ0] */
+	GPIO_KEY(KEY_PHONE, GPIO_PORT238, "Tel"), /* S7: TEL [IRQ11] */
+	GPIO_KEY(KEY_POWER, GPIO_PORT239, "C1"), /* S8: CAM [IRQ13] */
+	GPIO_KEY(KEY_MAIL, GPIO_PORT224, "Mail"), /* S9: MAIL [IRQ3] */
+	/* Omitted button "C3?": GPIO_PORT223 - S10: CUST [IRQ8] */
+	GPIO_KEY(KEY_CAMERA, GPIO_PORT164, "C2"), /* S11: CAM_HALF [IRQ25] */
+	/* Omitted button "?": GPIO_PORT152 - S12: CAM_FULL [No IRQ] */
+};
+
+static struct gpio_keys_platform_data gpio_key_info = {
+	.buttons        = gpio_buttons,
+	.nbuttons       = ARRAY_SIZE(gpio_buttons),
+	.poll_interval  = 250, /* polled for now */
+};
+
+static struct platform_device gpio_keys_device = {
+	.name   = "gpio-keys-polled", /* polled for now */
+	.id     = -1,
+	.dev    = {
+		.platform_data  = &gpio_key_info,
+	},
+};
+
 static struct platform_device *kota2_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
+	&gpio_keys_device,
 };
 
 static struct map_desc kota2_io_desc[] __initdata = {
