From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 May 2010 14:35:30 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7367/G3EVM evt2irq() update
Message-Id: <20100520143530.27616.16098.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the irq numbers on sh7367/G3EVM
to make use of evt2irq() and intcs_evt2irq().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-g3evm.c  |    8 ++++----
 arch/arm/mach-shmobile/setup-sh7367.c |   30 ++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 12 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-g3evm.c
+++ work/arch/arm/mach-shmobile/board-g3evm.c	2010-05-20 19:00:00.000000000 +0900
@@ -121,7 +121,7 @@ static struct resource usb_host_resource
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= 65,
+		.start	= evt2irq(0xa20), /* USBHS_USHI0 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
@@ -161,7 +161,7 @@ static struct resource keysc_resources[]
 		.flags  = IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 79,
+		.start  = evt2irq(0xbe0), /* KEYSC_KEY */
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -224,7 +224,7 @@ static struct resource irda_resources[] 
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start  = 20,
+		.start  = evt2irq(0x480), /* IRDA */
 		.flags  = IORESOURCE_IRQ,
 	},
 };
@@ -349,7 +349,7 @@ static void __init g3evm_init(void)
 	gpio_request(GPIO_FN_IRDA_OUT, NULL);
 	gpio_request(GPIO_FN_IRDA_IN, NULL);
 	gpio_request(GPIO_FN_IRDA_FIRSEL, NULL);
-	set_irq_type(20, IRQ_TYPE_LEVEL_LOW);
+	set_irq_type(evt2irq(0x480), IRQ_TYPE_LEVEL_LOW);
 
 	sh7367_add_standard_devices();
 
--- 0001/arch/arm/mach-shmobile/setup-sh7367.c
+++ work/arch/arm/mach-shmobile/setup-sh7367.c	2010-05-20 18:31:21.000000000 +0900
@@ -31,11 +31,13 @@
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
@@ -46,11 +48,13 @@ static struct platform_device scif0_devi
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
@@ -61,11 +65,13 @@ static struct platform_device scif1_devi
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
@@ -76,11 +82,13 @@ static struct platform_device scif2_devi
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
@@ -91,11 +99,13 @@ static struct platform_device scif3_devi
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
@@ -106,11 +116,13 @@ static struct platform_device scif4_devi
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
@@ -121,11 +133,13 @@ static struct platform_device scif5_devi
 	},
 };
 
+/* SCIFB */
 static struct plat_sci_port scif6_platform_data = {
 	.mapbase	= 0xe6c30000,
 	.flags		= UPF_BOOT_AUTOCONF,
 	.type		= PORT_SCIF,
-	.irqs           = { 91, 91, 91, 91 },
+	.irqs		= { evt2irq(0xd60), evt2irq(0xd60),
+			    evt2irq(0xd60), evt2irq(0xd60) },
 };
 
 static struct platform_device scif6_device = {
@@ -153,7 +167,7 @@ static struct resource cmt10_resources[]
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start	= 72,
+		.start	= evt2irq(0xb00), /* CMT1_CMT10 */
 		.flags	= IORESOURCE_IRQ,
 	},
 };
