From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 12 May 2009 10:15:30 +0000
Subject: [PATCH] sh: TMU platform data for sh7710/sh7712
Message-Id: <20090512101530.25698.96888.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds TMU platform data for sh7710 and sh7712.
Both clockevent and clocksource support is enabled.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh3/setup-sh7710.c |  108 +++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7710.c	2009-05-12 16:09:37.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/irq.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_timer.h>
 #include <asm/rtc.h>
 
 enum {
@@ -120,7 +121,102 @@ static struct platform_device sci_device
 	},
 };
 
+static struct sh_timer_config tmu0_platform_data = {
+	.name = "TMU0",
+	.channel_offset = 0x02,
+	.timer_bit = 0,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource tmu0_resources[] = {
+	[0] = {
+		.name	= "TMU0",
+		.start	= 0xa412fe94,
+		.end	= 0xa412fe9f,
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
+	.channel_offset = 0xe,
+	.timer_bit = 1,
+	.clk = "module_clk",
+	.clocksource_rating = 200,
+};
+
+static struct resource tmu1_resources[] = {
+	[0] = {
+		.name	= "TMU1",
+		.start	= 0xa412fea0,
+		.end	= 0xa412feab,
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
+	.channel_offset = 0x1a,
+	.timer_bit = 2,
+	.clk = "module_clk",
+};
+
+static struct resource tmu2_resources[] = {
+	[0] = {
+		.name	= "TMU2",
+		.start	= 0xa412feac,
+		.end	= 0xa412feb5,
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
 static struct platform_device *sh7710_devices[] __initdata = {
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
 	&sci_device,
 	&rtc_device,
 };
@@ -132,6 +228,18 @@ static int __init sh7710_devices_setup(v
 }
 __initcall(sh7710_devices_setup);
 
+static struct platform_device *sh7710_early_devices[] __initdata = {
+	&tmu0_device,
+	&tmu1_device,
+	&tmu2_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7710_early_devices,
+				   ARRAY_SIZE(sh7710_early_devices));
+}
+
 void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
