From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Dec 2009 12:29:56 +0000
Subject: [PATCH 02/07] sh: sh2a scif pdata (sh7201/sh7203/sh7206/mxg)
Message-Id: <20091214122956.10707.32562.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch breaks out the sh2a scif serial port platform
data from a shared platform device to one platform
device per port. Also, add serial ports to the list of
early platform devices.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |   23 +---
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |  177 +++++++++++++++++++++++---------
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |   89 +++++++++++-----
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |   89 +++++++++++-----
 4 files changed, 261 insertions(+), 117 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-mxg.c	2009-12-14 20:07:53.000000000 +0900
@@ -207,27 +207,23 @@ static struct platform_device mtu2_2_dev
 	.num_resources	= ARRAY_SIZE(mtu2_2_resources),
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xff804000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 220, 220, 220, 220 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xff804000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 220, 220, 220, 220 },
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
 
 static struct platform_device *mxg_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
 	&mtu2_0_device,
 	&mtu2_1_device,
 	&mtu2_2_device,
@@ -246,6 +242,7 @@ void __init plat_irq_setup(void)
 }
 
 static struct platform_device *mxg_early_devices[] __initdata = {
+	&scif0_device,
 	&mtu2_0_device,
 	&mtu2_1_device,
 	&mtu2_2_device,
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7201.c	2009-12-14 19:54:10.000000000 +0900
@@ -177,57 +177,123 @@ static struct intc_mask_reg mask_registe
 static DECLARE_INTC_DESC(intc_desc, "sh7201", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xfffe8000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 180, 180, 180, 180 }
-	}, {
-		.mapbase	= 0xfffe8800,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 184, 184, 184, 184 }
-	}, {
-		.mapbase	= 0xfffe9000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 188, 188, 188, 188 }
-	}, {
-		.mapbase	= 0xfffe9800,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 192, 192, 192, 192 }
-	}, {
-		.mapbase	= 0xfffea000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 196, 196, 196, 196 }
-	}, {
-		.mapbase	= 0xfffea800,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 200, 200, 200, 200 }
-	}, {
-		.mapbase	= 0xfffeb000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 204, 204, 204, 204 }
-	}, {
-		.mapbase	= 0xfffeb800,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 208, 208, 208, 208 }
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xfffe8000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 180, 180, 180, 180 }
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
+	.mapbase	= 0xfffe8800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 184, 184, 184, 184 }
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
+	.mapbase	= 0xfffe9000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 188, 188, 188, 188 }
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
+	.mapbase	= 0xfffe9800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 192, 192, 192, 192 }
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
+	.mapbase	= 0xfffea000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 196, 196, 196, 196 }
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
+	.mapbase	= 0xfffea800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 200, 200, 200, 200 }
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
+	.mapbase	= 0xfffeb000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 204, 204, 204, 204 }
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
+	.mapbase	= 0xfffeb800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 208, 208, 208, 208 }
+};
+
+static struct platform_device scif7_device = {
+	.name		= "sh-sci",
+	.id		= 7,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif7_platform_data,
 	},
 };
 
@@ -345,7 +411,14 @@ static struct platform_device mtu2_2_dev
 };
 
 static struct platform_device *sh7201_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
+	&scif6_device,
+	&scif7_device,
 	&rtc_device,
 	&mtu2_0_device,
 	&mtu2_1_device,
@@ -365,6 +438,14 @@ void __init plat_irq_setup(void)
 }
 
 static struct platform_device *sh7201_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
+	&scif6_device,
+	&scif7_device,
 	&mtu2_0_device,
 	&mtu2_1_device,
 	&mtu2_2_device,
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7203.c	2009-12-14 20:05:06.000000000 +0900
@@ -173,37 +173,63 @@ static struct intc_mask_reg mask_registe
 static DECLARE_INTC_DESC(intc_desc, "sh7203", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xfffe8000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		=  { 192, 192, 192, 192 },
-	}, {
-		.mapbase	= 0xfffe8800,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		=  { 196, 196, 196, 196 },
-	}, {
-		.mapbase	= 0xfffe9000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		=  { 200, 200, 200, 200 },
-	}, {
-		.mapbase	= 0xfffe9800,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		=  { 204, 204, 204, 204 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xfffe8000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		=  { 192, 192, 192, 192 },
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
+	.mapbase	= 0xfffe8800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		=  { 196, 196, 196, 196 },
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
+	.mapbase	= 0xfffe9000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		=  { 200, 200, 200, 200 },
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
+	.mapbase	= 0xfffe9800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		=  { 204, 204, 204, 204 },
+};
+
+static struct platform_device scif3_device = {
+	.name		= "sh-sci",
+	.id		= 3,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif3_platform_data,
 	},
 };
 
@@ -354,7 +380,10 @@ static struct platform_device rtc_device
 };
 
 static struct platform_device *sh7203_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
 	&cmt0_device,
 	&cmt1_device,
 	&mtu2_0_device,
@@ -375,6 +404,10 @@ void __init plat_irq_setup(void)
 }
 
 static struct platform_device *sh7203_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
 	&cmt0_device,
 	&cmt1_device,
 	&mtu2_0_device,
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7206.c	2009-12-14 20:07:12.000000000 +0900
@@ -133,37 +133,63 @@ static struct intc_mask_reg mask_registe
 static DECLARE_INTC_DESC(intc_desc, "sh7206", vectors, groups,
 			 mask_registers, prio_registers, NULL);
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xfffe8000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 240, 240, 240, 240 },
-	}, {
-		.mapbase	= 0xfffe8800,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 244, 244, 244, 244 },
-	}, {
-		.mapbase	= 0xfffe9000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 248, 248, 248, 248 },
-	}, {
-		.mapbase	= 0xfffe9800,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 252, 252, 252, 252 },
-	}, {
-		.flags = 0,
-	}
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xfffe8000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 240, 240, 240, 240 },
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
+	.mapbase	= 0xfffe8800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 244, 244, 244, 244 },
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
+	.mapbase	= 0xfffe9000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 248, 248, 248, 248 },
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
+	.mapbase	= 0xfffe9800,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 252, 252, 252, 252 },
+};
+
+static struct platform_device scif3_device = {
+	.name		= "sh-sci",
+	.id		= 3,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif3_platform_data,
 	},
 };
 
@@ -325,7 +351,10 @@ static struct platform_device mtu2_2_dev
 };
 
 static struct platform_device *sh7206_devices[] __initdata = {
-	&sci_device,
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
 	&cmt0_device,
 	&cmt1_device,
 	&mtu2_0_device,
@@ -346,6 +375,10 @@ void __init plat_irq_setup(void)
 }
 
 static struct platform_device *sh7206_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
 	&cmt0_device,
 	&cmt1_device,
 	&mtu2_0_device,
