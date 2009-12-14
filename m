From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Dec 2009 12:30:31 +0000
Subject: [PATCH 06/07] sh: sh4a scif pdata (sh7757/sh7763/sh7770/sh7780/sh7785/sh7786/x3)
Message-Id: <20091214123031.10707.63592.sendpatchset@rxone.opensource.se>
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

All sh4a except SuperH Mobile processors are modified by
this patch.

While at it, sh7757 gets early platform device support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   92 ++++++++-----
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |   81 +++++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |  221 +++++++++++++++++++++++---------
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   60 ++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  159 +++++++++++++++--------
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |  132 +++++++++++++------
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |   76 ++++++-----
 7 files changed, 551 insertions(+), 270 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7757.c	2009-12-14 19:10:53.000000000 +0900
@@ -17,6 +17,51 @@
 #include <linux/mm.h>
 #include <linux/sh_timer.h>
 
+static struct plat_sci_port scif2_platform_data = {
+	.mapbase	= 0xfe4b0000,		/* SCIF2 */
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 40, 40, 40 },
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
+	.mapbase	= 0xfe4c0000,		/* SCIF3 */
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 76, 76, 76, 76 },
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
+	.mapbase	= 0xfe4d0000,		/* SCIF4 */
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 104, 104, 104, 104 },
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
 static struct sh_timer_config tmu0_platform_data = {
 	.name = "TMU0",
 	.channel_offset = 0x04,
@@ -79,39 +124,12 @@ static struct platform_device tmu1_devic
 	.num_resources	= ARRAY_SIZE(tmu1_resources),
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xfe4b0000,		/* SCIF2 */
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 40, 40, 40 },
-	}, {
-		.mapbase	= 0xfe4c0000,		/* SCIF3 */
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 76, 76, 76, 76 },
-	}, {
-		.mapbase	= 0xfe4d0000,		/* SCIF4 */
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 104, 104, 104, 104 },
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
 static struct platform_device *sh7757_devices[] __initdata = {
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
 	&tmu0_device,
 	&tmu1_device,
-	&sci_device,
 };
 
 static int __init sh7757_devices_setup(void)
@@ -121,6 +139,20 @@ static int __init sh7757_devices_setup(v
 }
 arch_initcall(sh7757_devices_setup);
 
+static struct platform_device *sh7757_early_devices[] __initdata = {
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&tmu0_device,
+	&tmu1_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7757_early_devices,
+				   ARRAY_SIZE(sh7757_early_devices));
+}
+
 enum {
 	UNUSED = 0,
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7763.c	2009-12-14 18:26:07.000000000 +0900
@@ -16,6 +16,51 @@
 #include <linux/io.h>
 #include <linux/serial_sci.h>
 
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe00000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 40, 40, 40 },
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
+	.mapbase	= 0xffe08000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 76, 76, 76, 76 },
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
+	.irqs		= { 104, 104, 104, 104 },
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
 		.start	= 0xffe80000,
@@ -36,35 +81,6 @@ static struct platform_device rtc_device
 	.resource	= rtc_resources,
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 40, 40, 40 },
-	}, {
-		.mapbase	= 0xffe08000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 76, 76, 76, 76 },
-	}, {
-		.mapbase	= 0xffe10000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 104, 104, 104, 104 },
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
 static struct resource usb_ohci_resources[] = {
 	[0] = {
 		.start	= 0xffec8000,
@@ -297,6 +313,9 @@ static struct platform_device tmu5_devic
 };
 
 static struct platform_device *sh7763_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
@@ -304,7 +323,6 @@ static struct platform_device *sh7763_de
 	&tmu4_device,
 	&tmu5_device,
 	&rtc_device,
-	&sci_device,
 	&usb_ohci_device,
 	&usbf_device,
 };
@@ -317,6 +335,9 @@ static int __init sh7763_devices_setup(v
 arch_initcall(sh7763_devices_setup);
 
 static struct platform_device *sh7763_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7770.c	2009-12-14 18:25:10.000000000 +0900
@@ -14,67 +14,153 @@
 #include <linux/sh_timer.h>
 #include <linux/io.h>
 
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
 };
 
