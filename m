From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 May 2009 10:21:11 +0000
Subject: [PATCH] sh: CMT platform data for sh7720/sh7721
Message-Id: <20090512102111.25772.7187.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds CMT platform data for sh7720 and sh7721.
All 5 32-bit CMT channels unfortunately share a single IRQ.
Both clockevent and clocksource support is enabled.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                       |    2 
 arch/sh/kernel/cpu/sh3/setup-sh7720.c |  161 +++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-05-12 16:47:18.000000000 +0900
@@ -302,6 +302,7 @@ config CPU_SUBTYPE_SH7720
 	bool "Support SH7720 processor"
 	select CPU_SH3
 	select CPU_HAS_DSP
+	select SYS_SUPPORTS_CMT
 	help
 	  Select SH7720 if you have a SH3-DSP SH7720 CPU.
 
@@ -309,6 +310,7 @@ config CPU_SUBTYPE_SH7721
 	bool "Support SH7721 processor"
 	select CPU_SH3
 	select CPU_HAS_DSP
+	select SYS_SUPPORTS_CMT
 	help
 	  Select SH7721 if you have a SH3-DSP SH7721 CPU.
 
--- 0014/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7720.c	2009-05-12 16:45:22.000000000 +0900
@@ -124,6 +124,157 @@ static struct platform_device usbf_devic
 	.resource	= usbf_resources,
 };
 
+static struct sh_timer_config cmt0_platform_data = {
+	.name = "CMT0",
+	.channel_offset = 0x10,
+	.timer_bit = 0,
+	.clk = "module_clk",
+	.clockevent_rating = 125,
+	.clocksource_rating = 125,
+};
+
+static struct resource cmt0_resources[] = {
+	[0] = {
+		.name	= "CMT0",
+		.start	= 0x044a0010,
+		.end	= 0x044a001b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 104,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt0_device = {
+	.name		= "sh_cmt",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &cmt0_platform_data,
+	},
+	.resource	= cmt0_resources,
+	.num_resources	= ARRAY_SIZE(cmt0_resources),
+};
+
+static struct sh_timer_config cmt1_platform_data = {
+	.name = "CMT1",
+	.channel_offset = 0x20,
+	.timer_bit = 1,
+	.clk = "module_clk",
+};
+
+static struct resource cmt1_resources[] = {
+	[0] = {
+		.name	= "CMT1",
+		.start	= 0x044a0020,
+		.end	= 0x044a002b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 104,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt1_device = {
+	.name		= "sh_cmt",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &cmt1_platform_data,
+	},
+	.resource	= cmt1_resources,
+	.num_resources	= ARRAY_SIZE(cmt1_resources),
+};
+
+static struct sh_timer_config cmt2_platform_data = {
+	.name = "CMT2",
+	.channel_offset = 0x30,
+	.timer_bit = 2,
+	.clk = "module_clk",
+};
+
+static struct resource cmt2_resources[] = {
+	[0] = {
+		.name	= "CMT2",
+		.start	= 0x044a0030,
+		.end	= 0x044a003b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 104,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt2_device = {
+	.name		= "sh_cmt",
+	.id		= 2,
+	.dev = {
+		.platform_data	= &cmt2_platform_data,
+	},
+	.resource	= cmt2_resources,
+	.num_resources	= ARRAY_SIZE(cmt2_resources),
+};
+
+static struct sh_timer_config cmt3_platform_data = {
+	.name = "CMT3",
+	.channel_offset = 0x40,
+	.timer_bit = 3,
+	.clk = "module_clk",
+};
+
+static struct resource cmt3_resources[] = {
+	[0] = {
+		.name	= "CMT3",
+		.start	= 0x044a0040,
+		.end	= 0x044a004b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 104,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt3_device = {
+	.name		= "sh_cmt",
+	.id		= 3,
+	.dev = {
+		.platform_data	= &cmt3_platform_data,
+	},
+	.resource	= cmt3_resources,
+	.num_resources	= ARRAY_SIZE(cmt3_resources),
+};
+
+static struct sh_timer_config cmt4_platform_data = {
+	.name = "CMT4",
+	.channel_offset = 0x50,
+	.timer_bit = 4,
+	.clk = "module_clk",
+};
+
+static struct resource cmt4_resources[] = {
+	[0] = {
+		.name	= "CMT4",
+		.start	= 0x044a0050,
+		.end	= 0x044a005b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 104,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt4_device = {
+	.name		= "sh_cmt",
+	.id		= 4,
+	.dev = {
+		.platform_data	= &cmt4_platform_data,
+	},
+	.resource	= cmt4_resources,
+	.num_resources	= ARRAY_SIZE(cmt4_resources),
+};
 
 static struct sh_timer_config tmu0_platform_data = {
 	.name = "TMU0",
@@ -218,6 +369,11 @@ static struct platform_device tmu2_devic
 };
 
 static struct platform_device *sh7720_devices[] __initdata = {
+	&cmt0_device,
+	&cmt1_device,
+	&cmt2_device,
+	&cmt3_device,
+	&cmt4_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
@@ -235,6 +391,11 @@ static int __init sh7720_devices_setup(v
 __initcall(sh7720_devices_setup);
 
 static struct platform_device *sh7720_early_devices[] __initdata = {
+	&cmt0_device,
+	&cmt1_device,
+	&cmt2_device,
+	&cmt3_device,
+	&cmt4_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
