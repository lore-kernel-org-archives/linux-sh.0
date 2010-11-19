From: Yoshii Takashi <takashi.yoshii.zj@renesas.com>
Date: Fri, 19 Nov 2010 13:15:46 +0000
Subject: [PATCH] ARM: sh-mobile: ag5evm: scan keyboard support
Message-Id: <4CE67882.9090600@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

This consists of platform device resources/data for the board, and
simple clvdev entry for MSTP bit for keysc module.

This support only 49 of 80 key-switches on the board.

Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   64 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c |    4 ++-
 2 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index e0bc081..4758690 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -30,6 +30,9 @@
 #include <linux/serial_sci.h>
 #include <linux/smsc911x.h>
 #include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/input/sh_keysc.h>
+
 #include <mach/hardware.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
@@ -70,8 +73,49 @@ static struct platform_device eth_device = {
 	.num_resources	= ARRAY_SIZE(smsc9220_resources),
 };
 
+static struct sh_keysc_info keysc_platdata = {
+	.mode		= SH_KEYSC_MODE_6,
+	.scan_timing	= 3,
+	.delay		= 100,
+	.keycodes	= {
+		KEY_A, KEY_B, KEY_C, KEY_D, KEY_E, KEY_F, KEY_G,
+		KEY_H, KEY_I, KEY_J, KEY_K, KEY_L, KEY_M, KEY_N,
+		KEY_O, KEY_P, KEY_Q, KEY_R, KEY_S, KEY_T, KEY_U,
+		KEY_V, KEY_W, KEY_X, KEY_Y, KEY_Z, KEY_HOME, KEY_SLEEP,
+		KEY_SPACE, KEY_9, KEY_6, KEY_3, KEY_WAKEUP, KEY_RIGHT, \
+		KEY_COFFEE,
+		KEY_0, KEY_8, KEY_5, KEY_2, KEY_DOWN, KEY_ENTER, KEY_UP,
+		KEY_KPASTERISK, KEY_7, KEY_4, KEY_1, KEY_STOP, KEY_LEFT, \
+		KEY_COMPUTER,
+	},
+};
+
+static struct resource keysc_resources[] = {
+	[0] = {
+		.name	= "KEYSC",
+		.start	= 0xe61b0000,
+		.end	= 0xe61b0098 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_spi(71),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device keysc_device = {
+	.name		= "sh_keysc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(keysc_resources),
+	.resource	= keysc_resources,
+	.dev		= {
+		.platform_data	= &keysc_platdata,
+	},
+};
+
 static struct platform_device *ag5evm_devices[] __initdata = {
 	&eth_device,
+	&keysc_device,
 };
 
 static struct map_desc ag5evm_io_desc[] __initdata = {
@@ -129,6 +173,26 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_SCIFA2_RTS1_, NULL);
 	gpio_request(GPIO_FN_SCIFA2_CTS1_, NULL);
 
+	/* enable KEYSC */
+	gpio_request(GPIO_FN_KEYIN0, NULL);
+	gpio_request(GPIO_FN_KEYIN1, NULL);
+	gpio_request(GPIO_FN_KEYIN2, NULL);
+	gpio_request(GPIO_FN_KEYIN3, NULL);
+	gpio_request(GPIO_FN_KEYIN4, NULL);
+	gpio_request(GPIO_FN_KEYIN5, NULL);
+	gpio_request(GPIO_FN_KEYIN6, NULL);
+	gpio_request(GPIO_FN_KEYIN7, NULL);
+	gpio_request(GPIO_FN_KEYOUT0, NULL);
+	gpio_request(GPIO_FN_KEYOUT1, NULL);
+	gpio_request(GPIO_FN_KEYOUT2, NULL);
+	gpio_request(GPIO_FN_KEYOUT3, NULL);
+	gpio_request(GPIO_FN_KEYOUT4, NULL);
+	gpio_request(GPIO_FN_KEYOUT5, NULL);
+	gpio_request(GPIO_FN_PORT59_KEYOUT6, NULL);
+	gpio_request(GPIO_FN_PORT58_KEYOUT7, NULL);
+	gpio_request(GPIO_FN_KEYOUT8, NULL);
+	gpio_request(GPIO_FN_PORT149_KEYOUT9, NULL);
+
 	/* enable SMSC911X */
 	gpio_request(GPIO_PORT144, NULL); /* PINTA2 */
 	gpio_direction_input(GPIO_PORT144);
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index f2390ae..82c7251 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -47,7 +47,7 @@ static struct clk *main_clks[] = {
 
 enum { MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-	MSTP331, MSTP329,
+	MSTP331, MSTP329, MSTP403,
 	MSTP_NR };
 
 #define MSTP(_parent, _reg, _bit, _flags) \
@@ -64,6 +64,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP200] = MSTP(&sub_clk, SMSTPCR2, 0, 0), /* SCIFA4 */
 	[MSTP331] = MSTP(&sub_clk, SMSTPCR3, 31, 0), /* SCIFA6 */
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
+	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 0, 0), /* KEYSC0 */
 };
 
 #define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
@@ -80,6 +81,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
 	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
+	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC0 */
 };
 
 void __init sh73a0_clock_init(void)
-- 1.7.2.2 
