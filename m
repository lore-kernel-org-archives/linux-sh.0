From: "sim.chinyeow" <chinyeow.sim.xt@renesas.com>
Date: Tue, 07 Dec 2010 09:12:14 +0000
Subject: [PATCH] ARM: mach-shmobile: mackerel: Add Accelerometer sensor support
Message-Id: <6CAB45BE420C4B0E8D05620C1C1F75E8@rso.adwin.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Tony SIM <chinyeow.sim.xt@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index f9418e7..7ae1b03 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -309,6 +309,15 @@ static struct platform_device usb1_host_device = {
 	.resource	= usb1_host_resources,
 };
 
+#define IRQ21 evt2irq(0x32a0)
+static struct i2c_board_info i2c1_devices[] = {
+	/* Accelerometer */
+	{
+		I2C_BOARD_INFO("adxl34x", 0x53),
+		.irq = IRQ21,
+	},
+};
+
 static struct platform_device *mackerel_devices[] __initdata = {
 	&nor_flash_device,
 	&smc911x_device,
@@ -394,6 +403,12 @@ static void __init mackerel_init(void)
 	/* setup USB phy */
 	__raw_writew(0x8a0a, 0xE6058130);	/* USBCR2 */
 
+	/* enable Accelerometer */
+	gpio_request(GPIO_FN_IRQ21,	NULL);
+	set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
+
+	i2c_register_board_info(1, i2c1_devices,
+				ARRAY_SIZE(i2c1_devices));
 
 	sh7372_add_standard_devices();
 
-- 
1.7.2.3

