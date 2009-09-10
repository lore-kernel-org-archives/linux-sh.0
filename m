From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 10 Sep 2009 01:39:58 +0000
Subject: [PATCH 3/6] sh: EcoVec24: write MAC address in boot
Message-Id: <upr9zy3v5.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   81 +++++++++++++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 6721b25..620a6d7 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -17,6 +17,7 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/usb/r8a66597.h>
+#include <linux/i2c.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
 #include <asm/heartbeat.h>
@@ -342,9 +343,77 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&ceu1_device,
 };
 
+#define EEPROM_ADDR 0x50
+static u8 mac_read(struct i2c_adapter *a, u8 command)
+{
+	struct i2c_msg msg[2];
+	u8 buf;
+	int ret;
+
+	msg[0].addr  = EEPROM_ADDR;
+	msg[0].flags = 0;
+	msg[0].len   = 1;
+	msg[0].buf   = &command;
+
+	msg[1].addr  = EEPROM_ADDR;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len   = 1;
+	msg[1].buf   = &buf;
+
+	ret = i2c_transfer(a, msg, 2);
+	if (ret < 0) {
+		printk(KERN_ERR "error %d\n", ret);
+		buf = 0xff;
+	}
+
+	return buf;
+}
+
+#define MAC_LEN 6
+static void __init sh_eth_init(void)
+{
+	struct i2c_adapter *a = i2c_get_adapter(1);
+	struct clk *eth_clk;
+	u8 mac[MAC_LEN];
+	int i;
+
+	if (!a) {
+		pr_err("can not get I2C 1\n");
+		return;
+	}
+
+	eth_clk = clk_get(NULL, "eth0");
+	if (!eth_clk) {
+		pr_err("can not get eth0 clk\n");
+		return;
+	}
+
+	/* read MAC address frome EEPROM */
+	for (i = 0; i < MAC_LEN; i++) {
+		mac[i] = mac_read(a, 0x10 + i);
+		msleep(10);
+	}
+
+	/* clock enable */
+	clk_enable(eth_clk);
+
+	/* reset sh-eth */
+	ctrl_outl(0x1, SH_ETH_ADDR + 0x0);
+
+	/* set MAC addr */
+	ctrl_outl((mac[0] << 24) |
+		  (mac[1] << 16) |
+		  (mac[2] <<  8) |
+		  (mac[3] <<  0), SH_ETH_MAHR);
+	ctrl_outl((mac[4] <<  8) |
+		  (mac[5] <<  0), SH_ETH_MALR);
+
+	clk_put(eth_clk);
+}
+
 #define PORT_HIZA 0xA4050158
 #define IODRIVEA  0xA405018A
-static int __init devices_setup(void)
+static int __init arch_setup(void)
 {
 	/* enable SCIFA0 */
 	gpio_request(GPIO_FN_SCIF0_TXD, NULL);
@@ -520,7 +589,15 @@ static int __init devices_setup(void)
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
 }
-arch_initcall(devices_setup);
+arch_initcall(arch_setup);
+
+static int __init devices_setup(void)
+{
+	sh_eth_init();
+	return 0;
+}
+device_initcall(devices_setup);
+
 
 static struct sh_machine_vector mv_ecovec __initmv = {
 	.mv_name	= "R0P7724 (EcoVec)",
-- 
1.6.0.4

