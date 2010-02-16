From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 16 Feb 2010 02:30:25 +0000
Subject: [PATCH] ARM: ap4evb: Add SMSC 9220 network support
Message-Id: <ueiklq518.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   44 +++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 94b545b..f9af231 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -27,11 +27,13 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/io.h>
+#include <linux/smsc911x.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+/* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
 		.name		= "loader",
@@ -84,9 +86,37 @@ static struct platform_device nor_flash_device = {
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
@@ -111,10 +141,24 @@ static void __init ap4evb_map_io(void)
 	shmobile_setup_console();
 }
 
+#define	PORT39CR	0xE6051027
+#define	PORT65CR	0xE6052041
 static void __init ap4evb_init(void)
 {
 	sh7372_add_standard_devices();
 
+	/*
+	 * enable SMSC911X
+	 *
+	 * FIXME
+	 *
+	 * AP4 doesn't have pinmux support now.
+	 * So, set the value directly here
+	 */
+	__raw_writeb(0x01, PORT65CR); /* enable CS5A */
+	__raw_writeb(0x00, PORT39CR); /* enable IRQ6 */
+	enable_irq(6);
+
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
 }
 
-- 
1.6.3.3

