From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Feb 2010 10:48:15 +0000
Subject: [PATCH] ARM: mach-shmobile: G3EVM KEYSC platform data
Message-Id: <20100216104815.14455.317.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds KEYSC platform data for the G3EVM board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Build time dependencies:
  "input: update sh_keysc driver with mode 4 and mode 5 support"

 Run time dependencies:
  "sh: update PFC to allow any enum in MARK lists"

 Includes far-from-pretty dummy clock, perhaps worth waiting
 until a proper clock framework is in place.

 The sh_keysc cannot be selected by Kconfig at this point,
 will submit a separate patch to fix that.

 arch/arm/mach-shmobile/board-g3evm.c  |   55 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh7367.c |    7 ++++
 2 files changed, 62 insertions(+)

--- 0011/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2010-02-10 19:52:39.000000000 +0900
@@ -29,6 +29,8 @@
 #include <linux/usb/r8a66597.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/input/sh_keysc.h>
 #include <mach/sh7367.h>
 #include <mach/common.h>
 #include <asm/mach-types.h>
@@ -127,9 +129,47 @@ static struct platform_device usb_host_d
 	.resource	= usb_host_resources,
 };
 
+/* KEYSC */
+static struct sh_keysc_info keysc_info = {
+	.mode		= SH_KEYSC_MODE_5,
+	.scan_timing	= 3,
+	.delay		= 100,
+	.keycodes = {
+		KEY_A, KEY_B, KEY_C, KEY_D, KEY_E, KEY_F, KEY_G,
+		KEY_H, KEY_I, KEY_J, KEY_K, KEY_L, KEY_M, KEY_N,
+		KEY_O, KEY_P, KEY_Q, KEY_R, KEY_S, KEY_T, KEY_U,
+		KEY_V, KEY_W, KEY_X, KEY_Y, KEY_Z, KEY_HOME, KEY_SLEEP,
+		KEY_WAKEUP, KEY_COFFEE, KEY_0, KEY_1, KEY_2, KEY_3, KEY_4,
+		KEY_5, KEY_6, KEY_7, KEY_8, KEY_9, KEY_STOP, KEY_COMPUTER,
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
+	.num_resources  = ARRAY_SIZE(keysc_resources),
+	.resource       = keysc_resources,
+	.dev	= {
+		.platform_data	= &keysc_info,
+	},
+};
+
 static struct platform_device *g3evm_devices[] __initdata = {
 	&nor_flash_device,
 	&usb_host_device,
+	&keysc_device,
 };
 
 static struct map_desc g3evm_io_desc[] __initdata = {
@@ -196,6 +236,21 @@ static void __init g3evm_init(void)
 	__raw_writew(0x6010, 0xe60581c6);	/* CGPOSR */
 	__raw_writew(0x8a0a, 0xe605810c);	/* USBCR2 */
 
+	/* KEYSC @ CN7 */
+	gpio_request(GPIO_FN_PORT42_KEYOUT0, NULL);
+	gpio_request(GPIO_FN_PORT43_KEYOUT1, NULL);
+	gpio_request(GPIO_FN_PORT44_KEYOUT2, NULL);
+	gpio_request(GPIO_FN_PORT45_KEYOUT3, NULL);
+	gpio_request(GPIO_FN_PORT46_KEYOUT4, NULL);
+	gpio_request(GPIO_FN_PORT47_KEYOUT5, NULL);
+	gpio_request(GPIO_FN_PORT48_KEYIN0_PU, NULL);
+	gpio_request(GPIO_FN_PORT49_KEYIN1_PU, NULL);
+	gpio_request(GPIO_FN_PORT50_KEYIN2_PU, NULL);
+	gpio_request(GPIO_FN_PORT55_KEYIN3_PU, NULL);
+	gpio_request(GPIO_FN_PORT56_KEYIN4_PU, NULL);
+	gpio_request(GPIO_FN_PORT57_KEYIN5_PU, NULL);
+	gpio_request(GPIO_FN_PORT58_KEYIN6_PU, NULL);
+
 	sh7367_add_standard_devices();
 
 	platform_add_devices(g3evm_devices, ARRAY_SIZE(g3evm_devices));
--- 0011/arch/arm/mach-shmobile/clock-sh7367.c
+++ work/arch/arm/mach-shmobile/clock-sh7367.c	2010-02-10 19:55:05.000000000 +0900
@@ -75,6 +75,11 @@ static struct clk usb0_clk = {
 	.name	    = "usb0",
 };
 
+/* a static keysc0 clk for now - enough to get sh_keysc working */
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
 
