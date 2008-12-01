From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 01 Dec 2008 10:33:28 +0000
Subject: [PATCH 07/10] sh: enable CMT on sh7723/sh7722/sh7366/sh7343
Message-Id: <20081201103328.26620.16791.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add CMT and TMU devices and use the new timer code V3 on
SuperH Mobile processors such as sh7723/sh7722/sh7343/sh7366.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    4 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   39 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   39 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   39 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   39 ++++++++++++++++++++++++++++++++
 5 files changed, 160 insertions(+)

--- 0008/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-12-01 15:04:41.000000000 +0900
@@ -316,6 +316,7 @@ config CPU_SUBTYPE_SH7723
 	select CPU_SH4A
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
+	select SH_TIMER
 	help
 	  Select SH7723 if you have an SH-MobileR2 CPU.
 
@@ -354,6 +355,7 @@ config CPU_SUBTYPE_SHX3
 config CPU_SUBTYPE_SH7343
 	bool "Support SH7343 processor"
 	select CPU_SH4AL_DSP
+	select SH_TIMER
 
 config CPU_SUBTYPE_SH7722
 	bool "Support SH7722 processor"
@@ -361,6 +363,7 @@ config CPU_SUBTYPE_SH7722
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
+	select SH_TIMER
 
 config CPU_SUBTYPE_SH7366
 	bool "Support SH7366 processor"
@@ -368,6 +371,7 @@ config CPU_SUBTYPE_SH7366
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
+	select SH_TIMER
 
 # SH-5 Processor Support
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-12-01 15:05:16.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_timer.h>
 #include <asm/clock.h>
 
 static struct resource iic0_resources[] = {
@@ -112,6 +113,38 @@ static struct platform_device veu_device
 	.num_resources	= ARRAY_SIZE(veu_resources),
 };
 
+static struct sh_timer_config cmt_platform_data = {
+	.name = "CMT",
+	.channel_offset = 0x60,
+	.timer_bit = 5,
+	.clk = "cmt0",
+	.clockevent_rating = 125,
+	.clocksource_rating = 200,
+};
+
+static struct resource cmt_resources[] = {
+	[0] = {
+		.name	= "CMT",
+		.start	= 0x044a0060,
+		.end	= 0x044a006b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 104,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt_device = {
+	.name		= "sh_cmt",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &cmt_platform_data,
+	},
+	.resource	= cmt_resources,
+	.num_resources	= ARRAY_SIZE(cmt_resources),
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xffe00000,
@@ -137,6 +170,7 @@ static struct platform_device *sh7343_de
 	&sci_device,
 	&vpu_device,
 	&veu_device,
+	&cmt_device,
 };
 
 static int __init sh7343_devices_setup(void)
@@ -292,3 +326,8 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+void __init plat_timer_setup(void)
+{
+	sh_timer_register(sh7343_devices, ARRAY_SIZE(sh7343_devices));
+}
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2008-12-01 15:04:41.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_timer.h>
 #include <asm/clock.h>
 
 static struct resource iic_resources[] = {
@@ -147,6 +148,38 @@ static struct platform_device veu1_devic
 	.num_resources	= ARRAY_SIZE(veu1_resources),
 };
 
+static struct sh_timer_config cmt_platform_data = {
+	.name = "CMT",
+	.channel_offset = 0x60,
+	.timer_bit = 5,
+	.clk = "cmt0",
+	.clockevent_rating = 125,
+	.clocksource_rating = 200,
+};
+
+static struct resource cmt_resources[] = {
+	[0] = {
+		.name	= "CMT",
+		.start	= 0x044a0060,
+		.end	= 0x044a006b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 104,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt_device = {
+	.name		= "sh_cmt",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &cmt_platform_data,
+	},
+	.resource	= cmt_resources,
+	.num_resources	= ARRAY_SIZE(cmt_resources),
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xffe00000,
@@ -173,6 +206,7 @@ static struct platform_device *sh7366_de
 	&vpu_device,
 	&veu0_device,
 	&veu1_device,
+	&cmt_device,
 };
 
 static int __init sh7366_devices_setup(void)
@@ -325,6 +359,11 @@ void __init plat_irq_setup(void)
 	register_intc_controller(&intc_desc);
 }
 
+void __init plat_timer_setup(void)
+{
+	sh_timer_register(sh7366_devices, ARRAY_SIZE(sh7366_devices));
+}
+
 void __init plat_mem_setup(void)
 {
 	/* TODO: Register Node 1 */
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-12-01 15:04:41.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/serial_sci.h>
 #include <linux/mm.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_timer.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 
@@ -148,6 +149,38 @@ static struct platform_device veu_device
 	.num_resources	= ARRAY_SIZE(veu_resources),
 };
 
+static struct sh_timer_config cmt_platform_data = {
+	.name = "CMT",
+	.channel_offset = 0x60,
+	.timer_bit = 5,
+	.clk = "cmt0",
+	.clockevent_rating = 125,
+	.clocksource_rating = 200,
+};
+
+static struct resource cmt_resources[] = {
+	[0] = {
+		.name	= "CMT",
+		.start	= 0x044a0060,
+		.end	= 0x044a006b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 104,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt_device = {
+	.name		= "sh_cmt",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &cmt_platform_data,
+	},
+	.resource	= cmt_resources,
+	.num_resources	= ARRAY_SIZE(cmt_resources),
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase	= 0xffe00000,
@@ -187,6 +220,7 @@ static struct platform_device *sh7722_de
 	&sci_device,
 	&vpu_device,
 	&veu_device,
+	&cmt_device,
 };
 
 static int __init sh7722_devices_setup(void)
@@ -343,6 +377,11 @@ void __init plat_irq_setup(void)
 	register_intc_controller(&intc_desc);
 }
 
+void __init plat_timer_setup(void)
+{
+	sh_timer_register(sh7722_devices, ARRAY_SIZE(sh7722_devices));
+}
+
 void __init plat_mem_setup(void)
 {
 	/* Register the URAM space as Node 1 */
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-12-01 15:04:59.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_timer.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 
@@ -100,6 +101,38 @@ static struct platform_device veu1_devic
 	.num_resources	= ARRAY_SIZE(veu1_resources),
 };
 
+static struct sh_timer_config cmt_platform_data = {
+	.name = "CMT",
+	.channel_offset = 0x60,
+	.timer_bit = 5,
+	.clk = "cmt0",
+	.clockevent_rating = 125,
+	.clocksource_rating = 200,
+};
+
+static struct resource cmt_resources[] = {
+	[0] = {
+		.name	= "CMT",
+		.start	= 0x044a0060,
+		.end	= 0x044a006b,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 104,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device cmt_device = {
+	.name		= "sh_cmt",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &cmt_platform_data,
+	},
+	.resource	= cmt_resources,
+	.num_resources	= ARRAY_SIZE(cmt_resources),
+};
+
 static struct plat_sci_port sci_platform_data[] = {
 	{
 		.mapbase        = 0xffe00000,
@@ -228,6 +261,7 @@ static struct platform_device *sh7723_de
 	&vpu_device,
 	&veu0_device,
 	&veu1_device,
+	&cmt_device,
 };
 
 static int __init sh7723_devices_setup(void)
@@ -460,3 +494,8 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+void __init plat_timer_setup(void)
+{
+	sh_timer_register(sh7723_devices, ARRAY_SIZE(sh7723_devices));
+}
