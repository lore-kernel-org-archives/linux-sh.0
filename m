From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 23 Feb 2010 08:19:14 +0000
Subject: [PATCH] sh: ms7724: Add sh_sir support
Message-Id: <uaauzv5g4.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-se/7724/setup.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 1f6cf86..6419f27 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -489,6 +489,26 @@ static struct platform_device sdhi1_cn8_device = {
 	},
 };
 
+/* IrDA */
+static struct resource irda_resources[] = {
+	[0] = {
+		.name	= "IrDA",
+		.start  = 0xA45D0000,
+		.end    = 0xA45D0049,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 20,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device irda_device = {
+	.name           = "sh_sir",
+	.num_resources  = ARRAY_SIZE(irda_resources),
+	.resource       = irda_resources,
+};
+
 static struct platform_device *ms7724se_devices[] __initdata = {
 	&heartbeat_device,
 	&smc91x_eth_device,
@@ -503,6 +523,7 @@ static struct platform_device *ms7724se_devices[] __initdata = {
 	&fsi_device,
 	&sdhi0_cn7_device,
 	&sdhi1_cn8_device,
+	&irda_device,
 };
 
 /* I2C device */
@@ -599,6 +620,7 @@ static int __init devices_setup(void)
 		  ~((1 << 1)  | /* LAN */
 		    (1 << 6)  | /* VIDEO DAC */
 		    (1 << 7)  | /* AK4643 */
+		    (1 << 8)  | /* IrDA */
 		    (1 << 12) | /* USB0 */
 		    (1 << 14)), /* RMII */
 		  FPGA_OUT);
@@ -788,6 +810,10 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_SDHI1CMD, NULL);
 	gpio_request(GPIO_FN_SDHI1CLK, NULL);
 
+	/* enable IrDA */
+	gpio_request(GPIO_FN_IRDA_OUT, NULL);
+	gpio_request(GPIO_FN_IRDA_IN,  NULL);
+
 	/*
 	 * enable SH-Eth
 	 *
-- 
1.6.3.3

