From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:15:12 +0000
Subject: [PATCH 012/013] sh-sci: convert sh4 cpus to single port devices
Message-Id: <20090121151512.29269.85170.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Rework sh-sci platform data for sh4 processors such as:
 sh775x, sh776x, sh4-202

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |   22 +++-----
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |   51 ++++++++++++-------
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |   84 +++++++++++++++++++++-----------
 3 files changed, 97 insertions(+), 60 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh4-202.c	2009-01-21 22:11:39.000000000 +0900
@@ -12,27 +12,23 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe80000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 41, 43, 42 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe80000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 41, 43, 42 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif0_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 0,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif0_platform_data,
 	},
 };
 
 static struct platform_device *sh4202_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
 };
 
 static int __init sh4202_devices_setup(void)
--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7750.c	2009-01-21 22:08:36.000000000 +0900
@@ -44,35 +44,48 @@ static struct platform_device rtc_device
 	.resource	= rtc_resources,
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
 #ifndef CONFIG_SH_RTS7751R2D
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCI,
-		.irqs		= { 23, 24, 25, 0 },
-	}, {
-#endif
-		.mapbase	= 0xffe80000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 41, 43, 42 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port sci0_platform_data = {
+	.mapbase	= 0xffe00000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCI,
+	.irqs		= { 23, 24, 25, 0 },
+};
+
+static struct platform_device sci0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &sci0_platform_data,
+	},
+};
+#endif
+
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe80000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 41, 43, 42 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif0_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+#ifdef CONFIG_SH_RTS7751R2D
+	.id		= 0,
+#else
+	.id		= 1,
+#endif
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif0_platform_data,
 	},
 };
 
 static struct platform_device *sh7750_devices[] __initdata = {
 	&rtc_device,
-	&sci_device,
+#ifndef CONFIG_SH_RTS7751R2D
+	&sci0_device,
+#endif
+	&scif0_device,
 };
 
 static int __init sh7750_devices_setup(void)
--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7760.c	2009-01-21 22:10:33.000000000 +0900
@@ -134,42 +134,70 @@ static struct intc_vect vectors_irq[] __
 static DECLARE_INTC_DESC(intc_desc_irq, "sh7760-irq", vectors_irq, groups,
 			 mask_registers, prio_registers, NULL);
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xfe600000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 52, 53, 55, 54 },
-	}, {
-		.mapbase	= 0xfe610000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 72, 73, 75, 74 },
-	}, {
-		.mapbase	= 0xfe620000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 76, 77, 79, 78 },
-	}, {
-		.mapbase	= 0xfe480000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCI,
-		.irqs		= { 80, 81, 82, 0 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xfe600000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 52, 53, 55, 54 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif0_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 0,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif0_platform_data,
 	},
 };
 
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xfe610000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 72, 73, 75, 74 },
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &scif1_platform_data,
+	},
+};
+
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xfe620000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 76, 77, 79, 78 },
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
+	.dev		= {
+		.platform_data	= &scif2_platform_data,
+	},
+};
+
+static struct plat_sci_port sci0_platform_data = {
+	.mapbase	= 0xfe480000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCI,
+	.irqs		= { 80, 81, 82, 0 },
+};
+
+static struct platform_device sci0_device = {
+	.name		= "sh-sci",
+	.id		= 3,
+	.dev		= {
+		.platform_data	= &sci0_platform_data,
+	},
+};
 static struct platform_device *sh7760_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&sci0_device,
 };
 
 static int __init sh7760_devices_setup(void)
