From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 26 Aug 2009 11:04:36 +0000
Subject: [PATCH 5/6] sh: Add CEU support for EcoVec24
Message-Id: <u7hwqhm4b.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |  109 ++++++++++++++++++++++++++++++++++
 1 files changed, 109 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index a575b38..55ff735 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -18,6 +18,7 @@
 #include <linux/delay.h>
 #include <linux/usb/r8a66597.h>
 #include <video/sh_mobile_lcdc.h>
+#include <media/sh_mobile_ceu.h>
 #include <asm/heartbeat.h>
 #include <asm/sh_eth.h>
 #include <cpu/sh7724.h>
@@ -256,6 +257,74 @@ static struct platform_device lcdc_device = {
 	},
 };
 
+/* CEU0 */
+static struct sh_mobile_ceu_info sh_mobile_ceu0_info = {
+	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
+};
+
+static struct resource ceu0_resources[] = {
+	[0] = {
+		.name	= "CEU0",
+		.start	= 0xfe910000,
+		.end	= 0xfe91009f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 52,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device ceu0_device = {
+	.name		= "sh_mobile_ceu",
+	.id             = 0, /* "ceu0" clock */
+	.num_resources	= ARRAY_SIZE(ceu0_resources),
+	.resource	= ceu0_resources,
+	.dev	= {
+		.platform_data	= &sh_mobile_ceu0_info,
+	},
+	.archdata = {
+		.hwblk_id = HWBLK_CEU0,
+	},
+};
+
+/* CEU1 */
+static struct sh_mobile_ceu_info sh_mobile_ceu1_info = {
+	.flags = SH_CEU_FLAG_USE_8BIT_BUS,
+};
+
+static struct resource ceu1_resources[] = {
+	[0] = {
+		.name	= "CEU1",
+		.start	= 0xfe914000,
+		.end	= 0xfe91409f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = 63,
+		.flags  = IORESOURCE_IRQ,
+	},
+	[2] = {
+		/* place holder for contiguous memory */
+	},
+};
+
+static struct platform_device ceu1_device = {
+	.name		= "sh_mobile_ceu",
+	.id             = 1, /* "ceu1" clock */
+	.num_resources	= ARRAY_SIZE(ceu1_resources),
+	.resource	= ceu1_resources,
+	.dev	= {
+		.platform_data	= &sh_mobile_ceu1_info,
+	},
+	.archdata = {
+		.hwblk_id = HWBLK_CEU1,
+	},
+};
+
 static struct platform_device *ecovec_devices[] __initdata = {
 	&heartbeat_device,
 	&nor_flash_device,
@@ -263,6 +332,8 @@ static struct platform_device *ecovec_devices[] __initdata = {
 	&usb0_host_device,
 	&usb1_host_device, /* USB1 host support */
 	&lcdc_device,
+	&ceu0_device,
+	&ceu1_device,
 };
 
 #define PORT_HIZA 0xA4050158
@@ -371,6 +442,44 @@ static int __init devices_setup(void)
 		/* not supported */
 	}
 
+	/* enable CEU0 */
+	gpio_request(GPIO_FN_VIO0_D15, NULL);
+	gpio_request(GPIO_FN_VIO0_D14, NULL);
+	gpio_request(GPIO_FN_VIO0_D13, NULL);
+	gpio_request(GPIO_FN_VIO0_D12, NULL);
+	gpio_request(GPIO_FN_VIO0_D11, NULL);
+	gpio_request(GPIO_FN_VIO0_D10, NULL);
+	gpio_request(GPIO_FN_VIO0_D9,  NULL);
+	gpio_request(GPIO_FN_VIO0_D8,  NULL);
+	gpio_request(GPIO_FN_VIO0_D7,  NULL);
+	gpio_request(GPIO_FN_VIO0_D6,  NULL);
+	gpio_request(GPIO_FN_VIO0_D5,  NULL);
+	gpio_request(GPIO_FN_VIO0_D4,  NULL);
+	gpio_request(GPIO_FN_VIO0_D3,  NULL);
+	gpio_request(GPIO_FN_VIO0_D2,  NULL);
+	gpio_request(GPIO_FN_VIO0_D1,  NULL);
+	gpio_request(GPIO_FN_VIO0_D0,  NULL);
+	gpio_request(GPIO_FN_VIO0_VD,  NULL);
+	gpio_request(GPIO_FN_VIO0_CLK, NULL);
+	gpio_request(GPIO_FN_VIO0_FLD, NULL);
+	gpio_request(GPIO_FN_VIO0_HD,  NULL);
+	platform_resource_setup_memory(&ceu0_device, "ceu0", 4 << 20);
+
+	/* enable CEU1 */
+	gpio_request(GPIO_FN_VIO1_D7,  NULL);
+	gpio_request(GPIO_FN_VIO1_D6,  NULL);
+	gpio_request(GPIO_FN_VIO1_D5,  NULL);
+	gpio_request(GPIO_FN_VIO1_D4,  NULL);
+	gpio_request(GPIO_FN_VIO1_D3,  NULL);
+	gpio_request(GPIO_FN_VIO1_D2,  NULL);
+	gpio_request(GPIO_FN_VIO1_D1,  NULL);
+	gpio_request(GPIO_FN_VIO1_D0,  NULL);
+	gpio_request(GPIO_FN_VIO1_FLD, NULL);
+	gpio_request(GPIO_FN_VIO1_HD,  NULL);
+	gpio_request(GPIO_FN_VIO1_VD,  NULL);
+	gpio_request(GPIO_FN_VIO1_CLK, NULL);
+	platform_resource_setup_memory(&ceu1_device, "ceu1", 4 << 20);
+
 	return platform_add_devices(ecovec_devices,
 				    ARRAY_SIZE(ecovec_devices));
 }
-- 
1.6.0.4

