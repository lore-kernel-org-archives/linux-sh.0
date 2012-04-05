From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Apr 2012 08:34:16 +0000
Subject: [PATCH 5/6] ARM: mach-shmobile: armadillo800eva: add support gpio_key
Message-Id: <87iphe4lx7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |   26 ++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index b3754ee..987265a 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -23,8 +23,10 @@
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/irq.h>
+#include <linux/input.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/gpio_keys.h>
 #include <linux/videodev2.h>
 #include <mach/common.h>
 #include <asm/page.h>
@@ -157,11 +159,35 @@ static struct i2c_board_info i2c0_devices[] = {
 	},
 };
 
+/* GPIO KEY */
+#define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
+
+static struct gpio_keys_button gpio_buttons[] = {
+	GPIO_KEY(KEY_ENTER,	GPIO_PORT99,	"SW1"),
+	GPIO_KEY(KEY_BACK,	GPIO_PORT100,	"SW2"),
+	GPIO_KEY(KEY_MENU,	GPIO_PORT97,	"SW3"),
+	GPIO_KEY(KEY_HOME,	GPIO_PORT98,	"SW4"),
+};
+
+static struct gpio_keys_platform_data gpio_key_info = {
+	.buttons	= gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(gpio_buttons),
+};
+
+static struct platform_device gpio_keys_device = {
+	.name   = "gpio-keys",
+	.id     = -1,
+	.dev    = {
+		.platform_data  = &gpio_key_info,
+	},
+};
+
 /*
  * board devices
  */
 static struct platform_device *eva_devices[] __initdata = {
 	&lcdc0_device,
+	&gpio_keys_device,
 };
 
 /*
-- 
1.7.5.4

