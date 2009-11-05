From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Nov 2009 14:35:29 +0000
Subject: [PATCH 04/05] sh: Break out SH7724 serial ports
Message-Id: <20091105143529.9902.8190.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Break out the sh7724 serial ports into individual platform
devices and add them to the early device list.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  145 ++++++++++++++++++++++----------
 1 file changed, 101 insertions(+), 44 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2009-11-05 22:43:18.000000000 +0900
@@ -27,53 +27,99 @@
 #include <cpu/sh7724.h>
 
 /* Serial */
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase        = 0xffe00000,
-		.flags          = UPF_BOOT_AUTOCONF,
-		.type           = PORT_SCIF,
-		.irqs           = { 80, 80, 80, 80 },
-		.clk		= "scif0",
-	}, {
-		.mapbase        = 0xffe10000,
-		.flags          = UPF_BOOT_AUTOCONF,
-		.type           = PORT_SCIF,
-		.irqs           = { 81, 81, 81, 81 },
-		.clk		= "scif1",
-	}, {
-		.mapbase        = 0xffe20000,
-		.flags          = UPF_BOOT_AUTOCONF,
-		.type           = PORT_SCIF,
-		.irqs           = { 82, 82, 82, 82 },
-		.clk		= "scif2",
-	}, {
-		.mapbase	= 0xa4e30000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIFA,
-		.irqs		= { 56, 56, 56, 56 },
-		.clk		= "scif3",
-	}, {
-		.mapbase	= 0xa4e40000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIFA,
-		.irqs		= { 88, 88, 88, 88 },
-		.clk		= "scif4",
-	}, {
-		.mapbase	= 0xa4e50000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIFA,
-		.irqs		= { 109, 109, 109, 109 },
-		.clk		= "scif5",
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase        = 0xffe00000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.type           = PORT_SCIF,
+	.irqs           = { 80, 80, 80, 80 },
+	.clk		= "scif0",
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
+	.mapbase        = 0xffe10000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.type           = PORT_SCIF,
+	.irqs           = { 81, 81, 81, 81 },
+	.clk		= "scif1",
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
+	.mapbase        = 0xffe20000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.type           = PORT_SCIF,
+	.irqs           = { 82, 82, 82, 82 },
+	.clk		= "scif2",
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
+	.mapbase        = 0xa4e30000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.type           = PORT_SCIFA,
+	.irqs           = { 56, 56, 56, 56 },
+	.clk		= "scif3",
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
+	.mapbase        = 0xa4e40000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.type           = PORT_SCIFA,
+	.irqs           = { 88, 88, 88, 88 },
+	.clk		= "scif4",
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
+	.mapbase        = 0xa4e50000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.type           = PORT_SCIFA,
+	.irqs           = { 109, 109, 109, 109 },
+	.clk		= "scif5",
+};
+
+static struct platform_device scif5_device = {
+	.name		= "sh-sci",
+	.id		= 5,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif5_platform_data,
 	},
 };
 
@@ -597,7 +643,12 @@ static struct platform_device *sh7724_de
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 	&rtc_device,
 	&iic0_device,
 	&iic1_device,
@@ -631,6 +682,12 @@ static struct platform_device *sh7724_ea
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 };
 
 void __init plat_early_device_setup(void)
