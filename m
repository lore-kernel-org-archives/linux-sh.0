From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Feb 2010 09:54:06 +0000
Subject: [PATCH] ARM: mach-shmobile: G3EVM FLCTL platform data
Message-Id: <20100219095406.5206.86934.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds FLCTL platform data for the G3EVM board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on FLCTL patches in the sh-2.6 git tree
 Builds on top of the G3EVM KEYSC platform data patch.

 The sh_flctl cannot be selected by Kconfig at this point,
 will submit a separate patch to fix that.

 arch/arm/mach-shmobile/board-g3evm.c |   67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

--- 0003/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2010-02-19 18:50:03.000000000 +0900
@@ -26,6 +26,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
+#include <linux/mtd/sh_flctl.h>
 #include <linux/usb/r8a66597.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
@@ -166,10 +167,53 @@ static struct platform_device keysc_devi
 	},
 };
 
+static struct mtd_partition nand_partition_info[] = {
+	{
+		.name	= "system",
+		.offset	= 0,
+		.size	= 64 * 1024 * 1024,
+	},
+	{
+		.name	= "userdata",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= 128 * 1024 * 1024,
+	},
+	{
+		.name	= "cache",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= 64 * 1024 * 1024,
+	},
+};
+
+static struct resource nand_flash_resources[] = {
+	[0] = {
+		.start	= 0xe6a30000,
+		.end	= 0xe6a3009b,
+		.flags	= IORESOURCE_MEM,
+	}
+};
+
+static struct sh_flctl_platform_data nand_flash_data = {
+	.parts		= nand_partition_info,
+	.nr_parts	= ARRAY_SIZE(nand_partition_info),
+	.flcmncr_val	= QTSEL_E | FCKSEL_E | TYPESEL_SET | NANWF_E
+			| SHBUSSEL | SEL_16BIT,
+};
+
+static struct platform_device nand_flash_device = {
+	.name		= "sh_flctl",
+	.resource	= nand_flash_resources,
+	.num_resources	= ARRAY_SIZE(nand_flash_resources),
+	.dev		= {
+		.platform_data = &nand_flash_data,
+	},
+};
+
 static struct platform_device *g3evm_devices[] __initdata = {
 	&nor_flash_device,
 	&usb_host_device,
 	&keysc_device,
+	&nand_flash_device,
 };
 
 static struct map_desc g3evm_io_desc[] __initdata = {
@@ -251,6 +295,29 @@ static void __init g3evm_init(void)
 	gpio_request(GPIO_FN_PORT57_KEYIN5_PU, NULL);
 	gpio_request(GPIO_FN_PORT58_KEYIN6_PU, NULL);
 
+	/* FLCTL */
+	gpio_request(GPIO_FN_FCE0, NULL);
+	gpio_request(GPIO_FN_D0_ED0_NAF0, NULL);
+	gpio_request(GPIO_FN_D1_ED1_NAF1, NULL);
+	gpio_request(GPIO_FN_D2_ED2_NAF2, NULL);
+	gpio_request(GPIO_FN_D3_ED3_NAF3, NULL);
+	gpio_request(GPIO_FN_D4_ED4_NAF4, NULL);
+	gpio_request(GPIO_FN_D5_ED5_NAF5, NULL);
+	gpio_request(GPIO_FN_D6_ED6_NAF6, NULL);
+	gpio_request(GPIO_FN_D7_ED7_NAF7, NULL);
+	gpio_request(GPIO_FN_D8_ED8_NAF8, NULL);
+	gpio_request(GPIO_FN_D9_ED9_NAF9, NULL);
+	gpio_request(GPIO_FN_D10_ED10_NAF10, NULL);
+	gpio_request(GPIO_FN_D11_ED11_NAF11, NULL);
+	gpio_request(GPIO_FN_D12_ED12_NAF12, NULL);
+	gpio_request(GPIO_FN_D13_ED13_NAF13, NULL);
+	gpio_request(GPIO_FN_D14_ED14_NAF14, NULL);
+	gpio_request(GPIO_FN_D15_ED15_NAF15, NULL);
+	gpio_request(GPIO_FN_WE0_XWR0_FWE, NULL);
+	gpio_request(GPIO_FN_FRB, NULL);
+	/* FOE, FCDE, FSC on dedicated pins */
+	__raw_writel(__raw_readl(0xe6158048) & ~(1 << 15), 0xe6158048);
+
 	sh7367_add_standard_devices();
 
 	platform_add_devices(g3evm_devices, ARRAY_SIZE(g3evm_devices));
