From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 29 Mar 2010 06:31:36 +0000
Subject: [PATCH] ARM: mach-shmobile: Add SDHI support
Message-Id: <u8w9bvdtj.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch add SDHI support for G4 board.
Current gpio frame work doesn't have
the method to control only pull-up/down/free.
So, it have special gpio_pull_up function for SDHI.
It is quick hack, so this function should be replaced
by correct gpio frame work in future.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/board-g4evm.c |  127 ++++++++++++++++++++++++++++++++++
 1 files changed, 127 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index 10673a9..33441d5 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -30,6 +30,7 @@
 #include <linux/io.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/gpio.h>
 #include <mach/sh7377.h>
 #include <mach/common.h>
@@ -37,6 +38,31 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
+/*
+ * SDHI
+ *
+ * SDHI0 : card detection is possible
+ * SDHI1 : card detection is impossible
+ *
+ * [G4-MAIN-BOARD]
+ * JP74 : short		# DBG_2V8A    for SDHI0
+ * JP75 : NC		# DBG_3V3A    for SDHI0
+ * JP76 : NC		# DBG_3V3A_SD for SDHI0
+ * JP77 : NC		# 3V3A_SDIO   for SDHI1
+ * JP78 : short		# DBG_2V8A    for SDHI1
+ * JP79 : NC		# DBG_3V3A    for SDHI1
+ * JP80 : NC		# DBG_3V3A_SD for SDHI1
+ *
+ * [G4-CORE-BOARD]
+ * S32 : all off	# to dissever from G3-CORE_DBG board
+ * S33 : all off	# to dissever from G3-CORE_DBG board
+ *
+ * [G3-CORE_DBG-BOARD]
+ * S1  : all off	# to dissever from G3-CORE_DBG board
+ * S3  : all off	# to dissever from G3-CORE_DBG board
+ * S4  : all off	# to dissever from G3-CORE_DBG board
+ */
+
 static struct mtd_partition nor_flash_partitions[] = {
 	{
 		.name		= "loader",
@@ -169,10 +195,53 @@ static struct platform_device keysc_device = {
 	},
 };
 
+/* SDHI */
+static struct resource sdhi0_resources[] = {
+	[0] = {
+		.name	= "SDHI0",
+		.start  = 0xe6d50000,
+		.end    = 0xe6d501ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 96,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi0_device = {
+	.name           = "sh_mobile_sdhi",
+	.num_resources  = ARRAY_SIZE(sdhi0_resources),
+	.resource       = sdhi0_resources,
+	.id             = 0,
+};
+
+static struct resource sdhi1_resources[] = {
+	[0] = {
+		.name	= "SDHI1",
+		.start  = 0xe6d60000,
+		.end    = 0xe6d601ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 100,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi1_device = {
+	.name           = "sh_mobile_sdhi",
+	.num_resources  = ARRAY_SIZE(sdhi1_resources),
+	.resource       = sdhi1_resources,
+	.id             = 1,
+};
+
 static struct platform_device *g4evm_devices[] __initdata = {
 	&nor_flash_device,
 	&usb_host_device,
 	&keysc_device,
+	&sdhi0_device,
+	&sdhi1_device,
 };
 
 static struct map_desc g4evm_io_desc[] __initdata = {
@@ -197,6 +266,36 @@ static void __init g4evm_map_io(void)
 	shmobile_setup_console();
 }
 
+#define GPIO_SDHID0_D0	0xe60520fc
+#define GPIO_SDHID0_D1	0xe60520fd
+#define GPIO_SDHID0_D2	0xe60520fe
+#define GPIO_SDHID0_D3	0xe60520ff
+#define GPIO_SDHICMD0	0xe6052100
+
+#define GPIO_SDHID1_D0	0xe6052103
+#define GPIO_SDHID1_D1	0xe6052104
+#define GPIO_SDHID1_D2	0xe6052105
+#define GPIO_SDHID1_D3	0xe6052106
+#define GPIO_SDHICMD1	0xe6052107
+
+/*
+ * FIXME !!
+ *
+ * gpio_pull_up is quick_hack.
+ *
+ * current gpio frame work doesn't have
+ * the method to control only pull up/down/free.
+ * this function should be replaced by correct gpio function
+ */
+static void __init gpio_pull_up(u32 addr)
+{
+	u8 data = __raw_readb(addr);
+
+	data &= 0x0F;
+	data |= 0xC0;
+	__raw_writeb(data, addr);
+}
+
 static void __init g4evm_init(void)
 {
 	sh7377_pinmux_init();
@@ -253,6 +352,34 @@ static void __init g4evm_init(void)
 	gpio_request(GPIO_FN_PORT71_KEYIN5_PU, NULL);
 	gpio_request(GPIO_FN_PORT72_KEYIN6_PU, NULL);
 
+	/* SDHI0 */
+	gpio_request(GPIO_FN_SDHICLK0, NULL);
+	gpio_request(GPIO_FN_SDHICD0, NULL);
+	gpio_request(GPIO_FN_SDHID0_0, NULL);
+	gpio_request(GPIO_FN_SDHID0_1, NULL);
+	gpio_request(GPIO_FN_SDHID0_2, NULL);
+	gpio_request(GPIO_FN_SDHID0_3, NULL);
+	gpio_request(GPIO_FN_SDHICMD0, NULL);
+	gpio_request(GPIO_FN_SDHIWP0, NULL);
+	gpio_pull_up(GPIO_SDHID0_D0);
+	gpio_pull_up(GPIO_SDHID0_D1);
+	gpio_pull_up(GPIO_SDHID0_D2);
+	gpio_pull_up(GPIO_SDHID0_D3);
+	gpio_pull_up(GPIO_SDHICMD0);
+
+	/* SDHI1 */
+	gpio_request(GPIO_FN_SDHICLK1, NULL);
+	gpio_request(GPIO_FN_SDHID1_0, NULL);
+	gpio_request(GPIO_FN_SDHID1_1, NULL);
+	gpio_request(GPIO_FN_SDHID1_2, NULL);
+	gpio_request(GPIO_FN_SDHID1_3, NULL);
+	gpio_request(GPIO_FN_SDHICMD1, NULL);
+	gpio_pull_up(GPIO_SDHID1_D0);
+	gpio_pull_up(GPIO_SDHID1_D1);
+	gpio_pull_up(GPIO_SDHID1_D2);
+	gpio_pull_up(GPIO_SDHID1_D3);
+	gpio_pull_up(GPIO_SDHICMD1);
+
 	sh7377_add_standard_devices();
 
 	platform_add_devices(g4evm_devices, ARRAY_SIZE(g4evm_devices));
-- 
1.6.3.3

