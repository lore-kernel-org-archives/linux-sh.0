From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 27 Oct 2009 10:49:55 +0000
Subject: [PATCH] sh: add SDHI1 support to ms7724se
Message-Id: <20091027104955.26350.60772.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add support for cn8 and SDHI1 to the ms7724se board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-se/7724/setup.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

--- 0005/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2009-10-27 18:50:48.000000000 +0900
@@ -463,6 +463,7 @@ static struct resource sdhi0_cn7_resourc
 
 static struct platform_device sdhi0_cn7_device = {
 	.name           = "sh_mobile_sdhi",
+	.id		= 0,
 	.num_resources  = ARRAY_SIZE(sdhi0_cn7_resources),
 	.resource       = sdhi0_cn7_resources,
 	.archdata = {
@@ -470,6 +471,29 @@ static struct platform_device sdhi0_cn7_
 	},
 };
 
+static struct resource sdhi1_cn8_resources[] = {
+	[0] = {
+		.name	= "SDHI1",
+		.start  = 0x04cf0000,
+		.end    = 0x04cf01ff,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 24,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi1_cn8_device = {
+	.name           = "sh_mobile_sdhi",
+	.id		= 1,
+	.num_resources  = ARRAY_SIZE(sdhi1_cn8_resources),
+	.resource       = sdhi1_cn8_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_SDHI1,
+	},
+};
+
 static struct platform_device *ms7724se_devices[] __initdata = {
 	&heartbeat_device,
 	&smc91x_eth_device,
@@ -483,6 +507,7 @@ static struct platform_device *ms7724se_
 	&sh7724_usb1_gadget_device,
 	&fsi_device,
 	&sdhi0_cn7_device,
+	&sdhi1_cn8_device,
 };
 
 #define EEPROM_OP   0xBA206000
@@ -725,6 +750,16 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_SDHI0CMD, NULL);
 	gpio_request(GPIO_FN_SDHI0CLK, NULL);
 
+	/* SDHI1 connected to cn8 */
+	gpio_request(GPIO_FN_SDHI1CD, NULL);
+	gpio_request(GPIO_FN_SDHI1WP, NULL);
+	gpio_request(GPIO_FN_SDHI1D3, NULL);
+	gpio_request(GPIO_FN_SDHI1D2, NULL);
+	gpio_request(GPIO_FN_SDHI1D1, NULL);
+	gpio_request(GPIO_FN_SDHI1D0, NULL);
+	gpio_request(GPIO_FN_SDHI1CMD, NULL);
+	gpio_request(GPIO_FN_SDHI1CLK, NULL);
+
 	/*
 	 * enable SH-Eth
 	 *
