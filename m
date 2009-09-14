From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 14 Sep 2009 11:23:00 +0000
Subject: [PATCH 2/2] sh: Add KEYSC support for EcoVec24
Message-Id: <uzl8xepnv.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   52 ++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 2129e4c..40decfe 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -18,10 +18,12 @@
 #include <linux/delay.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/i2c.h>
+#include <linux/input.h>
 #include <video/sh_mobile_lcdc.h>
 #include <media/sh_mobile_ceu.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
+#include <asm/sh_keysc.h>
 #include <cpu/sh7724.h>
 
 /*
@@ -332,6 +334,46 @@ static struct i2c_board_info i2c1_devices[] = {
 	},
 };
 
+/* KEYSC */
+static struct sh_keysc_info keysc_info = {
+	.mode		= SH_KEYSC_MODE_1,
+	.scan_timing	= 3,
+	.delay		= 50,
+	.kycr2_delay	= 100,
+	.keycodes	= { KEY_1, 0, 0, 0, 0,
+			    KEY_2, 0, 0, 0, 0,
+			    KEY_3, 0, 0, 0, 0,
+			    KEY_4, 0, 0, 0, 0,
+			    KEY_5, 0, 0, 0, 0,
+			    KEY_6, 0, 0, 0, 0, },
+};
+
+static struct resource keysc_resources[] = {
+	[0] = {
+		.name	= "KEYSC",
+		.start  = 0x044b0000,
+		.end    = 0x044b000f,
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
+	.archdata = {
+		.hwblk_id = HWBLK_KEYSC,
+	},
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
@@ -341,6 +383,7 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&lcdc_device,
 	&ceu0_device,
 	&ceu1_device,
+	&keysc_device,
 };
 
 #define EEPROM_ADDR 0x50
@@ -585,6 +628,15 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_VIO1_CLK, NULL);
 	platform_resource_setup_memory(&ceu1_device, "ceu1", 4 << 20);
 
+	/* enable KEYSC */
+	gpio_request(GPIO_FN_KEYOUT5_IN5, NULL);
+	gpio_request(GPIO_FN_KEYOUT4_IN6, NULL);
+	gpio_request(GPIO_FN_KEYOUT3,     NULL);
+	gpio_request(GPIO_FN_KEYOUT2,     NULL);
+	gpio_request(GPIO_FN_KEYOUT1,     NULL);
+	gpio_request(GPIO_FN_KEYOUT0,     NULL);
+	gpio_request(GPIO_FN_KEYIN0,      NULL);
+
 	/* enable I2C device */
 	i2c_register_board_info(1, i2c1_devices,
 				ARRAY_SIZE(i2c1_devices));
-- 
1.6.0.4

