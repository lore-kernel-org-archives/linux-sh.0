From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Nov 2010 02:21:37 +0000
Subject: [PATCH 2/5] ARM: mach-shmobile: mackerel: Add SMSC support
Message-Id: <w3pfwuk50pb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   34 +++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index b8df709..e2def7e 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -32,6 +32,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/smsc911x.h>
 
 #include <mach/common.h>
 #include <mach/sh7372.h>
@@ -109,8 +110,37 @@ static struct platform_device nor_flash_device = {
 	.resource	= nor_flash_resources,
 };
 
+/* SMSC */
+static struct resource smc911x_resources[] = {
+	{
+		.start	= 0x14000000,
+		.end	= 0x16000000 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= evt2irq(0x02c0) /* IRQ6A */,
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
+
 static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
+	&smc911x_device,
 };
 
 static struct map_desc mackerel_io_desc[] __initdata = {
@@ -142,6 +172,10 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_SCIFA0_TXD, NULL);
 	gpio_request(GPIO_FN_SCIFA0_RXD, NULL);
 
+	/* enable SMSC911X */
+	gpio_request(GPIO_FN_CS5A,	NULL);
+	gpio_request(GPIO_FN_IRQ6_39,	NULL);
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
-- 
1.7.0.4

