From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Aug 2011 09:49:52 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 SCIF platform data update
Message-Id: <20110802094952.2785.67371.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add .regtype members to the sh7372 SCIF platform data.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Tested on AP4EVB, fixes no-console-on-boot issue.

 arch/arm/mach-shmobile/setup-sh7372.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-08-02 18:19:47.000000000 +0900
@@ -44,6 +44,7 @@ static struct plat_sci_port scif0_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0x0c00), evt2irq(0x0c00),
 			    evt2irq(0x0c00), evt2irq(0x0c00) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif0_device = {
@@ -63,6 +64,7 @@ static struct plat_sci_port scif1_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0x0c20), evt2irq(0x0c20),
 			    evt2irq(0x0c20), evt2irq(0x0c20) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif1_device = {
@@ -82,6 +84,7 @@ static struct plat_sci_port scif2_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0x0c40), evt2irq(0x0c40),
 			    evt2irq(0x0c40), evt2irq(0x0c40) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif2_device = {
@@ -101,6 +104,7 @@ static struct plat_sci_port scif3_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0x0c60), evt2irq(0x0c60),
 			    evt2irq(0x0c60), evt2irq(0x0c60) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif3_device = {
@@ -120,6 +124,7 @@ static struct plat_sci_port scif4_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0x0d20), evt2irq(0x0d20),
 			    evt2irq(0x0d20), evt2irq(0x0d20) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif4_device = {
@@ -139,6 +144,7 @@ static struct plat_sci_port scif5_platfo
 	.type		= PORT_SCIFA,
 	.irqs		= { evt2irq(0x0d40), evt2irq(0x0d40),
 			    evt2irq(0x0d40), evt2irq(0x0d40) },
+	.regtype	= SCIx_SCIFA_REGTYPE,
 };
 
 static struct platform_device scif5_device = {
@@ -158,6 +164,7 @@ static struct plat_sci_port scif6_platfo
 	.type		= PORT_SCIFB,
 	.irqs		= { evt2irq(0x0d60), evt2irq(0x0d60),
 			    evt2irq(0x0d60), evt2irq(0x0d60) },
+	.regtype	= SCIx_SCIFB_REGTYPE,
 };
 
 static struct platform_device scif6_device = {
