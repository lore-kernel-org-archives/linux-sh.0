From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 08 Aug 2008 05:29:58 +0000
Subject: [PATCH] sh: Add support sh_eth to sh7763rdp board
Message-Id: <489BD9D6.6060804@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH7763 has sh_eth device. This patch add sh_eth platform device
to this board.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/mach-sh7763rdp/setup.c |   34 +++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-sh7763rdp/setup.c b/arch/sh/boards/mach-sh7763rdp/setup.c
index 925f16a..49940d1 100644
--- a/arch/sh/boards/mach-sh7763rdp/setup.c
+++ b/arch/sh/boards/mach-sh7763rdp/setup.c
@@ -15,8 +15,9 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/mtd/physmap.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/sh7763rdp.h>
+#include <asm/sh_eth.h>

 /* NOR Flash */
 static struct mtd_partition sh7763rdp_nor_flash_partitions[] = {
@@ -60,8 +61,36 @@ static struct platform_device sh7763rdp_nor_flash_device = {
 	},
 };

+/* SH-Ether */
+static struct resource sh_eth_resources[] = {
+	{
+		.start  = 0xFEE00800,   /* use eth1 */
+		.end    = 0xFEE00F7C - 1,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = 58,   /* irq number */
+		.end    = 58,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_eth_plat_data sh7763_eth_pdata = {
+	.phy = 1,
+	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+};
+
+static struct platform_device sh7763rdp_eth_device = {
+	.name       = "sh-eth",
+	.resource   = sh_eth_resources,
+	.num_resources  = ARRAY_SIZE(sh_eth_resources),
+	.dev        = {
+		.platform_data = &sh7763_eth_pdata,
+	},
+};
+
 static struct platform_device *sh7763rdp_devices[] __initdata = {
 	&sh7763rdp_nor_flash_device,
+	&sh7763rdp_eth_device,
 };

 static int __init sh7763rdp_devices_setup(void)
@@ -69,7 +98,8 @@ static int __init sh7763rdp_devices_setup(void)
 	return platform_add_devices(sh7763rdp_devices,
 				    ARRAY_SIZE(sh7763rdp_devices));
 }
-__initcall(sh7763rdp_devices_setup);
+
+device_initcall(sh7763rdp_devices_setup);

 static void __init sh7763rdp_setup(char **cmdline_p)
 {
-- 
1.5.6.2

