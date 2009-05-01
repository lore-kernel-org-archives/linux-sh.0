From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 01 May 2009 06:58:52 +0000
Subject: [PATCH] sh: TMU platform data for sh7722
Message-Id: <20090501065852.8861.19090.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds TMU platform data for sh7722. Only clockevent
mode is enabled for now, clocksource requires this patch:
"clocksource: setup mult_orig in clocksource_enable()"

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    1 
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   99 ++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

--- 0007/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-05-01 13:22:50.000000000 +0900
@@ -423,6 +423,7 @@ config CPU_SUBTYPE_SH7722
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
 	select SYS_SUPPORTS_CMT
+	select SYS_SUPPORTS_TMU
 
 config CPU_SUBTYPE_SH7366
 	bool "Support SH7366 processor"
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-05-01 13:32:49.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/uio_driver.h>
 #include <linux/sh_cmt.h>
+#include <linux/sh_tmu.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 
@@ -209,6 +210,98 @@ static struct platform_device cmt_device
 	.num_resources	= ARRAY_SIZE(cmt_resources),
 };
 
+static struct sh_tmu_config tmu0_platform_data = {
+	.name = "TMU0",
+	.channel_offset = 0x04,
+	.timer_bit = 0,
+	.clk = "tmu0",
+	.clockevent_rating = 200,
+};
+
+static struct resource tmu0_resources[] = {
+	[0] = {
+		.name	= "TMU0",
+		.start	= 0xffd80008,
+		.end	= 0xffd80013,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 16,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu0_device = {
+	.name		= "sh_tmu",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &tmu0_platform_data,
+	},
+	.resource	= tmu0_resources,
+	.num_resources	= ARRAY_SIZE(tmu0_resources),
+};
+
+static struct sh_tmu_config tmu1_platform_data = {
+	.name = "TMU1",
+	.channel_offset = 0x10,
+	.timer_bit = 1,
+	.clk = "tmu0",
+	.clocksource_rating = 0, /* disabled for now */
+};
+
+static struct resource tmu1_resources[] = {
+	[0] = {
+		.name	= "TMU1",
+		.start	= 0xffd80014,
+		.end	= 0xffd8001f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 17,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu1_device = {
+	.name		= "sh_tmu",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &tmu1_platform_data,
+	},
+	.resource	= tmu1_resources,
+	.num_resources	= ARRAY_SIZE(tmu1_resources),
+};
+
+static struct sh_tmu_config tmu2_platform_data = {
+	.name = "TMU2",
+	.channel_offset = 0x1c,
+	.timer_bit = 2,
+	.clk = "tmu0",
+};
+
+static struct resource tmu2_resources[] = {
+	[0] = {
+		.name	= "TMU2",
+		.start	= 0xffd80020,
+		.end	= 0xffd8002b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 18,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu2_device = {
+	.name		= "sh_tmu",
+	.id		= 2,
+	.dev = {
+		.platform_data	= &tmu2_platform_data,
+	},
+	.resource	= tmu2_resources,
+	.num_resources	= ARRAY_SIZE(tmu2_resources),
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xffe00000,
@@ -243,6 +336,9 @@ static struct platform_device sci_device
 
 static struct platform_device *sh7722_devices[] __initdata = {
 	&cmt_device,
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
 	&rtc_device,
 	&usbf_device,
 	&iic_device,
@@ -271,6 +367,9 @@ __initcall(sh7722_devices_setup);
 
 static struct platform_device *sh7722_early_devices[] __initdata = {
 	&cmt_device,
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
 };
 
 void __init plat_early_device_setup(void)
