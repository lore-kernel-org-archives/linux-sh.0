From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 17 Feb 2010 09:30:14 +0000
Subject: [PATCH 2/2 v2] ARM: ap4evb: Add SMSC 9220 network support
Message-Id: <uaav818us.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
v1 -> v2

o remove enable_irq
o use gpio_request

 arch/arm/mach-shmobile/board-ap4evb.c |   38 +++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 94b545b..70277e0 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -27,11 +27,15 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
+#include <linux/smsc911x.h>
+#include <linux/gpio.h>
 #include <mach/common.h>
+#include <mach/sh7372.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+/* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
 		.name		= "loader",
@@ -84,9 +88,37 @@ static struct platform_device nor_flash_device = {
 	.resource	= nor_flash_resources,
 };
 
+/* SMSC 9220 */
+static struct resource smc911x_resources[] = {
+	{
+		.start	= 0x14000000,
+		.end	= 0x16000000 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= 6,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
+	},
+};
+
+static struct smsc911x_platform_config smsc911x_info = {
+	.flags		= SMSC911X_USE_16BIT | SMSC911X_SAVE_MAC_ADDRESS,
+	.irq_polarity   = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type       = SMSC911X_IRQ_TYPE_PUSH_PULL,
+};
+
+static struct platform_device smc911x_device = {
+	.name           = "smsc911x",
+	.id             = -1,
+	.num_resources  = ARRAY_SIZE(smc911x_resources),
+	.resource       = smc911x_resources,
+	.dev            = {
+		.platform_data = &smsc911x_info,
+	},
+};
 
 static struct platform_device *ap4evb_devices[] __initdata = {
 	&nor_flash_device,
+	&smc911x_device,
 };
 
 static struct map_desc ap4evb_io_desc[] __initdata = {
@@ -113,6 +145,12 @@ static void __init ap4evb_map_io(void)
 
 static void __init ap4evb_init(void)
 {
+	sh7372_pinmux_init();
+
+	/* enable SMSC911X */
+	gpio_request(GPIO_FN_CS5A,	NULL);
+	gpio_request(GPIO_FN_IRQ6_39,	NULL);
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
-- 
1.6.3.3

