From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Aug 2009 14:58:43 +0000
Subject: [PATCH] sh: kfr2r09 board support - NAND flash
Message-Id: <20090806145843.4475.33947.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: tony@atomide.com, Magnus Damm <magnus.damm@gmail.com>, kyungmin.park@samsung.com, lethal@linux-sh.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, dwmw2@infradead.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds support for the NAND flash chip
attached to CS4 on the KFR2R09 board. The device is
driven by the platform device driver "onenand-flash".

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 No merge/build time dependencies, but needs the following patch
 to start working on the actual hardware:

 "[PATCH] mtd: make onenand/generic.c more generic"

 arch/sh/boards/mach-kfr2r09/setup.c |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

--- 0003/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-08-06 21:37:18.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mtd/onenand.h>
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
@@ -62,6 +63,21 @@ static struct platform_device kfr2r09_no
 	},
 };
 
+static struct resource kfr2r09_nand_flash_resources[] = {
+	[0] = {
+		.name		= "NAND Flash",
+		.start		= 0x10000000,
+		.end		= 0x1001ffff,
+		.flags		= IORESOURCE_MEM,
+	}
+};
+
+static struct platform_device kfr2r09_nand_flash_device = {
+	.name		= "onenand-flash",
+	.resource	= kfr2r09_nand_flash_resources,
+	.num_resources	= ARRAY_SIZE(kfr2r09_nand_flash_resources),
+};
+
 static struct sh_keysc_info kfr2r09_sh_keysc_info = {
 	.mode = SH_KEYSC_MODE_1, /* KEYOUT0->4, KEYIN0->4 */
 	.scan_timing = 3,
@@ -161,12 +177,15 @@ static struct platform_device kfr2r09_sh
 
 static struct platform_device *kfr2r09_devices[] __initdata = {
 	&kfr2r09_nor_flash_device,
+	&kfr2r09_nand_flash_device,
 	&kfr2r09_sh_keysc_device,
 	&kfr2r09_sh_lcdc_device,
 };
 
 #define BSC_CS0BCR 0xfec10004
 #define BSC_CS0WCR 0xfec10024
+#define BSC_CS4BCR 0xfec10010
+#define BSC_CS4WCR 0xfec10030
 
 static int __init kfr2r09_devices_setup(void)
 {
@@ -178,6 +197,10 @@ static int __init kfr2r09_devices_setup(
 	ctrl_outl(0x36db0400, BSC_CS0BCR);
 	ctrl_outl(0x00000500, BSC_CS0WCR);
 
+	/* setup NAND flash at CS4 */
+	ctrl_outl(0x36db0400, BSC_CS4BCR);
+	ctrl_outl(0x00000500, BSC_CS4WCR);
+
 	/* setup KEYSC pins */
 	gpio_request(GPIO_FN_KEYOUT0, NULL);
 	gpio_request(GPIO_FN_KEYOUT1, NULL);
