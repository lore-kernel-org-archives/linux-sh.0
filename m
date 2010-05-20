From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 May 2010 14:39:21 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7377/G4EVM evt2irq() update
Message-Id: <20100520143921.27634.60795.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the irq numbers on sh7377/G4EVM
to make use of evt2irq() and intcs_evt2irq().

Makes the system cope with an updated INTCS_VECT_BASE.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-g4evm.c  |    9 +++-----
 arch/arm/mach-shmobile/setup-sh7377.c |   34 ++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 14 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-g4evm.c
+++ work/arch/arm/mach-shmobile/board-g4evm.c	2010-05-20 18:57:19.000000000 +0900
@@ -138,8 +138,7 @@ static struct resource usb_host_resource
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= 65,
-		.end	= 65,
+		.start	= evt2irq(0x0a20), /* USBHS_USHI0 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -180,7 +179,7 @@ static struct resource keysc_resources[]
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 79,
+		.start  = evt2irq(0x0be0), /* KEYSC_KEY */
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -204,7 +203,7 @@ static struct resource sdhi0_resources[]
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 96,
+		.start  = evt2irq(0x0e00), /* SDHI0 */
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -224,7 +223,7 @@ static struct resource sdhi1_resources[]
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 100,
+		.start  = evt2irq(0x0e80), /* SDHI1 */
 		.flags  = IORESOURCE_IRQ,
 	},
 };
--- 0001/arch/arm/mach-shmobile/setup-sh7377.c
+++ work/arch/arm/mach-shmobile/setup-sh7377.c	2010-05-20 18:55:44.000000000 +0900
@@ -32,11 +32,13 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+/* SCIFA0 */
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase	= 0xe6c40000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs		= { 80, 80, 80, 80 },
+	.irqs		= { evt2irq(0xc00), evt2irq(0xc00),
+			    evt2irq(0xc00), evt2irq(0xc00) },
 };
 
 static struct platform_device scif0_device = {
@@ -47,11 +49,13 @@ static struct platform_device scif0_devi
 	},
 };
 
+/* SCIFA1 */
 static struct plat_sci_port scif1_platform_data = {
 	.mapbase	= 0xe6c50000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 81, 81, 81, 81 },
+	.irqs		= { evt2irq(0xc20), evt2irq(0xc20),
+			    evt2irq(0xc20), evt2irq(0xc20) },
 };
 
 static struct platform_device scif1_device = {
@@ -62,11 +66,13 @@ static struct platform_device scif1_devi
 	},
 };
 
+/* SCIFA2 */
 static struct plat_sci_port scif2_platform_data = {
 	.mapbase	= 0xe6c60000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 82, 82, 82, 82 },
+	.irqs		= { evt2irq(0xc40), evt2irq(0xc40),
+			    evt2irq(0xc40), evt2irq(0xc40) },
 };
 
 static struct platform_device scif2_device = {
@@ -77,11 +83,13 @@ static struct platform_device scif2_devi
 	},
 };
 
+/* SCIFA3 */
 static struct plat_sci_port scif3_platform_data = {
 	.mapbase	= 0xe6c70000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 83, 83, 83, 83 },
+	.irqs		= { evt2irq(0xc60), evt2irq(0xc60),
+			    evt2irq(0xc60), evt2irq(0xc60) },
 };
 
 static struct platform_device scif3_device = {
@@ -92,11 +100,13 @@ static struct platform_device scif3_devi
 	},
 };
 
+/* SCIFA4 */
 static struct plat_sci_port scif4_platform_data = {
 	.mapbase	= 0xe6c80000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 89, 89, 89, 89 },
+	.irqs		= { evt2irq(0xd20), evt2irq(0xd20),
+			    evt2irq(0xd20), evt2irq(0xd20) },
 };
 
 static struct platform_device scif4_device = {
@@ -107,11 +117,13 @@ static struct platform_device scif4_devi
 	},
 };
 
+/* SCIFA5 */
 static struct plat_sci_port scif5_platform_data = {
 	.mapbase	= 0xe6cb0000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 90, 90, 90, 90 },
+	.irqs		= { evt2irq(0xd40), evt2irq(0xd40),
+			    evt2irq(0xd40), evt2irq(0xd40) },
 };
 
 static struct platform_device scif5_device = {
@@ -122,11 +134,13 @@ static struct platform_device scif5_devi
 	},
 };
 
+/* SCIFA6 */
 static struct plat_sci_port scif6_platform_data = {
 	.mapbase	= 0xe6cc0000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 196, 196, 196, 196 },
+	.irqs		= { intcs_evt2irq(0x1a80), intcs_evt2irq(0x1a80),
+			    intcs_evt2irq(0x1a80), intcs_evt2irq(0x1a80) },
 };
 
 static struct platform_device scif6_device = {
@@ -137,11 +151,13 @@ static struct platform_device scif6_devi
 	},
 };
 
+/* SCIFB */
 static struct plat_sci_port scif7_platform_data = {
 	.mapbase	= 0xe6c30000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 91, 91, 91, 91 },
+	.irqs		= { evt2irq(0xd60), evt2irq(0xd60),
+			    evt2irq(0xd60), evt2irq(0xd60) },
 };
 
 static struct platform_device scif7_device = {
@@ -169,7 +185,7 @@ static struct resource cmt10_resources[]
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= 72,
+		.start	= evt2irq(0xb00), /* CMT1_CMT10 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
