From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:48:11 +0000
Subject: [PATCH 07/09] sh: Runtime PM pdev hwblk - sh7724
Message-Id: <20090731074811.29009.32186.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add hwblk_id to on-chip sh7724 platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   43 ++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2009-07-31 15:10:48.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/io.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
+#include <cpu/sh7724.h>
 
 /* Serial */
 static struct plat_sci_port sci_platform_data[] = {
@@ -103,6 +104,9 @@ static struct platform_device rtc_device
 	.id		= -1,
 	.num_resources	= ARRAY_SIZE(rtc_resources),
 	.resource	= rtc_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_RTC,
+	},
 };
 
 /* I2C0 */
@@ -125,6 +129,9 @@ static struct platform_device iic0_devic
 	.id             = 0, /* "i2c0" clock */
 	.num_resources  = ARRAY_SIZE(iic0_resources),
 	.resource       = iic0_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_IIC0,
+	},
 };
 
 /* I2C1 */
@@ -147,6 +154,9 @@ static struct platform_device iic1_devic
 	.id             = 1, /* "i2c1" clock */
 	.num_resources  = ARRAY_SIZE(iic1_resources),
 	.resource       = iic1_resources,
+	.archdata = {
+		.hwblk_id = HWBLK_IIC1,
+	},
 };
 
 /* VPU */
@@ -176,6 +186,9 @@ static struct platform_device vpu_device
 	},
 	.resource	= vpu_resources,
 	.num_resources	= ARRAY_SIZE(vpu_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_VPU,
+	},
 };
 
 /* VEU0 */
@@ -205,6 +218,9 @@ static struct platform_device veu0_devic
 	},
 	.resource	= veu0_resources,
 	.num_resources	= ARRAY_SIZE(veu0_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_VEU0,
+	},
 };
 
 /* VEU1 */
@@ -234,6 +250,9 @@ static struct platform_device veu1_devic
 	},
 	.resource	= veu1_resources,
 	.num_resources	= ARRAY_SIZE(veu1_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_VEU1,
+	},
 };
 
 static struct sh_timer_config cmt_platform_data = {
@@ -266,6 +285,9 @@ static struct platform_device cmt_device
 	},
 	.resource	= cmt_resources,
 	.num_resources	= ARRAY_SIZE(cmt_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_CMT,
+	},
 };
 
 static struct sh_timer_config tmu0_platform_data = {
@@ -297,6 +319,9 @@ static struct platform_device tmu0_devic
 	},
 	.resource	= tmu0_resources,
 	.num_resources	= ARRAY_SIZE(tmu0_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU0,
+	},
 };
 
 static struct sh_timer_config tmu1_platform_data = {
@@ -328,6 +353,9 @@ static struct platform_device tmu1_devic
 	},
 	.resource	= tmu1_resources,
 	.num_resources	= ARRAY_SIZE(tmu1_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU0,
+	},
 };
 
 static struct sh_timer_config tmu2_platform_data = {
@@ -358,6 +386,9 @@ static struct platform_device tmu2_devic
 	},
 	.resource	= tmu2_resources,
 	.num_resources	= ARRAY_SIZE(tmu2_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU0,
+	},
 };
 
 
@@ -389,6 +420,9 @@ static struct platform_device tmu3_devic
 	},
 	.resource	= tmu3_resources,
 	.num_resources	= ARRAY_SIZE(tmu3_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU1,
+	},
 };
 
 static struct sh_timer_config tmu4_platform_data = {
@@ -419,6 +453,9 @@ static struct platform_device tmu4_devic
 	},
 	.resource	= tmu4_resources,
 	.num_resources	= ARRAY_SIZE(tmu4_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU1,
+	},
 };
 
 static struct sh_timer_config tmu5_platform_data = {
@@ -449,6 +486,9 @@ static struct platform_device tmu5_devic
 	},
 	.resource	= tmu5_resources,
 	.num_resources	= ARRAY_SIZE(tmu5_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_TMU1,
+	},
 };
 
 /* JPU */
@@ -478,6 +518,9 @@ static struct platform_device jpu_device
 	},
 	.resource	= jpu_resources,
 	.num_resources	= ARRAY_SIZE(jpu_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_JPU,
+	},
 };
 
 static struct platform_device *sh7724_devices[] __initdata = {
