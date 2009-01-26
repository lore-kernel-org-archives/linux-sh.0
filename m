From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 26 Jan 2009 06:43:08 +0000
Subject: [PATCH] sh-sci: sh4a/sh7770 single port devices
Message-Id: <20090126064308.16809.9767.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Rework sh-sci platform data for the sh7770 processor.
Use one platform device per port.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Forgot sh7770 in the previous sh4a patch.

 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |  211 +++++++++++++++++++++++---------
 1 file changed, 153 insertions(+), 58 deletions(-)

--- 0026/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7770.c	2009-01-26 15:28:01.000000000 +0900
@@ -12,72 +12,167 @@
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xff923000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 61, 61, 61, 61 },
-	}, {
-		.mapbase	= 0xff924000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 62, 62, 62, 62 },
-	}, {
-		.mapbase	= 0xff925000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 63, 63, 63, 63 },
-	}, {
-		.mapbase	= 0xff926000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 64, 64, 64, 64 },
-	}, {
-		.mapbase	= 0xff927000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 65, 65, 65, 65 },
-	}, {
-		.mapbase	= 0xff928000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 66, 66, 66, 66 },
-	}, {
-		.mapbase	= 0xff929000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 67, 67, 67, 67 },
-	}, {
-		.mapbase	= 0xff92a000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 68, 68, 68, 68 },
-	}, {
-		.mapbase	= 0xff92b000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 69, 69, 69, 69 },
-	}, {
-		.mapbase	= 0xff92c000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 70, 70, 70, 70 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xff923000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 61, 61, 61, 61 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif0_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 0,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xff924000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 62, 62, 62, 62 },
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
+	.mapbase	= 0xff925000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 63, 63, 63, 63 },
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
+static struct plat_sci_port scif3_platform_data = {
+	.mapbase	= 0xff926000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 64, 64, 64, 64 },
+};
+
+static struct platform_device scif3_device = {
+	.name		= "sh-sci",
+	.id		= 3,
+	.dev		= {
+		.platform_data	= &scif3_platform_data,
+	},
+};
+
+static struct plat_sci_port scif4_platform_data = {
+	.mapbase	= 0xff927000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 65, 65, 65, 65 },
+};
+
+static struct platform_device scif4_device = {
+	.name		= "sh-sci",
+	.id		= 4,
+	.dev		= {
+		.platform_data	= &scif4_platform_data,
+	},
+};
+
+static struct plat_sci_port scif5_platform_data = {
+	.mapbase	= 0xff928000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 66, 66, 66, 66 },
+};
+
+static struct platform_device scif5_device = {
+	.name		= "sh-sci",
+	.id		= 5,
+	.dev		= {
+		.platform_data	= &scif5_platform_data,
+	},
+};
+
+static struct plat_sci_port scif6_platform_data = {
+	.mapbase	= 0xff929000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 67, 67, 67, 67 },
+};
+
+static struct platform_device scif6_device = {
+	.name		= "sh-sci",
+	.id		= 6,
+	.dev		= {
+		.platform_data	= &scif6_platform_data,
+	},
+};
+
+static struct plat_sci_port scif7_platform_data = {
+	.mapbase	= 0xff92a000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 68, 68, 68, 68 },
+};
+
+static struct platform_device scif7_device = {
+	.name		= "sh-sci",
+	.id		= 7,
+	.dev		= {
+		.platform_data	= &scif7_platform_data,
+	},
+};
+
+static struct plat_sci_port scif8_platform_data = {
+	.mapbase	= 0xff92b000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 69, 69, 69, 69 },
+};
+
+static struct platform_device scif8_device = {
+	.name		= "sh-sci",
+	.id		= 8,
+	.dev		= {
+		.platform_data	= &scif8_platform_data,
+	},
+};
+
+static struct plat_sci_port scif9_platform_data = {
+	.mapbase	= 0xff92c000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 70, 70, 70, 70 },
+};
+
+static struct platform_device scif9_device = {
+	.name		= "sh-sci",
+	.id		= 9,
+	.dev		= {
+		.platform_data	= &scif9_platform_data,
 	},
 };
 
 static struct platform_device *sh7770_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
+	&scif6_device,
+	&scif7_device,
+	&scif8_device,
+	&scif9_device,
 };
 
 static int __init sh7770_devices_setup(void)
