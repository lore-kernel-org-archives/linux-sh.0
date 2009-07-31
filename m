From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:48:29 +0000
Subject: [PATCH 09/09] sh: Runtime PM pdev hwblk - Solution Engine 7724
Message-Id: <20090731074829.29009.65668.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add hwblk_id to Solution Engine 7724 board specific
on-chip sh7724 platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-se/7724/setup.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2009-07-31 15:19:58.000000000 +0900
@@ -174,6 +174,9 @@ static struct platform_device lcdc_devic
 	.dev		= {
 		.platform_data	= &lcdc_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_LCDC,
+	},
 };
 
 /* CEU0 */
@@ -205,6 +208,9 @@ static struct platform_device ceu0_devic
 	.dev	= {
 		.platform_data	= &sh_mobile_ceu0_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_CEU0,
+	},
 };
 
 /* CEU1 */
@@ -236,6 +242,9 @@ static struct platform_device ceu1_devic
 	.dev	= {
 		.platform_data	= &sh_mobile_ceu1_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_CEU1,
+	},
 };
 
 /* KEYSC */
@@ -273,6 +282,9 @@ static struct platform_device keysc_devi
 	.dev	= {
 		.platform_data	= &keysc_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_KEYSC,
+	},
 };
 
 /* SH Eth */
@@ -301,6 +313,9 @@ static struct platform_device sh_eth_dev
 	},
 	.num_resources = ARRAY_SIZE(sh_eth_resources),
 	.resource = sh_eth_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_ETHER,
+	},
 };
 
 static struct r8a66597_platdata sh7724_usb0_host_data = {
@@ -330,6 +345,9 @@ static struct platform_device sh7724_usb
 	},
 	.num_resources	= ARRAY_SIZE(sh7724_usb0_host_resources),
 	.resource	= sh7724_usb0_host_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_USB0,
+	},
 };
 
 static struct platform_device *ms7724se_devices[] __initdata = {
