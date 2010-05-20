From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 May 2010 14:41:00 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372/AP4EVB evt2irq() update
Message-Id: <20100520144100.27640.19152.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the irq numbers on sh7372/AP4EVB
to make use of evt2irq() and intcs_evt2irq().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ap4evb.c |   11 ++++-----
 arch/arm/mach-shmobile/setup-sh7372.c |   39 ++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 19 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2010-05-20 23:13:43.000000000 +0900
@@ -165,7 +165,7 @@ static struct resource smc911x_resources
 		.end	= 0x16000000 - 1,
 		.flags	= IORESOURCE_MEM,
 	}, {
-		.start	= 6,
+		.start	= evt2irq(0x02c0) /* IRQ6A */,
 		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_LOWLEVEL,
 	},
 };
@@ -208,7 +208,7 @@ static struct resource keysc_resources[]
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 79,
+		.start  = evt2irq(0x0be0), /* KEYSC_KEY */
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -232,7 +232,7 @@ static struct resource sdhi0_resources[]
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 96,
+		.start  = evt2irq(0x0e00) /* SDHI0 */,
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -267,8 +267,7 @@ static struct resource usb1_host_resourc
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= 215,
-		.end	= 215,
+		.start	= evt2irq(0x1ce0) /* USB1_USB1I0 */,
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -294,7 +293,7 @@ static struct platform_device *ap4evb_de
 };
 
 /* TouchScreen (Needs SW3 set to OFF) */
-#define IRQ28	396
+#define IRQ28	evt2irq(0x3380) /* IRQ28A */
 struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
 	.x_plate_ohms		= 180,
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2010-05-20 23:13:22.000000000 +0900
@@ -32,12 +32,13 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-/* SCIF */
+/* SCIFA0 */
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs		= { 80, 80, 80, 80 },
+	.irqs		= { evt2irq(0x0c00), evt2irq(0x0c00),
+			    evt2irq(0x0c00), evt2irq(0x0c00) },
 };
 
 static struct platform_device scif0_device = {
@@ -48,11 +49,13 @@ static struct platform_device scif0_devi
 	},
 };
 
+/* SCIFA1 */
 static struct plat_sci_port scif1_platform_data = {
 	.mapbase	= 0xe6c50000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 81, 81, 81, 81 },
+	.irqs		= { evt2irq(0x0c20), evt2irq(0x0c20),
+			    evt2irq(0x0c20), evt2irq(0x0c20) },
 };
 
 static struct platform_device scif1_device = {
@@ -63,11 +66,13 @@ static struct platform_device scif1_devi
 	},
 };
 
+/* SCIFA2 */
 static struct plat_sci_port scif2_platform_data = {
 	.mapbase	= 0xe6c60000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 82, 82, 82, 82 },
+	.irqs		= { evt2irq(0x0c40), evt2irq(0x0c40),
+			    evt2irq(0x0c40), evt2irq(0x0c40) },
 };
 
 static struct platform_device scif2_device = {
@@ -78,11 +83,13 @@ static struct platform_device scif2_devi
 	},
 };
 
+/* SCIFA3 */
 static struct plat_sci_port scif3_platform_data = {
 	.mapbase	= 0xe6c70000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 83, 83, 83, 83 },
+	.irqs		= { evt2irq(0x0c60), evt2irq(0x0c60),
+			    evt2irq(0x0c60), evt2irq(0x0c60) },
 };
 
 static struct platform_device scif3_device = {
@@ -93,11 +100,13 @@ static struct platform_device scif3_devi
 	},
 };
 
+/* SCIFA4 */
 static struct plat_sci_port scif4_platform_data = {
 	.mapbase	= 0xe6c80000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 89, 89, 89, 89 },
+	.irqs		= { evt2irq(0x0d20), evt2irq(0x0d20),
+			    evt2irq(0x0d20), evt2irq(0x0d20) },
 };
 
 static struct platform_device scif4_device = {
@@ -108,11 +117,13 @@ static struct platform_device scif4_devi
 	},
 };
 
+/* SCIFA5 */
 static struct plat_sci_port scif5_platform_data = {
 	.mapbase	= 0xe6cb0000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 90, 90, 90, 90 },
+	.irqs		= { evt2irq(0x0d40), evt2irq(0x0d40),
+			    evt2irq(0x0d40), evt2irq(0x0d40) },
 };
 
 static struct platform_device scif5_device = {
@@ -123,11 +134,13 @@ static struct platform_device scif5_devi
 	},
 };
 
+/* SCIFB */
 static struct plat_sci_port scif6_platform_data = {
 	.mapbase	= 0xe6c30000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 91, 91, 91, 91 },
+	.irqs		= { evt2irq(0x0d60), evt2irq(0x0d60),
+			    evt2irq(0x0d60), evt2irq(0x0d60) },
 };
 
 static struct platform_device scif6_device = {
@@ -156,7 +169,7 @@ static struct resource cmt10_resources[]
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= 72,
+		.start	= evt2irq(0x0b00), /* CMT1_CMT10 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -180,8 +193,8 @@ static struct resource iic0_resources[] 
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = intcs_evt2irq(0xe00),
-		.end    = intcs_evt2irq(0xe60),
+		.start  = intcs_evt2irq(0xe00), /* IIC0_ALI0 */
+		.end    = intcs_evt2irq(0xe60), /* IIC0_DTEI0 */
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -201,8 +214,8 @@ static struct resource iic1_resources[] 
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 44,
-		.end    = 47,
+		.start  = evt2irq(0x780), /* IIC1_ALI1 */
+		.end    = evt2irq(0x7e0), /* IIC1_DTEI1 */
 		.flags  = IORESOURCE_IRQ,
 	},
 };
