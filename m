From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 May 2013 14:55:19 +0000
Subject: [PATCH 8/9] ARM: shmobile: APE6EVM: switch to using platform_add_devices()
Message-Id: <1368802520-16378-9-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Switch from platform_device_register_resndata() to platform_add_devices()
to make adding new devices easier.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-ape6evm.c |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 5eb0caa..9c69643 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -41,7 +41,7 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 };
 
 /* SMSC LAN9220 */
-static const struct resource lan9220_res[] = {
+static struct resource lan9220_res[] = {
 	DEFINE_RES_MEM(0x08000000, 0x1000),
 	{
 		.start	= irq_pin(40), /* IRQ40 */
@@ -49,12 +49,22 @@ static const struct resource lan9220_res[] = {
 	},
 };
 
-static const struct smsc911x_platform_config lan9220_data = {
+static struct smsc911x_platform_config lan9220_data = {
 	.flags		= SMSC911X_USE_32BIT,
 	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
 };
 
+static struct platform_device lan9220_device = {
+	.name           = "smsc911x",
+	.id             = -1,
+	.num_resources  = ARRAY_SIZE(lan9220_res),
+	.resource       = lan9220_res,
+	.dev            = {
+		.platform_data = &lan9220_data,
+	},
+};
+
 static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 	/* SCIFA0 console */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
@@ -64,6 +74,13 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 				  "irqc_irq40", "irqc"),
 };
 
+/*
+ * board devices
+ */
+static struct platform_device *ape6evm_devices[] __initdata = {
+	&lan9220_device,
+};
+
 static void __init ape6evm_add_standard_devices(void)
 {
 
@@ -91,9 +108,8 @@ static void __init ape6evm_add_standard_devices(void)
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
-	platform_device_register_resndata(&platform_bus, "smsc911x", -1,
-					  lan9220_res, ARRAY_SIZE(lan9220_res),
-					  &lan9220_data, sizeof(lan9220_data));
+	platform_add_devices(ape6evm_devices,
+			     ARRAY_SIZE(ape6evm_devices));
 }
 
 static const char *ape6evm_boards_compat_dt[] __initdata = {
-- 
1.7.2.5

