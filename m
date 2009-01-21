From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:15:20 +0000
Subject: [PATCH 013/013] sh-sci: sh4a single port devices and clock support
Message-Id: <20090121151520.29269.68219.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Rework sh-sci platform data for sh4a processors such as:
 sh7343, sh7366, sh7722, sh7723, sh7763, sh7780, sh7785, shx3

Also add clock framework data for SuperH Mobile processors.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   89 ++++++++++++++-------
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   23 ++---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   66 ++++++++++-----
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |  133 ++++++++++++++++++++++----------
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   64 +++++++++------
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   43 ++++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  128 ++++++++++++++++++++----------
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   85 +++++++++++++-------
 8 files changed, 418 insertions(+), 213 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2009-01-21 17:40:55.000000000 +0900
@@ -140,44 +140,77 @@ static struct platform_device jpu_device
 	.num_resources	= ARRAY_SIZE(jpu_resources),
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 80, 80, 80, 80 },
-	}, {
-		.mapbase	= 0xffe10000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 81, 81, 81, 81 },
-	}, {
-		.mapbase	= 0xffe20000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 82, 82, 82, 82 },
-	}, {
-		.mapbase	= 0xffe30000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 83, 83, 83, 83 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe00000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 80, 80, 80, 80 },
+	.clk		= "scif0",
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
+	.mapbase	= 0xffe10000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 81, 81, 81, 81 },
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
+	.mapbase	= 0xffe20000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 82, 82, 82, 82 },
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
+	.mapbase	= 0xffe30000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 83, 83, 83, 83 },
+	.clk		= "scif3",
+};
+
+static struct platform_device scif3_device = {
+	.name		= "sh-sci",
+	.id		= 3,
+	.dev		= {
+		.platform_data	= &scif3_platform_data,
 	},
 };
 
 static struct platform_device *sh7343_devices[] __initdata = {
 	&iic0_device,
 	&iic1_device,
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
 	&vpu_device,
 	&veu_device,
 	&jpu_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2009-01-21 17:42:17.000000000 +0900
@@ -147,28 +147,25 @@ static struct platform_device veu1_devic
 	.num_resources	= ARRAY_SIZE(veu1_resources),
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 80, 80, 80, 80 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe00000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 80, 80, 80, 80 },
+	.clk		= "scif0",
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
 
 static struct platform_device *sh7366_devices[] __initdata = {
 	&iic_device,
-	&sci_device,
+	&scif0_device,
 	&usb_host_device,
 	&vpu_device,
 	&veu0_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-01-21 17:31:52.000000000 +0900
@@ -176,35 +176,51 @@ static struct platform_device jpu_device
 	.num_resources	= ARRAY_SIZE(jpu_resources),
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 80, 80, 80, 80 },
-	},
-	{
-		.mapbase	= 0xffe10000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 81, 81, 81, 81 },
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
 	},
-	{
-		.mapbase	= 0xffe20000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 82, 82, 82, 82 },
+};
+
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xffe10000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 81, 81, 81, 81 },
+	.clk		= "scif1",
+};
+
+static struct platform_device scif1_device = {
+	.name		= "sh-sci",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &scif1_platform_data,
 	},
-	{
-		.flags = 0,
-	}
 };
 
-static struct platform_device sci_device = {
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xffe20000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 82, 82, 82, 82 },
+	.clk		= "scif2",
+};
+
+static struct platform_device scif2_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 2,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif2_platform_data,
 	},
 };
 
@@ -212,7 +228,9 @@ static struct platform_device *sh7722_de
 	&rtc_device,
 	&usbf_device,
 	&iic_device,
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
 	&vpu_device,
 	&veu_device,
 	&jpu_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2009-01-21 17:41:55.000000000 +0900
@@ -100,47 +100,99 @@ static struct platform_device veu1_devic
 	.num_resources	= ARRAY_SIZE(veu1_resources),
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase        = 0xffe00000,
-		.flags          = UPF_BOOT_AUTOCONF,
-		.type           = PORT_SCIF,
-		.irqs           = { 80, 80, 80, 80 },
-	},{
-		.mapbase        = 0xffe10000,
-		.flags          = UPF_BOOT_AUTOCONF,
-		.type           = PORT_SCIF,
-		.irqs           = { 81, 81, 81, 81 },
-	},{
-		.mapbase        = 0xffe20000,
-		.flags          = UPF_BOOT_AUTOCONF,
-		.type           = PORT_SCIF,
-		.irqs           = { 82, 82, 82, 82 },
-	},{
-		.mapbase	= 0xa4e30000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIFA,
-		.irqs		= { 56, 56, 56, 56 },
-	},{
-		.mapbase	= 0xa4e40000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIFA,
-		.irqs		= { 88, 88, 88, 88 },
-	},{
-		.mapbase	= 0xa4e50000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIFA,
-		.irqs		= { 109, 109, 109, 109 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe00000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 80, 80, 80, 80 },
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
+	.mapbase	= 0xffe10000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 81, 81, 81, 81 },
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
+	.mapbase	= 0xffe20000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 82, 82, 82, 82 },
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
+	.mapbase	= 0xa4e30000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { 56, 56, 56, 56 },
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
+	.mapbase	= 0xa4e40000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { 88, 88, 88, 88 },
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
+	.mapbase	= 0xa4e50000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIFA,
+	.irqs		= { 109, 109, 109, 109 },
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
 
