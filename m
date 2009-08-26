From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 26 Aug 2009 11:04:26 +0000
Subject: [PATCH 2/6] sh: Add SH-ETH support for EcoVec24
Message-Id: <ubpm2hm4l.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   53 +++++++++++++++++++++++++++++++++-
 1 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index e555b92..8c0c845 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -14,8 +14,10 @@
 #include <linux/mtd/physmap.h>
 #include <linux/gpio.h>
 #include <linux/interrupt.h>
-#include <asm/io.h>
+#include <linux/io.h>
+#include <linux/delay.h>
 #include <asm/heartbeat.h>
+#include <asm/sh_eth.h>
 #include <cpu/sh7724.h>
 
 /*
@@ -93,9 +95,41 @@ static struct platform_device nor_flash_device = {
 	},
 };
 
+/* SH Eth */
+#define SH_ETH_ADDR	(0xA4600000)
+#define SH_ETH_MAHR	(SH_ETH_ADDR + 0x1C0)
+#define SH_ETH_MALR	(SH_ETH_ADDR + 0x1C8)
+static struct resource sh_eth_resources[] = {
+	[0] = {
+		.start = SH_ETH_ADDR,
+		.end   = SH_ETH_ADDR + 0x1FC,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = 91,
+		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHLEVEL,
+	},
+};
+
+struct sh_eth_plat_data sh_eth_plat = {
+	.phy = 0x1f, /* SMSC LAN8700 */
+	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+};
+
+static struct platform_device sh_eth_device = {
+	.name = "sh-eth",
+	.id	= 0,
+	.dev = {
+		.platform_data = &sh_eth_plat,
+	},
+	.num_resources = ARRAY_SIZE(sh_eth_resources),
+	.resource = sh_eth_resources,
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
+	&sh_eth_device,
 };
 
 static int __init devices_setup(void)
@@ -114,6 +148,23 @@ static int __init devices_setup(void)
 	gpio_direction_output(GPIO_PTG2, 0);
 	gpio_direction_output(GPIO_PTG3, 0);
 
+	/* enable SH-Eth */
+	gpio_request(GPIO_PTA1, NULL);
+	gpio_direction_output(GPIO_PTA1, 1);
+	mdelay(20);
+
+	gpio_request(GPIO_FN_RMII_RXD0,    NULL);
+	gpio_request(GPIO_FN_RMII_RXD1,    NULL);
+	gpio_request(GPIO_FN_RMII_TXD0,    NULL);
+	gpio_request(GPIO_FN_RMII_TXD1,    NULL);
+	gpio_request(GPIO_FN_RMII_REF_CLK, NULL);
+	gpio_request(GPIO_FN_RMII_TX_EN,   NULL);
+	gpio_request(GPIO_FN_RMII_RX_ER,   NULL);
+	gpio_request(GPIO_FN_RMII_CRS_DV,  NULL);
+	gpio_request(GPIO_FN_MDIO,         NULL);
+	gpio_request(GPIO_FN_MDC,          NULL);
+	gpio_request(GPIO_FN_LNKSTA,       NULL);
+
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
 }
-- 
1.6.0.4

