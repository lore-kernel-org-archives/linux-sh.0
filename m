From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 11 Dec 2008 12:53:05 +0000
Subject: [PATCH 03/03] sh: enable CMT on sh7723/sh7722/sh7366/sh7343
Message-Id: <20081211125305.19369.65221.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

CMT platform data V5 for SuperH Mobile sh7723/sh7722/sh7343/sh7366.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig                        |    4 +++
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   40 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   40 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   40 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   40 ++++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+)

--- 0010/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-12-11 17:06:13.000000000 +0900
@@ -322,6 +322,7 @@ config CPU_SUBTYPE_SH7723
 	select CPU_SH4A
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
+	select SH_TIMER
 	help
 	  Select SH7723 if you have an SH-MobileR2 CPU.
 
@@ -360,6 +361,7 @@ config CPU_SUBTYPE_SHX3
 config CPU_SUBTYPE_SH7343
 	bool "Support SH7343 processor"
 	select CPU_SH4AL_DSP
+	select SH_TIMER
 
 config CPU_SUBTYPE_SH7722
 	bool "Support SH7722 processor"
@@ -367,6 +369,7 @@ config CPU_SUBTYPE_SH7722
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
+	select SH_TIMER
 
 config CPU_SUBTYPE_SH7366
 	bool "Support SH7366 processor"
@@ -374,6 +377,7 @@ config CPU_SUBTYPE_SH7366
 	select CPU_SHX2
 	select ARCH_SPARSEMEM_ENABLE
 	select SYS_SUPPORTS_NUMA
+	select SH_TIMER
 
 # SH-5 Processor Support
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-12-11 17:08:16.000000000 +0900
@@ -12,6 +12,8 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_cmt.h>
+#include <asm/timer.h>
 #include <asm/clock.h>
 
 static struct resource iic0_resources[] = {
@@ -112,6 +114,38 @@ static struct platform_device veu_device
 	.num_resources	= ARRAY_SIZE(veu_resources),
 };
 
+static struct sh_cmt_config cmt_platform_data = {
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
@@ -152,6 +186,7 @@ static struct platform_device *sh7343_de
 	&sci_device,
 	&vpu_device,
 	&veu_device,
+	&cmt_device,
 };
 
 static int __init sh7343_devices_setup(void)
@@ -307,3 +342,8 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+void __init plat_timer_setup(void)
+{
+	sh_timer_register(sh7343_devices, ARRAY_SIZE(sh7343_devices));
+}
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2008-12-11 17:08:06.000000000 +0900
@@ -14,6 +14,8 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_cmt.h>
+#include <asm/timer.h>
 #include <asm/clock.h>
 
 static struct resource iic_resources[] = {
@@ -147,6 +149,38 @@ static struct platform_device veu1_devic
 	.num_resources	= ARRAY_SIZE(veu1_resources),
 };
 
+static struct sh_cmt_config cmt_platform_data = {
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
@@ -173,6 +207,7 @@ static struct platform_device *sh7366_de
 	&vpu_device,
 	&veu0_device,
 	&veu1_device,
+	&cmt_device,
 };
 
 static int __init sh7366_devices_setup(void)
@@ -325,6 +360,11 @@ void __init plat_irq_setup(void)
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
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-12-11 17:06:26.000000000 +0900
@@ -13,6 +13,8 @@
 #include <linux/serial_sci.h>
 #include <linux/mm.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_cmt.h>
+#include <asm/timer.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 
@@ -148,6 +150,38 @@ static struct platform_device veu_device
 	.num_resources	= ARRAY_SIZE(veu_resources),
 };
 
+static struct sh_cmt_config cmt_platform_data = {
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
@@ -187,6 +221,7 @@ static struct platform_device *sh7722_de
 	&sci_device,
 	&vpu_device,
 	&veu_device,
+	&cmt_device,
 };
 
 static int __init sh7722_devices_setup(void)
@@ -343,6 +378,11 @@ void __init plat_irq_setup(void)
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
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-12-11 17:08:27.000000000 +0900
@@ -13,6 +13,8 @@
 #include <linux/mm.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_cmt.h>
+#include <asm/timer.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 
@@ -100,6 +102,38 @@ static struct platform_device veu1_devic
 	.num_resources	= ARRAY_SIZE(veu1_resources),
 };
 
+static struct sh_cmt_config cmt_platform_data = {
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
@@ -228,6 +262,7 @@ static struct platform_device *sh7723_de
 	&vpu_device,
 	&veu0_device,
 	&veu1_device,
+	&cmt_device,
 };
 
 static int __init sh7723_devices_setup(void)
@@ -460,3 +495,8 @@ void __init plat_irq_setup(void)
 {
 	register_intc_controller(&intc_desc);
 }
+
+void __init plat_timer_setup(void)
+{
+	sh_timer_register(sh7723_devices, ARRAY_SIZE(sh7723_devices));
+}
