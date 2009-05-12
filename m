From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 May 2009 09:20:08 +0000
Subject: [PATCH] sh: TMU platform data for sh7770
Message-Id: <20090512092008.25045.53897.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds TMU platform data for sh7770. Both clockevent
and clocksource support is enabled.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |  300 ++++++++++++++++++++++++++++++++
 1 file changed, 300 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7770.c	2009-05-12 14:47:07.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_timer.h>
 
 static struct plat_sci_port sci_platform_data[] = {
 	{
@@ -76,7 +77,288 @@ static struct platform_device sci_device
 	},
 };
 
+static struct sh_timer_config tmu0_platform_data = {
+	.name = "TMU0",
+	.channel_offset = 0x04,
+	.timer_bit = 0,
+	.clk = "module_clk",
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
+	.clk = "module_clk",
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
+	.clk = "module_clk",
+};
+
+static struct resource tmu2_resources[] = {
+	[0] = {
+		.name	= "TMU2",
+		.start	= 0xffd80020,
+		.end	= 0xffd8002f,
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
+	.clk = "module_clk",
+};
+
+static struct resource tmu3_resources[] = {
+	[0] = {
+		.name	= "TMU3",
+		.start	= 0xffd81008,
+		.end	= 0xffd81013,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 19,
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
+	.clk = "module_clk",
+};
+
+static struct resource tmu4_resources[] = {
+	[0] = {
+		.name	= "TMU4",
+		.start	= 0xffd81014,
+		.end	= 0xffd8101f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 20,
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
+	.clk = "module_clk",
+};
+
+static struct resource tmu5_resources[] = {
+	[0] = {
+		.name	= "TMU5",
+		.start	= 0xffd81020,
+		.end	= 0xffd8102f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 21,
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
+static struct sh_timer_config tmu6_platform_data = {
+	.name = "TMU6",
+	.channel_offset = 0x04,
+	.timer_bit = 0,
+	.clk = "module_clk",
+};
+
+static struct resource tmu6_resources[] = {
+	[0] = {
+		.name	= "TMU6",
+		.start	= 0xffd82008,
+		.end	= 0xffd82013,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 22,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu6_device = {
+	.name		= "sh_tmu",
+	.id		= 6,
+	.dev = {
+		.platform_data	= &tmu6_platform_data,
+	},
+	.resource	= tmu6_resources,
+	.num_resources	= ARRAY_SIZE(tmu6_resources),
+};
+
+static struct sh_timer_config tmu7_platform_data = {
+	.name = "TMU7",
+	.channel_offset = 0x10,
+	.timer_bit = 1,
+	.clk = "module_clk",
+};
+
+static struct resource tmu7_resources[] = {
+	[0] = {
+		.name	= "TMU7",
+		.start	= 0xffd82014,
+		.end	= 0xffd8201f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 23,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu7_device = {
+	.name		= "sh_tmu",
+	.id		= 7,
+	.dev = {
+		.platform_data	= &tmu7_platform_data,
+	},
+	.resource	= tmu7_resources,
+	.num_resources	= ARRAY_SIZE(tmu7_resources),
+};
+
+static struct sh_timer_config tmu8_platform_data = {
+	.name = "TMU8",
+	.channel_offset = 0x1c,
+	.timer_bit = 2,
+	.clk = "module_clk",
+};
+
+static struct resource tmu8_resources[] = {
+	[0] = {
+		.name	= "TMU8",
+		.start	= 0xffd82020,
+		.end	= 0xffd8202b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 24,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device tmu8_device = {
+	.name		= "sh_tmu",
+	.id		= 8,
+	.dev = {
+		.platform_data	= &tmu8_platform_data,
+	},
+	.resource	= tmu8_resources,
+	.num_resources	= ARRAY_SIZE(tmu8_resources),
+};
+
 static struct platform_device *sh7770_devices[] __initdata = {
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+	&tmu3_device,
+	&tmu4_device,
+	&tmu5_device,
+	&tmu6_device,
+	&tmu7_device,
+	&tmu8_device,
 	&sci_device,
 };
 
@@ -87,6 +369,24 @@ static int __init sh7770_devices_setup(v
 }
 __initcall(sh7770_devices_setup);
 
+static struct platform_device *sh7770_early_devices[] __initdata = {
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+	&tmu3_device,
+	&tmu4_device,
+	&tmu5_device,
+	&tmu6_device,
+	&tmu7_device,
+	&tmu8_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7770_early_devices,
+				   ARRAY_SIZE(sh7770_early_devices));
+}
+
 void __init plat_irq_setup(void)
 {
 }
