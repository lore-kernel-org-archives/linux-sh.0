From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Dec 2009 12:30:22 +0000
Subject: [PATCH 05/07] sh: sh4a scif pdata (sh7343/sh7366/sh7722/sh7723/sh7724)
Message-Id: <20091214123022.10707.95606.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch breaks out the sh4a scif serial port platform
data from a shared platform device to one platform
device per port. Also, add serial ports to the list of
early platform devices.

Only sh4a SuperH Mobile processors are modified by this
patch.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |  112 ++++++++++++++--------
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   39 +++----
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   91 +++++++++++-------
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  160 +++++++++++++++++++++-----------
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  145 ++++++++++++++++++++---------
 5 files changed, 356 insertions(+), 191 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2009-12-14 17:32:59.000000000 +0900
@@ -15,6 +15,71 @@
 #include <linux/sh_timer.h>
 #include <asm/clock.h>
 
+/* Serial */
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase        = 0xffe00000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.type           = PORT_SCIF,
+	.irqs           = { 80, 80, 80, 80 },
+	.clk		= "scif0",
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
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
+	.mapbase        = 0xffe30000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.type           = PORT_SCIF,
+	.irqs           = { 83, 83, 83, 83 },
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
 static struct resource iic0_resources[] = {
 	[0] = {
 		.name	= "IIC0",
@@ -265,52 +330,17 @@ static struct platform_device tmu2_devic
 	.num_resources	= ARRAY_SIZE(tmu2_resources),
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 80, 80, 80, 80 },
-		.clk		= "scif0",
-	}, {
-		.mapbase	= 0xffe10000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 81, 81, 81, 81 },
-		.clk		= "scif1",
-	}, {
-		.mapbase	= 0xffe20000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 82, 82, 82, 82 },
-		.clk		= "scif2",
-	}, {
-		.mapbase	= 0xffe30000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 83, 83, 83, 83 },
-		.clk		= "scif3",
-	}, {
-		.flags = 0,
-	}
-};
-
-static struct platform_device sci_device = {
-	.name		= "sh-sci",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= sci_platform_data,
-	},
-};
-
 static struct platform_device *sh7343_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
 	&cmt_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
 	&iic0_device,
 	&iic1_device,
-	&sci_device,
 	&vpu_device,
 	&veu_device,
 	&jpu_device,
@@ -328,6 +358,10 @@ static int __init sh7343_devices_setup(v
 arch_initcall(sh7343_devices_setup);
 
 static struct platform_device *sh7343_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
 	&cmt_device,
 	&tmu0_device,
 	&tmu1_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2009-12-14 17:42:43.000000000 +0900
@@ -18,6 +18,22 @@
 #include <linux/usb/r8a66597.h>
 #include <asm/clock.h>
 
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe00000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 80, 80, 80, 80 },
+	.clk		= "scif0",
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
+	},
+};
+
 static struct resource iic_resources[] = {
 	[0] = {
 		.name	= "IIC",
@@ -276,33 +292,13 @@ static struct platform_device tmu2_devic
 	.num_resources	= ARRAY_SIZE(tmu2_resources),
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 80, 80, 80, 80 },
-		.clk		= "scif0",
-	}, {
-		.flags = 0,
-	}
-};
-
-static struct platform_device sci_device = {
-	.name		= "sh-sci",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= sci_platform_data,
-	},
-};
-
 static struct platform_device *sh7366_devices[] __initdata = {
+	&scif0_device,
 	&cmt_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
 	&iic_device,
-	&sci_device,
 	&usb_host_device,
 	&vpu_device,
 	&veu0_device,
@@ -321,6 +317,7 @@ static int __init sh7366_devices_setup(v
 arch_initcall(sh7366_devices_setup);
 
 static struct platform_device *sh7366_early_devices[] __initdata = {
+	&scif0_device,
 	&cmt_device,
 	&tmu0_device,
 	&tmu1_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-12-14 17:32:40.000000000 +0900
@@ -20,6 +20,55 @@
 #include <asm/dma-sh.h>
 #include <cpu/sh7722.h>
 
+/* Serial */
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase        = 0xffe00000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.type           = PORT_SCIF,
+	.irqs           = { 80, 80, 80, 80 },
+	.clk		= "scif0",
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
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
 static struct resource rtc_resources[] = {
 	[0] = {
 		.start	= 0xa465fec0,
@@ -339,41 +388,6 @@ static struct platform_device tmu2_devic
 	},
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 80, 80, 80, 80 },
-		.clk		= "scif0",
-	},
-	{
-		.mapbase	= 0xffe10000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 81, 81, 81, 81 },
-		.clk		= "scif1",
-	},
-	{
-		.mapbase	= 0xffe20000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 82, 82, 82, 82 },
-		.clk		= "scif2",
-	},
-	{
-		.flags = 0,
-	}
-};
-
-static struct platform_device sci_device = {
-	.name		= "sh-sci",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= sci_platform_data,
-	},
-};
-
 static struct sh_dmae_pdata dma_platform_data = {
 	.mode = 0,
 };
