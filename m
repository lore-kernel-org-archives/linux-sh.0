From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 30 Apr 2009 07:06:26 +0000
Subject: [PATCH] sh: sh2a MTU2 platform data
Message-Id: <20090430070626.26577.56330.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds MTU2 platform data for the following cpus:
 - sh7201 (3/5 channels)
 - sh7203/sh7263 (2/4 channels)
 - sh7206 (3/5 channels)
 - MXG (3/5 channels)

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Periodic clockevent is tested on a rsk7203 board (sh7203).

 arch/sh/Kconfig                        |    5 +
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |  111 ++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |  115 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   71 +++++++++++++++++++
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |  104 ++++++++++++++++++++++++++++
 5 files changed, 405 insertions(+), 1 deletion(-)

--- 0008/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-04-30 15:21:37.000000000 +0900
@@ -214,27 +214,32 @@ config CPU_SUBTYPE_SH7201
 	bool "Support SH7201 processor"
 	select CPU_SH2A
 	select CPU_HAS_FPU
+	select SYS_SUPPORTS_MTU2
  
 config CPU_SUBTYPE_SH7203
 	bool "Support SH7203 processor"
 	select CPU_SH2A
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_CMT
+	select SYS_SUPPORTS_MTU2
 
 config CPU_SUBTYPE_SH7206
 	bool "Support SH7206 processor"
 	select CPU_SH2A
 	select SYS_SUPPORTS_CMT
+	select SYS_SUPPORTS_MTU2
 
 config CPU_SUBTYPE_SH7263
 	bool "Support SH7263 processor"
 	select CPU_SH2A
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_CMT
+	select SYS_SUPPORTS_MTU2
 
 config CPU_SUBTYPE_MXG
 	bool "Support MX-G processor"
 	select CPU_SH2A
+	select SYS_SUPPORTS_MTU2
 	help
 	  Select MX-G if running on an R8A03022BG part.
 
