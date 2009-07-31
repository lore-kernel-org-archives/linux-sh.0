From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:47:27 +0000
Subject: [PATCH 02/09] sh: Runtime PM pdev hwblk - sh7722
Message-Id: <20090731074727.29009.95656.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add hwblk_id to on-chip sh7722 platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-07-30 15:03:50.000000000 +0900
@@ -17,6 +17,7 @@
 #include <linux/sh_timer.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
+#include <cpu/sh7722.h>
 
 static struct resource rtc_resources[] = {
 	[0] = {
@@ -46,6 +47,9 @@ static struct platform_device rtc_device
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(rtc_resources),
 	.resource	= rtc_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_RTC,
+	},
 };
 
 static struct m66592_platdata usbf_platdata = {
@@ -76,6 +80,9 @@ static struct platform_device usbf_devic
 	},
 	.num_resources	= ARRAY_SIZE(usbf_resources),
 	.resource	= usbf_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_USBF,
+	},
 };
 
 static struct resource iic_resources[] = {
@@ -97,6 +104,9 @@ static struct platform_device iic_device
 	.id             = 0, /* "i2c0" clock */
 	.num_resources  = ARRAY_SIZE(iic_resources),
 	.resource       = iic_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_IIC,
+	},
 };
 
 static struct uio_info vpu_platform_data = {
@@ -125,6 +135,9 @@ static struct platform_device vpu_device
 	},
 	.resource	= vpu_resources,
 	.num_resources	= ARRAY_SIZE(vpu_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_VPU,
+	},
 };
 
 static struct uio_info veu_platform_data = {
@@ -153,6 +166,9 @@ static struct platform_device veu_device
 	},
 	.resource	= veu_resources,
 	.num_resources	= ARRAY_SIZE(veu_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_VEU,
+	},
 };
 
 static struct uio_info jpu_platform_data = {
@@ -181,6 +197,9 @@ static struct platform_device jpu_device
 	},
 	.resource	= jpu_resources,
 	.num_resources	= ARRAY_SIZE(jpu_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_JPU,
+	},
 };
 
 static struct sh_timer_config cmt_platform_data = {
@@ -213,6 +232,9 @@ static struct platform_device cmt_device
 	},
 	.resource	= cmt_resources,
 	.num_resources	= ARRAY_SIZE(cmt_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_CMT,
+	},
 };
 
 static struct sh_timer_config tmu0_platform_data = {
@@ -244,6 +266,9 @@ static struct platform_device tmu0_devic
 	},
 	.resource	= tmu0_resources,
 	.num_resources	= ARRAY_SIZE(tmu0_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU,
+	},
 };
 
 static struct sh_timer_config tmu1_platform_data = {
@@ -275,6 +300,9 @@ static struct platform_device tmu1_devic
 	},
 	.resource	= tmu1_resources,
 	.num_resources	= ARRAY_SIZE(tmu1_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU,
+	},
 };
 
 static struct sh_timer_config tmu2_platform_data = {
@@ -305,6 +333,9 @@ static struct platform_device tmu2_devic
 	},
 	.resource	= tmu2_resources,
 	.num_resources	= ARRAY_SIZE(tmu2_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU,
+	},
 };
 
 static struct plat_sci_port sci_platform_data[] = {
