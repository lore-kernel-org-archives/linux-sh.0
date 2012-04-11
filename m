From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Apr 2012 03:57:58 +0000
Subject: [PATCH 3/6] ARM: mach-shmobile: kzm9g: add SMSC 9221 support
Message-Id: <87aa2i3oot.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |   39 ++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 55dad87..a46aec1 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -20,6 +20,8 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+#include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
 #include <asm/hardware/cache-l2x0.h>
@@ -27,7 +29,37 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
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
 static struct platform_device *kzm_devices[] __initdata = {
+	&smsc_device,
 };
 
 static void __init kzm_init(void)
@@ -40,6 +72,13 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
 	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
 
+	/* CS4 for SMSC/USB */
+	gpio_request(GPIO_FN_CS4_, NULL); /* CS4 */
+
+	/* SMSC */
+	gpio_request(GPIO_PORT224, NULL); /* IRQ3 */
+	gpio_direction_input(GPIO_PORT224);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
 	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
-- 
1.7.5.4