-static struct platform_device sci_device = {
+static struct platform_device scif9_device = {
 	.name		= "sh-sci",
-	.id		= -1,
+	.id		= 9,
 	.dev		= {
-		.platform_data	= sci_platform_data,
+		.platform_data	= &scif9_platform_data,
 	},
 };
 
@@ -351,6 +437,16 @@ static struct platform_device tmu8_devic
 };
 
 static struct platform_device *sh7770_devices[] __initdata = {
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
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
@@ -360,7 +456,6 @@ static struct platform_device *sh7770_de
 	&tmu6_device,
 	&tmu7_device,
 	&tmu8_device,
-	&sci_device,
 };
 
 static int __init sh7770_devices_setup(void)
@@ -371,6 +466,16 @@ static int __init sh7770_devices_setup(v
 arch_initcall(sh7770_devices_setup);
 
 static struct platform_device *sh7770_early_devices[] __initdata = {
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
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7780.c	2009-12-14 18:36:19.000000000 +0900
@@ -15,6 +15,36 @@
 #include <linux/sh_timer.h>
 #include <asm/dma-sh.h>
 
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffe00000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 40, 40, 40 },
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
+	.irqs		= { 76, 76, 76, 76 },
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
 static struct sh_timer_config tmu0_platform_data = {
 	.name = "TMU0",
 	.channel_offset = 0x04,
@@ -217,30 +247,6 @@ static struct platform_device rtc_device
 	.resource	= rtc_resources,
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffe00000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 40, 40, 40 },
-	}, {
-		.mapbase	= 0xffe10000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 76, 76, 76, 76 },
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
 static struct sh_dmae_pdata dma_platform_data = {
 	.mode = (SHDMA_MIX_IRQ | SHDMA_DMAOR1),
 };
@@ -254,6 +260,8 @@ static struct platform_device dma_device
 };
 
 static struct platform_device *sh7780_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
@@ -261,7 +269,6 @@ static struct platform_device *sh7780_de
 	&tmu4_device,
 	&tmu5_device,
 	&rtc_device,
-	&sci_device,
 	&dma_device,
 };
 
@@ -271,8 +278,9 @@ static int __init sh7780_devices_setup(v
 				    ARRAY_SIZE(sh7780_devices));
 }
 arch_initcall(sh7780_devices_setup);
-
 static struct platform_device *sh7780_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7785.c	2009-12-14 18:59:03.000000000 +0900
@@ -16,6 +16,102 @@
 #include <linux/sh_timer.h>
 #include <asm/mmzone.h>
 
+static struct plat_sci_port scif0_platform_data = {
+	.mapbase	= 0xffea0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 40, 40, 40, 40 },
+	.clk		= "scif_fck",
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
+	.mapbase	= 0xffeb0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 44, 44, 44, 44 },
+	.clk		= "scif_fck",
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
+	.clk		= "scif_fck",
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
+	.clk		= "scif_fck",
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
+	.clk		= "scif_fck",
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
+	.clk		= "scif_fck",
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
 static struct sh_timer_config tmu0_platform_data = {
 	.name = "TMU0",
 	.channel_offset = 0x04,
@@ -198,64 +294,19 @@ static struct platform_device tmu5_devic
 	.num_resources	= ARRAY_SIZE(tmu5_resources),
 };
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffea0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 40, 40, 40 },
-		.clk		= "scif_fck",
-	}, {
-		.mapbase	= 0xffeb0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 44, 44, 44, 44 },
-		.clk		= "scif_fck",
-	}, {
-		.mapbase	= 0xffec0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 60, 60, 60, 60 },
-		.clk		= "scif_fck",
-	}, {
-		.mapbase	= 0xffed0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 61, 61, 61, 61 },
-		.clk		= "scif_fck",
-	}, {
-		.mapbase	= 0xffee0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 62, 62, 62, 62 },
-		.clk		= "scif_fck",
-	}, {
-		.mapbase	= 0xffef0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 63, 63, 63, 63 },
-		.clk		= "scif_fck",
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
 static struct platform_device *sh7785_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
