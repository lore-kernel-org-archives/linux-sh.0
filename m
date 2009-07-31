From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:47:53 +0000
Subject: [PATCH 05/09] sh: Runtime PM pdev hwblk - sh7723
Message-Id: <20090731074753.29009.79799.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add hwblk_id to on-chip sh7723 platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2009-07-30 15:16:00.000000000 +0900
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
+#include <cpu/sh7723.h>
 
 static struct uio_info vpu_platform_data = {
 	.name = "VPU5",
@@ -45,6 +46,9 @@ static struct platform_device vpu_device
 	},
 	.resource	= vpu_resources,
 	.num_resources	= ARRAY_SIZE(vpu_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_VPU,
+	},
 };
 
 static struct uio_info veu0_platform_data = {
@@ -73,6 +77,9 @@ static struct platform_device veu0_devic
 	},
 	.resource	= veu0_resources,
 	.num_resources	= ARRAY_SIZE(veu0_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_VEU2H0,
+	},
 };
 
 static struct uio_info veu1_platform_data = {
@@ -101,6 +108,9 @@ static struct platform_device veu1_devic
 	},
 	.resource	= veu1_resources,
 	.num_resources	= ARRAY_SIZE(veu1_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_VEU2H1,
+	},
 };
 
 static struct sh_timer_config cmt_platform_data = {
@@ -133,6 +143,9 @@ static struct platform_device cmt_device
 	},
 	.resource	= cmt_resources,
 	.num_resources	= ARRAY_SIZE(cmt_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_CMT,
+	},
 };
 
 static struct sh_timer_config tmu0_platform_data = {
@@ -164,6 +177,9 @@ static struct platform_device tmu0_devic
 	},
 	.resource	= tmu0_resources,
 	.num_resources	= ARRAY_SIZE(tmu0_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU0,
+	},
 };
 
 static struct sh_timer_config tmu1_platform_data = {
@@ -195,6 +211,9 @@ static struct platform_device tmu1_devic
 	},
 	.resource	= tmu1_resources,
 	.num_resources	= ARRAY_SIZE(tmu1_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU0,
+	},
 };
 
 static struct sh_timer_config tmu2_platform_data = {
@@ -225,6 +244,9 @@ static struct platform_device tmu2_devic
 	},
 	.resource	= tmu2_resources,
 	.num_resources	= ARRAY_SIZE(tmu2_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU0,
+	},
 };
 
 static struct sh_timer_config tmu3_platform_data = {
@@ -255,6 +277,9 @@ static struct platform_device tmu3_devic
 	},
 	.resource	= tmu3_resources,
 	.num_resources	= ARRAY_SIZE(tmu3_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU1,
+	},
 };
 
 static struct sh_timer_config tmu4_platform_data = {
@@ -285,6 +310,9 @@ static struct platform_device tmu4_devic
 	},
 	.resource	= tmu4_resources,
 	.num_resources	= ARRAY_SIZE(tmu4_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU1,
+	},
 };
 
 static struct sh_timer_config tmu5_platform_data = {
@@ -315,6 +343,9 @@ static struct platform_device tmu5_devic
 	},
 	.resource	= tmu5_resources,
 	.num_resources	= ARRAY_SIZE(tmu5_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU1,
+	},
 };
 
 static struct plat_sci_port sci_platform_data[] = {
@@ -395,6 +426,9 @@ static struct platform_device rtc_device
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(rtc_resources),
 	.resource	= rtc_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_RTC,
+	},
 };
 
 static struct r8a66597_platdata r8a66597_data = {
@@ -424,6 +458,9 @@ static struct platform_device sh7723_usb
 	},
 	.num_resources	= ARRAY_SIZE(sh7723_usb_host_resources),
 	.resource	= sh7723_usb_host_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_USB,
+	},
 };
 
 static struct resource iic_resources[] = {
@@ -445,6 +482,9 @@ static struct platform_device iic_device
 	.id             = 0, /* "i2c0" clock */
 	.num_resources  = ARRAY_SIZE(iic_resources),
 	.resource       = iic_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_IIC,
+	},
 };
 
 static struct platform_device *sh7723_devices[] __initdata = {
