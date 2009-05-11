From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 11:37:16 +0000
Subject: [PATCH] sh: TMU platform data for sh7780
Message-Id: <20090511113716.12681.44470.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds TMU platform data for sh7780. Both clockevent
and clocksource support is enabled.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on r7780.

 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |  204 ++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7780.c	2009-05-11 19:45:28.000000000 +0900
@@ -12,6 +12,189 @@
 #include <linux/serial.h>
 #include <linux/io.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_timer.h>
+
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
+		.start	= 28,
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
+		.start	= 29,
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
+		.start	= 30,
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
+		.start	= 0xffdc0008,
+		.end	= 0xffdc0013,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 96,
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
+		.start	= 0xffdc0014,
+		.end	= 0xffdc001f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 97,
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
+		.start	= 0xffdc0020,
+		.end	= 0xffdc002b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 98,
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
 
 static struct resource rtc_resources[] = {
 	[0] = {
@@ -58,6 +241,12 @@ static struct platform_device sci_device
 };
 
 static struct platform_device *sh7780_devices[] __initdata = {
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+	&tmu3_device,
+	&tmu4_device,
+	&tmu5_device,
 	&rtc_device,
 	&sci_device,
 };
@@ -69,6 +258,21 @@ static int __init sh7780_devices_setup(v
 }
 __initcall(sh7780_devices_setup);
 
+static struct platform_device *sh7780_early_devices[] __initdata = {
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+	&tmu3_device,
+	&tmu4_device,
+	&tmu5_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7780_early_devices,
+				   ARRAY_SIZE(sh7780_early_devices));
+}
+
 enum {
 	UNUSED = 0,
 