-	&sci_device,
 };
 
 static int __init sh7785_devices_setup(void)
@@ -266,6 +317,12 @@ static int __init sh7785_devices_setup(v
 arch_initcall(sh7785_devices_setup);
 
 static struct platform_device *sh7785_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7786.c	2009-12-14 18:54:58.000000000 +0900
@@ -23,51 +23,96 @@
 #include <linux/sh_timer.h>
 #include <asm/mmzone.h>
 
-static struct plat_sci_port sci_platform_data[] = {
-	{
-		.mapbase	= 0xffea0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 40, 41, 43, 42 },
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
-	/*
-	 * The rest of these all have multiplexed IRQs
-	 */
-	{
-		.mapbase	= 0xffeb0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 44, 44, 44, 44 },
-	}, {
-		.mapbase	= 0xffec0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 50, 50, 50, 50 },
-	}, {
-		.mapbase	= 0xffed0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 51, 51, 51, 51 },
-	}, {
-		.mapbase	= 0xffee0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 52, 52, 52, 52 },
-	}, {
-		.mapbase	= 0xffef0000,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.type		= PORT_SCIF,
-		.irqs		= { 53, 53, 53, 53 },
-	}, {
-		.flags = 0,
-	}
 };
 
-static struct platform_device sci_device = {
+/*
+ * The rest of these all have multiplexed IRQs
+ */
+static struct plat_sci_port scif1_platform_data = {
+	.mapbase	= 0xffeb0000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 44, 44, 44, 44 },
+};
+
+static struct platform_device scif1_device = {
 	.name		= "sh-sci",
-	.id		= -1,
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
+	.irqs		= { 50, 50, 50, 50 },
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
+	.irqs		= { 51, 51, 51, 51 },
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
+	.irqs		= { 52, 52, 52, 52 },
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
+	.irqs		= { 53, 53, 53, 53 },
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
 
@@ -459,6 +504,12 @@ static struct platform_device usb_ohci_d
 };
 
 static struct platform_device *sh7786_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
+	&scif3_device,
+	&scif4_device,
+	&scif5_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
@@ -474,7 +525,6 @@ static struct platform_device *sh7786_ea
 };
 
 static struct platform_device *sh7786_devices[] __initdata = {
-	&sci_device,
 	&usb_ohci_device,
 };
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-shx3.c	2009-12-14 19:03:25.000000000 +0900
@@ -24,32 +24,48 @@
  * silicon in the first place, we just refuse to deal with the port at
  * all rather than adding infrastructure to hack around it.
  */
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
+	.mapbase	= 0xffc60000,
+	.flags		= UPF_BOOT_AUTOCONF,
+	.type		= PORT_SCIF,
+	.irqs		= { 52, 53, 55, 54 },
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
 
@@ -236,6 +252,9 @@ static struct platform_device tmu5_devic
 };
 
 static struct platform_device *shx3_early_devices[] __initdata = {
+	&scif0_device,
+	&scif1_device,
+	&scif2_device,
 	&tmu0_device,
 	&tmu1_device,
 	&tmu2_device,
@@ -244,21 +263,10 @@ static struct platform_device *shx3_earl
 	&tmu5_device,
 };
 
-static struct platform_device *shx3_devices[] __initdata = {
-	&sci_device,
-};
-
 static int __init shx3_devices_setup(void)
 {
-	int ret;
-
-	ret = platform_add_devices(shx3_early_devices,
+	return platform_add_devices(shx3_early_devices,
 				   ARRAY_SIZE(shx3_early_devices));
-	if (unlikely(ret != 0))
-		return ret;
-
-	return platform_add_devices(shx3_devices,
-				    ARRAY_SIZE(shx3_devices));
 }
 arch_initcall(shx3_devices_setup);
 
