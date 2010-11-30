From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 30 Nov 2010 06:52:18 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: Add LEDs support
Message-Id: <w3psjyj9uch.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

you can control it by
echo 0 > /sys/class/leds/led0/brightness
echo 1 > /sys/class/leds/led0/brightness

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   40 +++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f9418e7..b9528b0 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -29,6 +29,7 @@
 #include <linux/gpio.h>
 #include <linux/input.h>
 #include <linux/io.h>
+#include <linux/leds.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
@@ -309,11 +310,50 @@ static struct platform_device usb1_host_device = {
 	.resource	= usb1_host_resources,
 };
 
+/* LED */
+static struct gpio_led mackerel_leds[] = {
+	{
+		.name		= "led0",
+		.gpio		= GPIO_PORT0,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+	{
+		.name		= "led1",
+		.gpio		= GPIO_PORT1,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+	{
+		.name		= "led2",
+		.gpio		= GPIO_PORT2,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	},
+	{
+		.name		= "led3",
+		.gpio		= GPIO_PORT159,
+		.default_state	= LEDS_GPIO_DEFSTATE_ON,
+	}
+};
+
+static struct gpio_led_platform_data mackerel_leds_pdata = {
+	.leds = mackerel_leds,
+	.num_leds = ARRAY_SIZE(mackerel_leds),
+};
+
+static struct platform_device leds_device = {
+	.name = "leds-gpio",
+	.id = 0,
+	.dev = {
+		.platform_data  = &mackerel_leds_pdata,
+	},
+};
+
+
 static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
 	&lcdc_device,
 	&usb1_host_device,
+	&leds_device,
 };
 
 static struct map_desc mackerel_io_desc[] __initdata = {
-- 
1.7.1

