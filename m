From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 30 Apr 2009 04:08:18 +0000
Subject: [PATCH] sh: sh2/sh2a 16-bit CMT platform data
Message-Id: <20090430040818.25261.69223.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds 16-bit cmt platform data for the following cpus:
 - sh7619 (2 channels)
 - sh7203/sh7263 (2 channels)
 - sh7206 (2 channels)

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Periodic clockevent is tested on a rsk7203 board (sh7203).
 Clocksource support is currently disabled in the platform data.

 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |   84 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   84 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   84 ++++++++++++++++++++++++++++++++
 3 files changed, 252 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ work/arch/sh/kernel/cpu/sh2/setup-sh7619.c	2009-04-30 12:32:25.000000000 +0900
@@ -12,6 +12,8 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_cmt.h>
+#include <linux/io.h>
 
 enum {
 	UNUSED = 0,
@@ -109,9 +111,75 @@ static struct platform_device eth_device
 	.resource = eth_resources,
 };
 
+static struct sh_cmt_config cmt0_platform_data = {
+	.name = "CMT0",
+	.channel_offset = 0x02,
+	.timer_bit = 0,
+	.clk = "module_clk",
+	.clockevent_rating = 125,
+	.clocksource_rating = 0, /* disabled due to code generation issues */
+};
+
+static struct resource cmt0_resources[] = {
+	[0] = {
+		.name	= "CMT0",
+		.start	= 0xf84a0072,
+		.end	= 0xf84a0077,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 86,
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
+static struct sh_cmt_config cmt1_platform_data = {
+	.name = "CMT1",
+	.channel_offset = 0x08,
+	.timer_bit = 1,
+	.clk = "module_clk",
+	.clockevent_rating = 125,
+	.clocksource_rating = 0, /* disabled due to code generation issues */
+};
+
+static struct resource cmt1_resources[] = {
+	[0] = {
+		.name	= "CMT1",
+		.start	= 0xf84a0078,
+		.end	= 0xf84a007d,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 87,
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
 static struct platform_device *sh7619_devices[] __initdata = {
 	&sci_device,
 	&eth_device,
+	&cmt0_device,
+	&cmt1_device,
 };
 
 static int __init sh7619_devices_setup(void)
@@ -125,3 +193,19 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+static struct platform_device *sh7619_early_devices[] __initdata = {
+	&cmt0_device,
+	&cmt1_device,
+};
+
+#define STBCR3 0xf80a0000
+
+void __init plat_early_device_setup(void)
+{
+	/* enable CMT clock */
+	ctrl_outb(ctrl_inb(STBCR3) & ~0x10, STBCR3);
+
+	early_platform_add_devices(sh7619_early_devices,
+				   ARRAY_SIZE(sh7619_early_devices));
+}
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7203.c	2009-04-30 12:31:53.000000000 +0900
@@ -11,6 +11,8 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_cmt.h>
+#include <linux/io.h>
 
 enum {
 	UNUSED = 0,
@@ -205,6 +207,70 @@ static struct platform_device sci_device
 	},
 };
 
+static struct sh_cmt_config cmt0_platform_data = {
+	.name = "CMT0",
+	.channel_offset = 0x02,
+	.timer_bit = 0,
+	.clk = "module_clk",
+	.clockevent_rating = 125,
+	.clocksource_rating = 0, /* disabled due to code generation issues */
+};
+
+static struct resource cmt0_resources[] = {
+	[0] = {
+		.name	= "CMT0",
+		.start	= 0xfffec002,
+		.end	= 0xfffec007,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 142,
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
+static struct sh_cmt_config cmt1_platform_data = {
+	.name = "CMT1",
+	.channel_offset = 0x08,
+	.timer_bit = 1,
+	.clk = "module_clk",
+	.clockevent_rating = 125,
+	.clocksource_rating = 0, /* disabled due to code generation issues */
+};
+
+static struct resource cmt1_resources[] = {
+	[0] = {
+		.name	= "CMT1",
+		.start	= 0xfffec008,
+		.end	= 0xfffec00d,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 143,
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
 static struct resource rtc_resources[] = {
 	[0] = {
 		.start	= 0xffff2000,
@@ -227,6 +293,8 @@ static struct platform_device rtc_device
 
 static struct platform_device *sh7203_devices[] __initdata = {
 	&sci_device,
+	&cmt0_device,
+	&cmt1_device,
 	&rtc_device,
 };
 
@@ -241,3 +309,19 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+static struct platform_device *sh7203_early_devices[] __initdata = {
+	&cmt0_device,
+	&cmt1_device,
+};
+
+#define STBCR4 0xfffe040c
+
+void __init plat_early_device_setup(void)
+{
+	/* enable CMT clock */
+	ctrl_outb(ctrl_inb(STBCR4) & ~0x04, STBCR4);
+
+	early_platform_add_devices(sh7203_early_devices,
+				   ARRAY_SIZE(sh7203_early_devices));
+}
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7206.c	2009-04-30 12:32:08.000000000 +0900
@@ -12,6 +12,8 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_cmt.h>
+#include <linux/io.h>
 
 enum {
 	UNUSED = 0,
@@ -165,8 +167,74 @@ static struct platform_device sci_device
 	},
 };
 
+static struct sh_cmt_config cmt0_platform_data = {
+	.name = "CMT0",
+	.channel_offset = 0x02,
+	.timer_bit = 0,
+	.clk = "module_clk",
+	.clockevent_rating = 125,
+	.clocksource_rating = 0, /* disabled due to code generation issues */
+};
+
+static struct resource cmt0_resources[] = {
+	[0] = {
+		.name	= "CMT0",
+		.start	= 0xfffec002,
+		.end	= 0xfffec007,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 140,
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
+static struct sh_cmt_config cmt1_platform_data = {
+	.name = "CMT1",
+	.channel_offset = 0x08,
+	.timer_bit = 1,
+	.clk = "module_clk",
+	.clockevent_rating = 125,
+	.clocksource_rating = 0, /* disabled due to code generation issues */
+};
+
+static struct resource cmt1_resources[] = {
+	[0] = {
+		.name	= "CMT1",
+		.start	= 0xfffec008,
+		.end	= 0xfffec00d,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 144,
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
 static struct platform_device *sh7206_devices[] __initdata = {
 	&sci_device,
+	&cmt0_device,
+	&cmt1_device,
 };
 
 static int __init sh7206_devices_setup(void)
@@ -180,3 +248,19 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+static struct platform_device *sh7206_early_devices[] __initdata = {
+	&cmt0_device,
+	&cmt1_device,
+};
+
+#define STBCR4 0xfffe040c
+
+void __init plat_early_device_setup(void)
+{
+	/* enable CMT clock */
+	ctrl_outb(ctrl_inb(STBCR4) & ~0x04, STBCR4);
+
+	early_platform_add_devices(sh7206_early_devices,
+				   ARRAY_SIZE(sh7206_early_devices));
+}
