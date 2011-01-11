From: chinyeow.sim.xt@renesas.com
Date: Tue, 11 Jan 2011 00:47:59 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: Add touchscreen ST1232 support
Message-Id: <1294706879-5290-1-git-send-email-chinyeow.sim.xt@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Tony SIM <chinyeow.sim.xt@renesas.com>


Signed-off-by: Tony SIM <chinyeow.sim.xt@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 42f7c0d..b0027d2 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -746,6 +746,7 @@ static struct tca6416_keys_platform_data mackerel_tca6416_keys_info = {
 };
 
 /* I2C */
+#define IRQ7 evt2irq(0x02e0)
 #define IRQ9 evt2irq(0x0320)
 
 static struct i2c_board_info i2c0_devices[] = {
@@ -758,6 +759,11 @@ static struct i2c_board_info i2c0_devices[] = {
 		.platform_data = &mackerel_tca6416_keys_info,
 		.irq = IRQ9,
 	},
+	/* Touchscreen */
+	{
+		I2C_BOARD_INFO("st1232-ts", 0x55),
+		.irq = IRQ7,
+	},
 };
 
 #define IRQ21 evt2irq(0x32a0)
@@ -869,6 +875,10 @@ static void __init mackerel_init(void)
 	gpio_request(GPIO_FN_IRQ9_42,	NULL);
 	set_irq_type(IRQ9, IRQ_TYPE_LEVEL_HIGH);
 
+	/* enable Touchscreen */
+	gpio_request(GPIO_FN_IRQ7_40,	NULL);
+	set_irq_type(IRQ7, IRQ_TYPE_LEVEL_LOW);
+
 	/* enable Accelerometer */
 	gpio_request(GPIO_FN_IRQ21,	NULL);
 	set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
-- 
1.7.2.3