--- 0001/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-mxg.c	2009-04-30 15:20:34.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_mtu2.h>
 
 enum {
 	UNUSED = 0,
@@ -24,7 +25,7 @@ enum {
 
 	SCIF0, SCIF1,
 
-	MTU2_GROUP1, MTU2_GROUP2, MTU2_GROUP3, MTU2_GROUP4, MTU2_GROUP5
+	MTU2_GROUP1, MTU2_GROUP2, MTU2_GROUP3, MTU2_GROUP4, MTU2_GROUP5,
 	MTU2_TGI3B, MTU2_TGI3C,
 
 	/* interrupt groups */
@@ -113,6 +114,99 @@ static struct intc_mask_reg mask_registe
 static DECLARE_INTC_DESC(intc_desc, "mxg", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
+static struct sh_mtu2_config mtu2_0_platform_data = {
+	.name = "MTU2_0",
+	.channel_offset = -0x80,
+	.timer_bit = 0,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_0_resources[] = {
+	[0] = {
+		.name	= "MTU2_0",
+		.start	= 0xff801300,
+		.end	= 0xff801326,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 228,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_0_device = {
+	.name		= "sh_mtu2",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &mtu2_0_platform_data,
+	},
+	.resource	= mtu2_0_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_0_resources),
+};
+
+static struct sh_mtu2_config mtu2_1_platform_data = {
+	.name = "MTU2_1",
+	.channel_offset = -0x100,
+	.timer_bit = 1,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_1_resources[] = {
+	[0] = {
+		.name	= "MTU2_1",
+		.start	= 0xff801380,
+		.end	= 0xff801390,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 234,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_1_device = {
+	.name		= "sh_mtu2",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &mtu2_1_platform_data,
+	},
+	.resource	= mtu2_1_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_1_resources),
+};
+
+static struct sh_mtu2_config mtu2_2_platform_data = {
+	.name = "MTU2_2",
+	.channel_offset = 0x80,
+	.timer_bit = 2,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_2_resources[] = {
+	[0] = {
+		.name	= "MTU2_2",
+		.start	= 0xff801000,
+		.end	= 0xff80100a,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 240,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_2_device = {
+	.name		= "sh_mtu2",
+	.id		= 2,
+	.dev = {
+		.platform_data	= &mtu2_2_platform_data,
+	},
+	.resource	= mtu2_2_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_2_resources),
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xff804000,
@@ -134,6 +228,9 @@ static struct platform_device sci_device
 
 static struct platform_device *mxg_devices[] __initdata = {
 	&sci_device,
+	&mtu2_0_device,
+	&mtu2_1_device,
+	&mtu2_2_device,
 };
 
 static int __init mxg_devices_setup(void)
@@ -147,3 +244,15 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+static struct platform_device *mxg_early_devices[] __initdata = {
+	&mtu2_0_device,
+	&mtu2_1_device,
+	&mtu2_2_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(mxg_early_devices,
+				   ARRAY_SIZE(mxg_early_devices));
+}
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7201.c	2009-04-30 13:11:19.000000000 +0900
@@ -12,6 +12,8 @@
 #include <linux/init.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_mtu2.h>
+#include <linux/io.h>
 
 enum {
 	UNUSED = 0,
@@ -249,9 +251,105 @@ static struct platform_device rtc_device
 	.resource	= rtc_resources,
 };
 
+static struct sh_mtu2_config mtu2_0_platform_data = {
+	.name = "MTU2_0",
+	.channel_offset = -0x80,
+	.timer_bit = 0,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_0_resources[] = {
+	[0] = {
+		.name	= "MTU2_0",
+		.start	= 0xfffe4300,
+		.end	= 0xfffe4326,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 108,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_0_device = {
+	.name		= "sh_mtu2",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &mtu2_0_platform_data,
+	},
+	.resource	= mtu2_0_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_0_resources),
+};
+
+static struct sh_mtu2_config mtu2_1_platform_data = {
+	.name = "MTU2_1",
+	.channel_offset = -0x100,
+	.timer_bit = 1,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_1_resources[] = {
+	[0] = {
+		.name	= "MTU2_1",
+		.start	= 0xfffe4380,
+		.end	= 0xfffe4390,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 116,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_1_device = {
+	.name		= "sh_mtu2",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &mtu2_1_platform_data,
+	},
+	.resource	= mtu2_1_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_1_resources),
+};
+
+static struct sh_mtu2_config mtu2_2_platform_data = {
+	.name = "MTU2_2",
+	.channel_offset = 0x80,
+	.timer_bit = 2,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_2_resources[] = {
+	[0] = {
+		.name	= "MTU2_2",
+		.start	= 0xfffe4000,
+		.end	= 0xfffe400a,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 124,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_2_device = {
+	.name		= "sh_mtu2",
+	.id		= 2,
+	.dev = {
+		.platform_data	= &mtu2_2_platform_data,
+	},
+	.resource	= mtu2_2_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_2_resources),
+};
+
 static struct platform_device *sh7201_devices[] __initdata = {
 	&sci_device,
 	&rtc_device,
+	&mtu2_0_device,
+	&mtu2_1_device,
+	&mtu2_2_device,
 };
 
 static int __init sh7201_devices_setup(void)
@@ -265,3 +363,20 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+static struct platform_device *sh7201_early_devices[] __initdata = {
+	&mtu2_0_device,
+	&mtu2_1_device,
+	&mtu2_2_device,
+};
+
+#define STBCR3 0xfffe0408
+
+void __init plat_early_device_setup(void)
+{
+	/* enable MTU2 clock */
+	ctrl_outb(ctrl_inb(STBCR3) & ~0x20, STBCR3);
+
+	early_platform_add_devices(sh7201_early_devices,
+				   ARRAY_SIZE(sh7201_early_devices));
+}
--- 0006/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7203.c	2009-04-30 13:11:19.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_cmt.h>
+#include <linux/sh_mtu2.h>
 #include <linux/io.h>
 
 enum {
@@ -271,6 +272,68 @@ static struct platform_device cmt1_devic
 	.num_resources	= ARRAY_SIZE(cmt1_resources),
 };
 
+static struct sh_mtu2_config mtu2_0_platform_data = {
+	.name = "MTU2_0",
+	.channel_offset = -0x80,
+	.timer_bit = 0,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_0_resources[] = {
+	[0] = {
+		.name	= "MTU2_0",
+		.start	= 0xfffe4300,
+		.end	= 0xfffe4326,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 146,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_0_device = {
+	.name		= "sh_mtu2",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &mtu2_0_platform_data,
+	},
+	.resource	= mtu2_0_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_0_resources),
+};
+
+static struct sh_mtu2_config mtu2_1_platform_data = {
+	.name = "MTU2_1",
+	.channel_offset = -0x100,
+	.timer_bit = 1,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_1_resources[] = {
+	[0] = {
+		.name	= "MTU2_1",
+		.start	= 0xfffe4380,
+		.end	= 0xfffe4390,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 153,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_1_device = {
+	.name		= "sh_mtu2",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &mtu2_1_platform_data,
+	},
+	.resource	= mtu2_1_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_1_resources),
+};
+
 static struct resource rtc_resources[] = {
 	[0] = {
 		.start	= 0xffff2000,
@@ -295,6 +358,8 @@ static struct platform_device *sh7203_de
 	&sci_device,
 	&cmt0_device,
 	&cmt1_device,
+	&mtu2_0_device,
+	&mtu2_1_device,
 	&rtc_device,
 };
 
@@ -313,8 +378,11 @@ void __init plat_irq_setup(void)
 static struct platform_device *sh7203_early_devices[] __initdata = {
 	&cmt0_device,
 	&cmt1_device,
+	&mtu2_0_device,
+	&mtu2_1_device,
 };
 
+#define STBCR3 0xfffe0408
 #define STBCR4 0xfffe040c
 
 void __init plat_early_device_setup(void)
@@ -322,6 +390,9 @@ void __init plat_early_device_setup(void
 	/* enable CMT clock */
 	ctrl_outb(ctrl_inb(STBCR4) & ~0x04, STBCR4);
 
+	/* enable MTU2 clock */
+	ctrl_outb(ctrl_inb(STBCR3) & ~0x20, STBCR3);
+
 	early_platform_add_devices(sh7203_early_devices,
 				   ARRAY_SIZE(sh7203_early_devices));
 }
--- 0006/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7206.c	2009-04-30 13:11:19.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_cmt.h>
+#include <linux/sh_mtu2.h>
 #include <linux/io.h>
 
 enum {
@@ -231,10 +232,106 @@ static struct platform_device cmt1_devic
 	.num_resources	= ARRAY_SIZE(cmt1_resources),
 };
 
+static struct sh_mtu2_config mtu2_0_platform_data = {
+	.name = "MTU2_0",
+	.channel_offset = -0x80,
+	.timer_bit = 0,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_0_resources[] = {
+	[0] = {
+		.name	= "MTU2_0",
+		.start	= 0xfffe4300,
+		.end	= 0xfffe4326,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 156,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_0_device = {
+	.name		= "sh_mtu2",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &mtu2_0_platform_data,
+	},
+	.resource	= mtu2_0_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_0_resources),
+};
+
+static struct sh_mtu2_config mtu2_1_platform_data = {
+	.name = "MTU2_1",
+	.channel_offset = -0x100,
+	.timer_bit = 1,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_1_resources[] = {
+	[0] = {
+		.name	= "MTU2_1",
+		.start	= 0xfffe4380,
+		.end	= 0xfffe4390,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 164,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_1_device = {
+	.name		= "sh_mtu2",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &mtu2_1_platform_data,
+	},
+	.resource	= mtu2_1_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_1_resources),
+};
+
+static struct sh_mtu2_config mtu2_2_platform_data = {
+	.name = "MTU2_2",
+	.channel_offset = 0x80,
+	.timer_bit = 2,
+	.clk = "module_clk",
+	.clockevent_rating = 200,
+};
+
+static struct resource mtu2_2_resources[] = {
+	[0] = {
+		.name	= "MTU2_2",
+		.start	= 0xfffe4000,
+		.end	= 0xfffe400a,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 180,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mtu2_2_device = {
+	.name		= "sh_mtu2",
+	.id		= 2,
+	.dev = {
+		.platform_data	= &mtu2_2_platform_data,
+	},
+	.resource	= mtu2_2_resources,
+	.num_resources	= ARRAY_SIZE(mtu2_2_resources),
+};
+
 static struct platform_device *sh7206_devices[] __initdata = {
 	&sci_device,
 	&cmt0_device,
 	&cmt1_device,
+	&mtu2_0_device,
+	&mtu2_1_device,
+	&mtu2_2_device,
 };
 
 static int __init sh7206_devices_setup(void)
@@ -252,8 +349,12 @@ void __init plat_irq_setup(void)
 static struct platform_device *sh7206_early_devices[] __initdata = {
 	&cmt0_device,
 	&cmt1_device,
+	&mtu2_0_device,
+	&mtu2_1_device,
+	&mtu2_2_device,
 };
 
+#define STBCR3 0xfffe0408
 #define STBCR4 0xfffe040c
 
 void __init plat_early_device_setup(void)
@@ -261,6 +362,9 @@ void __init plat_early_device_setup(void
 	/* enable CMT clock */
 	ctrl_outb(ctrl_inb(STBCR4) & ~0x04, STBCR4);
 
+	/* enable MTU2 clock */
+	ctrl_outb(ctrl_inb(STBCR3) & ~0x20, STBCR3);
+
 	early_platform_add_devices(sh7206_early_devices,
 				   ARRAY_SIZE(sh7206_early_devices));
 }