@@ -387,6 +401,9 @@ static struct platform_device dma_device
 };
 
 static struct platform_device *sh7722_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
 	&cmt_device,
 	&tmu0_device,
 	&tmu1_device,
@@ -394,7 +411,6 @@ static struct platform_device *sh7722_de
 	&rtc_device,
 	&usbf_device,
 	&iic_device,
-	&sci_device,
 	&vpu_device,
 	&veu_device,
 	&jpu_device,
@@ -413,6 +429,9 @@ static int __init sh7722_devices_setup(v
 arch_initcall(sh7722_devices_setup);
 
 static struct platform_device *sh7722_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
 	&cmt_device,
 	&tmu0_device,
 	&tmu1_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2009-12-14 17:05:27.000000000 +0900
@@ -20,6 +20,103 @@
 #include <asm/mmzone.h>
 #include <cpu/sh7723.h>
 
+/* Serial */
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase        = 0xffe00000,
+	.flags          = UPF_BOOT_AUTOCONF,
+	.type           = PORT_SCIF,
+	.irqs           = { 80, 80, 80, 80 },
+	.clk		= "scif0",
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
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
+	.dev		= {
+		.platform_data	= &scif5_platform_data,
+	},
+};
+
 static struct uio_info vpu_platform_data = {
 	.name = "VPU5",
 	.version = "0",
@@ -348,56 +445,6 @@ static struct platform_device tmu5_devic
 	},
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase        = 0xffe00000,
-		.flags          = UPF_BOOT_AUTOCONF,
-		.type           = PORT_SCIF,
-		.irqs           = { 80, 80, 80, 80 },
-		.clk		= "scif0",
-	},{
-		.mapbase        = 0xffe10000,
-		.flags          = UPF_BOOT_AUTOCONF,
-		.type           = PORT_SCIF,
-		.irqs           = { 81, 81, 81, 81 },
-		.clk		= "scif1",
-	},{
-		.mapbase        = 0xffe20000,
-		.flags          = UPF_BOOT_AUTOCONF,
-		.type           = PORT_SCIF,
-		.irqs           = { 82, 82, 82, 82 },
-		.clk		= "scif2",
-	},{
-		.mapbase	= 0xa4e30000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIFA,
-		.irqs		= { 56, 56, 56, 56 },
-		.clk		= "scif3",
-	},{
-		.mapbase	= 0xa4e40000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIFA,
-		.irqs		= { 88, 88, 88, 88 },
-		.clk		= "scif4",
-	},{
-		.mapbase	= 0xa4e50000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIFA,
-		.irqs		= { 109, 109, 109, 109 },
-		.clk		= "scif5",
-	}, {
-		.flags = 0,
-	}
-};
-
-static struct platform_device sci_device = {
-	.name		= "sh-sci",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= sci_platform_data,
-	},
-};
-
 static struct resource rtc_resources[] = {
 	[0] = {
 		.start	= 0xa465fec0,
@@ -488,6 +535,12 @@ static struct platform_device iic_device
 };
 
 static struct platform_device *sh7723_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 	&cmt_device,
 	&tmu0_device,
 	&tmu1_device,
@@ -495,7 +548,6 @@ static struct platform_device *sh7723_de
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
-	&sci_device,
 	&rtc_device,
 	&iic_device,
 	&sh7723_usb_host_device,
@@ -516,6 +568,12 @@ static int __init sh7723_devices_setup(v
 arch_initcall(sh7723_devices_setup);
 
 static struct platform_device *sh7723_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 	&cmt_device,
 	&tmu0_device,
 	&tmu1_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2009-12-14 17:05:50.000000000 +0900
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
 
@@ -590,6 +636,12 @@ static struct platform_device spu1_devic
 };
 
 static struct platform_device *sh7724_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 	&cmt_device,
 	&tmu0_device,
 	&tmu1_device,
@@ -597,7 +649,6 @@ static struct platform_device *sh7724_de
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
-	&sci_device,
 	&rtc_device,
 	&iic0_device,
 	&iic1_device,
@@ -624,6 +675,12 @@ static int __init sh7724_devices_setup(v
 arch_initcall(sh7724_devices_setup);
 
 static struct platform_device *sh7724_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 	&cmt_device,
 	&tmu0_device,
 	&tmu1_device,
