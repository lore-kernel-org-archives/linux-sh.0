From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Nov 2013 07:41:48 +0000
Subject: [PATCH] ARM: shmobile: Add pinctrl_register_mappings() for Koelsch
Message-Id: <20131120074148.22744.70608.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, horms@verge.net.au, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add code to setup the r8a7791 PFC for the Koelsch board.

At this point serial consoles are added, and in the near
future other platform-device-only devices will be added
here like for instance the r8a7791 DU.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- 0014/arch/arm/mach-shmobile/board-koelsch.c
+++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-11-20 16:18:28.000000000 +0900
@@ -24,6 +24,7 @@
 #include <linux/input.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
 #include <mach/common.h>
@@ -78,9 +79,20 @@ static const struct gpio_keys_platform_d
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
 
+static const struct pinctrl_map koelsch_pinctrl_map[] = {
+	/* SCIF0 (CN19: DEBUG SERIAL0) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7791",
+				  "scif0_data_d", "scif0"),
+	/* SCIF1 (CN20: DEBUG SERIAL1) */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7791",
+				  "scif1_data_d", "scif1"),
+};
+
 static void __init koelsch_add_standard_devices(void)
 {
 	r8a7791_clock_init();
+	pinctrl_register_mappings(koelsch_pinctrl_map,
+				  ARRAY_SIZE(koelsch_pinctrl_map));
 	r8a7791_pinmux_init();
 	r8a7791_add_standard_devices();
 	platform_device_register_data(&platform_bus, "leds-gpio", -1,
