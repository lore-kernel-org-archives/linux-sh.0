From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Nov 2010 02:10:08 +0000
Subject: [PATCH] ARM: mach-shmobile: ag5evm: Add FSI resources
Message-Id: <w3pk4jw518f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   41 +++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 7336a00..d4c82bd 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -33,6 +33,8 @@
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
 
+#include <sound/sh_fsi.h>
+
 #include <mach/hardware.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
@@ -113,9 +115,41 @@ static struct platform_device keysc_device = {
 	},
 };
 
+/* FSI A */
+static struct sh_fsi_platform_info fsi_info = {
+	.porta_flags = SH_FSI_OUT_SLAVE_MODE	|
+		       SH_FSI_IN_SLAVE_MODE	|
+		       SH_FSI_OFMT(I2S)		|
+		       SH_FSI_IFMT(I2S),
+};
+
+static struct resource fsi_resources[] = {
+	[0] = {
+		.name	= "FSI",
+		.start	= 0xEC230000,
+		.end	= 0xEC230400 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start  = gic_spi(146),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device fsi_device = {
+	.name		= "sh_fsi2",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(fsi_resources),
+	.resource	= fsi_resources,
+	.dev	= {
+		.platform_data	= &fsi_info,
+	},
+};
+
 static struct platform_device *ag5evm_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
+	&fsi_device,
 };
 
 static struct map_desc ag5evm_io_desc[] __initdata = {
@@ -195,6 +229,13 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_PORT145, NULL); /* RESET */
 	gpio_direction_output(GPIO_PORT145, 1);
 
+	/* FSI A */
+	gpio_request(GPIO_FN_FSIACK, NULL);
+	gpio_request(GPIO_FN_FSIAILR, NULL);
+	gpio_request(GPIO_FN_FSIAIBT, NULL);
+	gpio_request(GPIO_FN_FSIAISLD, NULL);
+	gpio_request(GPIO_FN_FSIAOSLD, NULL);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
 	l2x0_init(__io(0xf0100000), 0x00460000, 0xc2000fff);
-- 
1.7.0.4

