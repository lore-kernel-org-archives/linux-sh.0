From: chinyeow.sim.xt@renesas.com
Date: Thu, 09 Dec 2010 01:55:55 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: Add keypad tca6408a support
Message-Id: <57DD4A9F06D14DC9B39EEA2E7B7E05FF@rso.adwin.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch maps key0/key1/key2/key3 as HOME/MENU/BACK/POWER buttons
on mackerel board.

Signed-off-by: Tony SIM <chinyeow.sim.xt@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   38 +++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index a0caa9e..3e30a52 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -36,6 +36,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/smsc911x.h>
 #include <linux/sh_intc.h>
+#include <linux/tca6416_keypad.h>
 #include <linux/usb/r8a66597.h>
 
 #include <video/sh_mobile_lcdc.h>
@@ -413,11 +414,44 @@ static struct platform_device *mackerel_devices[] __initdata = {
 	&fsi_ak4643_device,
 };
 
+/* Keypad Initialization */
+#define KEYPAD_BUTTON(ev_type, ev_code, act_low) \
+{								\
+	.type		= ev_type,				\
+	.code		= ev_code,				\
+	.active_low	= act_low,				\
+}
+
+#define KEYPAD_BUTTON_LOW(event_code) KEYPAD_BUTTON(EV_KEY, event_code, 1)
+
+static struct tca6416_button mackerel_gpio_keys[] = {
+	KEYPAD_BUTTON_LOW(KEY_HOME),
+	KEYPAD_BUTTON_LOW(KEY_MENU),
+	KEYPAD_BUTTON_LOW(KEY_BACK),
+	KEYPAD_BUTTON_LOW(KEY_POWER),
+};
+
+static struct tca6416_keys_platform_data mackerel_tca6416_keys_info = {
+	.buttons	= mackerel_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(mackerel_gpio_keys),
+	.rep		= 1,
+	.use_polling	= 0,
+	.pinmask	= 0x000F,
+};
+
 /* I2C */
+#define IRQ9 evt2irq(0x0320)
+
 static struct i2c_board_info i2c0_devices[] = {
 	{
 		I2C_BOARD_INFO("ak4643", 0x13),
 	},
+	/* Keypad */
+	{
+		I2C_BOARD_INFO("tca6408-keys", 0x20),
+		.platform_data = &mackerel_tca6416_keys_info,
+		.irq = IRQ9,
+	},
 };
 
 #define IRQ21 evt2irq(0x32a0)
@@ -525,6 +559,10 @@ static void __init mackerel_init(void)
 
 	intc_set_priority(IRQ_FSI, 3); /* irq priority FSI(3) > SMSC911X(2) */
 
+	/* enable Keypad */
+	gpio_request(GPIO_FN_IRQ9_42,	NULL);
+	set_irq_type(IRQ9, IRQ_TYPE_LEVEL_HIGH);
+
 	/* enable Accelerometer */
 	gpio_request(GPIO_FN_IRQ21,	NULL);
 	set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
-- 
1.7.2.3

