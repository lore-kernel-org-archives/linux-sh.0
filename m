From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Jul 2013 15:25:30 +0000
Subject: [PATCH v2 4/6] ARM: shmobile: Lager: add MMCIF support
Message-Id: <1373037932-19918-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add support for the MMCIF1 interface on Lager.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: fixed MMCIF memory resource size

 arch/arm/mach-shmobile/board-lager.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index d0da052..3c67b2a 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -24,10 +24,15 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
 #include <mach/common.h>
+#include <mach/irqs.h>
 #include <mach/r8a7790.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -70,6 +75,22 @@ static __initdata struct gpio_keys_platform_data lager_keys_pdata = {
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
 
+/* Fixed 3.3V regulator to be used by MMCIF */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] +{
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.1"),
+};
+
+/* MMCIF */
+static struct sh_mmcif_plat_data mmcif1_pdata = {
+	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+};
+
+static struct resource mmcif1_resources[] = {
+	DEFINE_RES_MEM_NAMED(0xee220000, 0x80, "MMCIF1"),
+	DEFINE_RES_IRQ(gic_spi(170)),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7790",
@@ -77,6 +98,11 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF1 (CN20: DEBUG SERIAL1) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
 				  "scif1_data", "scif1"),
+	/* MMCIF1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.1", "pfc-r8a7790",
+				  "mmc1_data8", "mmc1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.1", "pfc-r8a7790",
+				  "mmc1_ctrl", "mmc1"),
 };
 
 static void __init lager_add_standard_devices(void)
@@ -94,6 +120,11 @@ static void __init lager_add_standard_devices(void)
 	platform_device_register_data(&platform_bus, "gpio-keys", -1,
 				      &lager_keys_pdata,
 				      sizeof(lager_keys_pdata));
+	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+	platform_device_register_resndata(&platform_bus, "sh_mmcif", 1,
+					  mmcif1_resources, ARRAY_SIZE(mmcif1_resources),
+					  &mmcif1_pdata, sizeof(mmcif1_pdata));
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
-- 
1.7.2.5

