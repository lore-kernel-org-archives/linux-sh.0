From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 23 Feb 2010 07:07:01 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: Add KEYSC support
Message-Id: <umxz09yzk.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Because AP4 board has capacitor for KEYSC,
we need much time for waiting.

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   61 +++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 41bc248..39cfd59 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -29,6 +29,8 @@
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 #include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/input/sh_keysc.h>
 #include <mach/common.h>
 #include <mach/sh7372.h>
 #include <asm/mach-types.h>
@@ -77,6 +79,15 @@
  *  OFF		access enable
  */
 
+/*
+ * KEYSC
+ *
+ * SW43		KEYSC
+ * -------------------------
+ * ON		enable
+ * OFF		disable
+ */
+
 /* MTD */
 static struct mtd_partition nor_flash_partitions[] = {
 	{
@@ -158,9 +169,47 @@ static struct platform_device smc911x_device = {
 	},
 };
 
+/* KEYSC (Needs SW43 set to ON) */
+static struct sh_keysc_info keysc_info = {
+	.mode		= SH_KEYSC_MODE_1,
+	.scan_timing	= 3,
+	.delay		= 2500,
+	.keycodes = {
+		KEY_0, KEY_1, KEY_2, KEY_3, KEY_4,
+		KEY_5, KEY_6, KEY_7, KEY_8, KEY_9,
+		KEY_A, KEY_B, KEY_C, KEY_D, KEY_E,
+		KEY_F, KEY_G, KEY_H, KEY_I, KEY_J,
+		KEY_K, KEY_L, KEY_M, KEY_N, KEY_O,
+	},
+};
+
+static struct resource keysc_resources[] = {
+	[0] = {
+		.name	= "KEYSC",
+		.start  = 0xe61b0000,
+		.end    = 0xe61b0063,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 79,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device keysc_device = {
+	.name           = "sh_keysc",
+	.id             = 0, /* "keysc0" clock */
+	.num_resources  = ARRAY_SIZE(keysc_resources),
+	.resource       = keysc_resources,
+	.dev	= {
+		.platform_data	= &keysc_info,
+	},
+};
+
 static struct platform_device *ap4evb_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
+	&keysc_device,
 };
 
 static struct map_desc ap4evb_io_desc[] __initdata = {
@@ -197,6 +246,18 @@ static void __init ap4evb_init(void)
 	gpio_request(GPIO_FN_CS5A,	NULL);
 	gpio_request(GPIO_FN_IRQ6_39,	NULL);
 
+	/* enable KEYSC */
+	gpio_request(GPIO_FN_KEYOUT0, NULL);
+	gpio_request(GPIO_FN_KEYOUT1, NULL);
+	gpio_request(GPIO_FN_KEYOUT2, NULL);
+	gpio_request(GPIO_FN_KEYOUT3, NULL);
+	gpio_request(GPIO_FN_KEYOUT4, NULL);
+	gpio_request(GPIO_FN_KEYIN0_136, NULL);
+	gpio_request(GPIO_FN_KEYIN1_135, NULL);
+	gpio_request(GPIO_FN_KEYIN2_134, NULL);
+	gpio_request(GPIO_FN_KEYIN3_133, NULL);
+	gpio_request(GPIO_FN_KEYIN4,     NULL);
+
 	sh7372_add_standard_devices();
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
-- 
1.6.3.3

