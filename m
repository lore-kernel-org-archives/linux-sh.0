From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 13 May 2010 01:07:54 +0000
Subject: [PATCH] ARM: mach-shmobile: g3evm: Add IrDA support
Message-Id: <ueihglic5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-g3evm.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-g3evm.c b/arch/arm/mach-shmobile/board-g3evm.c
index 9247503..19b3bf3 100644
--- a/arch/arm/mach-shmobile/board-g3evm.c
+++ b/arch/arm/mach-shmobile/board-g3evm.c
@@ -38,6 +38,14 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+/*
+ * IrDA
+ *
+ * S67: 5bit : ON  power
+ *    : 6bit : ON  remote control
+ *             OFF IrDA
+ */
+
 static struct mtd_partition nor_flash_partitions[] = {
 	{
 		.name		= "loader",
@@ -209,11 +217,30 @@ static struct platform_device nand_flash_device = {
 	},
 };
 
+static struct resource irda_resources[] = {
+	[0] = {
+		.start	= 0xE6D00000,
+		.end	= 0xE6D01FD4 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 20,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device irda_device = {
+	.name		= "sh_irda",
+	.resource	= irda_resources,
+	.num_resources	= ARRAY_SIZE(irda_resources),
+};
+
 static struct platform_device *g3evm_devices[] __initdata = {
 	&nor_flash_device,
 	&usb_host_device,
 	&keysc_device,
 	&nand_flash_device,
+	&irda_device,
 };
 
 static struct map_desc g3evm_io_desc[] __initdata = {
@@ -318,6 +345,12 @@ static void __init g3evm_init(void)
 	/* FOE, FCDE, FSC on dedicated pins */
 	__raw_writel(__raw_readl(0xe6158048) & ~(1 << 15), 0xe6158048);
 
+	/* IrDA */
+	gpio_request(GPIO_FN_IRDA_OUT, NULL);
+	gpio_request(GPIO_FN_IRDA_IN, NULL);
+	gpio_request(GPIO_FN_IRDA_FIRSEL, NULL);
+	set_irq_type(20, IRQ_TYPE_LEVEL_LOW);
+
 	sh7367_add_standard_devices();
 
 	platform_add_devices(g3evm_devices, ARRAY_SIZE(g3evm_devices));
-- 
1.7.0.4

