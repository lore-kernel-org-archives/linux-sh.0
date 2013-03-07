From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 07 Mar 2013 19:00:35 +0000
Subject: [no-PATCH 2/3] ARM: shmobile: add ethernet support to kzm9g-reference
Message-Id: <Pine.LNX.4.64.1303071956390.16065@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enable the smsc9221 ethernet controller on kzm9g-reference in the board .c
file, because INTCS initialisation from DT isn't supported yet.

Not-Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   44 ++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index fbbaa55..81d44d8 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -28,12 +28,53 @@
 #include <linux/input.h>
 #include <linux/of_platform.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+#include <linux/smsc911x.h>
+
+#include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* Dummy supplies, where voltage doesn't matter */
+static struct regulator_consumer_supply dummy_supplies[] = {
+	REGULATOR_SUPPLY("vddvario", "smsc911x.0"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x.0"),
+};
+
+/* SMSC 9221 */
+static struct resource smsc9221_resources[] = {
+	[0] = {
+		.start	= 0x10000000, /* CS4 */
+		.end	= 0x100000ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= irq_pin(3), /* IRQ3 */
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct smsc911x_platform_config smsc9221_platdata = {
+	.flags		= SMSC911X_USE_32BIT | SMSC911X_SAVE_MAC_ADDRESS,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+};
+
+static struct platform_device smsc_device = {
+	.name		= "smsc911x",
+	.dev  = {
+		.platform_data = &smsc9221_platdata,
+	},
+	.resource	= smsc9221_resources,
+	.num_resources	= ARRAY_SIZE(smsc9221_resources),
+};
+
 static const struct pinctrl_map kzm_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-sh_mobile.3", "pfc-sh73a0",
 				  "i2c3_1", "i2c3"),
@@ -49,6 +90,9 @@ static void __init kzm_init(void)
 	pinctrl_register_mappings(kzm_pinctrl_map, ARRAY_SIZE(kzm_pinctrl_map));
 	sh73a0_pinmux_init();
 
+	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	platform_device_register(&smsc_device);
+
 	/* enable MMCIF */
 	gpio_request(GPIO_FN_MMCCLK0,		NULL);
 	gpio_request(GPIO_FN_MMCCMD0_PU,	NULL);
-- 
1.7.2.5

