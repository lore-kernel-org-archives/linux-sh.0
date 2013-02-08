From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 08 Feb 2013 18:38:32 +0000
Subject: [PATCH/RFC v2 8/8] ARM: shmobile: add ethernet support to kzm9g-reference
Message-Id: <1360348712-29255-9-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enable the smsc9221 ethernet controller on kzm9g-reference in the board .c
file, because INTCS initialisation from DT isn't supported yet.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

The last hack - once INTC and pinctrl are in DT, ethernet will be added 
there too.

 arch/arm/mach-shmobile/board-kzm9g-reference.c |   44 ++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 728c810..8679eb2 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -26,17 +26,61 @@
 #include <linux/irq.h>
 #include <linux/input.h>
 #include <linux/of_platform.h>
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
+	REGULATOR_SUPPLY("vddvario", "smsc911x"),
+	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
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
+		.start	= intcs_evt2irq(0x260), /* IRQ3 */
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
 static void __init kzm_init(void)
 {
 	sh73a0_add_standard_devices_dt();
 	sh73a0_pinmux_init();
 
+	regulator_register_fixed(2, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	platform_device_register(&smsc_device);
+
 	/* enable SCIFA4 */
 	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
 	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
-- 
1.7.2.5

