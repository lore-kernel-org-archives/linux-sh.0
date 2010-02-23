From: NISHIMOTO Hiroki <nishimoto.hiroki@renesas.com>
Date: Tue, 23 Feb 2010 10:55:10 +0000
Subject: [PATCH] ARM: mach-shmobile: G4EVM KEYSC platform data
Message-Id: <4B83B40E.5040203@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds KEYSC platform data for the G4EVM board.

Signed-off-by: NISHIMOTO Hiroki <nishimoto.hiroki@renesas.com>
---
 arch/arm/mach-shmobile/board-g4evm.c  |   57 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh7367.c |    7 ++++
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-g4evm.c b/arch/arm/mach-shmobile/board-g4evm.c
index 5acd623..10673a9 100644
--- a/arch/arm/mach-shmobile/board-g4evm.c
+++ b/arch/arm/mach-shmobile/board-g4evm.c
@@ -28,6 +28,8 @@
 #include <linux/mtd/physmap.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/io.h>
+#include <linux/input.h>
+#include <linux/input/sh_keysc.h>
 #include <linux/gpio.h>
 #include <mach/sh7377.h>
 #include <mach/common.h>
@@ -128,9 +130,49 @@ static struct platform_device usb_host_device = {
 	.resource	= usb_host_resources,
 };
 
+/* KEYSC */
+static struct sh_keysc_info keysc_info = {
+	.mode		= SH_KEYSC_MODE_5,
+	.scan_timing	= 3,
+	.delay		= 100,
+	.keycodes = {
+		KEY_A, KEY_B, KEY_C, KEY_D, KEY_E, KEY_F,
+		KEY_G, KEY_H, KEY_I, KEY_J, KEY_K, KEY_L,
+		KEY_M, KEY_N, KEY_U, KEY_P, KEY_Q, KEY_R,
+		KEY_S, KEY_T, KEY_U, KEY_V, KEY_W, KEY_X,
+		KEY_Y, KEY_Z, KEY_HOME, KEY_SLEEP, KEY_WAKEUP, KEY_COFFEE,
+		KEY_0, KEY_1, KEY_2, KEY_3, KEY_4, KEY_5,
+		KEY_6, KEY_7, KEY_8, KEY_9, KEY_STOP, KEY_COMPUTER,
+	},
+};
+
+static struct resource keysc_resources[] = {
+	[0] = {
+		.name	= "KEYSC",
+		.start  = 0xe61b0000,
+		.end    = 0xe61b000f,
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
+	.id             = 0, /* keysc0 clock */
+	.num_resources  = ARRAY_SIZE(keysc_resources),
+	.resource       = keysc_resources,
+	.dev	= {
+		.platform_data	= &keysc_info,
+	},
+};
+
 static struct platform_device *g4evm_devices[] __initdata = {
 	&nor_flash_device,
 	&usb_host_device,
+	&keysc_device,
 };
 
 static struct map_desc g4evm_io_desc[] __initdata = {
@@ -196,6 +238,21 @@ static void __init g4evm_init(void)
 	__raw_writew(0x6010, 0xe60581c6);       /* CGPOSR */
 	__raw_writew(0x8a0a, 0xe605810c);       /* USBCR2 */
 
+	/* KEYSC @ CN31 */
+	gpio_request(GPIO_FN_PORT60_KEYOUT5, NULL);
+	gpio_request(GPIO_FN_PORT61_KEYOUT4, NULL);
+	gpio_request(GPIO_FN_PORT62_KEYOUT3, NULL);
+	gpio_request(GPIO_FN_PORT63_KEYOUT2, NULL);
+	gpio_request(GPIO_FN_PORT64_KEYOUT1, NULL);
+	gpio_request(GPIO_FN_PORT65_KEYOUT0, NULL);
+	gpio_request(GPIO_FN_PORT66_KEYIN0_PU, NULL);
+	gpio_request(GPIO_FN_PORT67_KEYIN1_PU, NULL);
+	gpio_request(GPIO_FN_PORT68_KEYIN2_PU, NULL);
+	gpio_request(GPIO_FN_PORT69_KEYIN3_PU, NULL);
+	gpio_request(GPIO_FN_PORT70_KEYIN4_PU, NULL);
+	gpio_request(GPIO_FN_PORT71_KEYIN5_PU, NULL);
+	gpio_request(GPIO_FN_PORT72_KEYIN6_PU, NULL);
+
 	sh7377_add_standard_devices();
 
 	platform_add_devices(g4evm_devices, ARRAY_SIZE(g4evm_devices));
diff --git a/arch/arm/mach-shmobile/clock-sh7367.c b/arch/arm/mach-shmobile/clock-sh7367.c
index 58bd54e..fddc5d9 100644
--- a/arch/arm/mach-shmobile/clock-sh7367.c
+++ b/arch/arm/mach-shmobile/clock-sh7367.c
@@ -75,6 +75,11 @@ static struct clk usb0_clk = {
 	.name	    = "usb0",
 };
 
+/* a static keysc0 for now - enough to get sh_keysc working */
+static struct clk keysc0_clk = {
+	.name	    = "keysc0",
+};
+
 static struct clk_lookup lookups[] = {
 	{
 		.clk = &peripheral_clk,
@@ -82,6 +87,8 @@ static struct clk_lookup lookups[] = {
 		.clk = &r_clk,
 	}, {
 		.clk = &usb0_clk,
+	}, {
+		.clk = &keysc0_clk,
 	}
 };
 
-- 
1.6.3.3



