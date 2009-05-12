From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 May 2009 09:39:06 +0000
Subject: [PATCH] sh: TMU platform data for sh7343
Message-Id: <20090512093906.25245.41268.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds TMU platform data for sh7343. Both clockevent
and clocksource support is enabled.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   98 ++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2009-05-12 13:30:06.000000000 +0900
@@ -173,6 +173,98 @@ static struct platform_device cmt_device
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
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xffe00000,
@@ -213,6 +305,9 @@ static struct platform_device sci_device
 
 static struct platform_device *sh7343_devices[] __initdata = {
 	&cmt_device,
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
 	&iic0_device,
 	&iic1_device,
 	&sci_device,
@@ -240,6 +335,9 @@ __initcall(sh7343_devices_setup);
 
 static struct platform_device *sh7343_early_devices[] __initdata = {
 	&cmt_device,
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
 };
 
 void __init plat_early_device_setup(void)
