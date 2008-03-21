From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 21 Mar 2008 09:43:37 +0000
Subject: [PATCH 03/06] sh: Move KEYSC platform data to sh7722
Message-Id: <20080321094337.10532.69879.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move KEYSC platform data to cpu-specific file. Use weak symbol for
KEYSC board specific data structure so board code can override.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/renesas/migor/setup.c   |   24 +-----------------------
 arch/sh/boards/se/7722/setup.c         |   24 +-----------------------
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 46 deletions(-)

--- 0003/arch/sh/boards/renesas/migor/setup.c
+++ work/arch/sh/boards/renesas/migor/setup.c	2008-03-20 17:53:38.000000000 +0900
@@ -43,7 +43,7 @@ static struct platform_device smc91x_eth
 	.resource       = smc91x_eth_resources,
 };
 
-static struct sh_keysc_info sh_keysc_info = {
+struct sh_keysc_info sh_keysc_info = {
 	.mode = SH_KEYSC_MODE_2, /* KEYOUT0->4, KEYIN1->5 */
 	.scan_timing = 3,
 	.delay = 5,
@@ -56,30 +56,8 @@ static struct sh_keysc_info sh_keysc_inf
 	},
 };
 
-static struct resource sh_keysc_resources[] = {
-	[0] = {
-		.start  = 0x044b0000,
-		.end    = 0x044b000f,
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start  = 79,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device sh_keysc_device = {
-	.name           = "sh_keysc",
-	.num_resources  = ARRAY_SIZE(sh_keysc_resources),
-	.resource       = sh_keysc_resources,
-	.dev	= {
-		.platform_data	= &sh_keysc_info,
-	},
-};
-
 static struct platform_device *migor_devices[] __initdata = {
 	&smc91x_eth_device,
-	&sh_keysc_device,
 };
 
 static int __init migor_devices_setup(void)
--- 0001/arch/sh/boards/se/7722/setup.c
+++ work/arch/sh/boards/se/7722/setup.c	2008-03-20 17:49:20.000000000 +0900
@@ -94,7 +94,7 @@ static struct platform_device cf_ide_dev
 	.resource       = cf_ide_resources,
 };
 
-static struct sh_keysc_info sh_keysc_info = {
+struct sh_keysc_info sh_keysc_info = {
 	.mode = SH_KEYSC_MODE_1, /* KEYOUT0->5, KEYIN0->4 */
 	.scan_timing = 3,
 	.delay = 5,
@@ -109,32 +109,10 @@ static struct sh_keysc_info sh_keysc_inf
 	},
 };
 
-static struct resource sh_keysc_resources[] = {
-	[0] = {
-		.start  = 0x044b0000,
-		.end    = 0x044b000f,
-		.flags  = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start  = 79,
-		.flags  = IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device sh_keysc_device = {
-	.name           = "sh_keysc",
-	.num_resources  = ARRAY_SIZE(sh_keysc_resources),
-	.resource       = sh_keysc_resources,
-	.dev	= {
-		.platform_data	= &sh_keysc_info,
-	},
-};
-
 static struct platform_device *se7722_devices[] __initdata = {
 	&heartbeat_device,
 	&smc91x_eth_device,
 	&cf_ide_device,
-	&sh_keysc_device,
 };
 
 static int __init se7722_devices_setup(void)
--- 0004/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-03-20 17:51:02.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/serial_sci.h>
 #include <linux/mm.h>
 #include <asm/mmzone.h>
+#include <asm/sh_keysc.h>
 
 static struct resource usbf_resources[] = {
 	[0] = {
@@ -39,6 +40,30 @@ static struct platform_device usbf_devic
 	.resource	= usbf_resources,
 };
 
+struct sh_keysc_info __weak sh_keysc_info = {};
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
+	.num_resources  = ARRAY_SIZE(keysc_resources),
+	.resource       = keysc_resources,
+	.dev	= {
+		.platform_data	= &sh_keysc_info,
+	},
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xffe00000,
@@ -73,6 +98,7 @@ static struct platform_device sci_device
 
 static struct platform_device *sh7722_devices[] __initdata = {
 	&usbf_device,
+	&keysc_device,
 	&sci_device,
 };
 
