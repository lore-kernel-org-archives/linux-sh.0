From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Dec 2009 12:30:05 +0000
Subject: [PATCH 03/07] sh: sh3 scif pdata (sh7705/sh770x/sh7710/sh7720)
Message-Id: <20091214123005.10707.19076.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch breaks out the sh3 scif serial port platform
data from a shared platform device to one platform
device per port. Also, add serial ports to the list of
early platform devices.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh3/setup-sh7705.c |   45 +++++++++++-------
 arch/sh/kernel/cpu/sh3/setup-sh770x.c |   80 ++++++++++++++++++++++-----------
 arch/sh/kernel/cpu/sh3/setup-sh7710.c |   44 ++++++++++--------
 arch/sh/kernel/cpu/sh3/setup-sh7720.c |   44 ++++++++++--------
 4 files changed, 134 insertions(+), 79 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7705.c	2009-12-14 20:21:45.000000000 +0900
@@ -67,27 +67,33 @@ static struct intc_prio_reg prio_registe
 static DECLARE_INTC_DESC(intc_desc, "sh7705", vectors, NULL,
 			 NULL, prio_registers, NULL);
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xa4410000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 56, 56, 56 },
-	}, {
-		.mapbase	= 0xa4400000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 52, 52, 52 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xa4410000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 56, 56, 56 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif0_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xa4400000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 52, 52, 52 },
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif1_platform_data,
 	},
 };
 
@@ -210,10 +216,11 @@ static struct platform_device tmu2_devic
 };
 
 static struct platform_device *sh7705_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
-	&sci_device,
 	&rtc_device,
 };
 
@@ -225,6 +232,8 @@ static int __init sh7705_devices_setup(v
 arch_initcall(sh7705_devices_setup);
 
 static struct platform_device *sh7705_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh770x.c	2009-12-14 20:23:49.000000000 +0900
@@ -106,44 +106,55 @@ static struct platform_device rtc_device
 	.resource	= rtc_resources,
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xfffffe80,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCI,
-		.irqs		= { 23, 23, 23, 0 },
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xfffffe80,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCI,
+	.irqs		= { 23, 23, 23, 0 },
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
 	},
+};
 #if defined(CONFIG_CPU_SUBTYPE_SH7706) || \
     defined(CONFIG_CPU_SUBTYPE_SH7707) || \
     defined(CONFIG_CPU_SUBTYPE_SH7709)
-	{
-		.mapbase	= 0xa4000150,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 56, 56, 56, 56 },
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xa4000150,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 56, 56, 56, 56 },
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &scif1_platform_data,
 	},
+};
 #endif
 #if defined(CONFIG_CPU_SUBTYPE_SH7707) || \
     defined(CONFIG_CPU_SUBTYPE_SH7709)
-	{
-		.mapbase	= 0xa4000140,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_IRDA,
-		.irqs		= { 52, 52, 52, 52 },
-	},
-#endif
-	{
-		.flags = 0,
-	}
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xa4000140,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_IRDA,
+	.irqs		= { 52, 52, 52, 52 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif2_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 2,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif2_platform_data,
 	},
 };
+#endif
 
 static struct sh_timer_config tmu0_platform_data = {
 	.name = "TMU0",
@@ -238,10 +249,19 @@ static struct platform_device tmu2_devic
 };
 
 static struct platform_device *sh770x_devices[] __initdata = {
+	&scif0_device,
+#if defined(CONFIG_CPU_SUBTYPE_SH7706) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7707) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7709)
+	&scif1_device,
+#endif
+#if defined(CONFIG_CPU_SUBTYPE_SH7707) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7709)
+	&scif2_device,
+#endif
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
-	&sci_device,
 	&rtc_device,
 };
 
@@ -253,6 +273,16 @@ static int __init sh770x_devices_setup(v
 arch_initcall(sh770x_devices_setup);
 
 static struct platform_device *sh770x_early_devices[] __initdata = {
+	&scif0_device,
+#if defined(CONFIG_CPU_SUBTYPE_SH7706) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7707) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7709)
+	&scif1_device,
+#endif
+#if defined(CONFIG_CPU_SUBTYPE_SH7707) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7709)
+	&scif2_device,
+#endif
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7710.c	2009-12-14 20:29:51.000000000 +0900
@@ -96,28 +96,33 @@ static struct platform_device rtc_device
 	},
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xa4400000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 52, 52, 52, 52 },
-	}, {
-		.mapbase	= 0xa4410000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs           = { 56, 56, 56, 56 },
-	}, {
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xa4400000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 52, 52, 52, 52 },
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
+};
 
-		.flags = 0,
-	}
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xa4410000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs           = { 56, 56, 56, 56 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif1_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 1,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif1_platform_data,
 	},
 };
 
@@ -214,10 +219,11 @@ static struct platform_device tmu2_devic
 };
 
 static struct platform_device *sh7710_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
-	&sci_device,
 	&rtc_device,
 };
 
@@ -229,6 +235,8 @@ static int __init sh7710_devices_setup(v
 arch_initcall(sh7710_devices_setup);
 
 static struct platform_device *sh7710_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7720.c	2009-12-14 20:31:37.000000000 +0900
@@ -48,28 +48,33 @@ static struct platform_device rtc_device
 	},
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xa4430000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 80, 80, 80, 80 },
-	}, {
-		.mapbase	= 0xa4438000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs           = { 81, 81, 81, 81 },
-	}, {
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xa4430000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 80, 80, 80, 80 },
+};
 
-		.flags = 0,
-	}
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
 };
 
-static struct platform_device sci_device = {
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xa4438000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs           = { 81, 81, 81, 81 },
+};
+
+static struct platform_device scif1_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 1,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif1_platform_data,
 	},
 };
 
@@ -369,6 +374,8 @@ static struct platform_device tmu2_devic
 };
 
 static struct platform_device *sh7720_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
 	&cmt0_device,
 	&cmt1_device,
 	&cmt2_device,
@@ -378,7 +385,6 @@ static struct platform_device *sh7720_de
 	&tmu1_device,
 	&tmu2_device,
 	&rtc_device,
-	&sci_device,
 	&usb_ohci_device,
 	&usbf_device,
 };
@@ -391,6 +397,8 @@ static int __init sh7720_devices_setup(v
 arch_initcall(sh7720_devices_setup);
 
 static struct platform_device *sh7720_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
 	&cmt0_device,
 	&cmt1_device,
 	&cmt2_device,
