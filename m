From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:50 +0000
Subject: [PATCH v3 30/64] ARM: shmobile: marzen: Register pinctrl mappings for SDHI and MMCIF
Message-Id: <1362740544-19164-31-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the GPIO-based SDHI and MMCIF pinmux configuration by pinctrl
mappings

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-marzen.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index fec49eb..d25a7b3 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/gpio.h>
 #include <linux/dma-mapping.h>
+#include <linux/pinctrl/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
@@ -327,6 +328,17 @@ void __init marzen_init_late(void)
 			     ARRAY_SIZE(marzen_late_devices));
 }
 
+static const struct pinctrl_map marzen_pinctrl_map[] = {
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_cd", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
+				  "sdhi0_wp", "sdhi0"),
+};
+
 static void __init marzen_init(void)
 {
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
@@ -334,6 +346,8 @@ static void __init marzen_init(void)
 	regulator_register_fixed(1, dummy_supplies,
 				ARRAY_SIZE(dummy_supplies));
 
+	pinctrl_register_mappings(marzen_pinctrl_map,
+				  ARRAY_SIZE(marzen_pinctrl_map));
 	r8a7779_pinmux_init();
 
 	/* SCIF2 (CN18: DEBUG0) */
@@ -348,16 +362,6 @@ static void __init marzen_init(void)
 	gpio_request(GPIO_FN_EX_CS0, NULL); /* nCS */
 	gpio_request(GPIO_FN_IRQ1_B, NULL); /* IRQ + PME */
 
-	/* SD0 (CN20) */
-	gpio_request(GPIO_FN_SD0_CLK, NULL);
-	gpio_request(GPIO_FN_SD0_CMD, NULL);
-	gpio_request(GPIO_FN_SD0_DAT0, NULL);
-	gpio_request(GPIO_FN_SD0_DAT1, NULL);
-	gpio_request(GPIO_FN_SD0_DAT2, NULL);
-	gpio_request(GPIO_FN_SD0_DAT3, NULL);
-	gpio_request(GPIO_FN_SD0_CD, NULL);
-	gpio_request(GPIO_FN_SD0_WP, NULL);
-
 	/* HSPI 0 */
 	gpio_request(GPIO_FN_HSPI_CLK0,	NULL);
 	gpio_request(GPIO_FN_HSPI_CS0,	NULL);
-- 
1.8.1.5

