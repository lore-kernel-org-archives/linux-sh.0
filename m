From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:15:03 +0000
Subject: [PATCH 011/013] sh-sci: convert sh3 cpus to single port devices
Message-Id: <20090121151503.29269.174.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Rework sh-sci platform data for sh3 processors such as:
 sh770x, sh7705, sh7710 and sh7720

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh3/setup-sh7705.c |   43 +++++++++++--------
 arch/sh/kernel/cpu/sh3/setup-sh770x.c |   72 +++++++++++++++++++++------------
 arch/sh/kernel/cpu/sh3/setup-sh7710.c |   42 +++++++++++--------
 arch/sh/kernel/cpu/sh3/setup-sh7720.c |   42 +++++++++++--------
 4 files changed, 120 insertions(+), 79 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7705.c	2009-01-21 22:33:15.000000000 +0900
@@ -81,27 +81,33 @@ static struct intc_prio_reg prio_registe
 static DECLARE_INTC_DESC(intc_desc, "sh7705", vectors, groups,
 			 NULL, prio_registers, NULL);
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xa4410000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 56, 57, 59 },
-	}, {
-		.mapbase	= 0xa4400000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 52, 53, 55 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xa4410000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 56, 57, 59 },
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
+	.irqs		= { 52, 53, 55 },
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
 
@@ -140,7 +146,8 @@ static struct platform_device rtc_device
 };
 
 static struct platform_device *sh7705_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
 	&rtc_device,
 };
 
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh770x.c	2009-01-21 22:31:46.000000000 +0900
@@ -131,47 +131,69 @@ static struct platform_device rtc_device
 	.resource	= rtc_resources,
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xfffffe80,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCI,
-		.irqs		= { 23, 24, 25, 0 },
+static struct plat_sci_port sci0_platform_data = {
+	.mapbase	= 0xfffffe80,
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
 	},
+};
+
 #if defined(CONFIG_CPU_SUBTYPE_SH7706) || \
     defined(CONFIG_CPU_SUBTYPE_SH7707) || \
     defined(CONFIG_CPU_SUBTYPE_SH7709)
-	{
-		.mapbase	= 0xa4000150,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 56, 57, 59, 58 },
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xa4000150,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 56, 57, 59, 58 },
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
 	},
+};
 #endif
+
 #if defined(CONFIG_CPU_SUBTYPE_SH7707) || \
     defined(CONFIG_CPU_SUBTYPE_SH7709)
-	{
-		.mapbase	= 0xa4000140,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_IRDA,
-		.irqs		= { 52, 53, 55, 54 },
-	},
-#endif
-	{
-		.flags = 0,
-	}
+static struct plat_sci_port irda0_platform_data = {
+	.mapbase	= 0xa4000140,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_IRDA,
+	.irqs		= { 52, 53, 55, 54 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device irda0_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 2,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &irda0_platform_data,
 	},
 };
+#endif
 
 static struct platform_device *sh770x_devices[] __initdata = {
-	&sci_device,
+	&sci0_device,
+#if defined(CONFIG_CPU_SUBTYPE_SH7706) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7707) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7709)
+	&scif0_device,
+#endif
+#if defined(CONFIG_CPU_SUBTYPE_SH7707) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7709)
+	&irda0_device,
+#endif
 	&rtc_device,
 };
 
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7710.c	2009-01-21 22:35:11.000000000 +0900
@@ -122,33 +122,39 @@ static struct platform_device rtc_device
 	},
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xa4400000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 52, 53, 55, 54 },
-	}, {
-		.mapbase	= 0xa4410000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs           = { 56, 57, 59, 58 },
-	}, {
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xa4400000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 52, 53, 55, 54 },
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
+	.irqs           = { 56, 57, 59, 58 },
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
 
 static struct platform_device *sh7710_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
 	&rtc_device,
 };
 
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7720.c	2009-01-21 22:35:56.000000000 +0900
@@ -56,28 +56,33 @@ static struct platform_device rtc_device
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
 
@@ -134,7 +139,8 @@ static struct platform_device usbf_devic
 
 static struct platform_device *sh7720_devices[] __initdata = {
 	&rtc_device,
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
 	&usb_ohci_device,
 	&usbf_device,
 };