@@ -221,7 +273,12 @@ static struct platform_device iic_device
 };
 
 static struct platform_device *sh7723_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 	&rtc_device,
 	&iic_device,
 	&sh7723_usb_host_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7763.c	2009-01-21 17:30:54.000000000 +0900
@@ -45,32 +45,48 @@ static struct platform_device rtc_device
 	.resource	= rtc_resources,
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 41, 43, 42 },
-	}, {
-		.mapbase	= 0xffe08000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 76, 77, 79, 78 },
-	}, {
-		.mapbase	= 0xffe10000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 104, 105, 107, 106 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe00000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 41, 43, 42 },
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
+	.mapbase	= 0xffe08000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 76, 77, 79, 78 },
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
+	.mapbase	= 0xffe10000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 104, 105, 107, 106 },
+};
+
+static struct platform_device scif2_device = {
+	.name		= "sh-sci",
+	.id		= 2,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif2_platform_data,
 	},
 };
 
@@ -125,7 +141,9 @@ static struct platform_device usbf_devic
 
 static struct platform_device *sh7763_devices[] __initdata = {
 	&rtc_device,
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
 	&usb_ohci_device,
 	&usbf_device,
 };
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7780.c	2009-01-21 17:30:54.000000000 +0900
@@ -43,33 +43,40 @@ static struct platform_device rtc_device
 	.resource	= rtc_resources,
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 41, 43, 42 },
-	}, {
-		.mapbase	= 0xffe10000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 76, 77, 79, 78 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe00000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 41, 43, 42 },
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
+	.mapbase	= 0xffe10000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 76, 77, 79, 78 },
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
 
 static struct platform_device *sh7780_devices[] __initdata = {
 	&rtc_device,
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
 };
 
 static int __init sh7780_devices_setup(void)
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7785.c	2009-01-21 17:30:54.000000000 +0900
@@ -15,57 +15,103 @@
 #include <linux/mm.h>
 #include <asm/mmzone.h>
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffea0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 41, 43, 42 },
-	}, {
-		.mapbase	= 0xffeb0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 44, 45, 47, 46 },
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffea0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 41, 43, 42 },
+};
+
+static struct platform_device scif0_device = {
+	.name		= "sh-sci",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &scif0_platform_data,
 	},
+};
 
-	/*
-	 * The rest of these all have multiplexed IRQs
-	 */
-	{
-		.mapbase	= 0xffec0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 60, 60, 60, 60 },
-	}, {
-		.mapbase	= 0xffed0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 61, 61, 61, 61 },
-	}, {
-		.mapbase	= 0xffee0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 62, 62, 62, 62 },
-	}, {
-		.mapbase	= 0xffef0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 63, 63, 63, 63 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xffeb0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 44, 45, 47, 46 },
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
+	.mapbase	= 0xffec0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 60, 60, 60, 60 },
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
+	.mapbase	= 0xffed0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 61, 61, 61, 61 },
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
+	.mapbase	= 0xffee0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 62, 62, 62, 62 },
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
+	.mapbase	= 0xffef0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 63, 63, 63, 63 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif5_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 5,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif5_platform_data,
 	},
 };
 
 static struct platform_device *sh7785_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 };
 
 static int __init sh7785_devices_setup(void)
--- 0001/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-shx3.c	2009-01-21 17:30:54.000000000 +0900
@@ -14,42 +14,71 @@
 #include <linux/io.h>
 #include <asm/mmzone.h>
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffc30000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 41, 43, 42 },
-	}, {
-		.mapbase	= 0xffc40000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 44, 45, 47, 46 },
-	}, {
-		.mapbase	= 0xffc50000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 48, 49, 51, 50 },
-	}, {
-		.mapbase	= 0xffc60000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 52, 53, 55, 54 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffc30000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 41, 43, 42 },
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
+	.mapbase	= 0xffc40000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 44, 45, 47, 46 },
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
+	.mapbase	= 0xffc50000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 48, 49, 51, 50 },
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
+	.mapbase	= 0xffc60000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 52, 53, 55, 54 },
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif3_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 3,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif3_platform_data,
 	},
 };
 
 static struct platform_device *shx3_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
 };
 
 static int __init shx3_devices_setup(void)
