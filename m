From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Jan 2009 09:56:09 +0000
Subject: [PATCH 05/05] sh: CMT platform data for sh7723/sh7722/sh7366/sh7343
Message-Id: <20090122095609.31653.60597.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

CMT platform data for SuperH Mobile sh7723/sh7722/sh7343/sh7366.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   34 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   34 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   34 ++++++++++++++++++++++++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   34 ++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)

--- 0010/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2009-01-22 14:06:51.000000000 +0900
@@ -12,6 +12,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_cmt.h>
 #include <asm/clock.h>
 
 static struct resource iic0_resources[] = {
@@ -140,6 +141,38 @@ static struct platform_device jpu_device
 	.num_resources	= ARRAY_SIZE(jpu_resources),
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
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xffe00000,
 	.flags		= UPF_BOOT_AUTOCONF,
@@ -205,6 +238,7 @@ static struct platform_device scif3_devi
 };
 
 static struct platform_device *sh7343_devices[] __initdata = {
+	&cmt_device,
 	&iic0_device,
 	&iic1_device,
 	&scif0_device,
--- 0010/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2009-01-22 14:08:07.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_cmt.h>
 #include <asm/clock.h>
 
 static struct resource iic_resources[] = {
@@ -147,6 +148,38 @@ static struct platform_device veu1_devic
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
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xffe00000,
 	.flags		= UPF_BOOT_AUTOCONF,
@@ -164,6 +197,7 @@ static struct platform_device scif0_devi
 };
 
 static struct platform_device *sh7366_devices[] __initdata = {
+	&cmt_device,
 	&iic_device,
 	&scif0_device,
 	&usb_host_device,
--- 0010/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-01-22 14:09:07.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/serial_sci.h>
 #include <linux/mm.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_cmt.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 
@@ -176,6 +177,38 @@ static struct platform_device jpu_device
 	.num_resources	= ARRAY_SIZE(jpu_resources),
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
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xffe00000,
 	.flags		= UPF_BOOT_AUTOCONF,
@@ -225,6 +258,7 @@ static struct platform_device scif2_devi
 };
 
 static struct platform_device *sh7722_devices[] __initdata = {
+	&cmt_device,
 	&rtc_device,
 	&usbf_device,
 	&iic_device,
--- 0010/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2009-01-22 14:10:02.000000000 +0900
@@ -13,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
+#include <linux/sh_cmt.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 
@@ -100,6 +101,38 @@ static struct platform_device veu1_devic
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
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xffe00000,
 	.flags		= UPF_BOOT_AUTOCONF,
@@ -273,6 +306,7 @@ static struct platform_device iic_device
 };
 
 static struct platform_device *sh7723_devices[] __initdata = {
+	&cmt_device,
 	&scif0_device,
 	&scif1_device,
 	&scif2_device,
