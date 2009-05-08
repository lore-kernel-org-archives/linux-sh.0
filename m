From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 08 May 2009 08:32:18 +0000
Subject: [PATCH] sh: TMU platform data for sh7723
Message-Id: <20090508083218.31071.69934.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds TMU platform data for sh7723. Both clockevent
and clocksource support is enabled. While at it, adjust the
CMT clocksource rating to prioritize the TMU.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on ap325.

 For correct run-time behaviour this patch is needed:
 "clocksource: setup mult_orig in clocksource_enable()"

 arch/sh/Kconfig                        |    1 
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  196 +++++++++++++++++++++++++++++++-
 2 files changed, 196 insertions(+), 1 deletion(-)

--- 0007/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-05-08 17:09:39.000000000 +0900
@@ -356,6 +356,7 @@ config CPU_SUBTYPE_SH7723
 	select ARCH_SHMOBILE
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_CMT
+	select SYS_SUPPORTS_TMU
 	help
 	  Select SH7723 if you have an SH-MobileR2 CPU.
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2009-05-08 17:27:49.000000000 +0900
@@ -107,7 +107,7 @@ static struct sh_timer_config cmt_platfo
 	.timer_bit = 5,
 	.clk = "cmt0",
 	.clockevent_rating = 125,
-	.clocksource_rating = 200,
+	.clocksource_rating = 125,
 };
 
 static struct resource cmt_resources[] = {
@@ -133,6 +133,188 @@ static struct platform_device cmt_device
 	.num_resources	= ARRAY_SIZE(cmt_resources),
 };
 
+static struct sh_timer_config tmu0_platform_data = {
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
+static struct sh_timer_config tmu1_platform_data = {
+	.name = "TMU1",
+	.channel_offset = 0x10,
+	.timer_bit = 1,
+	.clk = "tmu0",
+	.clocksource_rating = 200,
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
+static struct sh_timer_config tmu2_platform_data = {
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
+static struct sh_timer_config tmu3_platform_data = {
+	.name = "TMU3",
+	.channel_offset = 0x04,
+	.timer_bit = 0,
+	.clk = "tmu1",
+};
+
+static struct resource tmu3_resources[] = {
+	[0] = {
+		.name	= "TMU3",
+		.start	= 0xffd90008,
+		.end	= 0xffd90013,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 57,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu3_device = {
+	.name		= "sh_tmu",
+	.id		= 3,
+	.dev = {
+		.platform_data	= &tmu3_platform_data,
+	},
+	.resource	= tmu3_resources,
+	.num_resources	= ARRAY_SIZE(tmu3_resources),
+};
+
+static struct sh_timer_config tmu4_platform_data = {
+	.name = "TMU4",
+	.channel_offset = 0x10,
+	.timer_bit = 1,
+	.clk = "tmu1",
+};
+
+static struct resource tmu4_resources[] = {
+	[0] = {
+		.name	= "TMU4",
+		.start	= 0xffd90014,
+		.end	= 0xffd9001f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 58,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu4_device = {
+	.name		= "sh_tmu",
+	.id		= 4,
+	.dev = {
+		.platform_data	= &tmu4_platform_data,
+	},
+	.resource	= tmu4_resources,
+	.num_resources	= ARRAY_SIZE(tmu4_resources),
+};
+
+static struct sh_timer_config tmu5_platform_data = {
+	.name = "TMU5",
+	.channel_offset = 0x1c,
+	.timer_bit = 2,
+	.clk = "tmu1",
+};
+
+static struct resource tmu5_resources[] = {
+	[0] = {
+		.name	= "TMU5",
+		.start	= 0xffd90020,
+		.end	= 0xffd9002b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 57,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu5_device = {
+	.name		= "sh_tmu",
+	.id		= 5,
+	.dev = {
+		.platform_data	= &tmu5_platform_data,
+	},
+	.resource	= tmu5_resources,
+	.num_resources	= ARRAY_SIZE(tmu5_resources),
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase        = 0xffe00000,
@@ -255,6 +437,12 @@ static struct platform_device iic_device
 
 static struct platform_device *sh7723_devices[] __initdata = {
 	&cmt_device,
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+	&tmu3_device,
+	&tmu4_device,
+	&tmu5_device,
 	&sci_device,
 	&rtc_device,
 	&iic_device,
@@ -282,6 +470,12 @@ __initcall(sh7723_devices_setup);
 
 static struct platform_device *sh7723_early_devices[] __initdata = {
 	&cmt_device,
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+	&tmu3_device,
+	&tmu4_device,
+	&tmu5_device,
 };
 
 void __init plat_early_device_setup(void)
