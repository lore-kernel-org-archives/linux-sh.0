From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 May 2009 08:54:54 +0000
Subject: [PATCH] sh: TMU platform data for sh775x
Message-Id: <20090511085454.32672.952.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds TMU platform data for sh775x. Both clockevent
and clocksource support is enabled.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on R2D-Plus.

 arch/sh/kernel/cpu/sh4/setup-sh7750.c |  187 +++++++++++++++++++++++++++++++++
 1 file changed, 187 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7750.c	2009-05-11 13:13:50.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/io.h>
+#include <linux/sh_timer.h>
 #include <linux/serial_sci.h>
 
 static struct resource rtc_resources[] = {
@@ -60,9 +61,177 @@ static struct platform_device sci_device
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
+/* SH7750R, SH7751 and SH7751R all have two extra timer channels */
+#if defined(CONFIG_CPU_SUBTYPE_SH7750R) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7751) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7751R)
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
+		.start	= 0xfe100008,
+		.end	= 0xfe100013,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 72,
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
+		.start	= 0xfe100014,
+		.end	= 0xfe10001f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 76,
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
+#endif
+
 static struct platform_device *sh7750_devices[] __initdata = {
 	&rtc_device,
 	&sci_device,
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+#if defined(CONFIG_CPU_SUBTYPE_SH7750R) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7751) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7751R)
+	&tmu3_device,
+	&tmu4_device,
+#endif
 };
 
 static int __init sh7750_devices_setup(void)
@@ -72,6 +241,24 @@ static int __init sh7750_devices_setup(v
 }
 __initcall(sh7750_devices_setup);
 
+static struct platform_device *sh7750_early_devices[] __initdata = {
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+#if defined(CONFIG_CPU_SUBTYPE_SH7750R) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7751) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7751R)
+	&tmu3_device,
+	&tmu4_device,
+#endif
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7750_early_devices,
+				   ARRAY_SIZE(sh7750_early_devices));
+}
+
 enum {
 	UNUSED = 0,
 
